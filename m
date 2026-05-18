Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D3303CAE
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117737; cv=none; b=hE0t19Y5z0pqA9Lj6w2gzWtZYo09WM52DcLTiPL8BL2HM7HWIeOizrCgR6aNWUP4YOZz8uJDrIsN1+mfnscHvCdy37GfmOAik3vkPU4khky+0T7iLv44hUHvMOb0UIA6D0V32JenTVFbNjGTeqUlWMJUnfjiRnl2f38XslDQsIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117737; c=relaxed/simple;
	bh=V79vTSzD2XiaseIDeXSmTod1B9Ozq5m90ZL54VyrUcA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMQyTlo0C4NxvHFysj5w5ZNPh2g42Y088o1M5BVVc3E5u63315xTBcaIyKA5SJOtZGoR7WR6L1Fa97mR7otNZj19ppNhuL5GD1zErePukY7YHErfLcl3C6aYHC+UCh5syAGySOOjl7WX3QKyJpFEtp2V4LzuvFseyPbuYzqaPFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4NnwQzy; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4NnwQzy"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d87610513so32313761cf.3
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 08:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779117735; x=1779722535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=shyo4xlhnq/UPNypnKjG3zAawrSKPXg+C0Xsmz2uevc=;
        b=q4NnwQzyAm2ohkNsXb30/ixqM2a+ftgWQPnGHvqQlFI0ofHNdN9g+p62PH3Lt0qmJo
         nWQs/uFvBi21gXMeX2qx5fcnQu3ga8gs22Y1s+1Fbp9x0mjV/t0+anBizsa7q2XNDwaC
         FAJnKw0pQ8ciF78OX7VMOUXy5epeHvs9SlZ3XfSYroRA7tkr/GMUL+VNaMTArSZFCvaj
         L96CObdKkl24gDjpyvtQWJb3V9R+gonDNPnukh0ljWtkwk0g9R2XsIkTgyAgCkU5ElDO
         aOvR03DEudNBhEcXmEQ9+H0ZpBIICoDzhH7ipCuI/b/mOfLWmTDiiYfka8RxUEbpyZ35
         6vaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117735; x=1779722535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shyo4xlhnq/UPNypnKjG3zAawrSKPXg+C0Xsmz2uevc=;
        b=WZiDJByPEhfjl5tsi2FVUzg0cbevrikAH7s1jbVQqeuKpNhXLj6RrDOA4gGth/2VI8
         gEThcPdG/xlzdSr/RZoOuqFxHEl+k+Pa3mk11OFBj5Ny16ESI9zmusJggTeb7g1YlgtB
         YQzoUqB0pvKEI0uLcUlIqJcYirG6cWRpEKRIwZDSdxa1OS9ShuJ0bQgffS/oX3hwS9xY
         ks1ewhvDbN/yTPUAtnb+rmiazccnW2HPp9GTD9PtbT5XxffJlZf1UCB+FGVgj403z8LK
         LR5d2BCDpketZazdab8YoD9gqO/D/Y+z5hKQ0Gbv97yFbWiNqa6yCTAGbwYYrkMtgoq9
         NpdQ==
X-Gm-Message-State: AOJu0Ywi1N/+0DwDlJAFcPZs7Z1sU4Ea6j9nb78h9nzC6OjXhRzM34AL
	ghtL+bPvcWtnQfRfwblPg08hbPyPWheqyip7C+yMKyGDIEjCtXk8b093cv+vrvGSE1Q=
X-Gm-Gg: Acq92OHIK9CzWLLTcX1iPyDbD2S+jQHdE6WLiLxqoZBL3oOh+O3ro4hoBDCam7V0nSL
	KKqeAdQr8JopDdK0iTG0ct1HO2H4EOQECYlWD2CadsgClxmnBMmp9ySYmGmfTOni3iFfRxrL1Bm
	jejCkZ8phksUIfJWUuWO9r6cRfdGSjBcRIeXGBZ2jsAo7+BnlxHtjs9diTiNES3QqASDyilAtI/
	AY8Vwgbu8b7qDlqw7+H4qeQJD6Bq7Y/BcvPPEKbEE9EUIxuxZ6g5MmtHWkWIA9MCi1iesKERmsJ
	ZTULgswrSqofyatUN3KcGYpP0/ruOFhAfjdjafLqKseCBX0YKgumUrQnSq9wbNzpAHgIvW2M0in
	E+imaLcmN0uQZKhNOOeXGn+nM8H13srhHG5FM+fHRjuPjRLSCqPeGFyGvIwNlDIzp9lzVeC/Zkc
	vA/Rwp+iD5P6w2Jj/aRHOg9z/ZExzzah7Fg1S7lohMAFc=
X-Received: by 2002:a05:622a:4d4f:b0:510:141d:9d05 with SMTP id d75a77b69052e-5165a007379mr226162431cf.7.1779117734486;
        Mon, 18 May 2026 08:22:14 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3619061dsm59993976d6.28.2026.05.18.08.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:22:13 -0700 (PDT)
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Google-Original-From: Marcelo Schmitt <marcelo.schmitt@analog.com>
Date: Mon, 18 May 2026 12:22:29 -0300
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: [PATCH v1 4/4] iio: adc: ltc2378: Enable triggered buffer data
 capture
Message-ID: <986a75b1c92d1a3f0607d1671241db1c8d2ac019.1779117444.git.marcelo.schmitt1@gmail.com>
References: <cover.1779117444.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779117444.git.marcelo.schmitt1@gmail.com>

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

Enable users to run triggered data captures with LTC2378 and similar ADCs.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/Kconfig   |  1 +
 drivers/iio/adc/ltc2378.c | 39 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b5368ee783f7..265c4a2b5fb7 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -944,6 +944,7 @@ config LTC2378
 	depends on SPI
 	depends on GPIOLIB || PWM
 	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	imply LTC2378_OFFLOAD_BUFFER
 	help
 	  Say yes here to build support for Analog Devices LTC2378-20 and
diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
index fdbe919d45d5..993e6b09bb41 100644
--- a/drivers/iio/adc/ltc2378.c
+++ b/drivers/iio/adc/ltc2378.c
@@ -10,6 +10,9 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 
@@ -272,6 +275,25 @@ static const struct iio_info ltc2378_iio_info = {
 	.read_raw = &ltc2378_read_raw,
 };
 
+static irqreturn_t ltc2378_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ltc2378_convert_and_acquire(st);
+	if (ret < 0)
+		goto err_out;
+
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+				    pf->timestamp);
+
+err_out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int ltc2378_probe(struct spi_device *spi)
 {
 	struct iio_chan_spec *ltc2378_chan;
@@ -305,11 +327,11 @@ static int ltc2378_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
 				     "failed to get CNV GPIO");
 
-	ltc2378_chan = devm_kzalloc(&spi->dev, sizeof(struct iio_chan_spec), GFP_KERNEL);
+	ltc2378_chan = devm_kzalloc(&spi->dev, 2 * sizeof(struct iio_chan_spec), GFP_KERNEL);
 	if (!ltc2378_chan)
 		return -ENOMEM;
 
-	*ltc2378_chan = (struct iio_chan_spec) {
+	ltc2378_chan[0] = (struct iio_chan_spec) {
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
@@ -327,7 +349,18 @@ static int ltc2378_probe(struct spi_device *spi)
 	ret = ltc2378_offload_buffer_setup(indio_dev, spi);
 	if (ret == -ENODEV) {
 		/* SPI offloading is unavailable. Fall back to triggered buffer. */
-		dev_notice(dev, "buffered data capture not supported\n");
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      &iio_pollfunc_store_time,
+						      &ltc2378_trigger_handler,
+						      NULL);
+		if (ret)
+			return ret;
+
+		/* Add timestamp channel */
+		struct iio_chan_spec ts_chan = IIO_CHAN_SOFT_TIMESTAMP(1);
+
+		ltc2378_chan[1] = ts_chan;
+		num_iio_chans++;
 	} else if (ret) {
 		return dev_err_probe(dev, ret, "error on SPI offload setup\n");
 	} else {
-- 
2.53.0

