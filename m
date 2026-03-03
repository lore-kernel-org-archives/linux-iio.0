Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9401FECBA;
	Tue,  3 Mar 2026 02:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505510; cv=none; b=WcxUSoKYBROZ44aiPD6bDX6nJ4FKx5cpzsfpvqA+QbKbhtVhzGoyOwhLWp2hj0dPlRuJV4zjENt8f59EcMwy+SZYa8xGwNUfk8OHBIC/WqWHU0PxX1qLZaksoLpMMJASvHoQUzpvaC8AOE6Ez0yRCgIuSoC+ChfpMGpyvbFH47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505510; c=relaxed/simple;
	bh=vyRSNAFGP/y8QafqAEY2QSHcXxBy39wt1+hBkhXUcbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=RgbJ0GVCF1JLYYQ2c4u87ei1CjpY0phRMnnCejy/2rY8Rv9pn3slx3NaFcaxX8sYVCCWh6ZTt5KIKaB/QexcwEjWz4hW2Wu59LNfa6xp9leRoNQRFakbtnvrcUkQKcnAFb/j8aPSkbipMk8slkQ/7zTk9qjtkcKoInmA3B/4iQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Mar
 2026 10:38:25 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Mar 2026 10:38:25 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 3 Mar 2026 10:38:26 +0800
Subject: [PATCH v3] iio: adc: aspeed: clear reference voltage bits before
 configuring vref
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260303-adc-v3-1-10570f23d3ce@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAKFJpmkC/zWMQQqDMBBFryKzbiRR0xpXvUcpJSaTOqBGklBax
 Lt3KHT1efDf2yFjIswwVDskfFGmuDK0pwrcZNcnCvLM0MjmLFvZCuud6C6ox+BDb5wBfm4JA71
 /ldudOaS4iDIltH9XK9n0Unc8tTK601xSYqR5/jxKtnS1eUP0Bd1Uu7jAcXwB6v/QJ5oAAAA=
X-Change-ID: 20260303-adc-47e5bfdf89c9
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772505505; l=1172;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=vyRSNAFGP/y8QafqAEY2QSHcXxBy39wt1+hBkhXUcbY=;
 b=21ac4yo0r6x7x/tJeAkxkZ/VU17Pf2KeA7eGaRWUcCnyEzaf6AgHmYvSx46CZcRbHG9+9xTDI
 iIB0a/DyuZPBd77hGpNz0mL20hh8AiqGWmJl1NIBVIHQH/1TBW3bccp
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Ensures the reference voltage bits are cleared in the ADC engine
control register before configuring the voltage reference. This
avoids potential misconfigurations caused by residual bits.

Fixes: 1b5ceb55fec2 ("iio: adc: aspeed: Support ast2600 adc.")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Changes in v3:
- Added the missing Fixes: tag

Changes in v2:
- Remove Gerrit Change-Id's
---
 drivers/iio/adc/aspeed_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 4be44c524b4d..83a9885b9ae4 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -415,6 +415,7 @@ static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 	}
 	adc_engine_control_reg_val =
 		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+	adc_engine_control_reg_val &= ~ASPEED_ADC_REF_VOLTAGE;
 
 	ret = devm_regulator_get_enable_read_voltage(data->dev, "vref");
 	if (ret < 0 && ret != -ENODEV)

---
base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
change-id: 20260303-adc-47e5bfdf89c9

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>

