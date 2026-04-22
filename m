Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC534846E;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869185; cv=none; b=XZk0MoL3Ix2qZ1m+0LtQpz0aNIXldngoAYIO+Dmb9QJlov4eVDdgftapMJcR2ZkDFtGMElpZEEceQ2tiJw5KZ/2UDbC3Okyi+1sRGbRl/4SEwSbrffGUEegsM5yPnLwOvWPmTuXVHJpCHHViVWGe8tAqedTVvaz+Atg8ZNX1iw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869185; c=relaxed/simple;
	bh=3hESn832CfVD1qGqLh7+GlKm0U4NhAxkZ7Jm+PmxZfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9214TDxYpR+HJdktt15gis06C+jA7s8aOXixjRLwdE8aOmoP24CyCSTTNYv1S0Bp33U+yQC/nkztfuavD2JM3vpfabU8mbzpkcvLP3X4bKeSfb9XjDA3lGeWE9Ql25uz6ee+JcyagmhlFRqx029Xasv6bkVrfXlAHyhq6ClcQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNg2yGLo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNg2yGLo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEA9FC2BCC7;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869184;
	bh=3hESn832CfVD1qGqLh7+GlKm0U4NhAxkZ7Jm+PmxZfo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JNg2yGLoFpsOWkyeVaMnv1zbEpzRsezV66/C8WGBGgsm2VvANZqIPn0dDWk0jbKyL
	 +UzscNWQaohkZ6AcjfVj+0X0CJTC1FVuH5O52ktcH8Abcc6ofiYzFzLUZT8AcfpPXD
	 nF2kA4rvzsp3fh0q16HHSY+wrZovUsCzmdZTc6vLFhGF3h/njlkmD8m+VKMy/2OGEw
	 F9wtNYFup3iHzODgdGCr+IXprswlYnCxLxoktxukhQ3h4QprAmMz+WjUeTnQa+1DOg
	 p0iYGmJDr9VTej+nxnoHp4AmXp9gg7yPlBy3ShcZ+vVhJJiaIURgEpEG0Q6qgxET7b
	 Ts6/bkrMUw1XQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B259DF9EDF8;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:48 +0100
Subject: [PATCH 14/22] iio: dac: ad5686: add support for missing power
 supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-14-ed7dca001d1b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=2155;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Z/GezyWiY80ZBSqa1VITaQKZTnq4hO/6275dv+f3m1U=;
 b=3RNNPvTq3x/z9VtYoeaK53SU6Z31sVadzXzmfwmHfmiQ1pvHV4I33R/F4W2EhjmkTg99iK7pz
 +l2nVz2SAebAnHLN9tvaJdY1s4MrN+OLbB61Auk/w6PfQPM1Z66ZzZm
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Get optional regulators for vdd, vlogic and vref input power pins. vdd is
the input power supply, while vlogic powers the digital side. vref is
replacing vcc, which is being deprecated, but still supported. The value
of vref_mv is checked so that a device without internal voltage reference
cannot proceed without an explicit supply. Error report uses
dev_err_probe(), which helps debugging an init issue.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 07a944311f0e..4989404a7b6e 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -7,6 +7,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/module.h>
@@ -471,13 +472,27 @@ int ad5686_probe(struct device *dev,
 	st->read = read;
 	st->chip_info = chip_info;
 
-	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
+	ret = devm_regulator_get_enable_optional(dev, "vdd");
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
+
+	ret = devm_regulator_get_enable_optional(dev, "vlogic");
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable vlogic supply\n");
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret == -ENODEV) /* vcc-supply is deprecated, but supported still */
+		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
 	if (ret < 0 && ret != -ENODEV)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to read vref voltage\n");
 
 	st->use_internal_vref = ret == -ENODEV;
 	st->vref_mv = st->use_internal_vref ? st->chip_info->int_vref_mv : ret / 1000;
 
+	if (!st->vref_mv)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid or not provided vref voltage\n");
+
 	/* Set all the power down mode for all channels to 1K pulldown */
 	st->pwr_down_mode = ~0U;
 	st->pwr_down_mask = ~0U;

-- 
2.43.0


