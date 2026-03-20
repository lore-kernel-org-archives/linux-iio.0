Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C7E31B10B;
	Fri, 20 Mar 2026 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773985617; cv=none; b=mXu9iS01cbRuk8qvAWvgZwaBCGpDorPIOrCMFskWbj8iLzJGagKaDmq4T4tFWNuIXpIccXxR7E1PD2GM4rG8spahDHqFhH9sxLNu7vy8V8bhkfTjUllCPmuVbWEgwSOm0TzsSw6QDlKLTeYrK+PKn8poFtjJAOIvqtXnK7Kw3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773985617; c=relaxed/simple;
	bh=/PC/NyBFthLGN9cW7uymrG04TM1B2jgffJp1BtJPzvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EnCtaFPlhgjga+/9S6P85S0w2ch+o4g8wUfX/ll7C55Q7QYJKKiSyldDbE97W4KyapCwr7XmmY43SaJ3V7EAN61F3ofZD7ATRrE390sN/ppmThJmikDn6iJdSZ6lSmOqRdpVDuumpeiZVtqOpghrpQLCR2ilkVAEt6ciD1tFmtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 20 Mar
 2026 13:46:40 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 20 Mar 2026 13:46:40 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 20 Mar 2026 13:46:38 +0800
Subject: [PATCH v3 4/4] iio: adc: aspeed: Reserve battery sensing channel
 for on-demand use
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260320-adc-v3-4-bc0eac04ef7c@aspeedtech.com>
References: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
In-Reply-To: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<morris_mao@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773985600; l=3092;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=/PC/NyBFthLGN9cW7uymrG04TM1B2jgffJp1BtJPzvk=;
 b=RB0NDy13+uaIk/DhgVlJNMyfDOujB1yWJsODg/DzzJixBX0EPQO4bj3PrRMZ6FyO9JwEA9sjk
 oZj077hCYySDDdpXtifv5kTKDBB2UvkJ3EWbmhtBLqw2kADoQ7YRzNB
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

For controllers with battery sensing capability (AST2600/AST2700), the
last channel uses a different circuit design optimized for battery
voltage measurement. This channel should not be enabled by default
along with other channels to avoid potential interference and power
efficiency issues.
This ensures optimal power efficiency for normal ADC operations while
maintaining full functionality when battery sensing is needed.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index a1a6296d3003..b3dee172adbf 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -138,6 +138,13 @@ static inline u32 aspeed_adc_channels_mask(unsigned int num_channels)
 
 static inline unsigned int aspeed_adc_get_active_channels(const struct aspeed_adc_data *data)
 {
+	/*
+	 * For controllers with battery sensing capability, the last channel
+	 * is reserved for battery sensing and should not be included in
+	 * normal channel operations.
+	 */
+	if (data->model_data->bat_sense_sup)
+		return data->model_data->num_channels - 1;
 	return data->model_data->num_channels;
 }
 
@@ -305,9 +312,26 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		adc_engine_control_reg_val = readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+		/*
+		 * For battery sensing capable controllers, we need to enable
+		 * the specific channel before reading. This is required because
+		 * the battery channel may not be enabled by default.
+		 */
+		if (data->model_data->bat_sense_sup &&
+		    chan->channel == ASPEED_ADC_BATTERY_CHANNEL) {
+			u32 ctrl_reg = adc_engine_control_reg_val & ~ASPEED_ADC_CTRL_CHANNEL;
+
+			ctrl_reg |= ASPEED_ADC_CTRL_CHANNEL_ENABLE(chan->channel);
+			writel(ctrl_reg, data->base + ASPEED_REG_ENGINE_CONTROL);
+			/*
+			 * After enable a new channel need to wait some time for ADC stable
+			 * Experiment result is 1ms.
+			 */
+			fsleep(1000);
+		}
+
 		if (data->battery_sensing && chan->channel == ASPEED_ADC_BATTERY_CHANNEL) {
-			adc_engine_control_reg_val =
-				readl(data->base + ASPEED_REG_ENGINE_CONTROL);
 			writel(adc_engine_control_reg_val |
 				       FIELD_PREP(ASPEED_ADC_CH7_MODE,
 						  ASPEED_ADC_CH7_BAT) |
@@ -321,11 +345,11 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 			*val = readw(data->base + chan->address);
 			*val = (*val * data->battery_mode_gain.mult) /
 			       data->battery_mode_gain.div;
-			/* Restore control register value */
-			writel(adc_engine_control_reg_val,
-			       data->base + ASPEED_REG_ENGINE_CONTROL);
 		} else
 			*val = readw(data->base + chan->address);
+		/* Restore control register value */
+		writel(adc_engine_control_reg_val,
+				data->base + ASPEED_REG_ENGINE_CONTROL);
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OFFSET:

-- 
2.34.1

