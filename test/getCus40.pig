a = LOAD '/dataset/customer.csv' using PigStorage(',');
b = foreach a generate $1,$2,$3,$4;
c = filter b by (int)$2 > 40;
dump c;
