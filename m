Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276D91FC8
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775945640; cv=none; b=LT/jaa2X4xj8TcKLh4Sr+yISx1zIniWqh1gwUxmdHk7VyAIq2yFAwaCNzPTzZo8Su2CWFl8ktcRs9f9eZ81IKk3FI472vz8fJsgknV4Yem4Jtmu8PDf5StsQ3yWdbi5LXMPL7z4IAEsfR60oQxIREHBaENd/53N1Cd2cJgCiEns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775945640; c=relaxed/simple;
	bh=trRkemWp5dWHUHDUM9KMQQolEfmLtt2uNpgKuvqDYfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NrrsEuEb3BOE1SsDxMROQI7nRqVXO7yWPzPCupm3fUT/UzcZDlVDgEMAb+FoBNS2kteIUI7qUHK9PviNR0umiJHc+WmSLsLKEieTKaOhOm2n+QgUKNMkzCSP7xaKcSlMoOn+pduDNyaQhDnVvPH8Wi+BtzUDldlv1mDWGkEMiuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=AgvyN4DR; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="AgvyN4DR"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d7f92bde91so2079955a34.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 15:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775945636; x=1776550436; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LmaKQJnZeZ/TFIGRnUXCFPtfqzkxWm8tTHvrFKsphJ8=;
        b=AgvyN4DRySuMgI+q6bm0UbSCFapiwrUshkVxDqjbQ0HGa3D9q8ZArxPFwpUpOfyPzg
         yuL/bMGDOFJ3jmI1Qd4RDZjBNEJ9mvaHTo26L+XyHYm5uJowMxsvED/L5VTJje2Z4Fv8
         V8kM8VGRVpjvL+XVDWBYyhWPGhDWuyP5vutFZWRVl6BaMvbM5dSv3ehJkvP/WOCOee8U
         RtNibzf5lwWt5OAprLjQR9C2j0s4HPc6uWxUBuAzMJaEq0ypRTEo9+bCMh50GrLdVr8Z
         lx8C3PlfxuQEAd/6+UgKdrllcTjGGwm6+Xr28Uma/imZb734KyBmclYik0ULLSf734cd
         iZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775945636; x=1776550436;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmaKQJnZeZ/TFIGRnUXCFPtfqzkxWm8tTHvrFKsphJ8=;
        b=dUGYdpQTvxHn2K5h6UpftX5YgWtp0z1AM1SLQz4fuRikaOotFxvuTZSlyVQdKeRLQz
         GkgQInVi8Qom917VDWJ7ksYDvSdiT/BmGJwJsDIjbSip090wnZQXPq1PyFT6gxUSss65
         TDrmYQvYALPCa+ijIgh0/6pWUFFW0ZltYaf6Jo8uHZ5OcfuShGv0QIiU5hwQuvWRuyYc
         Ur/ms+1TyXNAVMMcKY/OyNXSMJxN38426SOmU/zMiHj+WqUXIMXy0PdpWD4+XWVx7t8u
         cOaXMB3Erc5HeAd5uSuKCtiFbOUTkeJVmScKhq26nj4ziY0e91qLMCwHqlXaP5WbKDW5
         a23w==
X-Gm-Message-State: AOJu0YztxbUuFbRNwUPwa1KtbJIyEpfPNUF1IrHpr94uWGovmMnh3FW1
	oti6QImVZ8gm22MTZ+kcg+75BAH3ZkzWuLFjh8mncQs84AuIvWnJE2qUhhWXbFBvwMo=
X-Gm-Gg: AeBDieuGa7nWfVjiNwRB+Zao0lSTfbz34siBXCfigREHg5tETKf8cLADgiQ04NgE7+z
	XqYVUxIvrz6dhS2TuEohyjuuDeE5nfomh6fMPR4yikrfJa1NF+5T/4EmHRWFj6IKz4ZPibPczIh
	/aBVdLhl3AWMLXqxpKvqHPuxkzMIznyoZHfn1VQ1N7OcOzKp1TDNpV2in/8jWrBP/ScDB29E8x8
	44TqRPq7pVWYrvwY6GHca74JioUz7k+v1o4ydnoY/PuRNEsTPRv++JNppTyDjuUa4g/ZC62wjQ+
	SSskB5ZZn3PcWIkZ60JoQoHrlCjOjTW1an8dqO9VpQHMbevaOK5JUeVgLEPVKIV/YzocL2SNkNf
	UqkrwHgHlneqN/V55kYJxmwMyfr2n1N6RoY3bh9yOqUiqY+UM46bTyiuRUZRpCWfwsLSu8m59fq
	iKgjcsvCLzrzOlizWdAZN00fEZOpVW
X-Received: by 2002:a05:6830:4c0c:b0:7d9:b2ba:a35d with SMTP id 46e09a7af769-7dc27e878a0mr5021569a34.29.1775945636089;
        Sat, 11 Apr 2026 15:13:56 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d2e5:c81c:5b23:fe55])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc26965485sm5002303a34.22.2026.04.11.15.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 15:13:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 11 Apr 2026 17:13:33 -0500
Subject: [PATCH] iio: adc: ti-ads7950: use spi_optimize_message()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-iio-adc-ti-ads7950-spi-optimize-msg-v1-1-617766ef2e38@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02OQQ6CMBBFr0K6drQgoCXGeA/jopYpjqGAnWKIx
 rtbxYWryUv+/P+egtETsqiSp/B4J6a+i5AuEmEuumsQqI4sMpmVMk9TIOpB1wYCxcMbVUjggaA
 fAjl6IDhuoFRZrkpVm3yzFrFp8Ghp+q4cTzPzeL6iCZ/qX8LjbYzzYY6Js2YE0ztHoUpa6sYJO
 pzCymkO6D8/Dpn1V7BKdrOfLP69rDbYkg1wL0BCatVWYr02VuGhcZraZazfi9Pr9QZsHR4zBgE
 AAA==
X-Change-ID: 20260411-iio-adc-ti-ads7950-spi-optimize-msg-6924969dc473
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4299; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=trRkemWp5dWHUHDUM9KMQQolEfmLtt2uNpgKuvqDYfw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBp2seciyJONTRR+SWR9ycmv6qPOpsPAWXYG/6VQ
 hgbAkjSLT2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadrHnAAKCRDCzCAB/wGP
 wIpYB/9ItC4NJ1ddVa/bULT8HX2L4RkXjyQAInZN+geDrMphH6ZtphI1L6r2oZ1gses9DubaFzz
 8kxzIPZs9uUB9wQj8Tv9l+gVpmVVvnEbn+Fzi6jzH7AdrcB8HUoaqU/gU+g+gqoqlGYjFclLhhx
 J/Lj80rJwsVIPwZLJ84y5b+DtV9hA7cIhJqATu33/pQJiqN50w0qvx33w0kaFTafd3BZbo6gJtz
 TmILmaQH59OPwwnCynStp5eYsQSD3e0yQuRPwKS2crAd7XBPHyvxZXmcLPPoN8y5exgAmIAHoRX
 mJ4ZbKssFwqTeoT9d0B15pyKXLHY9LbGtwoJyaoEbiPNdudo
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use spi_optimize_message() to reduce CPU usage during buffered reads.

On hardware with support for SPI_CS_WORD, this reduced the CPU usage
of the threaded interrupt by about 5%. On hardware without support, this
should reduce CPU usage even more since it won't have to split the SPI
transfers each time the interrupt handler is called.

The update_scan_mode callback hand to be moved to the buffer preenable
callback since the SPI transfer mode can't be changed after
spi_optimize_message() has been called. (The buffer postenable callback
can't be used because it happens after the trigger is enabled, so the
SPI message needs to be optimized before that.)

The indent of ti_ads7950_read_raw is changed since there is no longer
anything else in the struct to align with since we removed
ti_ads7950_update_scan_mode.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads7950.c | 65 +++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 882b280d9e0b..39a074bce6d5 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -267,31 +267,6 @@ static const struct ti_ads7950_chip_info ti_ads7961_chip_info = {
 	.num_channels	= ARRAY_SIZE(ti_ads7961_channels),
 };
 
-/*
- * ti_ads7950_update_scan_mode() setup the spi transfer buffer for the new
- * scan mask
- */
-static int ti_ads7950_update_scan_mode(struct iio_dev *indio_dev,
-				       const unsigned long *active_scan_mask)
-{
-	struct ti_ads7950_state *st = iio_priv(indio_dev);
-	int i, cmd, len;
-
-	len = 0;
-	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels) {
-		cmd = TI_ADS7950_MAN_CMD(TI_ADS7950_CR_CHAN(i));
-		st->tx_buf[len++] = cmd;
-	}
-
-	/* Data for the 1st channel is not returned until the 3rd transfer */
-	st->tx_buf[len++] = 0;
-	st->tx_buf[len++] = 0;
-
-	st->ring_xfer.len = len * 2;
-
-	return 0;
-}
-
 static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -375,8 +350,42 @@ static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ti_ads7950_info = {
-	.read_raw		= &ti_ads7950_read_raw,
-	.update_scan_mode	= ti_ads7950_update_scan_mode,
+	.read_raw = &ti_ads7950_read_raw,
+};
+
+static int ti_ads7950_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ti_ads7950_state *st = iio_priv(indio_dev);
+	u32 len = 0;
+	u32 i;
+	u16 cmd;
+
+	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->num_channels) {
+		cmd = TI_ADS7950_MAN_CMD(TI_ADS7950_CR_CHAN(i));
+		st->tx_buf[len++] = cmd;
+	}
+
+	/* Data for the 1st channel is not returned until the 3rd transfer */
+	st->tx_buf[len++] = 0;
+	st->tx_buf[len++] = 0;
+
+	st->ring_xfer.len = len * 2;
+
+	return spi_optimize_message(st->spi, &st->ring_msg);
+}
+
+static int ti_ads7950_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ti_ads7950_state *st = iio_priv(indio_dev);
+
+	spi_unoptimize_message(&st->ring_msg);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ti_ads7950_buffer_setup_ops = {
+	.preenable = ti_ads7950_buffer_preenable,
+	.postdisable = ti_ads7950_buffer_postdisable,
 };
 
 static int ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
@@ -573,7 +582,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
 
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
 					      &ti_ads7950_trigger_handler,
-					      NULL);
+					      &ti_ads7950_buffer_setup_ops);
 	if (ret)
 		return dev_err_probe(&spi->dev, ret,
 				     "Failed to setup triggered buffer\n");

---
base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
change-id: 20260411-iio-adc-ti-ads7950-spi-optimize-msg-6924969dc473
prerequisite-message-id: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
prerequisite-patch-id: 0606a4fc48f3fe7bf5f9156c93f434050898c309
prerequisite-patch-id: 1bb68480bcba4198e8b18b3ca7d8a0980fdd4bdd
prerequisite-patch-id: 551390239268e710bdb14ae2629e287fa751cb62
prerequisite-patch-id: 1a5f202fc1b16f2aee0368cccda2a521a9c8af19

Best regards,
--  
David Lechner <dlechner@baylibre.com>

