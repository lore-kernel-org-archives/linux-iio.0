Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DF3B47F3
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307928; cv=none; b=IXA395wfOcPvLGP0kpITxgVwzvpz2rplJqmyyFfWEEdvaqJROGgiQr/zXCJdd7dI+g3WuQUDYk00oy078jRYPG3n8qA/9ZjZ8RZLd3ib6kp61WVhEnGv6a+7/BJXcOxvzUMUppjdd4MuPKazp93oEodKcfx1bd5xn2Ow0uTJRCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307928; c=relaxed/simple;
	bh=xBnxiN14VeU0fDSul+psuINaNYuBf1EnMjbrI5YxO5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dw6xq/hJKYwLDJ2qBr/VC1oUpbjSSYkcicN+VdHXQnFKfEjuu78nv2XlAEaKG2AvOFLBWw9b0deZHsEacpaTRzxZxrFli8qo0nPaYNEkEHcKLRyWv1gATnH7bOoYxqCRUdMuvdg82UF8kMRNpa1kOpcnadkuYZrjK1286yxgPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7wRqWO8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7wRqWO8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b966dd74so3549725e9.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787307916; x=1787912716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nLLSpwKmauDrKByG1roh80ilhu5DeGRufmbN2+oazIA=;
        b=F7wRqWO8w1p5Zx4yGLE0qHkX+bgGQPoq4RFioEwZqsgkRRYjRheNvqET1f0tkxldx9
         mDHjW6PSM++c/oA57rWcsMxkifVPiLgY2JcCO3KpSht950uZYMNqUUNSSJwYxtlnmLcI
         iDyAFxixG79Foost+SLFhXRY7R4X6TCcqT2IOx2bXp2OWDwgtI1fuN24SmeTxOeROHk3
         gZ82CLFhjTJl6d9aunCAJmlBFi2gjbevBLIGYkcs6ejXVyEKRdbCBJAxD0dtPqXa4aLL
         04PnYRjgHCwEiKLVVo15/MiIszU/O4kASp++ZqZvmEtJIFFXzrfMNE4AZSTJoc054T/b
         iwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307916; x=1787912716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nLLSpwKmauDrKByG1roh80ilhu5DeGRufmbN2+oazIA=;
        b=TUzc3HVWMhCGomTI/IU7lHTuMDqy4HwRqud/aFCMKINddgLhMjjPznr2WkdWJZFxS9
         43zYyZMV7RJUlzlzGY04ivrRbI+0lyy1wPoZGE+M8lau/xOj5DB9RfblGobocIZGR1u6
         lv9O2NNxl/O5A7BSGhwHbVkZKv6KfYL1CceYruD+I/LOTmxus0GfODh4fCCoO9z/6pYp
         QLhVOjbGW6A+zgg1dQluDU58ucK9Z9KAfQcbJbOHNAwg9BX08KNCi50Xtly7pGLCOdZy
         61Zcp+PoqYVM4kRg2me1VvkAut4XdvFKKyhF0XJTgWuJa9dL43aTNnF/R49JopSxP7al
         b6TQ==
X-Forwarded-Encrypted: i=1; AHgh+RpvjgVpvvATIRaQmGSR/peTGmvM1uUhB59Q1+CdKx/6GVDr3lUoEI502Huq8gh4pVnL8qXPSqDgALg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHRjhSdIIa1ZFTMlyJA5O2iO1nbvTnCwobiIlNiFXoKr1/ZzId
	kAfNZSmh4kKKx+0qR0ONQXpIHWpU3sBr0mnWWCdIPa4kBhzp0zymYTcs
X-Gm-Gg: AR+sD1119qUdEkeCjX9pSv7J1TgIBZKwtDrA1QMlENQW6QOwpDB9//Ha3RtXfA5bbyI
	oHojDrw4oxsxta6cNr7vIcUBuBMCWyolRO48GmleI9pKvxmU+HUAji1aFlZ0sarR/NCBhH6hfu3
	PZyA1Qvc2fHkxMhysiYZnJ8owKJCfnvAk8s2IzUDPYSVxMYWTw+PbwvVvRXQBFlY7haEhzv4Rr9
	2nRtYAzyIgG4Yzq+9M2N3BVRwEp/ukOKC4wUNka95xNH0fapn3n25PvDnh6J3ioOSOjbFZ2j2gr
	hf+onKYOvYiZSLA5knfprjYwVaPbcWe5xP84nSEdcdzLRg5jJwlIhMsGMmQyTRBulDoqiVTcp7G
	++1Abpq7E1pTQUWfrQlMr/crTQeDQxcb+faooOajzv1vGwBzP+Wkj7CA714fx3pETM9V4uBlNSM
	CFTQDx7pH5FAyoPbZeVBK6ppyA7c+j4naI9deMtgkG4McoLO5bdXbaCa8/5D8OgqRdEEeHCaq4T
	FnWLaV656cCBpM=
X-Received: by 2002:a05:600c:540e:b0:499:7ce1:d8a2 with SMTP id 5b1f17b1804b1-499b82b57afmr82696755e9.8.1787307916027;
        Fri, 21 Aug 2026 03:25:16 -0700 (PDT)
Received: from fedora ([105.74.130.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9ba5139sm11663155e9.2.2026.08.21.03.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:25:15 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v5 5/6] iio: dac: ad5504: introduce local lock to protect state and spi transfers
Date: Fri, 21 Aug 2026 06:24:47 -0400
Message-ID: <20260821102452.37407-6-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821102452.37407-1-0rayn.dev@gmail.com>
References: <20260821102452.37407-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver lacks locking, exposing concurrent access to the shared DMA
SPI buffers, the non-atomic CTRL+NOOP write sequence in powerdown, and
the pwr_down_mask/pwr_down_mode state variables.

Introduce a mutex via devm_mutex_init() and guard(mutex) at the IIO
callbacks to serialize access. In read_raw() and write_raw(), scope the
lock to IIO_CHAN_INFO_RAW only since IIO_CHAN_INFO_SCALE reads vref_mv
which is immutable after probe.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 799726eafdf2..489d2e03e9f6 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -8,11 +8,13 @@
 #include <linux/acpi.h>
 #include <linux/array_size.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
@@ -55,10 +57,12 @@
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
  * @data:		transfer buffer
+ * @lock:		lock to protect state and spi transfers
  */
 struct ad5504_state {
 	struct spi_device		*spi;
 	struct regulator		*reg;
+	struct mutex			lock;
 	unsigned short			vref_mv;
 	unsigned			pwr_down_mask;
 	unsigned			pwr_down_mode;
@@ -109,7 +113,9 @@ static int ad5504_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (m) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->lock);
+
 		ret = ad5504_spi_read(st, chan->address);
 		if (ret < 0)
 			return ret;
@@ -117,6 +123,7 @@ static int ad5504_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_mv;
 		*val2 = chan->scan_type.realbits;
@@ -134,11 +141,14 @@ static int ad5504_write_raw(struct iio_dev *indio_dev,
 	struct ad5504_state *st = iio_priv(indio_dev);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->lock);
+
 		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
 		return ad5504_spi_write(st, chan->address, val);
+	}
 	default:
 		return -EINVAL;
 	}
@@ -154,6 +164,8 @@ static int ad5504_get_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5504_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	return st->pwr_down_mode;
 }
 
@@ -162,6 +174,8 @@ static int ad5504_set_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5504_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	st->pwr_down_mode = mode;
 
 	return 0;
@@ -179,6 +193,8 @@ static ssize_t ad5504_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5504_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	return sysfs_emit(buf, "%d\n",
 			  !(st->pwr_down_mask & (1 << chan->channel)));
 }
@@ -191,6 +207,8 @@ static ssize_t ad5504_write_dac_powerdown(struct iio_dev *indio_dev,
 	int ret;
 	struct ad5504_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	ret = kstrtobool(buf, &pwr_down);
 	if (ret)
 		return ret;
@@ -290,6 +308,10 @@ static int ad5504_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	if (is_acpi_device_node(dev_fwnode(dev))) {
 		st->vref_mv = AD5504_VREF_ACPI_DEFAULT_mV;
 	} else {
-- 
2.55.0

