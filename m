Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FAE3AB5CA;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655794; cv=none; b=coIQX+k6p8Y5XiHBcxjRMShk94KIKOD5ehJnygHUoCocOiEPDiXomvZenT70dBmCsAFuukSzaUXukll/6/bJkLE57+kXjQXOTrjNS31//aXTHUkK3ke2rbFBGYUAjPlmsky8pHeOMoK/NFweVvFLWS6gJtWEbeOpmgHcWKGPzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655794; c=relaxed/simple;
	bh=DP9b3X7hTn4lENMs1fQ7NumoTqXlS3alBnRcv5X59PU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dWOab10Jgv7rN+up+c4k3kSpPSDL7DQn4IvJHwV6DON/beTGlxQ1n3WWvW3ueeav+u394BCxOUv+wfCZhOV4ZmQWO2O6FPITz4ak1ermPWYsIhC4ksxW+bXSDtdyemLXwtQo3IDqpMCFsmiN9i0gmmWG/x+WKlmdH761AgzeY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSryoxyt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSryoxyt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24107C2BCF6;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782655794;
	bh=DP9b3X7hTn4lENMs1fQ7NumoTqXlS3alBnRcv5X59PU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eSryoxytFbE32E3BoB5LgqWSBHakJrvgPBA8GgIAIze9z7bVKpWnSB6kqvOauzxK7
	 abAmw7Hzbl8LjeJoA98kB/GpY9lTT47zquuDPPItXBLNnHAdpvd7jc4foPrIODLxRb
	 Kyql9B2yxAm4/30cu/UoxoZclTdYMPYErJzDC+El/6A1i6RfPb6WfXDV6oHf1RgpBF
	 HCjGXeMqP3GfpfYKEpVdivMXaHLACWzGDJmnI8zdrEKX6weRLw+znvq9CpadWUzgsW
	 5uXunrpmPc8PoB7YXfIcdhwa7uy6PgA4k+/rhE1JpisQhTM42XHVkZxJmgr13RM9ZE
	 uXQuo/lQ1MlhQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0C5C43458;
	Sun, 28 Jun 2026 14:09:54 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 28 Jun 2026 15:08:12 +0100
Subject: [PATCH v5 05/12] iio: dac: ad5686: add support for missing power
 supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-ad5686-new-features-v5-5-577caadbf7c0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782655792; l=2460;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Tr442c1u34XlsfiJuHQO8gjG3hY5veMoFtLrjc67lHs=;
 b=WUCjcdryK6BP4v+i+5TYZ2rFrgnfIeiy/YtXR0mqJMQgepWC9xo5/hXkUZsuN+L2l4M1dfzea
 H9NKyvC49jMDqMjb/Y89DGNTuvAG2e0QmXDXt3IUPoD+fdfQF5bh/xO
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Get and enable regulators for vdd, vlogic and vref input power pins. Vdd
is the input power supply, while vlogic powers the digital side. vref is
replacing vcc, which is being deprecated, but still supported. The value
of vref_mv is checked so that a device without internal voltage reference
cannot proceed without an explicit supply. For correct operation, vdd and
vlogic are required, then devm_regulator_get_enable() is used so the
driver can still work without them by using the stub/dummy regulators.
Error report uses dev_err_probe(), which helps debugging an init issue.
A small delay is added after the regulators are enabled to consider for
the power-up time (4.5 us).

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 5840fda4b011..e2ebabca6887 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -8,6 +8,8 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/kstrtox.h>
@@ -484,12 +486,28 @@ int ad5686_probe(struct device *dev,
 	st->ops = ops;
 	st->chip_info = chip_info;
 
-	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
+
+	ret = devm_regulator_get_enable(dev, "vlogic");
+	if (ret)
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
+	/* 4.5us power-up time: Datasheet Table 4: Timing Characteristics */
+	fsleep(5);
 
 	/* Initialize masks to all ones */
 	st->pwr_down_mask = ~0;

-- 
2.43.0


