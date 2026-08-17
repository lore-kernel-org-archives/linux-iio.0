Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A20471CE9
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001101; cv=none; b=Vzs0/Wb+U3yhE0LdrJ4l9xWK3x2iEqbMqeJitHE2Y5OI5c0RVbT01zEPJZdiJgsc9SRCADBDIe2k5WwB//4YjQSUhp0zL5mb8wXjtHdKP++i2uQ1TiAAjUt7MzaqwhN8QFMivXTypL74m7OXchYGwITr7X3nw1G1NIz/xNtMBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001101; c=relaxed/simple;
	bh=aNLYiY8tiU4jrBfATIo+G+2FSehF6lKWMP6uC1EN+YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQ+boy/HEjJA+zS5eItXoQi+Kb884a2OuPmnkVnlzmF90wJZyRFotfk97/cjVIU9DvE2CtXFElA6fSM5ZychvlosUy6OM65IrUj53DqS31HGnoIgcv+E5ECvTPzIx5psRnzJ84J6F6TzvQkW8+SP5d2oN1TJXBscmXhfLryD+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajBla6Ml; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajBla6Ml"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f7027ca11so2398174f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 14:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787001098; x=1787605898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Sn4eADzJ/6sfHwf7n+bx/UFgtIfsM24y9dSKsP+YBs=;
        b=ajBla6MlitU53YnDq7XkgpZcQBFZ6Q3axctz2td5PY3GTwjHHWmxE8b1hS2nkPrBWW
         /uyIluund1n08nibSwQXztJnQTdg4OSp7WBqIry0wQYQREfiEITrqYVxEgUobhiYx8LV
         2A4tnR9MgSfwS0HY+6jIMEopwEPR0+YcOCIYWXtCwE7jNOjLU61gQrIMHKaJDXFc5ncG
         mdIMJEYk6PtxZKL43e3aspFdUHmaUJQqUa/pBQCZOYhA8dhIy+8Ara+Hgp01vgxrss1E
         p1evCRrVF5ZsEIfqfWgTaN8gvz3+OJGy4mSMohO8/yfoDM0ZB1jXYDwQCg7uF6n2e4zt
         RihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001098; x=1787605898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Sn4eADzJ/6sfHwf7n+bx/UFgtIfsM24y9dSKsP+YBs=;
        b=bmldj4k3/ruLIc7068xP24gxSUBSag7A2IcTDf4f9czL7cuzASCyEawgX1ewqOHBlJ
         gvltbuF+0xYaUWSUcmtltXMQ08Z7n9qfxCa2sOdZmgOZr+gtSJAG2Vt1IpQ+9o0PWiV4
         BJSQaQz/3+tFUyqvGsu0N91wRj/C8R02MFy7+15sOrw9YZspA1Na6QNgrWy7G+gPQgl8
         IGq33cm/BAzJ6rkDagsRjdjdH44aAavNq0QX5mGA7QHrLN8GoRThgSWhdodSkaruRWkH
         +8PbjeKpNqwKdGOCCjDDWgfIU9ZBhAlUhHesWoTsqsplZ6JP2p9I25dj9B0I7YfVMTWK
         wxfw==
X-Forwarded-Encrypted: i=1; AHgh+Roxx2LCnhqddxTg8Y1Sctj3XrON5+66kkfxv+bB2IpDeZnMn3iJW3allm5Ke5deN6mu5Ueq/32cNBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKNMO0djckT5kBxDkmOshGNIhC5C4j+cWWkcV6p/aRzEA4J4Y
	cQLm2xlhAqsQsmJ2VCU3BNlt9yhebYfPfVnPBzA0kW/bMUWJ4BtsZn26
X-Gm-Gg: AR+sD11mYUG/UBDICc0cid8h82+sgMBhNsIaPH125d0ArNH/UdNBTBC64z4w5eGQesp
	ht+s7eBHR3SF/Z8UIwTxRoJUKf6fe/TlKmktWnlYlhHJ0qzsQQNV9Ks9En8lWBF9TMr0yBUawhj
	mu8R1D80ao9oEeWMSDUsHED6xxS6YgtxGOL6mnlnzUSn6jsNuTOuCDBEf0V7qIB2R+kxllgvzt5
	cd6X9Q6Ad4YGAPtjIT8Ckm7nIYdymggglsliN0Y6Yrc7WBrxYEULL09qU61gLbk5lJEG+BTqcEa
	HOR0s5arqVaMk/iGrFqaPtaC5s4GAqiFCbMoujP8XCz7hVHUKD8w0ZY83FmuP+/RlmrIBq0KNep
	wZVQiPtriYDmr3U4sXwetEfC7JRtQYAIBd/Z99uXjiWHHYyrWXH4DZ1xnfmaDoqLfVV/eqfxw/F
	FKTK0P/X3I79w5eGPYXpMSjm0HMRxbc5+3oqgi7JlQjFMLNG1HWMIg9bb1itLRXQsqa2JX/QlQV
	VTMgYruQK8o
X-Received: by 2002:a05:600c:4614:b0:499:858f:2653 with SMTP id 5b1f17b1804b1-49987929193mr291105475e9.2.1787001097786;
        Mon, 17 Aug 2026 14:11:37 -0700 (PDT)
Received: from fedora ([105.74.73.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996176b95sm134587625e9.10.2026.08.17.14.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:11:37 -0700 (PDT)
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
Subject: [PATCH v4 4/6] iio: dac: ad5504: introduce local lock to protect state and spi transfers
Date: Mon, 17 Aug 2026 17:11:13 -0400
Message-ID: <20260817211118.21833-5-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817211118.21833-1-0rayn.dev@gmail.com>
References: <20260817211118.21833-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD5504 driver currently lacks locking, exposing it to several
multi-threading race conditions:
1. The shared DMA-safe SPI transfer buffers (st->data) can be
   corrupted if multiple threads trigger read_raw or write_raw
   simultaneously.
2. The ad5504_write_dac_powerdown() routine executes a sequence of
   back-to-back SPI writes (a CTRL register update followed by a
   mandatory NOOP). This entire sequence must be atomic.
3. Internal state variables like pwr_down_mask and pwr_down_mode
   can be read and modified concurrently.

Introduce a mutex in the ad5504_state structure and initialize it via
devm_mutex_init() in probe. Use the modern scoped guard(mutex) macro
at the top-level public IIO callbacks (read_raw, write_raw, and the
powerdown attributes) to safely serialize access to the device state
and the SPI bus.

In ad5504_read_raw() and ad5504_write_raw(), guard(mutex) is scoped to
the IIO_CHAN_INFO_RAW case only, since IIO_CHAN_INFO_SCALE merely reads
vref_mv, which is fixed at probe time and never modified afterward and
therefore needs no serialization. Because guard(mutex) declares a
cleanup-scoped variable, it cannot appear directly after a case label;
wrap the case body in a compound statement (case IIO_CHAN_INFO_RAW: {
... }) to give it the block scope it requires.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
Note: The concurrency race conditions addressed in this patch were 
originally reported by the Sashiko bot:
https://sashiko.dev/#/patchset/20260509142047.30302-1-0rayn.dev@gmail.com

 drivers/iio/dac/ad5504.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 55ce7e49e0e0..87946cdf69e7 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -7,12 +7,14 @@
 
 #include <linux/array_size.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/kstrtox.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
@@ -49,10 +51,12 @@
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
@@ -103,7 +107,8 @@ static int ad5504_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (m) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->lock);
 		ret = ad5504_spi_read(st, chan->address);
 		if (ret < 0)
 			return ret;
@@ -111,6 +116,7 @@ static int ad5504_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_mv;
 		*val2 = chan->scan_type.realbits;
@@ -128,11 +134,13 @@ static int ad5504_write_raw(struct iio_dev *indio_dev,
 	struct ad5504_state *st = iio_priv(indio_dev);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->lock);
 		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
 		return ad5504_spi_write(st, chan->address, val);
+	}
 	default:
 		return -EINVAL;
 	}
@@ -148,6 +156,7 @@ static int ad5504_get_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5504_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
 	return st->pwr_down_mode;
 }
 
@@ -156,6 +165,7 @@ static int ad5504_set_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5504_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
 	st->pwr_down_mode = mode;
 
 	return 0;
@@ -173,6 +183,7 @@ static ssize_t ad5504_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5504_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
 	return sysfs_emit(buf, "%d\n",
 			  !(st->pwr_down_mask & (1 << chan->channel)));
 }
@@ -185,6 +196,7 @@ static ssize_t ad5504_write_dac_powerdown(struct iio_dev *indio_dev,
 	int ret;
 	struct ad5504_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
 	ret = kstrtobool(buf, &pwr_down);
 	if (ret)
 		return ret;
@@ -284,6 +296,10 @@ static int ad5504_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
 	if (ret < 0)
 		return ret;
-- 
2.55.0

