Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87903815E9
	for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774824438; cv=none; b=iSzmIqQs8GIIWqPPf+zDSf2m6sB4ns/QWWNCehRw6sk83MLSz99mNdOvEWsbjf9djeLyDFDONS9dcJvb2NE1TSMsKRIovv3IDW/UenOeq8FKQmfF8c3FRSKUl//gtq433AoB7N29FtHgRhSH/oHaLgD/pcGH+Dr/Onl8s3pst+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774824438; c=relaxed/simple;
	bh=qKG/Dk+YwmU5YXsCQA9AtevlFGr051QfNe264bDQuZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8z5HJ83jL9kKr71HLFJu94Qb/282X4VGvKjMT13dtkvw+I9wCn5/UC6FJ1aMGkKJstO4QSltuaXo5es/hdWB2l906sAkb2SuL6o5HjmroTRsxRxg7fCKsC4md+pvAHP78P1QLvB4QitbQa6EmPyovZ/L/6rN5HaKTl361j/aCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=opsU/Xj2; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opsU/Xj2"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c66eafc1easo349249eec.1
        for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 15:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774824436; x=1775429236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjnte4r6ScLiwT0fTQiZsZDg6SDDULG2OwlHg75Fmwg=;
        b=opsU/Xj2tS3Jtx/E3effpQYBTOCbK/HGgoMi2CjbHvYhmU12HfqKIb1076Xs7nvqmV
         25U4n1hjBReW14UkhTupn+c66972mwi0iQZD4OmQD4THPqwcvwUwEOte+psWpM/+V/8y
         x2vU/6aVW/23PReohDfzD4d2EwNz6zAgzcTFt4rl5ZvE48WfSp5mU5bdt3XwHG9qHUtw
         adc6dlnOG2GInLtiNf2YSFVlS2IQ906qdyRLWac/IDYyNOVl1RKjHs6o9Ku/SQ51nxVO
         h4VUIOkD0b6O2V0NGUlBjIuInlqqJ6NsZVZuxWRVya9kyGkBohZer4CobqYvS9bGcFNE
         /RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774824436; x=1775429236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xjnte4r6ScLiwT0fTQiZsZDg6SDDULG2OwlHg75Fmwg=;
        b=r+FwnJsHwrcOm8O0ZLjJIFcF+cyhtC46KpGsKVy2a46Gx/MBYpJTVcoyh0Hjegq0l7
         j0wCL+sz85SBy4OaFKD6MG/D9caxg8DzFsopQlBFTDcM/JHoy0PvbXqPuyn2IZr5gBGK
         wYfSBMMuRfvFUAWdtFOuVrfKCSUnz0aGSzefjWU/vccnyU0TEtbJwL/zjwnyS49su/bj
         dD1H+BA/g8niOhsWiUi2Ac9c9h34Mx0GEeFgl2ihMkO9qXc1B4pOmNHvtV5bRRRJfRqm
         0KIDEXUlDyuwPXXHpcbQ8NG+r13/FNNXgDT8ESlV63py9kd3FfUluNZfEG4xeLocBbRW
         qo1g==
X-Forwarded-Encrypted: i=1; AJvYcCUjNVlVALXQBWZrB74CFi3k0zXbCdIce3UlD2qdg6zF9NYLX7xDd4jY2LM7vITY5U2wmBXLDkmnnt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgT/IiS70wBlOf+EYypXs/5Vbh2Y0o2hKFhLmZxiHeuGM2sLOl
	A/0QJZbOkDQzB5jYUgwzYYLEtmHJTI/qML3VGy+quRaBmAKuGCt+JFN7
X-Gm-Gg: ATEYQzwl/PFWcWGbVjMcpS3Pcf87RgwBnCWF7wmunVno8zjPVzPS++AxUuYaqvR26Xv
	DXVCK/N0OMH/GbZMKI3K9hnuDtTKChU2e18tk3r3nw+r3/kdlfCE3FB4vHcr+SlbMdjAV6OIV4L
	uVDc1+tjR0G9DjtM+bGEZl9XTLZFaZMZspkJEwmjxZ4nkOC8XwWh6HnnuGTS6mVdW3Ly4PmZw7w
	StETMzbNdLaUd1Rd/NzTI9yl8GyO7ntLs3gAy0R8GUM3MIMUulPcAK+lYisf/uw+KWr0IqMuHRX
	JBhe/4if3toehCMi7llMrdj/Xi1x0ITImEYn4ep0JErE2nQuE7f0Eb8Q4d3lj0qfttU1pS69FAW
	ipTgvzZCdMIRfF0uBM+2hKRoMRrq3v0q8Ro8pC8r/sZW9+tfRkovzIpohyzO/9ePeOuzjAa66PI
	r7bsyGE2CvDzVFyfwm/QZ9g7hQmNZOvxNPbCWFaF4c3om0l/zQMtp96Gj9v14O5rufwNdPqqAdR
	3lxHrGF2AFNoJvdOaGwZnX7Aw==
X-Received: by 2002:a05:7300:1489:b0:2c5:220c:5673 with SMTP id 5a478bee46e88-2c5220c616bmr2019888eec.5.1774824436043;
        Sun, 29 Mar 2026 15:47:16 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7265:773a:8e51:c62f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm5840295eec.30.2026.03.29.15.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 15:47:15 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 29 Mar 2026 15:47:08 -0700
Subject: [PATCH v4 3/4] iio: adc: ti-ads7950: switch to using
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-ti-ads7950-facelift-v4-3-c568c508c49a@gmail.com>
References: <20260329-ti-ads7950-facelift-v4-0-c568c508c49a@gmail.com>
In-Reply-To: <20260329-ti-ads7950-facelift-v4-0-c568c508c49a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.15-dev-a6826

The regulator is enabled for the entire time the driver is bound to the
device, and we only need to access it to fetch voltage, which can be
done at probe time.

Switch to using devm_regulator_get_enable_read_voltage() which
simplifies probing and unbinding code.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 48 ++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index c31c706c92a9..0b98c8e7385d 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -334,19 +334,9 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 	return st->single_rx;
 }
 
-static int ti_ads7950_get_range(struct ti_ads7950_state *st)
+static unsigned int ti_ads7950_get_range(struct ti_ads7950_state *st)
 {
-	int vref;
-
-	if (st->vref_mv) {
-		vref = st->vref_mv;
-	} else {
-		vref = regulator_get_voltage(st->reg);
-		if (vref < 0)
-			return vref;
-
-		vref /= 1000;
-	}
+	unsigned int vref = st->vref_mv;
 
 	if (st->cmd_settings_bitmask & TI_ADS7950_CR_RANGE_5V)
 		vref *= 2;
@@ -375,11 +365,7 @@ static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = ti_ads7950_get_range(st);
-		if (ret < 0)
-			return ret;
-
-		*val = ret;
+		*val = ti_ads7950_get_range(st);
 		*val2 = (1 << chan->scan_type.realbits) - 1;
 
 		return IIO_VAL_FRACTIONAL;
@@ -573,30 +559,25 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	spi_message_init_with_transfers(&st->scan_single_msg,
 					st->scan_single_xfer, 3);
 
-	/* Use hard coded value for reference voltage in ACPI case */
-	if (ACPI_COMPANION(&spi->dev))
-		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;
-
 	mutex_init(&st->slock);
 
-	st->reg = devm_regulator_get(&spi->dev, "vref");
-	if (IS_ERR(st->reg)) {
-		ret = dev_err_probe(&spi->dev, PTR_ERR(st->reg),
-				     "Failed to get regulator \"vref\"\n");
-		goto error_destroy_mutex;
-	}
+	/* Use hard coded value for reference voltage in ACPI case */
+	if (ACPI_COMPANION(&spi->dev)) {
+		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;
+	} else {
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get regulator \"vref\"\n");
 
-	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable regulator \"vref\"\n");
-		goto error_destroy_mutex;
+		st->vref_mv = ret / 1000;
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 					 &ti_ads7950_trigger_handler, NULL);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
-		goto error_disable_reg;
+		goto error_destroy_mutex;
 	}
 
 	ret = ti_ads7950_init_hw(st);
@@ -636,8 +617,6 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 error_cleanup_ring:
 	iio_triggered_buffer_cleanup(indio_dev);
-error_disable_reg:
-	regulator_disable(st->reg);
 error_destroy_mutex:
 	mutex_destroy(&st->slock);
 
@@ -652,7 +631,6 @@ static void ti_ads7950_remove(struct spi_device *spi)
 	gpiochip_remove(&st->chip);
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	regulator_disable(st->reg);
 	mutex_destroy(&st->slock);
 }
 

-- 
2.53.0.1018.g2bb0e51243-goog

