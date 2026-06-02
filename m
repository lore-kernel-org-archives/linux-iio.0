Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAA8374185;
	Tue,  2 Jun 2026 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418033; cv=none; b=KKDOueNG01BUKwRvrsATVEPftVb3y9JD7hQ/pB9sJ6dLIWBoaP5AaXFTU1g3fdPWstSlQ/uyllsTMyQyTCkXtfsf05IJ/j6FfzAFNNdcZ/M+pEbPBnvnzux3n5eGs9GTpniiMPwy0Rdp7O6dnci3IY1PPd6O3rLH4pin7NgtHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418033; c=relaxed/simple;
	bh=Ex1nmMpcn3Pxn2Oc8203/m1TcpdVIjGVQfv879Sx2BM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ikae0ImwjOhWIcWUtKoQzAPwihsH3Ab7BxjPWj5wBTUN9WQ0z1gYOpyL5MnoFkVKCh8Y8rFSQI5bimRfJX4/VjS5HbKqZ4mC7rzYXWQ6Ut/4MTLEGRU8N0icvaUzhSl2zQfvd7ufqWjgJJriRCesqPTlwhrLc/yDY5UK8bwJYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnJ66FAD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnJ66FAD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13849C4AF10;
	Tue,  2 Jun 2026 16:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780418033;
	bh=Ex1nmMpcn3Pxn2Oc8203/m1TcpdVIjGVQfv879Sx2BM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BnJ66FADHhehXKU//VRsBDpypNSEuVl50NFWIGHhqdsKDBMnl4nBy5cNYn92J+pGA
	 TojyFP4Lbqfu/YDxoxk9LwY4u0T/RrYeMbeGJ1jXdba5Y36OG8W2X1J6KfGXwd2hVa
	 YHY7VmArUDL00ZRQuUOgnizZRLZ/bXSMujL6VdkP2hWjnlE4Njo6PDBmvsr61weIaL
	 93hg8We2a3rsMW1pmHzltqOVFGlE08bvewk9gaponvi7KB5Y+qi23t2K/p3N/ftzBp
	 UZcNct5ThMMIwB17u4t9mo3HKssaY6lsCPylMy2D+TlK0j7PLUngbNFKhTcbiKtohk
	 aXx5HrqBrJtaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0334ECD6E57;
	Tue,  2 Jun 2026 16:33:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 02 Jun 2026 17:33:54 +0100
Subject: [PATCH 07/12] iio: dac: ad5686: add ldac gpio
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-ad5686-new-features-v1-7-691e01883d27@analog.com>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
In-Reply-To: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780418030; l=2056;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=pQX+cKvJ4ibMApwzGdCAG2JhxzWSWbPGxwsmPRVd0Ks=;
 b=0fBdx4J+O+ZGJpTFZA1nz9YeD0BAqPDKODvAx1L3d+H0nwIMntPim294gNjuEYIHiWjCHzZJQ
 qW2BMeXTfF1CGmsMX/iMPgJIQR1RGVa/xQoaiWw1MrvGBNha5pYe6Ic
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
 drivers/iio/dac/ad5686.c | 5 +++++
 drivers/iio/dac/ad5686.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 345ca2436332..8f91838c5b53 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -514,6 +514,11 @@ int ad5686_probe(struct device *dev,
 		return dev_err_probe(dev, PTR_ERR(rstc),
 				     "Failed to get reset control\n");
 
+	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->ldac_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
+				     "Failed to get LDAC GPIO\n");
+
 	udelay(5); /* power-up time */
 	reset_control_assert(rstc);
 	udelay(1); /* reset pulse: comfortably bigger than the spec */
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index a06fe7d89305..498d05ab12ee 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -9,6 +9,7 @@
 #define __DRIVERS_IIO_DAC_AD5686_H__
 
 #include <linux/bits.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
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


