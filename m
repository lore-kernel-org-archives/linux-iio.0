Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F3370D79
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787867266; cv=none; b=NuuJUqwPvZdmB/Idqve6GyiLFyZDAssgJKQvs/cU4GF2iZByGptTn/KEOgsGJAgIA36Vn1B0QoEBGEYVR5lZuVUihex9LaezUVBRuQq7zCQVl7bNg3nfUlLHxRg2xQLGBMPybdkLEhJbcW86QI6RnbYHKkjFUS+k3BoSDK0gitc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787867266; c=relaxed/simple;
	bh=lCKmYmW8yf2l0SbBLQAKvKdKNtanvhtCwPx2DZVPfFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OBbneR6TOt55xSwUeLcGDz9Xg057iVIKtfASuBPQABacRULwynNJqyhmZzFgq6Cf47CN5IY0J/ebsUMrLn4VCvVNZVRAgZ0mnYu6/cpR+l6EhMcKO0ADJPY5c8Zx7XzEMiy0GtZgsnnuhmThd0hdxhKMgBooRsCgH6SbnuyijuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o5CJsApy; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5CJsApy"
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2cf02ecb572so1538945ad.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 14:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787867264; x=1788472064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IdbGRL67qpRJE5R55Xlt5nL99zqk3FRNJhY4AvBB8oU=;
        b=o5CJsApyjaNMYNYd8VTf7zt+MkP2JHWKRLhVYNV5ra9+J9x2DExZ0VmUEqY0Jjhm3P
         FVdP+dPADMy6l3URvVfduu/11OsWHqoBF19rvKwpL6+aOweVLlocU7j4uT62ctdtrE+x
         ZP2cZQE0XIK1EhG4vKz0WuewtwOSVpl0VeXoqrITETEFFT5X3N9n+8wqifH+M6oUebRP
         g0sHpfd7caBKwl9h8IWSkc5fooDt4w6Fg3xs8OhckPDY7c64UtH5ayBXauhRv5BZQx9U
         MVKmMlWxB0idcLLWQIo3j9NSoESVo+1fX9T1l68naWUF4IwUFZ7+8qRsSay8684Hqaya
         GaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787867264; x=1788472064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IdbGRL67qpRJE5R55Xlt5nL99zqk3FRNJhY4AvBB8oU=;
        b=IJ6ZKeXy+aiR5P/7+sGkHSC7k6OKEIdIlKcW2mkIp+BiHsEQ3H3DOnsQfagkSYwLU4
         tEzvmKCg9IpKNoylnxOBNDle8jpeorZ4JIX3/p4WLUOhCUr7BJZequHFfJHEqTem9Clj
         jGxsYyZJByB+tBZrki9J2oN51fa+uX9r4WqjDezdEy8TzRwgILIZINK3rpemtpBd9s6n
         iBjec6SuALlMrFuZ4Z4XBt5Oeyyf7ovydc/SurH+IxlNRGXscTx9XJxPPTQAn0EZfx/b
         NpDW6cXpcLo0D6Ss1GZRdkm4cXVhte8Gy66rBQCw3SY4kkwIe289GNEzJktv8OYVs3m4
         Swiw==
X-Forwarded-Encrypted: i=1; AHgh+RqqeQYAW85HzKSxlhpxBVwvv91IdmtaoFhNoiYXz2M0qa/tbjf/mrK49Rc2RiHsSEtun9/8IsSaI7U=@vger.kernel.org
X-Gm-Message-State: AFuF++kKEteRgnOFcRxy+HNjGnk7JWO9M47b/sD/PR0EKWUHEW/6KGz5
	FYZDrDFl2nsfWBTshh+6b2t12DizcsFvQbCtkcOHsjN34GZJe6Y2D/AV
X-Gm-Gg: AR+sD10PmrfcIKNpdLacPhS/GjjkWi7MsRg0F9rNGMsvmEFFozBYR4QbdbhDewK8CQ9
	zcGEKUI6nXz/3Rsp0oMcL317jMFdD1eKcJxopg3E7uzJ2G+FOkgDRpYxN6NLeGKSmVLoO6TtD05
	tYDVEJTMcvY/UdCVeluBLbS407sgEyVCeZDYYC5YBroGtvIigeJb0Qd8zJqvEN+ZUirriY0Ss2F
	XM3c5Al7vyuU8/ekZcmjQnnJEa+tk2CYcdJ2i/Totoo3dElWlYn7AqfNOkxS5XIOZ90GbkZa2DA
	zXKNaOnh8kAqW0EiZxeKvpNj5MN+kNtD0J1UKCQXXsg0kkoZeRTi89SpwbcHFUmjc6vurJAaPvD
	1fpE8E4CPbq0ErfzYGN0tUGEpcqdZDEaWv8/dWK7/3qZWiJadZZlIZGLj7d8IzyrM0eOfyAcJUe
	THIiEStThWQEBupzNeTG6KebYoXM0UA75GH88SaHotmjTExjUcQt+nQY2d2yJkZwJqLJufCw0x
X-Received: by 2002:a17:903:2a90:b0:2d7:1bfd:b240 with SMTP id d9443c01a7336-2d74dc4c2a1mr37262975ad.4.1787867264061;
        Thu, 27 Aug 2026 14:47:44 -0700 (PDT)
Received: from Mahmudul.. ([103.139.196.183])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8bc3d2sm25212613eec.21.2026.08.27.14.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 14:47:43 -0700 (PDT)
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
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v6] staging: iio: adc: ad7816: Use modern IIO attribute macros
Date: Fri, 28 Aug 2026 03:47:21 +0600
Message-Id: <20260827214721.19395-1-mdmahmudulhasan1511@gmail.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
v6:
  -Dropped extra blank lines based on Andy Shevchenko's feedback.
v5:
  - Converted to a standalone single patch (previously part of the v3/v4 series).
  - Updated commit message and fixed function header line lengths and wrapping based on Andy Shevchenko's feedback on v3.
    Link: https://lore.kernel.org/linux-iio/act9ovNVsJvWO6Cx@ashevche-desk.local/
v4:
  - Sent by mistake without updates.
v3:
  - Initial version (as patch 4/4 of the series).
 drivers/staging/iio/adc/ad7816.c | 69 +++++++++++---------------------
 1 file changed, 24 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 30644d2d7..e8c2c1bfe 100644
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
@@ -146,25 +143,18 @@ static ssize_t ad7816_store_mode(struct device *dev,
 
 	return len;
 }
+static IIO_DEVICE_ATTR_RW(mode, 0);
 
-static IIO_DEVICE_ATTR(mode, 0644,
-		ad7816_show_mode,
-		ad7816_store_mode,
-		0);
-
-static ssize_t ad7816_show_available_modes(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static ssize_t available_modes_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
 {
 	return sysfs_emit(buf, "full\npower-save\n");
 }
+static IIO_DEVICE_ATTR_RO(available_modes, 0);
 
-static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
-			NULL, 0);
-
-static ssize_t ad7816_show_channel(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
+static ssize_t channel_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -172,10 +162,8 @@ static ssize_t ad7816_show_channel(struct device *dev,
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
@@ -204,15 +192,10 @@ static ssize_t ad7816_store_channel(struct device *dev,
 
 	return len;
 }
+static IIO_DEVICE_ATTR_RW(channel, 0);
 
-static IIO_DEVICE_ATTR(channel, 0644,
-		ad7816_show_channel,
-		ad7816_store_channel,
-		0);
-
-static ssize_t ad7816_show_value(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
+static ssize_t value_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
@@ -235,8 +218,7 @@ static ssize_t ad7816_show_value(struct device *dev,
 	}
 	return sysfs_emit(buf, "%u\n", data);
 }
-
-static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
+static IIO_DEVICE_ATTR_RO(value, 0);
 
 static struct attribute *ad7816_attributes[] = {
 	&iio_dev_attr_available_modes.dev_attr.attr,
@@ -266,9 +248,8 @@ static irqreturn_t ad7816_event_handler(int irq, void *private)
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
@@ -286,10 +267,10 @@ static ssize_t ad7816_show_oti(struct device *dev,
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
@@ -326,9 +307,7 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
 
 	return len;
 }
-
-static IIO_DEVICE_ATTR(oti, 0644,
-		       ad7816_show_oti, ad7816_set_oti, 0);
+static IIO_DEVICE_ATTR_RW(oti, 0);
 
 static struct attribute *ad7816_event_attributes[] = {
 	&iio_dev_attr_oti.dev_attr.attr,
-- 
2.34.1

