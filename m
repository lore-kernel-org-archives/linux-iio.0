Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A3373C00;
	Tue,  2 Jun 2026 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418033; cv=none; b=IUXzF1NrXRGz0/oXnINodzij9sNPeyCHyXC4pI4wsmyrHBgg9fXtKsMU4Rk9TEh7pJ+bAK6y3m+K1EEsBdURazCwFClmTgSQJ2Z/V1VIqFt2VQ1HZbUR6PKViYskLSjVij3yef0N6tZixP/JY4c/1IgQRQwA/K/EE/A8+OVdU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418033; c=relaxed/simple;
	bh=1uhLpa5yyTgy0PQcnwcLD7pAKtgmq5gMx2kxNzRb//Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mj99lzZmYSKO59H8AyCcnoV4afbYNH+eu7br+lR14aVGjxrX67Jzd0vLaHgnFJDtULgwT2mWPWDeXmHi/1MtqK0LsC58mfy0vYxk1+nW2xIbJ+CFWU6CDv6eHofIUqvrI9EtPmjKYtCmNHf/iDMZ6Ecv7AuSZ+1pcGOMEKUgqjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDKjc+ZR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDKjc+ZR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB3A6C2BCC7;
	Tue,  2 Jun 2026 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780418033;
	bh=1uhLpa5yyTgy0PQcnwcLD7pAKtgmq5gMx2kxNzRb//Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MDKjc+ZRGSanL6Rvke0+5qlArvw+zAc6qzfN4vkiBpC6la2fVWVn+2I1VXsXNwP2Q
	 WeocpdBecYvZxfI2n0ieOMvFrsuipJokWSCtjt0kmwq81LAZ7c7JktQmIrE2COJL47
	 P/TeM/rJJaEGKn1y7yqEYoIdvXkNoZPnimcllYLpyoPrdmZcVA/fUFw3H2vanBXTVy
	 aUkUsudPyxInHbYRT7r3TT/KuZNuLeJOnOJcabEU2lSwlIzIjT6kKgx6M+/Fwuyg33
	 9llAsDAAs17cxhPyf/Pr5ifTmqWu44KshoNMyH3VfUNuC8r0FJmhrj45BIu2S9iYP3
	 4tGhVXp5dPG7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42B7CD5BD1;
	Tue,  2 Jun 2026 16:33:52 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 02 Jun 2026 17:33:53 +0100
Subject: [PATCH 06/12] iio: dac: ad5686: consume optional reset signal
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-ad5686-new-features-v1-6-691e01883d27@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780418030; l=1771;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=vXNN1mglGgjf48pZPy8eNX8aBxzrQUf3QPxVDN45sSE=;
 b=W4TrsPcJ/Kxj21ft0cLAe96AbCbgBo5ZD5cs9uFqRZEOoIMDfhQOWbJrjUIWclDq+xhJRSqFt
 VEOavaFWZ4hBj7Pw5UGrHuEbSj9sXaykfzXh7KLbp3iRgLxkmjx2daS
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add RESET pin GPIO support through an optional reset control, which is
local to the probe function. Also, include delays for power-up time and
reset pulse width.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 4a8c587ff116..345ca2436332 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -8,12 +8,14 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/sysfs.h>
 #include <linux/wordpart.h>
 
@@ -471,6 +473,7 @@ int ad5686_probe(struct device *dev,
 		 const struct ad5686_chip_info *chip_info,
 		 const char *name, const struct ad5686_bus_ops *ops)
 {
+	struct reset_control *rstc;
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
 	int ret, i;
@@ -506,6 +509,16 @@ int ad5686_probe(struct device *dev,
 		return dev_err_probe(dev, -EINVAL,
 				     "invalid or not provided vref voltage\n");
 
+	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc),
+				     "Failed to get reset control\n");
+
+	udelay(5); /* power-up time */
+	reset_control_assert(rstc);
+	udelay(1); /* reset pulse: comfortably bigger than the spec */
+	reset_control_deassert(rstc);
+
 	/* Initialize masks to all ones */
 	st->pwr_down_mask = ~0;
 	st->pwr_down_mode = ~0;

-- 
2.43.0


