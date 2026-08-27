Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8273F105E
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787860629; cv=none; b=ANB8XuiRN6pjLR1r7y7NXtGGgp0+ZjIuLPRMjZas3+zINzK1NOEeAVmnMysOz0q+ckL2IJmgXS/R5RNtp0C3Lfr5OtYF3K1eFyiKB6QEN38B8wn5+HuJvpCwgFlMrMEsGUPsGab/Yc6tHAF/pnA9nc5iI0JU5fKu0conhZSYG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787860629; c=relaxed/simple;
	bh=vDu5qVZi5+B2YTh94nK7d3oZgqw1oQXWOUqDYalHD4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TNRgeCNg+kArcfHvb3kk8HYoFqwkYzYJ+26qQUqmO6hzIbbr+0AA5559Wm7YFdwx4RVVNtaXH29zb6CfSXzl0zAhhdjcHIxxFd9ejpHD0iwwdswT1QpUFpp2eV0B1+8iAGPB+MB12cjY07mgkMiMMOmOpkV3xqrfBHeUqYmJ4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqFYZsOr; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqFYZsOr"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-cc147d86bebso260817a12.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 12:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787860627; x=1788465427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QKSwaBw0Qfs+/Q4v+yYjSyUPLlZIbYu5DPza0B2CzMo=;
        b=FqFYZsOrHipINoFni0BAz7C2EHuyWWsKI6CytT7CAJGPh7kMLccFbMocxC/ptl2MQ0
         qdsxcfJU1EmjlaoNaR9ne5h6wVhUVhowWQ9c/fyCuGbwqUCUQrF7HxRZwH0e0LHMmU7w
         mieHqL9OJXSDgE6AfUIc5liQaN6JwQrMf1t6EiB0rGUw//bstKENxO6GE5JWfI2tenOX
         7DXCcgf+2QcBTpmu1aa1NG5tAp8bviEAAzMXbuLvTvFF/6FyTW3nZkzNL0dg8OT4xnb8
         3FuedqydLb1bWUM35E2EPTju5f7Tka7EOSwdK6CJP5Zf0Bg/+bpzhD0tQHEz7lQI7aIT
         dufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787860627; x=1788465427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKSwaBw0Qfs+/Q4v+yYjSyUPLlZIbYu5DPza0B2CzMo=;
        b=tGiMjIvFvQC+96SJpnKKMIi8zTSD7UJJxNdtx0kKuo82HpQZ0snQqP62LuJO6JLAVF
         m1bPNqoJ2BCarl5wU3BEyXqZzG2tYNUp1eM3aPk63YPyU2GEhxfQb/TpgsRTum2HrPAz
         XuQDhHpIwzkkJviynQk4DgI34CM0XqJrQxVlj6AXjTwjcCDl/H/CYijqbgb2e7bXxAjV
         jtZXAeJxuMez5u3VpFVrYRDEyTCcAS31LBdnJypLlE1hc7yLEiTSAU7Osuo3nzutoa+p
         KYSStAMr3jFw5jJgy9u+ojBzNgcytgnY3Lorp981Sl1prVlgk5WI3XP1OkeCv9bYo3LR
         7Kug==
X-Forwarded-Encrypted: i=1; AHgh+Rqbv8y176KiMJQuFpMvCH+rIRULPeCWhleov0dUjyv6nK6wyWOXTnvndfbYVX/6bS8SGQmGaABf4kg=@vger.kernel.org
X-Gm-Message-State: AFuF++m69Z5tLBF5cxyLZLTfxJ9gjypfPk8f+fs0bRmUjEo/lu0fC56H
	zBl3KBZzAv+5VMBbi3ILQgNOkIjrCWDruN2xg+ekan06dYOGsZzepnuy
X-Gm-Gg: AR+sD13vzWZsOeMMVA8kEYQrJmDTuxMJuoato6s/0HChUsHOASFYCNElUbdMJUva35g
	GPMwu/BXiFueta+qUMbyFv2ftdeOyOMWujM8tuRdgJYE2eaC8LX/XjWeqkVL7sXBm2B+2XbEQv4
	KXu2ZuznjzarG91xpWrPwkRWBOdXcDwmht42sizDQyY90xgofS5mc5E1gu8xXlfzw7tZs1wFyrR
	JPN4uE72bfLTbwfSTZk3SvYe0FbpK/bZU8TJ2Si5NUUtkdZwB0ls3Xz690d1YicUVgUhaKUtiQJ
	c/l6KZ+UXAuyxuAOUEDKI4xMWDppQyI/EnhVHoI89qsD9c7diImf7FBZUurkmFkAMUtHgcTcwgZ
	zWRmt68OS213Vi751UBVGCegemp77GnfKgj0HNdmvrGes2cWztpavT514gezxi0Q1AiGb/tF801
	5Bcg16O55e+bDR98LMRWHzBdDgWtWwpsLvJyxsoWakJhGKjd8IG2ogUFoVbOjzrINjL+vyBcEw
X-Received: by 2002:a17:90b:4fd0:b0:38e:9784:dd47 with SMTP id 98e67ed59e1d1-3969ba3c181mr13031508a91.1.1787860627206;
        Thu, 27 Aug 2026 12:57:07 -0700 (PDT)
Received: from Mahmudul.. ([103.139.196.183])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3285a5f96efsm9258581eec.11.2026.08.27.12.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 12:57:06 -0700 (PDT)
From: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
To: jic23@kernel.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Subject: [PATCH v5] staging: iio: adc: ad7816: Use modern IIO attribute macros
Date: Fri, 28 Aug 2026 01:56:42 +0600
Message-Id: <20260827195642.12831-1-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the legacy IIO_DEVICE_ATTR() macros with the modern
IIO_DEVICE_ATTR_RW() and IIO_DEVICE_ATTR_RO() macros.

This includes renaming driver-specific callback functions to
standard <name>_show() and <name>_store() formats.

Signed-off-by: Md. Mahmudul Hasan Mabud <mdmahmudulhasan1511@gmail.com>
---
v5:
  - Converted to a standalone single patch (previously part of the v3/v4 series).
  - Updated commit message and fixed function header line lengths and wrapping based on Andy Shevchenko's feedback on v3.
    Link: https://lore.kernel.org/linux-iio/act9ovNVsJvWO6Cx@ashevche-desk.local/
v4:
  - Sent by mistake without updates.
v3:
  - Initial version (as patch 4/4 of the series).

 drivers/staging/iio/adc/ad7816.c | 64 ++++++++++++--------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 30644d2d7..62bbd7b34 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -116,9 +116,8 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
 	return ret;
 }
 
-static ssize_t ad7816_show_mode(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
+static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -128,10 +127,8 @@ static ssize_t ad7816_show_mode(struct device *dev,
 	return sysfs_emit(buf, "full\n");
 }
 
-static ssize_t ad7816_store_mode(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf,
-				 size_t len)
+static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -147,24 +144,19 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(mode, 0644,
-		ad7816_show_mode,
-		ad7816_store_mode,
-		0);
+static IIO_DEVICE_ATTR_RW(mode, 0);
 
-static ssize_t ad7816_show_available_modes(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static ssize_t available_modes_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
 {
 	return sysfs_emit(buf, "full\npower-save\n");
 }
 
-static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
-			NULL, 0);
+static IIO_DEVICE_ATTR_RO(available_modes, 0);
 
-static ssize_t ad7816_show_channel(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
+static ssize_t channel_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -172,10 +164,8 @@ static ssize_t ad7816_show_channel(struct device *dev,
 	return sysfs_emit(buf, "%d\n", chip->channel_id);
 }
 
-static ssize_t ad7816_store_channel(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf,
-				    size_t len)
+static ssize_t channel_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -205,14 +195,10 @@ static ssize_t ad7816_store_channel(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(channel, 0644,
-		ad7816_show_channel,
-		ad7816_store_channel,
-		0);
+static IIO_DEVICE_ATTR_RW(channel, 0);
 
-static ssize_t ad7816_show_value(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
+static ssize_t value_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -236,7 +222,7 @@ static ssize_t ad7816_show_value(struct device *dev,
 	return sysfs_emit(buf, "%u\n", data);
 }
 
-static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
+static IIO_DEVICE_ATTR_RO(value, 0);
 
 static struct attribute *ad7816_attributes[] = {
 	&iio_dev_attr_available_modes.dev_attr.attr,
@@ -266,9 +252,8 @@ static irqreturn_t ad7816_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static ssize_t ad7816_show_oti(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf)
+static ssize_t oti_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -286,10 +271,10 @@ static ssize_t ad7816_show_oti(struct device *dev,
 	return sysfs_emit(buf, "%u\n", chip->oti_data[chip->channel_id]);
 }
 
-static inline ssize_t ad7816_set_oti(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t len)
+static inline ssize_t oti_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -327,8 +312,7 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(oti, 0644,
-		       ad7816_show_oti, ad7816_set_oti, 0);
+static IIO_DEVICE_ATTR_RW(oti, 0);
 
 static struct attribute *ad7816_event_attributes[] = {
 	&iio_dev_attr_oti.dev_attr.attr,
-- 
2.34.1

