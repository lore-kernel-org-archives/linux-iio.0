Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD0B413D62;
	Tue, 16 Jun 2026 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598072; cv=none; b=rmxodPzKjhpZr5QGHp1U35JfTDkbVuuxPEvcaNf4N0gSD3eNs44yKQ471f1WUNcIFIqVjtZvU5mhkktSrD5kqGWbc0swgNADIlmF/T7NVxSmhuwXsrvjFdohf/pPrCTX51XMivQzWy8s+7goJV+L51USVZRBKN3+Fco0dBRqsXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598072; c=relaxed/simple;
	bh=T10KPJOOKWuZ5Fq017Sn3oeb8mnAxJ/S5xjvvdfQiK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwTGD0t78Jicz6gMZSWBr6NVAr/JTDZuEyOFqapC86Jyr/Fdz/BhiJ3S9cOheqpnnC5iP7ioPW89cDQ29DRX2z9NzzRDN6HZ6rwk5WSiBUUGSZZ8gr7UyjDAzcInS7JQjp82h0gRnp3NEOZub59ubnSzKH5J34Nd7dhT00aKB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvcwfrT6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvcwfrT6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DE6AC2BCB8;
	Tue, 16 Jun 2026 08:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781598072;
	bh=T10KPJOOKWuZ5Fq017Sn3oeb8mnAxJ/S5xjvvdfQiK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pvcwfrT6r2WC3rJLK9I5tUtBnszNT2RplfZTxe4ACHjof1Z/Mp6DT2ACYs1Co6O1+
	 gELDgab7ReG4vWZtTyPnDXe2AHtGYtDt32YVCiIM3tSVv1GcP7OZtYg3pqHpL6F0Mf
	 9g7HLcdWVOpcGkKhml2n0+LALJ+4BUoOgYObBSfifk7HGowVcRHRGqPJpGi5IHEW4D
	 DVNR5Li9qL8mikRwJ6mo8bVlhGSfIG2WXXdS/dN0lWoxkzxyHjRcGgldTSZDmqNzLp
	 jwzatcvaEbfBbGXDF67kDjO5mFMORxdJ74UdbI8rmeAgx8Aia1xbtUXXGoh5Z2pkjs
	 fyD5Vy00fU1Fw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8539ECD98CF;
	Tue, 16 Jun 2026 08:21:12 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 16 Jun 2026 09:21:13 +0100
Subject: [PATCH v3 07/12] iio: dac: ad5686: add ldac gpio
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-ad5686-new-features-v3-7-f829fb7e9262@analog.com>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
In-Reply-To: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781598070; l=2240;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=E84ULT/Vw/G5qLeMh29ivnSFEoa859ccYBvweeQdKOc=;
 b=tMLyqKmy3xKUR2xPpSl6VqCtFlpxl3Lsf58PkMv31NG6gey8/gQ+iv2PufuDj/7Obsu4kYdNM
 G076RR4JXYsB7BBhTbxcBQjeGP+jb1kUutXb38mwCUra9e2AtfdfIMc
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
index a48acedff51c..73105c197964 100644
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
@@ -515,6 +516,11 @@ int ad5686_probe(struct device *dev,
 		return dev_err_probe(dev, PTR_ERR(rstc),
 				     "Failed to get reset control\n");
 
+	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->ldac_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
+				     "Failed to get LDAC GPIO\n");
+
 	reset_control_assert(rstc);
 	fsleep(1); /* reset pulse: comfortably bigger than the spec */
 	reset_control_deassert(rstc);
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


