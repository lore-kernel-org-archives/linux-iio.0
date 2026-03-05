Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DD734B43D
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772744663; cv=none; b=R037TtbuMDq9E6ziSUvuvBukcpRBq4siS2KfXF9NyXUkn5YKcL0duSGcA3gP2pseTS0QogzcurD93Uf5UOen43BrQ1m8vtowoIAzrgoNrMusi+KHOuWuyEE8ldyf8i5c6rHAfDBHhVvdnDIEhp35YA+zCdL7MSr+Wj8dgcw9D5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772744663; c=relaxed/simple;
	bh=RrTc5ZHztUuUqkH+At+TJQt4NUn4orTcyqFWueIoEvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMb3hqDR4FyzyMuMMyRjYWaKF3sY4i9uNOB81i/4W7DsooXojUnP0jQ0/4w3dflkOQC2c502lazWBoO9bvpNj2VrhkGyskL3df2H9sR5mHyi95oFiMdHV3RAdrckXbn/maNbhrkUYFaoOYDyWTAX7/SoZeF5hx8nM0vVNGjeGp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZub/Hd8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZub/Hd8"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-824ac5d28f9so8636755b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 13:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772744662; x=1773349462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PFqSaEYNCjidkzwHN5ZnhX/rwyXadMMMmVhe1scX/pA=;
        b=WZub/Hd896c+918E7xmFYVjPMWf2xXQndxomZz1rb+ZvtM45RwlPvQVxG0Hh2BYEe9
         N0Mioi+RlV+9+3U67mbk8JUN39xKZCKPpI1voFPlliSGVSd10iMsqDPraBoBUAvv2LvD
         P3sIEHxOF+wUK60kPkzz2RdPFhCcaAiWcbfp4qBCUaNNJE+U/7VDKMxfz2mo+0aS9mOU
         D8fc+iR8Jt2aF/90sXKALk66IelWomDxC2tHI8+EASM90y5NNdXeYtMxsCStxDnbwZ2F
         ceFtmCYr4l1FnX3uBm6NNLymReAyDAef2sAE6/b41m3AtxpY2pjOMa2EJljdkQP0rERs
         PhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772744662; x=1773349462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFqSaEYNCjidkzwHN5ZnhX/rwyXadMMMmVhe1scX/pA=;
        b=TdqDC2EOY0ex6UI14w60m0S1rjsv03BGOEmkgmAuQ6YynZAXBnPlVrY1pKqm/4W5zZ
         Ugwb61lp3wEhDS4KhNAxiIZK2NUr/JKxEhkH3iFOgjg95ACrOXfmN/HFX2MWyIPDZCet
         PihWy3go/SK94dbQTZXgi4xxH9Q2jSE6D9Z/JP+P2FPHMw4X11v1Kkx/Hg/9Pn5NmS2T
         ShjwsZgNVCQScxUs+J7g1ustk/x9RdSNUo2KCYBuKVB0RgUeTKCDUEqDG4R3F5P+z3OE
         DLlUznurzo9eN6w7c7gk9IwSSHZDgVaGy+pMUYT/xVykOLJWRXPTe8ePVETA8AUWauTq
         C5qA==
X-Forwarded-Encrypted: i=1; AJvYcCXpA06i2fE1P2wUYHyIezw+ANGPgIrUdb1sPoqpMTOmZb7qLCVcS3f4O24Epl4K0C1HWrq093ziq0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvqpzrKsJWkr1EdSX+CfQDCijIluqe7CxUyLzOOceSTZ6fj+JN
	G9RQgo74l4GSsyGC4sjaIl7oyMEEKbLw7NiB2+v4WrQzGkZMPSg2hr/ofY3xJg==
X-Gm-Gg: ATEYQzzwuthdOz6PQS6JcKS5Nt8bIZofnFlhPLsHMaPdjmVmoBvsjrxG8IxxSMyFpAN
	RASdUBLcRc0uT8JDEozfq4aBcPcGTVOVQgP1gTyaq0yH2HTCcAlfSFmS/zWCwAFEyix+l3X5JQS
	L5Ap3ZUqR+C4rUfp/Q7i5hehK0tKEQxBOBE30Fbw3eXUpkZVxSwK2DEIouApRuEvJEFZr7mPMY+
	HwDVt4ZpoDeuQ/ln4mATPXCODPFc20sXCnJK6/A5Uj2eL+8g4td6u5g4ALP6DVk3JeLaAlQOW5O
	4WVdhEYqjtL5F5Pg7esrx7eOhhJ6vpbg50VxAsiiPUHzAWXT+lfdcuiVUxAEc21l6iXrsNROy3S
	wamqwPF/3h9P9zKgAdVgwL7jvhJpp5fUfuPOvi4sTHUUAIymfXfdb4P4bRlmH4LCUNEfGvLoSsc
	2ex+oYovtF/EIDpiVBbEuCMeff
X-Received: by 2002:a05:6a00:1c9a:b0:829:9130:e698 with SMTP id d2e1a72fcca58-8299130ecb8mr1738523b3a.64.1772744661731;
        Thu, 05 Mar 2026 13:04:21 -0800 (PST)
Received: from arch ([2409:40c2:542d:796b:d56f:9c25:f250:525e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a05c0b0sm21854421b3a.61.2026.03.05.13.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 13:04:20 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com,
	linux-staging@lists.linux.dev
Subject: [RFC PATCH] staging: iio: ad9832: modernize ABI and remove dds.h dependency
Date: Fri,  6 Mar 2026 02:33:47 +0530
Message-ID: <20260305210347.120446-1-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD9832 driver currently relies on legacy custom IIO macros defined
in dds.h. This triggers checkpatch.pl warnings (NON_OCTAL_PERMISSIONS)
and, more importantly, exposes a non-standard sysfs ABI (e.g.,
frequency0, frequency1, phase0-3) directly to user space.

This patch removes the custom macros and migrates the driver to standard
IIO API mechanisms:
- Standard attributes (frequency, phase) now use info_mask_separate.
- Non standard specific toggles (frequencysymbol, phasesymbol,
  pincontrol) have been migrated to an ext_info array.
- Remove dds.h header dependency.
- Pointless frequency_scale and phase_scale attributes are dropped as
  suggested by Jonathan in
  https://lore.kernel.org/linux-iio/20251231180939.422e9e62@jic23-huawei/

NOTE: This patch introduces an intentional ABI changes. The non-standard
attributes (out_altvoltage0_frequency0, etc.) have been removed. They
are replaced by standard attributes (out_altvoltage0_frequency and
out_altvoltage0_phase). Routing to correct register while writing is
handled by checking currently active frequencysymbol or phasesymbol.

Testing: This patch has been strictly compile-tested. I do not have
access to physical AD9832 hardware. I am submitting this as an RFC to
see if these changes are acceptable, and to ask if someone with physical
hardware could test thisg and provide a Tested-by tag.

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
---
This patch is heavily inspired from discussions in following
thread.
https://lore.kernel.org/linux-iio/20251215190806.11003-1-tomasborquez13@gmail.com/

Since this is an RFC please let me know if these changes are acceptable.

 drivers/staging/iio/frequency/ad9832.c | 135 +++++++++++++++----------
 1 file changed, 80 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b87ea1781b27..066a1b9ee8d5 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -23,8 +23,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include "dds.h"
-
 /* Registers */
 #define AD9832_FREQ0LL		0x0
 #define AD9832_FREQ0HL		0x1
@@ -168,12 +166,63 @@ static int ad9832_write_phase(struct ad9832_state *st,
 	return spi_sync(st->spi, &st->phase_msg);
 }
 
-static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t len)
+static int ad9832_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ad9832_state *st = iio_priv(indio_dev);
+	int ret;
+	unsigned int addr;
+
+	if (val < 0)
+		return -EINVAL;
+
+	mutex_lock(&st->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY:
+		if (st->ctrl_fp & AD9832_FREQ)
+			addr = AD9832_FREQ1HM;
+		else
+			addr = AD9832_FREQ0HM;
+
+		ret = ad9832_write_frequency(st, addr, val);
+		break;
+
+	case IIO_CHAN_INFO_PHASE:
+		switch (FIELD_GET(AD9832_PHASE_MASK, st->ctrl_fp)) {
+		case 0:
+			addr = AD9832_PHASE0H;
+			break;
+		case 1:
+			addr = AD9832_PHASE1H;
+			break;
+		case 2:
+			addr = AD9832_PHASE2H;
+			break;
+		case 3:
+			addr = AD9832_PHASE3H;
+			break;
+		default:
+			addr = AD9832_PHASE0H;
+			break;
+		}
+		ret = ad9832_write_phase(st, addr, val);
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static ssize_t ad9832_write_ext_info(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     const char *buf, size_t len)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad9832_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 	unsigned long val;
 
@@ -182,17 +231,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		goto error_ret;
 
 	mutex_lock(&st->lock);
-	switch ((u32)this_attr->address) {
-	case AD9832_FREQ0HM:
-	case AD9832_FREQ1HM:
-		ret = ad9832_write_frequency(st, this_attr->address, val);
-		break;
-	case AD9832_PHASE0H:
-	case AD9832_PHASE1H:
-	case AD9832_PHASE2H:
-	case AD9832_PHASE3H:
-		ret = ad9832_write_phase(st, this_attr->address, val);
-		break;
+	switch ((u32)private) {
 	case AD9832_PINCTRL_EN:
 		st->ctrl_ss &= ~AD9832_SELSRC;
 		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
@@ -245,50 +284,34 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 	return ret ? ret : len;
 }
 
-/*
- * see dds.h for further information
- */
+#define AD9832_EXT_INFO(_name, _ident) { \
+	.name = _name, \
+	.write = ad9832_write_ext_info, \
+	.private = _ident, \
+	.shared = IIO_SEPARATE, \
+}
 
-static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
-static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
-static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
-static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
-
-static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
-static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
-static IIO_DEV_ATTR_PHASE(0, 2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
-static IIO_DEV_ATTR_PHASE(0, 3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
-static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL,
-				ad9832_write, AD9832_PHASE_SYM);
-static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
-
-static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
-				ad9832_write, AD9832_PINCTRL_EN);
-static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
-				ad9832_write, AD9832_OUTPUT_EN);
-
-static struct attribute *ad9832_attributes[] = {
-	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
-	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase2.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase3.dev_attr.attr,
-	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
-	NULL,
+static const struct iio_chan_spec_ext_info ad9832_ext_info[] = {
+	AD9832_EXT_INFO("pincontrol_en", AD9832_PINCTRL_EN),
+	AD9832_EXT_INFO("frequencysymbol", AD9832_FREQ_SYM),
+	AD9832_EXT_INFO("phasesymbol", AD9832_PHASE_SYM),
+	AD9832_EXT_INFO("out_enable", AD9832_OUTPUT_EN),
+	{ }
 };
 
-static const struct attribute_group ad9832_attribute_group = {
-	.attrs = ad9832_attributes,
+static const struct iio_chan_spec ad9832_channels[] = {
+	{
+		.type = IIO_ALTVOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY) |
+				      BIT(IIO_CHAN_INFO_PHASE),
+		.ext_info = ad9832_ext_info,
+	},
 };
 
 static const struct iio_info ad9832_info = {
-	.attrs = &ad9832_attribute_group,
+	.write_raw = ad9832_write_raw,
 };
 
 static int ad9832_probe(struct spi_device *spi)
@@ -321,6 +344,8 @@ static int ad9832_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad9832_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad9832_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad9832_channels);
 
 	/* Setup default messages */
 	st->xfer.tx_buf = &st->data;
-- 
2.53.0

