Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5085368282;
	Sun, 10 May 2026 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778418143; cv=none; b=thgw83tGql0n/d+nZO6cMqR1eyTERcPMwAw+s9Y05NytgisnZYhdndXrAdMO8TsXfUZwn9b+SB6nfzXtQ4iTslhCqlCzJZ9Dzr2KgSevQBo+A1x5VOyVlurbLOiCUU3MA39I2gxzf3Y5KosLZcNCtEdNp2bXQzFutqjATbYK2m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778418143; c=relaxed/simple;
	bh=8W/e7Tc7AKga7S1oho/nSvDoTgXmWjUgZtFOjdd9w5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cd+2vmA/uPt72OzMzPzdm4HlIR6ZIecmQvYSIZeVjxG/2+41vjYzQMRj1OcVWIZa8lTZwW1aLLI7Gw2EywBlpvbNFw4U0aQ4Ktq+xu1n/NQ9uZ9SaGUnkLbGhf13TcPTY4NVpaHNWElELov/kMZfQHwpqUtTrZZHGHn71zRQmys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=I/TX8n6K; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="I/TX8n6K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=INVeGEZOFmKs0Tl9WJDgUcfquzKy7GBBrgR06GMQiFE=; b=I/TX8n6KBHc4FG4306tGjJdHS9
	CnyzQv59+wEDbOO+zYkBOidoGTBe2phjBSU8qZaD33yvABQz5zyge7dfy9XaMgWBZww11H7uLXl89
	eI2+ibopTJWbZiVP4qMNe1E3OXuEfDVk+H+n+W9h/gxSDHKVKUSSHMORhwSQtd1v8cdinPJ9aawuZ
	dviaGHrklpkCCXeoANMVb8I7MbcAiGhukOLXAhKE95jw9RTeTjCZwGUGeXSyazaENl8uz1k2fmKMQ
	oCetwHr8ge1MuLYlPeMwCqMzforkcKeGwIHphe9ug8HrmN98TqWDbMfurSk5Vt6EuqmEj29QqWYBO
	YphXMWSA==;
Received: from user-188-33-36-99.play-internet.pl ([188.33.36.99] helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1wM3nT-0000000DUl7-2bMM;
	Sun, 10 May 2026 15:02:15 +0200
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Date: Sun, 10 May 2026 14:57:23 +0200
Subject: [PATCH 2/3] iio: adc: sun20i-gpadc: add A523 gpadc support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-sunxi-a523-gpadc-v1-2-4f6b0f4000fb@mmpsystems.pl>
References: <20260510-sunxi-a523-gpadc-v1-0-4f6b0f4000fb@mmpsystems.pl>
In-Reply-To: <20260510-sunxi-a523-gpadc-v1-0-4f6b0f4000fb@mmpsystems.pl>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778417853; l=1275;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=8W/e7Tc7AKga7S1oho/nSvDoTgXmWjUgZtFOjdd9w5I=;
 b=a69kXrDPJ999nB3ARMTjh8GE016krvQqW2Av1dPHiwU8ZyZn+x+JZfw83Yjut8j6vI6mxUfzu
 JqghI7ZFH3pDpq7BxNAimCXUeflNWcs8+hh+x+B+41Z/OhzrSEHuSxm
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl

A523 differs from existing sun20i-gpadc-iio by having two clocks; bus
clock and module clock.

Change driver to enable all clocks.

Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
 drivers/iio/adc/sun20i-gpadc-iio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gpadc-iio.c
index 861c14da75ad..dd4c7e6e3d76 100644
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
 
@@ -205,9 +205,9 @@ static int sun20i_gpadc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
 
-	clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable bus clock\n");
+	ret = devm_clk_bulk_get_all_enabled(dev, &clks);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to enable clocks\n");
 
 	rst = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(rst))

-- 
2.43.0

