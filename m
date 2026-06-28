Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0083AC0C3;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655794; cv=none; b=gbeh3lUU7TI+mW8vUi1Jo940SmYjHCLI69UmwmDHAHf55vQy4jvBJ8WvHE7ZmAChBnZDYb8ygL9auWqrQGUmT73XWTfm0A0G9Ri3RILCEBkmpDTVyw8XLK3hpGig98N/MKwQkXI4f4tuSVRwP9/R03PXEIAUWYUdUy+p1YFsf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655794; c=relaxed/simple;
	bh=BX6XFLrrl7rQKzPIYZIJuegm0hFPGVT9h0aYfoKr/Ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDG/Ieh3SpCwB8jdcwhHZ7r0688cxR2MWXwSzxo7bLjGf5fhWXUk52GBrJewTwbl3qASqPoQhw7UFhG2916PcFTK6LUyaHBh9Sczkk5Bv4CAauadSqOlmVA06f0rXlnmBXJ1OBjLrPHR+iv+rnox47v3pElIVgxJq/OeoWngUdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLCuCzE0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLCuCzE0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 350F4C4AF12;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782655794;
	bh=BX6XFLrrl7rQKzPIYZIJuegm0hFPGVT9h0aYfoKr/Ac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gLCuCzE0yUcefzDmcIdA7PdbwK3+dEgN4Kkvs0AUYEDlZWTs5jdc6P5nVoGAnOwtb
	 w8aDDH/oSi5jbESZuZQwrc0/r+lcRMwjR5aZL27db2AxaQiToolf7dpd+oY5ck3lvR
	 NpBEWPiuNwfdccwXuH/Y329T+NDo66lG7Luwkv4y521itt/MoBaTe7zXf3NmVpwrHM
	 xSQL8c1M6Vkh70sKcqL1s1zIKIaKF4lMx7BNdQKCxed0BFJw8lkzWstbFWxVXeiscj
	 PWr9W9RPNe46xIBDbBwnMYHWf8zJHchbE293ER7LTnQiZSrr4RP3cs5Bt6LYrWqzdk
	 4KbHO5zMwaMVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289C0C43327;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 28 Jun 2026 15:08:13 +0100
Subject: [PATCH v5 06/12] iio: dac: ad5686: consume optional reset signal
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-ad5686-new-features-v5-6-577caadbf7c0@analog.com>
References: <20260628-ad5686-new-features-v5-0-577caadbf7c0@analog.com>
In-Reply-To: <20260628-ad5686-new-features-v5-0-577caadbf7c0@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782655792; l=1786;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=L5icfA5WYm8ov/3pCusG7IPcFnWQG1nvPrm0z48/efM=;
 b=rUJtlI4GFgejRbhOQwEUfj+2xmTMfJLtXITC5yiUeXThi8to9fMto+r5s4kYAU0C7Sj7ou6s8
 0yyNps1xTOPBC14sDbiXjhAEmTlJbBWUlZk5C6zgE41EIPk/goc5i/6
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add RESET pin GPIO support through an optional reset control, which is
local to the probe function. A reset pulse is manually generated after
the device is powered up.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index e2ebabca6887..8ad8931a3d7f 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -15,6 +15,7 @@
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/sysfs.h>
 #include <linux/wordpart.h>
 
@@ -472,6 +473,7 @@ int ad5686_probe(struct device *dev,
 		 const struct ad5686_chip_info *chip_info,
 		 const char *name, const struct ad5686_bus_ops *ops)
 {
+	struct reset_control *rstc;
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
 	int ret, i;
@@ -486,6 +488,11 @@ int ad5686_probe(struct device *dev,
 	st->ops = ops;
 	st->chip_info = chip_info;
 
+	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc),
+				     "Failed to get reset control\n");
+
 	ret = devm_regulator_get_enable(dev, "vdd");
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
@@ -509,6 +516,11 @@ int ad5686_probe(struct device *dev,
 	/* 4.5us power-up time: Datasheet Table 4: Timing Characteristics */
 	fsleep(5);
 
+	/* 1us >> 30ns reset pulse activation time: Datasheet Table 4 */
+	reset_control_assert(rstc);
+	fsleep(1);
+	reset_control_deassert(rstc);
+
 	/* Initialize masks to all ones */
 	st->pwr_down_mask = ~0;
 	st->pwr_down_mode = ~0;

-- 
2.43.0


