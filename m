Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625E3F6C3C;
	Tue,  9 Jun 2026 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999992; cv=none; b=rbu/zXbLwwRjnBOco2re0Bnh86Xb3Ia0x1zm3pHPcFsfPVJ9Ctem4ZhRbC2gBPlZk7XKVuTKRBboJC8RumcTMUfhTWnmeOtg36SdnnC3ptFoKaxSJwJVODB70WQ62NLR+TYpzhu8ZnJzVtKzFkxllyvKHMuUCbYujPfBoZ4kV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999992; c=relaxed/simple;
	bh=tOOC4UNMSMwVe9urbu68Tea/QhBFN57+nhhbZebO20Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHMp85MlIM0B3rDts9xyEb/7Y43/KLlydYyGHBOD0K2b9gUhIka9SNR7JehPU4URuPVM8dJIZISHkwrcF7La43DeG6t2jFH6LqinzTK/C1AGiGkZRU0APxBLRT7+dBh7voSSRgz9r+SAoRHSuXoVRnrDiOqsKycqyAgCIgV9e4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj1qM2d/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj1qM2d/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6962C4AF62;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780999992;
	bh=tOOC4UNMSMwVe9urbu68Tea/QhBFN57+nhhbZebO20Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oj1qM2d/WI8H1JTU/Vg0HeF197TX0lAb/v5n13C1Nc4uRlN1p/PW4NtOUHlcthzx3
	 V+KCN6j8Qf7iQf86j7FvyeklLB82UFeB1UCwmPOkpHK0LLlr4xhHSXRvDzkJB0Nrwt
	 uls9q3CO51Q1+oyKocL5wyYVK9XlVy6yCECFg/bB9sLaplj8yoR02ijXwuDvw9FNj3
	 fFNRLctd6UA7lXnsZfMD9cxBeXiTEYTB9QLVhVUtiuvCn8I1ocedkmnp8G+XSwKjqs
	 BCL4dtSWsSGwpqZTrlu0Ls8KEDjf9eMtOPyTVDXivdcEwZhY3N6JzEZTGRAGDdGoXW
	 lidN86LdHZo8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF52CD8CA7;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 11:13:01 +0100
Subject: [PATCH v2 06/12] iio: dac: ad5686: consume optional reset signal
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ad5686-new-features-v2-6-70b423f5c76d@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780999989; l=1542;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=iD1uBMTbVl2ooBBU7RDdcCG+3+7nz1NdlBWyRwwqH9Q=;
 b=XqXHeO0T02KEVS0DmdAMrHjX03nqtJKDT2Ewd4Devk+pYZBDWMhVOgZE/NsYIZ0Mt5PiPo3y7
 HT5Z0CtryuSAkQUIq/8yXXcSCM+F2IhabKFv/FhdjcGvcaVmv7jfEor
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add RESET pin GPIO support through an optional reset control, which is
local to the probe function. Also, include delay for the required reset
pulse width.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index fc3863274b29..700798b80f04 100644
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
@@ -506,7 +508,15 @@ int ad5686_probe(struct device *dev,
 		return dev_err_probe(dev, -EINVAL,
 				     "invalid or not provided vref voltage\n");
 
+	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc),
+				     "Failed to get reset control\n");
+
 	fsleep(5); /* power-up time */
+	reset_control_assert(rstc);
+	fsleep(1); /* reset pulse: comfortably bigger than the spec */
+	reset_control_deassert(rstc);
 
 	/* Initialize masks to all ones */
 	st->pwr_down_mask = ~0;

-- 
2.43.0


