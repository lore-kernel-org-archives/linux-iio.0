Return-Path: <SRS0=Em96=3H=foxmail.com=chen.chenchacha@kernel.org>
From: Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH] iio:meter:ade7759: Removing use of deprecated macros
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, trivial@kernel.org,
 linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Message-ID: <51add231-117a-2fce-9ad8-d4d477707715@foxmail.com>
Date: Thu, 30 Mar 2017 14:41:11 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Removing use of deprecated macros(S_IRUGO, SIWUGO, S_IXUGO), and replaced with 4 gidit octal.

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 drivers/staging/iio/meter/ade7759.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 0b65f1847510..dbd106f28cb7 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -279,49 +279,51 @@ static int ade7759_reset(struct device *dev)
 }

 static IIO_DEV_ATTR_AENERGY(ade7759_read_40bit, ADE7759_AENERGY);
-static IIO_DEV_ATTR_CFDEN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CFDEN(0644,
		ade7759_read_16bit,
		ade7759_write_16bit,
		ADE7759_CFDEN);
-static IIO_DEV_ATTR_CFNUM(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CFNUM(0644,
		ade7759_read_8bit,
		ade7759_write_8bit,
		ADE7759_CFNUM);
 static IIO_DEV_ATTR_CHKSUM(ade7759_read_8bit, ADE7759_CHKSUM);
-static IIO_DEV_ATTR_PHCAL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_PHCAL(0644,
		ade7759_read_16bit,
		ade7759_write_16bit,
		ADE7759_PHCAL);
-static IIO_DEV_ATTR_APOS(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_APOS(0644,
		ade7759_read_16bit,
		ade7759_write_16bit,
		ADE7759_APOS);
-static IIO_DEV_ATTR_SAGCYC(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_SAGCYC(0644,
		ade7759_read_8bit,
		ade7759_write_8bit,
		ADE7759_SAGCYC);
-static IIO_DEV_ATTR_SAGLVL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_SAGLVL(0644,
		ade7759_read_8bit,
		ade7759_write_8bit,
		ADE7759_SAGLVL);
-static IIO_DEV_ATTR_LINECYC(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_LINECYC(0644,
		ade7759_read_8bit,
		ade7759_write_8bit,
		ADE7759_LINECYC);
 static IIO_DEV_ATTR_LENERGY(ade7759_read_40bit, ADE7759_LENERGY);
-static IIO_DEV_ATTR_PGA_GAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_PGA_GAIN(0644,
		ade7759_read_8bit,
		ade7759_write_8bit,
		ADE7759_GAIN);
-static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
		ade7759_read_16bit,
		ade7759_write_16bit,
		ADE7759_APGAIN);
-static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CH_OFF(
+		1, 0644,
		ade7759_read_8bit,
		ade7759_write_8bit,
		ADE7759_CH1OS);
-static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CH_OFF(
+		2, 0644,
		ade7759_read_8bit,
		ade7759_write_8bit,
		ADE7759_CH2OS);
@@ -458,7 +460,7 @@ static IIO_DEV_ATTR_TEMP_RAW(ade7759_read_8bit);
 static IIO_CONST_ATTR(in_temp_offset, "70 C");
 static IIO_CONST_ATTR(in_temp_scale, "1 C");

-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_SAMP_FREQ(0644,
		ade7759_read_frequency,
		ade7759_write_frequency);

--
2.11.0
