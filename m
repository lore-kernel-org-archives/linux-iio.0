Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC22848A7
	for <linux-iio@vger.kernel.org>; Sun,  5 Apr 2026 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775425085; cv=none; b=sDBeFgn8yAT/Uti9uu7htZS3NPoyOYAzV3+odRcprivaXSaAAe3nVA4eRxHpUagGPkXSBkiDvJaCnvNnXxNk3O1dUR5+Hl6accUDgLUPYEZRXqO9Y5YYHps13W0DI8YYJ/iurXO4cDpYhvndysJ+eMjZSBhFuQbxPXDwM9htaI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775425085; c=relaxed/simple;
	bh=8nODRcvUnS4p+vn4a/5ft5GQxgjyz+ZEzZN0WfPtPIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZD6fLI9oELOX0BpRKSe1uPhaVZv0fJnpjjIl5B8w8LSQWmiaIjFOvJcnCM0siVjAkpyvMyuy/ltrH62picKSmQSpn24uzrmEh+SwpFxgA8NtI50nSMmZalv8qXW4zh+XqSynh8pEaTJgG8uLUtXWBvX7v82KMJeCDmUv1kJcTlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=jq7elhb0; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="jq7elhb0"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56d9c4f7f0bso2463579e0c.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1775425081; x=1776029881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qX7RWL7TDJnYlYdQ9XwBC0yy7c9ACcAwBuNCuK0VzFI=;
        b=jq7elhb0LiBpXvDGXgPSvY6wWLxMsp5k9CdVT7tLpKCYAobdGSBhnucWJ44vPLoNM+
         3WLziCrdlaGsKtcnf7uMGLNUnxNm10Wihg5tbknqX8Ci8cUNKstPa/GeXLjw66HHSj8C
         gH0lm2pyDo2Hv7l1I3/0GNVPWu3YcdM+OXqOAMboSfqdehX14SZq613KwXDRxYFvn2tI
         g+9zi6oMp6Z1tfTGgN8lLd1CigWlj4md2liXFcmX2vSP5liVRXsGh545lXOlSkWo2ALz
         +mSU3tFeFuGDAa+ToGuP3+/jlS9aDjLEThWkw61c0IKp8kJWmvqjjNhvvSyyxI4CLXrQ
         C2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775425081; x=1776029881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qX7RWL7TDJnYlYdQ9XwBC0yy7c9ACcAwBuNCuK0VzFI=;
        b=cKg0eVbp6q02th6v3bcI9Ez4a6dVTUIqjPz5rgxsqcaav/FMDgpuf/7LLnjknb7JL8
         iPOYruXv47tBq/Lcvn8B1XXU9smhu+DR4BN/xwaND+i52P4UisYbW/cfYhHqul9SxoJe
         6KXaOWrg5lVBizIJrwT8UutsmhvA8rhtyTtS00RCJwtCoPSZSwwV6vTDiFMeDMNo5a19
         YwrK1HMU8T588+1ZW2s/xfqTJpRLrxBGBCaNrVtcONS1QaHrny20W3BombfgiyybE+vV
         a++QdlhxXud/R53OXOOvxLqnu1fiJGGBKexCb6NTDMzSTZ3Fa9wv6InYESOecNpJHpfH
         ChBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoEg5aUCFWaU0wHYgBXcxQ6+9QFU3jzOcGezN03xIsinm9A8WiV072ofooF84Er5nAOo21wOjDqbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUNLn7ngf20W5P7+Iy7VIYkncBw2VsKc7br/Xb1nL0Yv4bZDjh
	/46COMG6BQieJkoQIKD/z+ZOU1t9LAPITYpUrVsXlditul3v9uJgaV4sfMJtGtFGEtcsqqjmv+0
	ycz4SiY+c8g==
X-Gm-Gg: AeBDieteDNT3bNGzE6NyQg79R+xrT5at9JrARfDJqt0ZU/iYDkK4RXBrfjUFD3r1BEk
	mp/6hJiDwgCGU4dHVvGa8iY79/aPCL4gESwqZmJ0MmI+3kl51ensEqJt41vwx/ANdH7/EZCLn5h
	Lov6KDsPo1GzbKQYrYxGsc1M9j5KZ5yn4DY7hxy0pEA2xa1ldWEJkwSXxL9zVi8hsYl6JJnfpwY
	7UR/dymZ8V1S76vOnxe2m9btVQvF9nmxbj/ktLgQ4profBbAOFJjx7d2RMJj44z7OknUGSO7hJX
	mECBkOWg5V48NY4YYZC3ikganCwIH3c+VH05d2kWcifgMciGeyK2V2eMb2WP+f4eW/tJ1BotUfW
	sRDh1sPD44bWz3V3g2cFSSp6YrahcEXkprBmlfJgICJOskPjoXxqj5pVMUd4lJ9tIPDoJGYX5Ah
	BenPoL6FVpnmyL64ccOcXpPxQiNBHlVnB1TCKxcAqz2tMECVLgtlsItLR0fbaxOtqzyRtaQl1I0
	OQfm3DVd9doXMJdiyebMrxnlgKmjYAIJSw0++2d5fGKxdNZFg==
X-Received: by 2002:a05:6122:3b84:b0:56e:eb08:21ca with SMTP id 71dfb90a1353d-56eeb082629mr1053487e0c.7.1775425081452;
        Sun, 05 Apr 2026 14:38:01 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bd0a8a3sm14805210e0c.17.2026.04.05.14.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 14:38:00 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guilherme.bozi@usp.br
Subject: [PATCH] iio: adc: ad4170: use lookup table for gpio mask selection
Date: Sun,  5 Apr 2026 18:37:26 -0300
Message-ID: <20260405213725.25426-2-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both ad4170_gpio_direction_input() and
ad4170_gpio_direction_output() duplicate the same switch
statement to map a GPIO offset to its corresponding mask.

Replace the switch with a static lookup table, simplifying the code
and avoiding duplication. This also makes future extensions easier.

No functional change intended.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 drivers/iio/adc/ad4170-4.c | 47 ++++++++++++--------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 82205bfae531..d1e971649b6f 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -1699,34 +1699,29 @@ static int ad4170_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 	return ret;
 }
 
+static const unsigned long gpio_masks[] = {
+	AD4170_GPIO_MODE_GPIO0_MSK,
+	AD4170_GPIO_MODE_GPIO1_MSK,
+	AD4170_GPIO_MODE_GPIO2_MSK,
+	AD4170_GPIO_MODE_GPIO3_MSK,
+};
+
 static int ad4170_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
 {
 	struct iio_dev *indio_dev = gpiochip_get_data(gc);
 	struct ad4170_state *st = iio_priv(indio_dev);
-	unsigned long gpio_mask;
 	int ret;
 
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
 
-	switch (offset) {
-	case 0:
-		gpio_mask = AD4170_GPIO_MODE_GPIO0_MSK;
-		break;
-	case 1:
-		gpio_mask = AD4170_GPIO_MODE_GPIO1_MSK;
-		break;
-	case 2:
-		gpio_mask = AD4170_GPIO_MODE_GPIO2_MSK;
-		break;
-	case 3:
-		gpio_mask = AD4170_GPIO_MODE_GPIO3_MSK;
-		break;
-	default:
+	if (offset >= ARRAY_SIZE(gpio_masks)) {
 		ret = -EINVAL;
 		goto err_release;
 	}
-	ret = regmap_update_bits(st->regmap, AD4170_GPIO_MODE_REG, gpio_mask,
+
+	ret = regmap_update_bits(st->regmap, AD4170_GPIO_MODE_REG,
+				 gpio_masks[offset],
 				 AD4170_GPIO_MODE_GPIO_INPUT << (2 * offset));
 
 err_release:
@@ -1740,7 +1735,6 @@ static int ad4170_gpio_direction_output(struct gpio_chip *gc,
 {
 	struct iio_dev *indio_dev = gpiochip_get_data(gc);
 	struct ad4170_state *st = iio_priv(indio_dev);
-	unsigned long gpio_mask;
 	int ret;
 
 	ret = ad4170_gpio_set(gc, offset, value);
@@ -1750,24 +1744,13 @@ static int ad4170_gpio_direction_output(struct gpio_chip *gc,
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
 
-	switch (offset) {
-	case 0:
-		gpio_mask = AD4170_GPIO_MODE_GPIO0_MSK;
-		break;
-	case 1:
-		gpio_mask = AD4170_GPIO_MODE_GPIO1_MSK;
-		break;
-	case 2:
-		gpio_mask = AD4170_GPIO_MODE_GPIO2_MSK;
-		break;
-	case 3:
-		gpio_mask = AD4170_GPIO_MODE_GPIO3_MSK;
-		break;
-	default:
+	if (offset >= ARRAY_SIZE(gpio_masks)) {
 		ret = -EINVAL;
 		goto err_release;
 	}
-	ret = regmap_update_bits(st->regmap, AD4170_GPIO_MODE_REG, gpio_mask,
+
+	ret = regmap_update_bits(st->regmap, AD4170_GPIO_MODE_REG,
+				 gpio_masks[offset],
 				 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * offset));
 
 err_release:
-- 
2.47.3

