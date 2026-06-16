Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF540E8D9;
	Tue, 16 Jun 2026 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598072; cv=none; b=i36G8kLO2zPeI5y0HbnA6pZ27ShaXNhGCsrxg22jxoIPZoHvsp6+pSTF0QYtpslkXfBBEyQv5paeQmzVUzhw6Xm77XsybntFk+mGeyNLqc3wH7CXP5ugEKWhy6MN8l2EWi7EKAzaUyKIiZ2pQikShM6GHvcVXAfbhECalel9OEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598072; c=relaxed/simple;
	bh=X4eK2WY3HCN2HXCz77ClHvMyYfKmXsEGeURLcc34pfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OO1pFKLiNuEdWaVKdp4bUn82M/QJm50eSk73Bcvc+GW9GVLwAlVy7MYWbG8g4kDIa2WuraNshKJIBHvhkBP3/BOezjMneTl/o45iUgXyrSglJ/Oc5aZVWzFtmKrICAdKxSSLdxOBNWz+i7Nb3lMMTgNY4KVHuU66/ydw4WklJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uov4zJO3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uov4zJO3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64294C4AF14;
	Tue, 16 Jun 2026 08:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781598072;
	bh=X4eK2WY3HCN2HXCz77ClHvMyYfKmXsEGeURLcc34pfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Uov4zJO36cgf/TbTBw5+hUL8k47Q2dB6F8wIui2X95+Ar+x2keJOir7NNoPV4JGxf
	 og1KemyRZauYzEHqB0kfl26YmiXkZSK/yljiJJcsqyZ5Vtr3/F+EnNTTx0AS+0FbeA
	 3NL7bNnOPmq9ktzdef+bGv22Bz5ygG9wXPPVBNpRNmJTr57tk/ksda/yQragodsoDm
	 b87HOQ7dvEWZWpR0c7ZuoDGS4+ZlBodNix2/yiMnup4Y7zT40786ZcK1pGsjrA/9Vt
	 X4/CxnCMm6MOxePs+myNHYosqsMAePN5ryc1pzDRPdjYsL9lykFDLm/6cb1kjH4R0+
	 7r5/z2FDKseBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4A9CD98E5;
	Tue, 16 Jun 2026 08:21:12 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 16 Jun 2026 09:21:11 +0100
Subject: [PATCH v3 05/12] iio: dac: ad5686: add support for missing power
 supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-ad5686-new-features-v3-5-f829fb7e9262@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781598070; l=2407;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Ok/L9t69TGKH5gf/InTKyQKJ9yC0oOAOxXM9Cq7sFt0=;
 b=T71kybLQPXbhZ39zGVM+scYSoOJ4ivmSrer26BekwRv3ycmfZ9MhNzFCOBWGW8ZFzp0gDprLp
 B0cu66BOtFgD247LAmoyImPQ95PQdSUzRPJFFFFPQWN2S+2QHN4WrYU
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
 drivers/iio/dac/ad5686.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 5840fda4b011..fc3863274b29 100644
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
@@ -484,12 +486,27 @@ int ad5686_probe(struct device *dev,
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
+	fsleep(5); /* power-up time */
 
 	/* Initialize masks to all ones */
 	st->pwr_down_mask = ~0;

-- 
2.43.0


