Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234433D1705;
	Tue, 23 Jun 2026 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212160; cv=none; b=dzEcWQ/hdWrjuC54OT1jFTDIwFgTzEKTk8s1YDJ4euBNzd56L7SOYYziJ2IL9ue/VZsCUQW9YwcgYRHf2VPZWkHie8fgr+Fz8Vp/Q2OZRC2ge7JD3ltbiZ5bzTk6hzpgOLuCbnlM93iRpAt1vnUX5mdrRyTjmeQ/ntY426k/9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212160; c=relaxed/simple;
	bh=BX6XFLrrl7rQKzPIYZIJuegm0hFPGVT9h0aYfoKr/Ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ols5CiyLQz8gB6uCUhfkX+f9IaBE68vAdC3BfED3Ha1PbVVeT6EztyOhTgEhpzz3IRtJMXRIte7v4vRaKvJjateZ1H0Sz07ewncoZeJDhwos/5FcziHHm9bbBjw40ahzpsXm2hKaaz8EUHP8yny3X/I5/oHzza1CQlM4iHrjcZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTyOj1vz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTyOj1vz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E63F4C4AF17;
	Tue, 23 Jun 2026 10:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782212160;
	bh=BX6XFLrrl7rQKzPIYZIJuegm0hFPGVT9h0aYfoKr/Ac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oTyOj1vz0MB/wLwxgFypdHQgy/oAe6KEraxnRNLJYbHzP78qNOEqnxFkcrDgXIBHe
	 6LZdQ0BwoEmqsTAKEwqc1xcsoezmAUeTqyJR5zJ8cvNGrA+Huoe/mbS/y3fp+JYxKK
	 MGjdiMpwQj4oW5+mhQXvQi7lXu2aRWSr2iV3ERpnWj4m6SoYcSBYHTAviL8O7Y0MP4
	 gO3aFE/xUqsDyqa305pCvZPUuzBYhyLeaj48iWZe3Bi5QsII4LHIgiuX9nsgvJ5rHa
	 MxDgMPiv2CN8i6a9dMUwC45nzC6J9TGulQ9CiwfShJJsrfi2/j4wErAlmHazX8u2cI
	 nmL8KMc+bYugg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE328CDB470;
	Tue, 23 Jun 2026 10:55:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 23 Jun 2026 11:55:46 +0100
Subject: [PATCH v4 06/12] iio: dac: ad5686: consume optional reset signal
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-ad5686-new-features-v4-6-28962a57db0f@analog.com>
References: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
In-Reply-To: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782212158; l=1786;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=L5icfA5WYm8ov/3pCusG7IPcFnWQG1nvPrm0z48/efM=;
 b=MVMCdyoQpw/jroXdTgtf58cOTj/B2vHiSakbCztsqc8uOdTuGHPMwhZQFvF/wK2u6raai4XJJ
 b7h1meBrJnjAyTmqsNB9Rshyz0BUDZ1od2EhIjJ3PAmYlofG7QR/nuj
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


