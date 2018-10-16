Return-Path: <SRS0=eLMt=M4=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][V2] iio: adc: ina2xx: add in early -EINVAL returns in case statements
Date: Tue, 16 Oct 2018 17:14:18 +0100
Message-Id: <20181016161418.29213-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Static analysis with CoverityScan is throwing warnings that specific
case statements are missing breaks.  Rather than adding breaks, add
return -EINVAL to the specific case statements to clarify the
error return paths. Fix also saves 50 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  21418	   4936	    128	  26482	   6772	drivers/iio/adc/ina2xx-adc.o

After:
  dec	    hex	filename
  21370	   4936	    128	  26434	   6742	drivers/iio/adc/ina2xx-adc.o

(gcc 8.2, x86-64)

Detected by CoverityScan, CID#1462408 ("Missing break in switch")

---

V2: use returns instead of break statements to keep with the
current style used in the switch statement.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/adc/ina2xx-adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index d1239624187d..bdd7cba6f6b0 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -250,6 +250,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 			*val2 = chip->shunt_resistor_uohm;
 			return IIO_VAL_FRACTIONAL;
 		}
+		return -EINVAL;
 
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		switch (chan->address) {
@@ -262,6 +263,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
 			*val = chip->range_vbus == 32 ? 1 : 2;
 			return IIO_VAL_INT;
 		}
+		return -EINVAL;
 	}
 
 	return -EINVAL;
-- 
2.19.1
