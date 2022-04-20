------------------------------------------------------------
--
-- Driver for 4-digit 7-segment display.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for display driver
--
--             +------------------+
--        -----|> clk             |
--        -----| reset       dp_o |-----
--             |       seg_o(6:0) |--/--
--        --/--| data0_i(3:0)     |  7
--        --/--| data1_i(3:0)     |
--        --/--| data2_i(3:0)     |
--        --/--| data3_i(3:0)     |
--          4  |        dig_o(3:0)|--/--
--        --/--| dp_i(3:0)        |  4
--          4  +------------------+
--
-- Inputs:
--   clk
--   reset
--   dataX_i(3:0) -- Data values for individual digits
--   dp_i(3:0)    -- Decimal points for individual digits
--
-- Outputs:
--   dp_o:        -- Decimal point for specific digit
--   seg_o(6:0)   -- Cathode values for individual segments
--   dig_o(3:0)   -- Common anode signals to individual digits
--
------------------------------------------------------------
entity driver_7seg_4digits is
    port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        data_i  : inout  std_logic_vector(31 downto 0);
        dp_i    : in  std_logic_vector(7 downto 0);
        dp_o    : out std_logic;
        seg_o   : out std_logic_vector(6 downto 0);
        dig_o   : out std_logic_vector(7 downto 0)
    );
end entity driver_7seg_4digits;

------------------------------------------------------------
-- Architecture declaration for display driver
------------------------------------------------------------
architecture Behavioral of driver_7seg_4digits is

    -- Internal clock enable
    signal s_en  : std_logic;
    -- Internal 2-bit counter for multiplexing 4 digits
    signal s_cnt : std_logic_vector(2 downto 0);
    -- Internal 4-bit value for 7-segment decoder
    signal s_hex : std_logic_vector(3 downto 0);

begin
    --------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates 
    -- an enable pulse every 4 ms
    clk_en0 : entity work.clock_enable
        generic map(
            -- FOR SIMULATION, CHANGE THIS VALUE TO 4
            -- FOR IMPLEMENTATION, KEEP THIS VALUE TO 400,000
            g_MAX => 200000  
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en
        );

    --------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity performs a 2-bit
    -- down counter
    bin_cnt0 : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH => 3
        )
        port map(
            en_i       =>   s_en,
            cnt_up_i   =>   '0',
            reset      =>   reset,
            clk        =>   clk,
            cnt_o      =>   s_cnt
        );

    --------------------------------------------------------
    -- Instance (copy) of hex_7seg entity performs a 7-segment
    -- display decoder
    hex2seg : entity work.hex_7seg
        port map(
            hex_i => s_hex,
            seg_o => seg_o
        );
        
    shift_array : entity work.shift_array
        port map(
            reset      =>   reset,
            clk        =>   clk,
            x          =>   data_i
        );

    --------------------------------------------------------
    -- p_mux:
    -- A sequential process that implements a multiplexer for
    -- selecting data for a single digit, a decimal point 
    -- signal, and switches the common anodes of each display.
    --------------------------------------------------------
    p_mux : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                dp_o  <= dp_i(0);
                dig_o <= "11111110";
                s_hex <= data_i (3 downto 0);
            else
                case s_cnt is
                    when "111" =>
                        dp_o  <= dp_i(7);
                        dig_o <= "01111111";
                        s_hex <= data_i (31 downto 28);

                    when "110" =>
                        dp_o  <= dp_i(6);
                        dig_o <= "10111111";
                        s_hex <= data_i (27 downto 24);
                        
                    when "101" =>
                        dp_o  <= dp_i(5);
                        dig_o <= "11011111";
                        s_hex <= data_i (23 downto 20);

                    when "100" =>
                        dp_o  <= dp_i(4);
                        dig_o <= "11101111";
                        s_hex <= data_i (19 downto 16);
                        
                    when "011" =>
                        dp_o  <= dp_i(3);
                        dig_o <= "11110111";
                        s_hex <= data_i (15 downto 12);

                    when "010" =>
                        dp_o  <= dp_i(2);
                        dig_o <= "11111011";
                        s_hex <= data_i (11 downto 8);
                        
                    when "001" =>
                        dp_o  <= dp_i(1);
                        dig_o <= "11111101";
                        s_hex <= data_i (7 downto 4);
                    when others =>
                        dp_o  <= dp_i(0);
                        dig_o <= "11111110";
                        s_hex <= data_i (3 downto 0);
                end case;
            end if;
        end if;
    end process p_mux;

end architecture Behavioral;
