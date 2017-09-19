Return-Path: <SRS0=9iAs=AU=gmail.com=hamohammed.sa@kernel.org>
Date: Mon, 18 Sep 2017 19:56:51 -0600
From: Haneen Mohammed <hamohammed.sa@gmail.com>
To: outreachy-kernel <outreachy-kernel@googlegroups.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, hamohammed.sa@gmail.com
Subject: [PATCH v2] staging: iio: Replace bit shifting with BIT macro
Message-ID: <20170919015651.GA4554@Haneen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch replace bit shifting on 1, and 3 with BIT(x) macro.
Issue resolved with the following Coccinelle script:

@r1@
identifier x;
constant int g;
@@
(
0<<\(x\|g\)
|
1<<\(x\|g\)
|
2<<\(x\|g\)
|
3<<\(x\|g\)
)

@script:python b@
g2 <<r1.g;
y;
@@

coccinelle.y = int(g2) + 1

@c@
constant int r1.g;
identifier b.y;
@@
(
-(1 << g)
+BIT(g)
|
-(0 << g)
+ 0
|
-(2 << g)
+BIT(y)
|
-(3 << g)
+(BIT(y) | BIT(g))
)

Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>
---
Changes in v2: 
- undo changes where it results in different styles mixed up
- remove parenthesis aroun BIT(y) | BIT(g)

 drivers/staging/iio/impedance-analyzer/ad5933.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 3d539ee..4cb418e 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -229,7 +229,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
 		u8 d8[4];
 	} dat;
 
-	freqreg = (u64) freq * (u64) (1 << 27);
+	freqreg = (u64)freq * (u64)BIT(27);
 	do_div(freqreg, st->mclk_hz / 4);
 
 	switch (reg) {
@@ -318,7 +318,7 @@ static ssize_t ad5933_show_frequency(struct device *dev,
 	freqreg = be32_to_cpu(dat.d32) & 0xFFFFFF;
 
 	freqreg = (u64)freqreg * (u64)(st->mclk_hz / 4);
-	do_div(freqreg, 1 << 27);
+	do_div(freqreg, BIT(27));
 
 	return sprintf(buf, "%d\n", (int)freqreg);
 }
@@ -452,9 +452,9 @@ static ssize_t ad5933_store(struct device *dev,
 
 		/* 2x, 4x handling, see datasheet */
 		if (val > 1022)
-			val = (val >> 2) | (3 << 9);
+			val = (val >> 2) | BIT(10) | BIT(9);
 		else if (val > 511)
-			val = (val >> 1) | (1 << 9);
+			val = (val >> 1) | BIT(9);
 
 		dat = cpu_to_be16(val);
 		ret = ad5933_i2c_write(st->client,
-- 
2.7.4
