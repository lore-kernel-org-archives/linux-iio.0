Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpauth-dc2.online.net ([62.210.16.40]:48955 "EHLO
        smtpauth-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750899AbdCPNr7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Mar 2017 09:47:59 -0400
From: Miguel Robles <miguel.robles@farole.net>
To: jic23@kernel.org, gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Miguel Robles <miguel.robles@farole.net>
Subject: [PATCH] Staging: iio: frequency: use octal permissions instead of symbolic
Date: Thu, 16 Mar 2017 14:47:36 +0100
Message-Id: <1489672056-7957-1-git-send-email-miguel.robles@farole.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix checkpatch warnings:
Symbolic permissions are not preferred. Consider using octal permissions.

Signed-off-by: Miguel Robles <miguel.robles@farole.net>
---
 drivers/staging/iio/frequency/ad9832.c | 20 ++++++++++----------
 drivers/staging/iio/frequency/ad9834.c | 22 +++++++++++-----------
 drivers/staging/iio/frequency/dds.h    |  2 +-
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 8d40c8e..163a4ef 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -248,22 +248,22 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
  * see dds.h for further information
  */
 
-static IIO_DEV_ATTR_FREQ(0, 0, S_IWUSR, NULL, ad9832_write, AD9832_FREQ0HM);
-static IIO_DEV_ATTR_FREQ(0, 1, S_IWUSR, NULL, ad9832_write, AD9832_FREQ1HM);
-static IIO_DEV_ATTR_FREQSYMBOL(0, S_IWUSR, NULL, ad9832_write, AD9832_FREQ_SYM);
+static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
+static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
+static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
 static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
 
-static IIO_DEV_ATTR_PHASE(0, 0, S_IWUSR, NULL, ad9832_write, AD9832_PHASE0H);
-static IIO_DEV_ATTR_PHASE(0, 1, S_IWUSR, NULL, ad9832_write, AD9832_PHASE1H);
-static IIO_DEV_ATTR_PHASE(0, 2, S_IWUSR, NULL, ad9832_write, AD9832_PHASE2H);
-static IIO_DEV_ATTR_PHASE(0, 3, S_IWUSR, NULL, ad9832_write, AD9832_PHASE3H);
-static IIO_DEV_ATTR_PHASESYMBOL(0, S_IWUSR, NULL,
+static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
+static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
+static IIO_DEV_ATTR_PHASE(0, 2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
+static IIO_DEV_ATTR_PHASE(0, 3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
+static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL,
 				ad9832_write, AD9832_PHASE_SYM);
 static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
 
-static IIO_DEV_ATTR_PINCONTROL_EN(0, S_IWUSR, NULL,
+static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
 				ad9832_write, AD9832_PINCTRL_EN);
-static IIO_DEV_ATTR_OUT_ENABLE(0, S_IWUSR, NULL,
+static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
 				ad9832_write, AD9832_OUTPUT_EN);
 
 static struct attribute *ad9832_attributes[] = {
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index f92ff7f..a56d17d 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -291,7 +291,7 @@ ssize_t ad9834_show_out0_wavetype_available(struct device *dev,
 	return sprintf(buf, "%s\n", str);
 }
 
-static IIO_DEVICE_ATTR(out_altvoltage0_out0_wavetype_available, S_IRUGO,
+static IIO_DEVICE_ATTR(out_altvoltage0_out0_wavetype_available, 0444,
 		       ad9834_show_out0_wavetype_available, NULL, 0);
 
 static
@@ -311,27 +311,27 @@ ssize_t ad9834_show_out1_wavetype_available(struct device *dev,
 	return sprintf(buf, "%s\n", str);
 }
 
-static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, S_IRUGO,
+static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
 		       ad9834_show_out1_wavetype_available, NULL, 0);
 
 /**
  * see dds.h for further information
  */
 
-static IIO_DEV_ATTR_FREQ(0, 0, S_IWUSR, NULL, ad9834_write, AD9834_REG_FREQ0);
-static IIO_DEV_ATTR_FREQ(0, 1, S_IWUSR, NULL, ad9834_write, AD9834_REG_FREQ1);
-static IIO_DEV_ATTR_FREQSYMBOL(0, S_IWUSR, NULL, ad9834_write, AD9834_FSEL);
+static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9834_write, AD9834_REG_FREQ0);
+static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9834_write, AD9834_REG_FREQ1);
+static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
 static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
 
-static IIO_DEV_ATTR_PHASE(0, 0, S_IWUSR, NULL, ad9834_write, AD9834_REG_PHASE0);
-static IIO_DEV_ATTR_PHASE(0, 1, S_IWUSR, NULL, ad9834_write, AD9834_REG_PHASE1);
-static IIO_DEV_ATTR_PHASESYMBOL(0, S_IWUSR, NULL, ad9834_write, AD9834_PSEL);
+static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9834_write, AD9834_REG_PHASE0);
+static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9834_write, AD9834_REG_PHASE1);
+static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL, ad9834_write, AD9834_PSEL);
 static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
 
-static IIO_DEV_ATTR_PINCONTROL_EN(0, S_IWUSR, NULL,
+static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
 	ad9834_write, AD9834_PIN_SW);
-static IIO_DEV_ATTR_OUT_ENABLE(0, S_IWUSR, NULL, ad9834_write, AD9834_RESET);
-static IIO_DEV_ATTR_OUTY_ENABLE(0, 1, S_IWUSR, NULL,
+static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL, ad9834_write, AD9834_RESET);
+static IIO_DEV_ATTR_OUTY_ENABLE(0, 1, 0200, NULL,
 	ad9834_write, AD9834_OPBITEN);
 static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
 static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
diff --git a/drivers/staging/iio/frequency/dds.h b/drivers/staging/iio/frequency/dds.h
index fe53e732..d6ccd99 100644
--- a/drivers/staging/iio/frequency/dds.h
+++ b/drivers/staging/iio/frequency/dds.h
@@ -101,7 +101,7 @@
 
 #define IIO_DEV_ATTR_OUT_WAVETYPE(_channel, _output, _store, _addr)	\
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_out##_output##_wavetype,\
-			S_IWUSR, NULL, _store, _addr)
+			0200, NULL, _store, _addr)
 
 /**
  * /sys/bus/iio/devices/.../out_altvoltageX_outY_wavetype_available
-- 
2.7.4

