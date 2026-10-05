Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840D453A29;
	Mon,  5 Oct 2026 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195799; cv=none; b=C8wtuC8qb0cjOX+WuZ42DT5uq+bGOyLjXbfIYDnTBmjfrxd9/JpJNm2D8zd0fJCh+7XadPAmCxc4t9q3e0oOSVzhRS/JDQh3rHwZxpd+PapeQGV9jjK2QWb/g+bXGLTtbY7mQC1N/9MZPpB8/JnFFAD3pfVFxz0erQrTaUNSsWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195799; c=relaxed/simple;
	bh=YH4Cmu/CfrLuJThDgte/J3hpKgFwZ2I49f2dMQ61fI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=X0PasTAXEmiQRRe+pFDiEiykNHYJkyD6waEgAYvaULzUgEd8ATBR4Kpr29yrFMdYtKUnsYXdEXVsLyoLQRX2W+hOSJXDJnDNC+OkvdM7RnyebKsePdGaQRxTL4Cb8S3XzDNKjFZhbNisaS/sMqdJGHytl1NNF/tZg4Pl5mO/KJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Oct
 2026 18:22:54 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Oct 2026 18:22:54 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 5 Oct 2026 18:22:54 +0800
Subject: [PATCH v3 2/3] iio: adc: aspeed: Use syscon phandle for trimming
 data when available
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261005-ast27xx-adc-upstream-v3-2-ef25552d3a59@aspeedtech.com>
References: <20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com>
In-Reply-To: <20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Ryan Chen" <ryan_chen@aspeedtech.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>,
	Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791195774; l=2496;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=YH4Cmu/CfrLuJThDgte/J3hpKgFwZ2I49f2dMQ61fI4=;
 b=FS0L5yTDLB2vZ3FQ7ws2UDJYqFOC+LaJ/sEIbbX6NRuZwwsf5jHVySmf8Mp6I6XDzcnClBGJu
 qkIca1S0By5C7QDScqEw6GBPTQVt2aisWBk1oMiBluk/IJmG2e0QmjD
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

aspeed_adc_set_trim_data() locates the SCU holding the ADC's
reference-voltage trimming data with of_find_node_by_name(NULL,
"syscon"), a global search that matches the first device-tree node
named "syscon" regardless of which SCU instance it actually is.

On AST2700, which splits its SCU into "syscon0" (soc0) and "syscon1"
(soc1), both nodes share the same node name "syscon" and only differ
by label and unit address, so the lookup always resolves to syscon0
even though the ADC's trimming data lives in syscon1.

Use the new "aspeed,trim-syscon" phandle property when present to look
up the correct regmap directly, falling back to the old global by-name
search when the property is absent so existing device trees keep
working.

Fixes: 9d8b88ffb773 ("iio: adc: aspeed: Add AST2700 ADC support")
Assisted-by: LLM
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 6169ce28261e..a31ba7b0efc1 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -201,18 +201,29 @@ static const struct iio_chan_spec aspeed_adc_iio_bat_channels[] = {
 
 static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
 {
-	struct device_node *syscon;
+	struct device_node *np, *syscon;
 	struct regmap *scu;
 	u32 scu_otp, trimming_val;
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
+	const char *propname = "aspeed,trim-syscon";
 
-	syscon = of_find_node_by_name(NULL, "syscon");
-	if (syscon == NULL) {
-		dev_warn(data->dev, "Couldn't find syscon node\n");
-		return -EOPNOTSUPP;
+	np = dev_of_node(data->dev);
+	if (of_property_present(np, propname)) {
+		scu = syscon_regmap_lookup_by_phandle(np, propname);
+	} else {
+		/*
+		 * No "aspeed,trim-syscon" phandle: either a single-SCU SoC,
+		 * or a DTB predating the property. Fall back to the old
+		 * global by-name lookup for backward compatibility.
+		 */
+		syscon = of_find_node_by_name(NULL, "syscon");
+		if (!syscon) {
+			dev_warn(data->dev, "Couldn't find syscon node\n");
+			return -EOPNOTSUPP;
+		}
+		scu = syscon_node_to_regmap(syscon);
+		of_node_put(syscon);
 	}
-	scu = syscon_node_to_regmap(syscon);
-	of_node_put(syscon);
 	if (IS_ERR(scu)) {
 		dev_warn(data->dev, "Failed to get syscon regmap\n");
 		return -EOPNOTSUPP;

-- 
2.34.1

