Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563883F7884;
	Tue,  9 Jun 2026 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999992; cv=none; b=Qsm3FRDYy2JVbRkOIGZxeVgwFOWLKg1uJFVmE8m4NAYmsYrSAK+lEXgcTzqR3pAaO7QtAeFOEmBEskinn4o9I+OR6RCCkfH6R+mGp4cjgFRhbzSjjxn4j2oFZhR9Zi4WLdLdzLojIoiIE0eziAqzl2W8H0C6Lvl255cc1OdXb9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999992; c=relaxed/simple;
	bh=f1B4HEoeZKZh3DR09cvlbP9QiKsQBpBwMcMJdwpprnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FS1f1qcqnssKsO1EGhPBZGLTEDL4bVvE5ggaw9krdw3HUJCX9LmwQZJuGKf632YGQllTH9aXpViyoK+mHrcnGLEy0i/pey/4O15MEd0oTyybGw+bnoaCc4jWCYYG4JVoE6xEPISB3/oaG2Lwx7KD/ymiZunsga9/C5+6z/SgQNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeDfWb+X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeDfWb+X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 333A5C4AF1A;
	Tue,  9 Jun 2026 10:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780999992;
	bh=f1B4HEoeZKZh3DR09cvlbP9QiKsQBpBwMcMJdwpprnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EeDfWb+XctJSQZz34y2tbN9Xivq/zNqzkAshU/K5Q5MVUoImyn2DwbP0/aR6HSWX7
	 C7NCFJrxBUU4LOe8ymgF5mAUOPbOe3mdxOAxbOSqW6hmfoPLthyfOnisSyg5dCZ9f3
	 BfANPDPz+f0rl+NNRnVXoFTuAP/C1ugmIkuBLzui/7sria/4SBQQar7hIkFSN8LrRE
	 bvj3CmYsYCCz2TsvRufI+ofeBkP4mV3BuMXDV8AwCAy8XVC+72xxxnW8fR0uoBgfSa
	 Q1Ssf4MMC4GNXlOTmzeYuXg1FvPNKBX1fYsy9kqSHDFZN+OE5TBquA4NG7B15u2bU+
	 P94cdniIBqdJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B89CD8CA4;
	Tue,  9 Jun 2026 10:13:12 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 11:13:02 +0100
Subject: [PATCH v2 07/12] iio: dac: ad5686: add ldac gpio
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ad5686-new-features-v2-7-70b423f5c76d@analog.com>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
In-Reply-To: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780999989; l=2241;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=pESd5r0XDlbwbkJVnEP0NKvEv+3IXSqbO1ZCBrUMm/E=;
 b=5GOUDC2BZoxIq6lT1D+DfQIULuc7IuHixX4mRqLyadjFS12S/PEn6HSPX0mEmp4b/LsKjBOHx
 dH31vcGmeXxDb0HXWdpqzKs50UrOtN1lQN5K02j/Rhn8aQjUW1z9Edw
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

If wired LDAC, should be held low when unused (pin is active-low), which
allows for synchronous DAC updates. This will be used to update all the
channels at the same time when adding buffer support.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 6 ++++++
 drivers/iio/dac/ad5686.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 700798b80f04..db37c3e50389 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -12,6 +12,7 @@
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
@@ -513,6 +514,11 @@ int ad5686_probe(struct device *dev,
 		return dev_err_probe(dev, PTR_ERR(rstc),
 				     "Failed to get reset control\n");
 
+	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->ldac_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
+				     "Failed to get LDAC GPIO\n");
+
 	fsleep(5); /* power-up time */
 	reset_control_assert(rstc);
 	fsleep(1); /* reset pulse: comfortably bigger than the spec */
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index a06fe7d89305..f3110410d89b 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -60,6 +60,7 @@ enum ad5686_regmap_type {
 	AD5686_REGMAP,
 };
 
+struct gpio_desc;
 struct ad5686_state;
 
 /**
@@ -119,6 +120,7 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
  * @dev:		device instance
  * @chip_info:		chip model specific constants, available modes etc
  * @ops:		bus specific operations
+ * @ldac_gpio:		LDAC pin GPIO descriptor
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
@@ -131,6 +133,7 @@ struct ad5686_state {
 	struct device			*dev;
 	const struct ad5686_chip_info	*chip_info;
 	const struct ad5686_bus_ops	*ops;
+	struct gpio_desc		*ldac_gpio;
 	unsigned short			vref_mv;
 	unsigned int			pwr_down_mask;
 	unsigned int			pwr_down_mode;

-- 
2.43.0


