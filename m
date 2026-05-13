Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088F37BE6B;
	Wed, 13 May 2026 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648451; cv=none; b=LOxp8bJeo7IO2xF7g4yyqZ//X2u7K0XyUF6uZ3nrpdwgdwNUkb5zRoFQIMypIUJ13gDOQOAfv17rIaNP2cJ0+B970GgvhLdteUhpBP1Nn5tBGBslV+tBPwzdgJ+WbWGlOxXWT/ks23vKXxny7Kd7aUiRwHI2uGY8mNkJKfKh6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648451; c=relaxed/simple;
	bh=I8HMsZirgXX885nuJJP7JQN223GiZKMXE/BN5ZNXDh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqorJ1PSngIhO5B+ycH9oPP3evo3oKVLqKo+mhZFw7M9tnlMM9qDjCvp1wJpRs+Y1fPKvCegQf7izlnxjePsJJILvqo1xVgRgdcT3m2hVhTJ2LDRSDHBbXNvMOHKfM+uU5DQPMq/qqtg03V3CWq1qAqvD/s2QPE6wFk1mu14+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=RY1eRyoq; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="RY1eRyoq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AyyMPtOl9wP1fMDaeO+c2BR6cLsA+AOebpc5PnOHZCg=; b=RY1eRyoqg4Dh7MoMTripUeubfu
	CjYcbXK8Br0OzeBE8cj4nFlg2G3PCFY1sdNBhtX7JLTiVfboFHlSjUX37ckPrtaWf+6XAXCcJNkBO
	BBiWbWCf16FpppES1CX0ROZOXpRdzRjQMkdTN9+GrQ8Btg1nzXFYc80LowtuCttwPnQJSNVD4gOCi
	GSHuSymhjmOAOhaUbAGwz4UNlRUfJR2l6KeaxMAxpx9MRny9pxzXYDj9ZTb4AZrDZFzuvsdDxG0Ec
	+6+mYLWL4+AZnV+Oew1S2kkaHOOu1sb3q/3m6WYUX0e5rJhVAkwEci2Rl6WQP3er/g+BzDiZ7peWI
	Mk6pPY1A==;
Received: from [91.102.182.218] (helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1wN1iA-0000000EbXi-35LL;
	Wed, 13 May 2026 07:00:46 +0200
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Date: Wed, 13 May 2026 06:59:43 +0200
Subject: [PATCH v2 2/3] iio: adc: sun20i-gpadc: add A523 gpadc support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-sunxi-a523-gpadc-v2-2-d5efde151dac@mmpsystems.pl>
References: <20260513-sunxi-a523-gpadc-v2-0-d5efde151dac@mmpsystems.pl>
In-Reply-To: <20260513-sunxi-a523-gpadc-v2-0-d5efde151dac@mmpsystems.pl>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maksim Kiselev <bigunclemax@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Michal Piekos <michal.piekos@mmpsystems.pl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778648397; l=1618;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=I8HMsZirgXX885nuJJP7JQN223GiZKMXE/BN5ZNXDh0=;
 b=9R/92n4OO7rz0UOg1KOojjxsQ2ixBGVbfkuPW7Agy7qsR5pS/ZHeTurTPQj4ZBpnEIsCSNCw/
 bfrCRcMH9Z9BVQcIIjvB/FZe9zMtH/Oz45RFgKuEGbks/H4kdnS62EH
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl

A523 differs from existing sun20i-gpadc-iio by having two clocks; bus
clock and module clock.

Change driver to enable all clocks.

Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
 drivers/iio/adc/sun20i-gpadc-iio.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gpadc-iio.c
index 861c14da75ad..3f1f07b3a385 100644
--- a/drivers/iio/adc/sun20i-gpadc-iio.c
+++ b/drivers/iio/adc/sun20i-gpadc-iio.c
@@ -180,7 +180,7 @@ static int sun20i_gpadc_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct sun20i_gpadc_iio *info;
 	struct reset_control *rst;
-	struct clk *clk;
+	struct clk_bulk_data *clks;
 	int irq;
 	int ret;
 
@@ -205,9 +205,11 @@ static int sun20i_gpadc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
 
-	clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable bus clock\n");
+	ret = devm_clk_bulk_get_all_enabled(dev, &clks);
+	if (ret <= 0)
+		return dev_err_probe(
+			dev, ret,
+			"failed to enable clocks or no clocks defined\n");
 
 	rst = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(rst))
@@ -243,6 +245,7 @@ static int sun20i_gpadc_probe(struct platform_device *pdev)
 
 static const struct of_device_id sun20i_gpadc_of_id[] = {
 	{ .compatible = "allwinner,sun20i-d1-gpadc" },
+	{ .compatible = "allwinner,sun55i-a523-gpadc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun20i_gpadc_of_id);

-- 
2.43.0

