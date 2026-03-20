Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E476931715F;
	Fri, 20 Mar 2026 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773985615; cv=none; b=RhlA/gmQQjIUDlgvSf5d5xZ06sUkL2FVgr866Igi6pPrVlt1kyVzlmRC04RYEDz1jlXdXybu3Ic08lalaYoGGXHmI+drq60JzFRnZVlB6zZNJFFMgKt9YxJyAVNIKu9oXgfr1qHIlTnY5hsqcEZMKebtwmRjsgni7GQP5Baz+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773985615; c=relaxed/simple;
	bh=nns6L1IWBrZoZF9du3xsZHyx3aa79UG/Vd6Iwrl6+E4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WMrg+TyuViQqX4Gk7uuDgHVq9yKCM8L0y4QQ329/ra4Gr0hMplV8Z4cqsqbwdT1WKKP2aFeWB9Kbp+EPzNuURqhFBHn7s7bEYbvY2z1p0pN7Hp/0X0XiGb/mAxZrKl/HczMALGZlSmjuJn4c1IEzJxV3cPQkULBokIJPFS6rS3k=
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
Date: Fri, 20 Mar 2026 13:46:37 +0800
Subject: [PATCH v3 3/4] iio: adc: aspeed: Replace mdelay() with fsleep()
 for ADC stabilization delay
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260320-adc-v3-3-bc0eac04ef7c@aspeedtech.com>
References: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
In-Reply-To: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<morris_mao@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773985600; l=1623;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=nns6L1IWBrZoZF9du3xsZHyx3aa79UG/Vd6Iwrl6+E4=;
 b=Qc5vqncqRGLGuLM3Fsty10mqFKuRhZ1K7YvVPDSfqOOI7GdSgN9c7iYBIUjuu+r/PXnsiWOSN
 xvgaZ6SBLT/B4iMZs8MNxA6NU+aeBkM4p6HjYbiLcTYDEzWDGEZyaYw
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The ADC stabilization delays in compensation mode and battery sensing
mode do not require atomic context. Using mdelay() here results in
unnecessary busy waiting.

Replace mdelay(1) with fsleep(1000) to allow the scheduler to run other
tasks while waiting for the ADC to stabilize.

Also fix a minor typo in the comment ("adc" -> "ADC").

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 3ff24474f394..a1a6296d3003 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -259,7 +259,7 @@ static int aspeed_adc_compensation(struct iio_dev *indio_dev)
 	 * After enable compensating sensing mode need to wait some time for ADC stable
 	 * Experiment result is 1ms.
 	 */
-	mdelay(1);
+	fsleep(1000);
 
 	for (index = 0; index < 16; index++) {
 		/*
@@ -314,10 +314,10 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 				       ASPEED_ADC_BAT_SENSING_ENABLE,
 			       data->base + ASPEED_REG_ENGINE_CONTROL);
 			/*
-			 * After enable battery sensing mode need to wait some time for adc stable
+			 * After enable battery sensing mode need to wait some time for ADC stable
 			 * Experiment result is 1ms.
 			 */
-			mdelay(1);
+			fsleep(1000);
 			*val = readw(data->base + chan->address);
 			*val = (*val * data->battery_mode_gain.mult) /
 			       data->battery_mode_gain.div;

-- 
2.34.1

