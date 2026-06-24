Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811D21D416C;
	Wed, 24 Jun 2026 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267404; cv=none; b=i9b7/Gqz1U0ZBs66Tcz6Vm3/mwL+NDp1SbC/1wC6+oVXO1Bfnkw9bBwbffWqe9r6aBLwmdl0/4MrHr9QBYqTN88cNjfEOCddgBCRc/Cqz5lwk30U8iwDqGO47jAPpDfMcz/PRdBNZjoGEJeHAZXhE7Fuf8v5wqJo2A/bghXYrqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267404; c=relaxed/simple;
	bh=r3Rgck32IaxExe3w1xrWOfBDcmRWz3RJFduOOH3eYF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXj+3lr8hhIkUlY3d9wwyetdse7VKf2n4EkCy21OQDSi05z2i0BYewpsW1olJkc1LAbGarsDrsiSb2m1g/b/GkOMgQ5jVHu48v162Z9U8lpHgAKK6ojBWCVm835yD17Cfbeb3uD7fgUJ/96p3vqDET4XSTygHozfnB3tL1xlTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ohE+wJPT; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ohE+wJPT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ih
	ZX/jCBy52pDyWMe+hAlovUDY+K/FWWneiAoRBDgRs=; b=ohE+wJPTXGfGX5O/bT
	JGlctVGKdA+3iqJbhnvmHI06d4h5uiIJggz+oWXiAhgb2CkY5NmXlkwHe8QT76YG
	iuFP+7OuTxjcLhpNWBsxWeKsLG/ZcQ1NLojKnspYfygU+m4vmHFNa1PggNvL9uNl
	/QJJZf1KbzObdCXh4RqWr3Y1I=
Received: from Ubuntu.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3Q1vtPTtqprHPFQ--.18191S2;
	Wed, 24 Jun 2026 10:16:14 +0800 (CST)
From: Xiaofeng Yuan <xiaofengmian@163.com>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiaofeng Yuan <xiaofengmian@163.com>
Subject: [PATCH] staging: iio: frequency: reorder dds.h macro parameters to match IIO convention
Date: Wed, 24 Jun 2026 02:16:12 +0000
Message-ID: <20260624021612.23808-1-xiaofengmian@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3Q1vtPTtqprHPFQ--.18191S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw48Xw1DCr4UZw4kGr1ftFb_yoWftrWrpa
	4IgFZ0vr1UJFs5tFykAF1UWr98ZwnF9Fn8WFyv9w4rXa17trn2kr10va48tF1kJaykX3yx
	JFn7Gr97uFWkKr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pinqXkUUUUU=
X-CM-SenderInfo: p0ld0w5hqjzxldq6il2tof0z/xtbC5g7z9mo7Pe6jGQAA3V

The IIO subsystem convention requires that the file permission
(_mode) parameter be the first argument of IIO_DEV_ATTR_* macros.
The dds.h macros had _mode after _channel, causing checkpatch to
misinterpret the channel number as a permission value.

Reorder the parameters so _mode is first, matching the convention
established by IIO_DEV_ATTR_SAMP_FREQ in include/linux/iio/sysfs.h.

Update all callers in ad9834.c and ad9832.c accordingly.

Compile tested.

Signed-off-by: Xiaofeng Yuan <xiaofengmian@163.com>
---
 drivers/staging/iio/frequency/ad9832.c | 20 ++++++++++----------
 drivers/staging/iio/frequency/ad9834.c | 22 +++++++++++-----------
 drivers/staging/iio/frequency/dds.h    | 24 ++++++++++++------------
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 659821a1e..2dfdd0d28 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -253,22 +253,22 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
  * see dds.h for further information
  */
 
-static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
-static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
-static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
+static IIO_DEV_ATTR_FREQ(0200, 0, 0, NULL, ad9832_write, AD9832_FREQ0HM);
+static IIO_DEV_ATTR_FREQ(0200, 0, 1, NULL, ad9832_write, AD9832_FREQ1HM);
+static IIO_DEV_ATTR_FREQSYMBOL(0200, 0, NULL, ad9832_write, AD9832_FREQ_SYM);
 static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
 
-static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
-static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
-static IIO_DEV_ATTR_PHASE(0, 2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
-static IIO_DEV_ATTR_PHASE(0, 3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
-static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL,
+static IIO_DEV_ATTR_PHASE(0200, 0, 0, NULL, ad9832_write, AD9832_PHASE0H);
+static IIO_DEV_ATTR_PHASE(0200, 0, 1, NULL, ad9832_write, AD9832_PHASE1H);
+static IIO_DEV_ATTR_PHASE(0200, 0, 2, NULL, ad9832_write, AD9832_PHASE2H);
+static IIO_DEV_ATTR_PHASE(0200, 0, 3, NULL, ad9832_write, AD9832_PHASE3H);
+static IIO_DEV_ATTR_PHASESYMBOL(0200, 0, NULL,
 				ad9832_write, AD9832_PHASE_SYM);
 static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
 
-static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
+static IIO_DEV_ATTR_PINCONTROL_EN(0200, 0, NULL,
 				ad9832_write, AD9832_PINCTRL_EN);
-static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
+static IIO_DEV_ATTR_OUT_ENABLE(0200, 0, NULL,
 				ad9832_write, AD9832_OUTPUT_EN);
 
 static struct attribute *ad9832_attributes[] = {
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 4359b358e..b232cb4a7 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -315,21 +315,21 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
  * see dds.h for further information
  */
 
-static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9834_write, AD9834_REG_FREQ0);
-static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9834_write, AD9834_REG_FREQ1);
-static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
+static IIO_DEV_ATTR_FREQ(0200, 0, 0, NULL, ad9834_write, AD9834_REG_FREQ0);
+static IIO_DEV_ATTR_FREQ(0200, 0, 1, NULL, ad9834_write, AD9834_REG_FREQ1);
+static IIO_DEV_ATTR_FREQSYMBOL(0200, 0, NULL, ad9834_write, AD9834_FSEL);
 static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
 
-static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9834_write, AD9834_REG_PHASE0);
-static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9834_write, AD9834_REG_PHASE1);
-static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL, ad9834_write, AD9834_PSEL);
+static IIO_DEV_ATTR_PHASE(0200, 0, 0, NULL, ad9834_write, AD9834_REG_PHASE0);
+static IIO_DEV_ATTR_PHASE(0200, 0, 1, NULL, ad9834_write, AD9834_REG_PHASE1);
+static IIO_DEV_ATTR_PHASESYMBOL(0200, 0, NULL, ad9834_write, AD9834_PSEL);
 static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
 
-static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL, ad9834_write, AD9834_PIN_SW);
-static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL, ad9834_write, AD9834_RESET);
-static IIO_DEV_ATTR_OUTY_ENABLE(0, 1, 0200, NULL, ad9834_write, AD9834_OPBITEN);
-static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
-static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
+static IIO_DEV_ATTR_PINCONTROL_EN(0200, 0, NULL, ad9834_write, AD9834_PIN_SW);
+static IIO_DEV_ATTR_OUT_ENABLE(0200, 0, NULL, ad9834_write, AD9834_RESET);
+static IIO_DEV_ATTR_OUTY_ENABLE(0200, 0, 1, NULL, ad9834_write, AD9834_OPBITEN);
+static IIO_DEV_ATTR_OUT_WAVETYPE(0200, 0, 0, ad9834_store_wavetype, 0);
+static IIO_DEV_ATTR_OUT_WAVETYPE(0200, 0, 1, ad9834_store_wavetype, 1);
 
 static struct attribute *ad9834_attributes[] = {
 	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
diff --git a/drivers/staging/iio/frequency/dds.h b/drivers/staging/iio/frequency/dds.h
index 2ebe68eb7..b2ca8bb97 100644
--- a/drivers/staging/iio/frequency/dds.h
+++ b/drivers/staging/iio/frequency/dds.h
@@ -11,7 +11,7 @@
  * /sys/bus/iio/devices/.../out_altvoltageX_frequencyY
  */
 
-#define IIO_DEV_ATTR_FREQ(_channel, _num, _mode, _show, _store, _addr)	\
+#define IIO_DEV_ATTR_FREQ(_mode, _channel, _num, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_frequency##_num,	\
 			_mode, _show, _store, _addr)
 
@@ -26,7 +26,7 @@
  * /sys/bus/iio/devices/.../out_altvoltageX_frequencysymbol
  */
 
-#define IIO_DEV_ATTR_FREQSYMBOL(_channel, _mode, _show, _store, _addr)	\
+#define IIO_DEV_ATTR_FREQSYMBOL(_mode, _channel, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_frequencysymbol,	\
 			_mode, _show, _store, _addr)
 
@@ -34,7 +34,7 @@
  * /sys/bus/iio/devices/.../out_altvoltageX_phaseY
  */
 
-#define IIO_DEV_ATTR_PHASE(_channel, _num, _mode, _show, _store, _addr)	\
+#define IIO_DEV_ATTR_PHASE(_mode, _channel, _num, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_phase##_num,		\
 			_mode, _show, _store, _addr)
 
@@ -49,7 +49,7 @@
  * /sys/bus/iio/devices/.../out_altvoltageX_phasesymbol
  */
 
-#define IIO_DEV_ATTR_PHASESYMBOL(_channel, _mode, _show, _store, _addr)	\
+#define IIO_DEV_ATTR_PHASESYMBOL(_mode, _channel, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_phasesymbol,		\
 			_mode, _show, _store, _addr)
 
@@ -57,7 +57,7 @@
  * /sys/bus/iio/devices/.../out_altvoltageX_pincontrol_en
  */
 
-#define IIO_DEV_ATTR_PINCONTROL_EN(_channel, _mode, _show, _store, _addr)\
+#define IIO_DEV_ATTR_PINCONTROL_EN(_mode, _channel, _show, _store, _addr)\
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_pincontrol_en,	\
 			_mode, _show, _store, _addr)
 
@@ -65,7 +65,7 @@
  * /sys/bus/iio/devices/.../out_altvoltageX_pincontrol_frequency_en
  */
 
-#define IIO_DEV_ATTR_PINCONTROL_FREQ_EN(_channel, _mode, _show, _store, _addr)\
+#define IIO_DEV_ATTR_PINCONTROL_FREQ_EN(_mode, _channel, _show, _store, _addr)\
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_pincontrol_frequency_en,\
 			_mode, _show, _store, _addr)
 
@@ -73,7 +73,7 @@
  * /sys/bus/iio/devices/.../out_altvoltageX_pincontrol_phase_en
  */
 
-#define IIO_DEV_ATTR_PINCONTROL_PHASE_EN(_channel, _mode, _show, _store, _addr)\
+#define IIO_DEV_ATTR_PINCONTROL_PHASE_EN(_mode, _channel, _show, _store, _addr)\
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_pincontrol_phase_en,	\
 			_mode, _show, _store, _addr)
 
@@ -81,7 +81,7 @@
  * /sys/bus/iio/devices/.../out_altvoltageX_out_enable
  */
 
-#define IIO_DEV_ATTR_OUT_ENABLE(_channel, _mode, _show, _store, _addr)	\
+#define IIO_DEV_ATTR_OUT_ENABLE(_mode, _channel, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_out_enable,		\
 			_mode, _show, _store, _addr)
 
@@ -89,8 +89,8 @@
  * /sys/bus/iio/devices/.../out_altvoltageX_outY_enable
  */
 
-#define IIO_DEV_ATTR_OUTY_ENABLE(_channel, _output,			\
-			_mode, _show, _store, _addr)			\
+#define IIO_DEV_ATTR_OUTY_ENABLE(_mode, _channel, _output,		\
+			_show, _store, _addr)				\
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_out##_output##_enable,\
 			_mode, _show, _store, _addr)
 
@@ -98,9 +98,9 @@
  * /sys/bus/iio/devices/.../out_altvoltageX_outY_wavetype
  */
 
-#define IIO_DEV_ATTR_OUT_WAVETYPE(_channel, _output, _store, _addr)	\
+#define IIO_DEV_ATTR_OUT_WAVETYPE(_mode, _channel, _output, _store, _addr)\
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_out##_output##_wavetype,\
-			0200, NULL, _store, _addr)
+			_mode, NULL, _store, _addr)
 
 /**
  * /sys/bus/iio/devices/.../out_altvoltageX_outY_wavetype_available
-- 
2.43.0

