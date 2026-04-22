Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381ED35CB6A;
	Wed, 22 Apr 2026 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869185; cv=none; b=byS4NGP5WhHfUAy80lvJIv3cmoe85iK4J2xOKaPeyg1yPk0fEXamMHsO71OOcRQzes7nCtonZHFFuO4YpDqG5fFPpf9b2L7HnARXzyYmc4P4c5VwObP0CCvqiBtCskHis+3uAOWnqKYHmdRiL6ONbraiUMDnQHMr7MTH9slufn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869185; c=relaxed/simple;
	bh=9Ry/xie9bws+jjU+HLl640jFV5VQErKM0NyN1y9kc5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bg/Xr/gGoq/5c7y42zM/erUEr9W9DcwqJaI7WuffL56EVD/o/DmXobSG/yQD1xFqYqWj7SqhXNoyYA0XUyfQGb5BduQwhYZhFB3ZCtSIEsZ2LPL2Qjx1hNbhRSoSQzDoH+btR42LIOiK/DcAT8UaKqXqFqEf40djQifJjGjnnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpswZKMH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpswZKMH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 100CAC2BCAF;
	Wed, 22 Apr 2026 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869185;
	bh=9Ry/xie9bws+jjU+HLl640jFV5VQErKM0NyN1y9kc5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kpswZKMHXzMyc3QudZhPA4SKi6jQFJQe4fH0R1ZjYGVyq/F2+8ZcE2Jbf+iG91LD2
	 YIbDonabJIAAfT3x1ZyNN9qCqBZCcL8BxVP4r3mW/cPIePLiFe1YFOOsRDVZq5V0fW
	 aF3mv71qXKj+Sq9lVkpsM5mEuWFBqyDDUBXvFuGuep+FAISp5dfGQ0R/YXQ46eKIOR
	 G6OJEfYIsesHe7pLvqW+aX8CW4IbBlqKh3PqCZSFjYCdp5+Ko9xJgI1anB09LQJeYg
	 yqMvPUP1yBnYs7QtWMRIjKNDcJkKiBReHp175XfmsG/JjoQEjfQB2b1r5PKvuBD4yA
	 LZrALXKwiyA5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036E2F9EDF8;
	Wed, 22 Apr 2026 14:46:25 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:52 +0100
Subject: [PATCH 18/22] iio: dac: ad5686: consume optional reset signal
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-18-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
In-Reply-To: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=1411;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=3UgEqXCA/XRsf04HaUrlAwYpFQa0MfcYtNAzXdyAGX4=;
 b=IrB3+7OY+DElqxbbkxVqr6FxOrgkYRuwuEkx2P+glAx8X/YLBvxBifOwljdzkK3GBkpKVuK4c
 3NflE0CYXbXDzFg2ZDC+rR88edxwgomPcJZ6CJd6CGELeEg0vwCOkZ9
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add RESET pin GPIO support through an optional reset controller, which is
local to the probe function and deasserted by default.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index cfbc1624e01c..f239880d1cc7 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/sysfs.h>
 #include <linux/wordpart.h>
 
@@ -509,6 +510,7 @@ int ad5686_probe(struct device *dev,
 		 const struct ad5686_chip_info *chip_info,
 		 const char *name, const struct ad5686_bus_ops *ops)
 {
+	struct reset_control *rstc;
 	struct iio_dev *indio_dev;
 	struct ad5686_state *st;
 	int ret, i, shift;
@@ -544,6 +546,11 @@ int ad5686_probe(struct device *dev,
 		return dev_err_probe(dev, -EINVAL,
 				     "invalid or not provided vref voltage\n");
 
+	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc),
+				     "Failed to get reset controller\n");
+
 	/* Set all the power down mode for all channels to 1K pulldown */
 	st->pwr_down_mode = ~0U;
 	st->pwr_down_mask = ~0U;

-- 
2.43.0


