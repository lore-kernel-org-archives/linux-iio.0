Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778370;
	b=su25rJ2Lme1d8nh6oyqJviKN4gAbG6o9VL4FTgfeTZLyvDDonqrhndq/c8K7i9wpNQz8
	 Y8UjIhitNhVQRePsNLtvc7dl1fcmQsMqOiqstsLOnF4YEfwDMLxXF93Kelo+SxM3I2KXH
	 x3lGrxY6fRpQDVHzaQwJ4L+Bt4vtNlWAdFmM2r83xpg0t7Jn7paliBqAYDJvKTu/2KVy8
	 l2U8qsSBYKM62C3sWgfLlDA1/rb05HrONjKFLHs/RHfVepcZJMyIrxVNXe1hgrzDlu4BO
	 lqYSoT13rlh06ZLN+PFW5cm3kY6mXozmZhZ+DNNItklp7LPYNXWJDWvj+OdmIUmSZEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BBJheptbrK1Xj6AgFoLSOO83tzUQObgmpiZOvZNyRbc=;
	b=0aTyQI+aSIcXXMIj0c4PPu6xjMYSqabnQT8cgA9u5dQ+5C2jH/bCNLPHamffIUWw5Nyq
	 +futNGFsPzmphzg7KsTxOKRrqG8A9mcOhXdWDw7um+/oBK1S+8I7BNOWO9N2BD6ckiKHs
	 xusoHmYVYwyziWDlEI59LzchHfcbS9XeGJf6iGean+n6juQQpoJFvw02+4BeQ+nkbOxdv
	 dRYLwRVF55rI/8JLHWfV4dv5vr87SihoGeW+kDpJES4MU55FxEfAUqlqAxbZ+P9kMU1LB
	 I5mQS5HEqya1YDzXCDz2/+GSs+Jw6qe5f1PKpYcqyY7Y9Z8DJJ37dTX9ihcvJF9fnxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S1wCsyAz;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA317606A337
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 17:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA317606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S1wCsyAz
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a214af2076so6872335e9.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778368; x=1793383168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BBJheptbrK1Xj6AgFoLSOO83tzUQObgmpiZOvZNyRbc=;
        b=S1wCsyAzFbrPOz3szW9M3HoEJRLbY4JkJT960VF0lYEI9tX6BdSrl9uPcUclDOD0iY
         shgMpLvvAiVZT7NpFh1ihkfuNTOyBSZA6rzQPMXxVjpd/Pq0yTz4msy9jjmZUXo1WlI1
         yHSAlCtK0oAk98KFGVlmvEa65UAiip18GfRP0PSYYi810Bez5qZg3TsJaAq+eHMVUGiC
         bEBzQm1DuRrVEncdKHglsTgNg1Yk4UXUZlt10s0y2L++P0XhNjuAqmO3Jca4JAQwzabD
         paE/0lA1cl7UNVAmTqqCF+hN2Lq4KYkFVO/siNRPBQqTJMgUvY1Hj9THzYXBMbubZpN4
         sHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778368; x=1793383168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BBJheptbrK1Xj6AgFoLSOO83tzUQObgmpiZOvZNyRbc=;
        b=vQh6AaT9+HXQAgb+fOqmcGpIsH+XoqTLL8/Q2hus2yJEu0ToDHegV1X+jvtU+UYd6o
         wvYMkb/IrKjz66HULDPXwif0boTLO0iM7CS5Ci07NN5aDWQ4M+WukWQh/vwflzm1b9N7
         aqqGpF0PvnBDu4IumbI27Wyg0NwwV7j5v0BYyGez5kKN6c1CoXCO+DmHd0p+2gwHH+E1
         5S2SeWn8h+mKPqfHpOSAnnVIU+y038OfnK6viOK6oEVFyNIkwI+xPKaLybUkjOiA93wW
         RWqoImC640N1SLEYm3n5nYqyD35SOgyrzTqh61ZhuCLAL8FnZGFihtA1yvKRUPdVGach
         aiAg==
X-Gm-Message-State: AFq9FYIXf4nh6YUOqqzD5vbfo6qWymzIoE7WfxCQxKeQJBUCQF341Q5k
	6Pz/Zyh2b5TPusJrhkprGF19m7oSahr/TpAyWAjuOujGrIDpxtwAa0Gw
X-Gm-Gg: AYBFou0j6YwIQ6RlQuUHzli3NJ1SkfOXUn/2tBTdhFAzqLGAZK3TjTjzhjhvnbWZqsi
	1+5T+HjrQUrXS/qLuW60j1nF4BF38hZjKJj/fREdRfFSyAgofU01fxcpot8+agZdbD62tYjeKlz
	WXcGU4bCDpb4qFXOiYOHre9sX+5d0ySEVqoHnL0jaHW2QIgj6QE1bjGVJk5FqEzMjOIQ2/2dIUN
	uYDnS+eFvB2RJrYN7mYKVnmmPiQSzqYhqxr3SPs5nlvE6Ye/WM2HSBYUOZzOThfSvXsfkkMhZ58
	Hks93p71SHsuxoTHEP6r1MFGFrVcWNBFgXGfCCMH6mL3Z322G3QKEmI2zijCeYr+34ocAnqbFFG
	a4kiKeXUQZgfBAzSOSsJtqpfwdWLtUnbscUoKbAqfP8SuPLT7LF4hqZyAW/hLvqWnCv3lgxQnXK
	pWuuqES10xv85a4ayRNYy39UwCV6JnPqtzth+lcIa/w1DJyTr1XXxjlPr4QX1gCsZrK95DBI0qH
	TSdqMtE9sXCMxa2NPFDAhioQYLjhpKQsDLvUonVzmfM3iFpztNctLCNZeeJCxvMveVOEsdgFPgv
	Js2TXKdCTK0U+O3R5FSwRHcHxB8/htczgXYKn8cUR2iSadC7ujZhq2bkbiMLANdin8rZlRF/ayc
	F1hXYVUgOuXxBNIF3pYkBft9dGOzOh77t82R4c8oemRBE
X-Received: by 2002:a05:600c:1909:b0:4a2:1398:dd05 with SMTP id 5b1f17b1804b1-4a21398df21mr47236325e9.16.1792778368304;
        Fri, 23 Oct 2026 10:59:28 -0700 (PDT)
Received: from iku.example.org (host86-133-9-17.range86-133.btcentralplus.com. [86.133.9.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d37ca2asm1342800f8f.8.2026.10.23.10.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:59:27 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 3/8] iio: adc: rzt2h: Add chip-specific configuration
Date: Fri, 23 Oct 2026 18:59:14 +0100
Message-ID: <20261023175919.160103-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Prepare the driver for supporting SoCs with ADC IP that is similar to the
RZ/T2H ADC but may have different channel configurations.

Introduce chip-specific configuration for the channel template and number
of channels, and use it when setting up the IIO channels and DMA layout.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- No change

v1->v2:
- Returned -ENODATA in case device_get_match_data() returns NULL
---
 drivers/iio/adc/rzt2h_adc.c | 49 ++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 131904d97b8c..2ada8ecb2603 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -57,15 +57,21 @@
 #define RZT2H_ADC_DMA_PERIODS		64
 #define RZT2H_ADC_DMA_BUFFER_SAMPLES	(RZT2H_ADC_DMA_PERIODS * \
 					 RZT2H_ADC_DMA_PERIOD_SAMPLES)
-#define RZT2H_ADC_DMA_BUFFER_SIZE	(RZT2H_ADC_DMA_BUFFER_SAMPLES * \
-					 RZT2H_ADC_MAX_CHANNELS * \
-					 RZT2H_ADC_CHANNEL_BYTES)
 #define RZT2H_ADC_STOP_CYCLES		2
 
+#define RZT2H_ADC_FEATURE_CALIBRATION	BIT(0)
+
+struct rzt2h_adc_chip_info {
+	const struct iio_chan_spec *chan_template;
+	unsigned int num_channels;
+	u8 features;
+};
+
 struct rzt2h_adc_dma {
 	struct dma_chan *chan;
 	u16 *buf;
 	dma_addr_t addr;
+	size_t buf_size;
 
 	unsigned int period_index;
 	unsigned int period_bytes;
@@ -84,6 +90,7 @@ struct rzt2h_adc_dma {
 struct rzt2h_adc {
 	void __iomem *base;
 	struct device *dev;
+	const struct rzt2h_adc_chip_info *chip_info;
 
 	phys_addr_t phys_base;
 	struct rzt2h_adc_dma dma;
@@ -328,7 +335,8 @@ static void rzt2h_adc_dma_callback(void *data)
 static void rzt2h_adc_dma_calc_layout(struct iio_dev *indio_dev)
 {
 	struct rzt2h_adc *adc = iio_priv(indio_dev);
-	unsigned int hi = 0, lo = RZT2H_ADC_MAX_CHANNELS - 1;
+	const struct rzt2h_adc_chip_info *chip_info = adc->chip_info;
+	unsigned int hi = 0, lo = chip_info->num_channels - 1;
 	const struct iio_chan_spec *chan;
 	unsigned int sample_chans;
 	unsigned int first_chan;
@@ -349,7 +357,7 @@ static void rzt2h_adc_dma_calc_layout(struct iio_dev *indio_dev)
 	 * width, so pick the smallest power-of-two-aligned block of channels
 	 * that covers all enabled channels.
 	 */
-	for (sample_chans = 1; sample_chans < RZT2H_ADC_MAX_CHANNELS; sample_chans <<= 1) {
+	for (sample_chans = 1; sample_chans < chip_info->num_channels; sample_chans <<= 1) {
 		first_chan = round_down(lo, sample_chans);
 
 		if (first_chan + sample_chans > hi)
@@ -609,8 +617,8 @@ static int rzt2h_adc_parse_properties(struct rzt2h_adc *adc)
 	int ret;
 
 	ret = devm_iio_adc_device_alloc_chaninfo_se(adc->dev,
-						    &rzt2h_adc_chan_template,
-						    RZT2H_ADC_MAX_CHANNELS - 1,
+						    adc->chip_info->chan_template,
+						    adc->chip_info->num_channels - 1,
 						    &chan_array);
 	if (ret < 0)
 		return dev_err_probe(adc->dev, ret, "Failed to read channel info");
@@ -631,7 +639,7 @@ static void rzt2h_adc_free_dma_buf(void *p)
 {
 	struct rzt2h_adc *adc = p;
 
-	dma_free_noncoherent(adc->dev, RZT2H_ADC_DMA_BUFFER_SIZE,
+	dma_free_noncoherent(adc->dev, adc->dma.buf_size,
 			     adc->dma.buf, adc->dma.addr, DMA_FROM_DEVICE);
 }
 
@@ -651,13 +659,16 @@ static int rzt2h_adc_setup_dma(struct iio_dev *indio_dev)
 		return 0;
 	}
 
-	adc->dma.buf = dma_alloc_noncoherent(dev, RZT2H_ADC_DMA_BUFFER_SIZE,
+	adc->dma.buf_size = adc->chip_info->num_channels *
+			    RZT2H_ADC_DMA_BUFFER_SAMPLES *
+			    RZT2H_ADC_CHANNEL_BYTES;
+	adc->dma.buf = dma_alloc_noncoherent(dev, adc->dma.buf_size,
 					     &adc->dma.addr, DMA_FROM_DEVICE,
 					     GFP_KERNEL);
 	if (!adc->dma.buf)
 		return -ENOMEM;
 
-	dma_sync_single_for_device(dev, adc->dma.addr, RZT2H_ADC_DMA_BUFFER_SIZE,
+	dma_sync_single_for_device(dev, adc->dma.addr, adc->dma.buf_size,
 				   DMA_FROM_DEVICE);
 
 	ret = devm_add_action_or_reset(dev, rzt2h_adc_free_dma_buf, adc);
@@ -670,6 +681,7 @@ static int rzt2h_adc_setup_dma(struct iio_dev *indio_dev)
 
 static int rzt2h_adc_probe(struct platform_device *pdev)
 {
+	const struct rzt2h_adc_chip_info *chip_info;
 	struct device *dev = &pdev->dev;
 	struct iio_dev *indio_dev;
 	struct rzt2h_adc *adc;
@@ -677,11 +689,16 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	struct clk *adclk;
 	int ret;
 
+	chip_info = device_get_match_data(dev);
+	if (!chip_info)
+		return -ENODATA;
+
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	adc = iio_priv(indio_dev);
+	adc->chip_info = chip_info;
 	adc->dev = dev;
 	init_completion(&adc->completion);
 	init_waitqueue_head(&adc->dma.wq);
@@ -741,8 +758,14 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	return devm_iio_device_register(dev, indio_dev);
 }
 
+static const struct rzt2h_adc_chip_info rzt2h_adc_info = {
+	.chan_template = &rzt2h_adc_chan_template,
+	.num_channels = 16,
+	.features = RZT2H_ADC_FEATURE_CALIBRATION,
+};
+
 static const struct of_device_id rzt2h_adc_match[] = {
-	{ .compatible = "renesas,r9a09g077-adc" },
+	{ .compatible = "renesas,r9a09g077-adc", .data = &rzt2h_adc_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rzt2h_adc_match);
@@ -750,6 +773,10 @@ MODULE_DEVICE_TABLE(of, rzt2h_adc_match);
 static int rzt2h_adc_pm_runtime_resume(struct device *dev)
 {
 	struct rzt2h_adc *adc = dev_get_drvdata(dev);
+	const struct rzt2h_adc_chip_info *chip_info = adc->chip_info;
+
+	if (!(chip_info->features & RZT2H_ADC_FEATURE_CALIBRATION))
+		return 0;
 
 	/*
 	 * Datasheet Page 2810, Section 41.5.6:
-- 
2.55.0

