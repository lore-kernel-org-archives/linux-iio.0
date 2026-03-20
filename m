Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97E31714C;
	Fri, 20 Mar 2026 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773985611; cv=none; b=i+eIvVINzpWAKjeR8ilb5/kj4AQPgKth0ch+Xox2gT1yJAxGVZWak8OETUCbzYnhv/dF2gAsUTJA6BQN4ZtAKOMxCJQRcjVr+gH+o4/NcpVB6URu5x9DpOlEmclEDjDjcbsbWsZIllfG+/CewCwB5ibvYN0dduTtkqoAtxIXXhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773985611; c=relaxed/simple;
	bh=U9UIMT5MY4p71koRPdELGX4IvlmgyoiNubG0RreHjtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Diimuab1QrnvHuk1yc7qBBBi1n5Ve9pfJslFAz5PMjmkY1EWxDbPJJ7ZJluYawfZcHrj9eYTzn3hLOuRrsMcPxbOtMBel5wnORZuZ186llW/1Tlv6uv9A9KVX+++u1wS82+ivN9c6wLg4m10Xt+C9Zxc0bx4GIvF1HF89tsNq8g=
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
Date: Fri, 20 Mar 2026 13:46:35 +0800
Subject: [PATCH v3 1/4] iio: adc: Add battery channel definition for ADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260320-adc-v3-1-bc0eac04ef7c@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773985600; l=1633;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=U9UIMT5MY4p71koRPdELGX4IvlmgyoiNubG0RreHjtA=;
 b=S/vv1jCj2l2SomhOwzSgeS124qs/Mb7r4uTu4QaXqK1A6yYlgQ1LI3SXtTfiJ5WYfKrz7Z0l/
 V16DTdvnu9jCcTaHZkL6Un1lFxrfbhpb+vOPUkGMskBrk3oABIQkZOC
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Defines a constant for the battery sensing channel, typically the last
channel of the ADC. Clarifies channel usage and improves code
readability.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 4be44c524b4d..8eebaa3dc534 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -75,6 +75,8 @@
 
 #define ASPEED_ADC_INIT_POLLING_TIME	500
 #define ASPEED_ADC_INIT_TIMEOUT		500000
+/* Battery sensing is typically on the last channel */
+#define ASPEED_ADC_BATTERY_CHANNEL		7
 /*
  * When the sampling rate is too high, the ADC may not have enough charging
  * time, resulting in a low voltage value. Thus, the default uses a slow
@@ -285,7 +287,7 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (data->battery_sensing && chan->channel == 7) {
+		if (data->battery_sensing && chan->channel == ASPEED_ADC_BATTERY_CHANNEL) {
 			adc_engine_control_reg_val =
 				readl(data->base + ASPEED_REG_ENGINE_CONTROL);
 			writel(adc_engine_control_reg_val |
@@ -309,7 +311,7 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OFFSET:
-		if (data->battery_sensing && chan->channel == 7)
+		if (data->battery_sensing && chan->channel == ASPEED_ADC_BATTERY_CHANNEL)
 			*val = (data->cv * data->battery_mode_gain.mult) /
 			       data->battery_mode_gain.div;
 		else

-- 
2.34.1

