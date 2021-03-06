
![wavedrom](https://user-images.githubusercontent.com/99534053/160382873-1ad13f18-7d8e-4c13-91a4-35a86499e6f0.png)


```javascript
{
  signal:
  [
    ['Digit position',
      {name: 'Common anode: AN(3)', wave: 'xx01..01..01'},
      {name: 'AN(2)', wave: 'xx101..01..0'},
      {name: 'AN(1)', wave: 'xx1.01..01..'},
      {name: 'AN(0)', wave: 'xx1..01..01.'},
    ],
    ['Seven-segment data',
      {name: '4-digit value to display', wave: 'xx3333555599', data: ['3','1','4','2','3','1','4','2','3','1']},
      {name: 'Cathod A: CA', wave: 'xx01.0.1.0.1'},
      {name: 'Cathod B: CB', wave: 'xx0.........'},
      {name: 'CC', wave: 'xx0..10..10.'},
      {name: 'CD', wave: 'xx01.0.1.0.1'},
      {name: 'CE', wave: 'xx1..01..01.'},
      {name: 'CF', wave: 'xx1.01..01..'},
      {name: 'Cathod G: CG', wave: 'xx010..10..1'},
    ],
    {name: 'Decimal point: DP', wave: 'xx01..01..01'},
  ],
  head:
  {
    text: '                    4ms   4ms   4ms   4ms   4ms   4ms   4ms   4ms   4ms   4ms',
  },
}
  ```

For 8-bit:

![image](https://user-images.githubusercontent.com/99534053/160825501-78336e55-5cf6-47ef-b1eb-f282e2450c79.png)


```javascript
{
  signal:
  [
    ['Digit position',
      {name: 'Common anode: AN(7)', wave: 'xx01......01......01'},
      {name: 'AN(6)', wave: 'xx101......01......0'},
      {name: 'AN(5)', wave: 'xx1.01......01......'},
      {name: 'AN(4)', wave: 'xx1..01......01.....'},
      {name: 'AN(3)', wave: 'xx1...01......01....'},
      {name: 'AN(2)', wave: 'xx1....01......01...'},
      {name: 'AN(1)', wave: 'xx1.....01......01..'},
      {name: 'AN(0)', wave: 'xx1......01......01.'},
    ],
    ['Seven-segment data',
      {name: '4-digit value to display', wave: 'xx3333555599', data: ['3','1','4','2','3','1','4','2','3','1']},
      {name: 'Cathod A: CA', wave: 'xx01.0.1.0.1'},
      {name: 'Cathod B: CB', wave: 'xx0.........'},
      {name: 'CC', wave: 'xx0..10..10.'},
      {name: 'CD', wave: 'xx01.0.1.0.1'},
      {name: 'CE', wave: 'xx1..01..01.'},
      {name: 'CF', wave: 'xx1.01..01..'},
      {name: 'Cathod G: CG', wave: 'xx010..10..1'},
    ],
    {name: 'Decimal point: DP', wave: 'xx01..01..01'},
  ],
  head:
  {
    text: '                    2ms   2ms   2ms   2ms   2ms   2ms   2ms   2ms   2ms   2ms   2ms   2ms   2ms   2ms   2ms   2ms   2ms   2ms   ',
  },
}
  ```
