Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490633DE457;
	Thu,  1 Oct 2026 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790825367; cv=none; b=WKHfww1ne/cudW2xPgaj28EKtfycQvccqBP1hPU1EyNZVCVTZAj0S/iElei2QaK14IS1By/OtuGHxklNYXH5ozs2f9GukglqVUgxdjCONrHGvAcoTS2jmAOY/xNua8ZjFrw12j5wim3LKY0k2Qt0QCAFA6rViXD66WlaGJM365Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790825367; c=relaxed/simple;
	bh=JoCVKHqa1BfpuBeYRt31i7335+6pSUtxVcgJhxASgGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QkNRpBE/89baAfViSwopcnT/TyzUJTOW3Bv0zAFVIN/t3aqB5mPKpi41o5Z14Un0Q8LHl6t7Wks+kMfKHl1TFW3+7HXAoDIe/yZAxybXzUN4smSKYdS7VzbHbsbjELTkB3CtjcFaluHfvRqVHHUBqf2AqBaih3tO8XfoHSVkIkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 1 Oct
 2026 11:28:46 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 1 Oct 2026 11:28:46 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 1 Oct 2026 11:28:45 +0800
Subject: [PATCH 2/3] iio: adc: aspeed: Use syscon phandle for trimming data
 when available
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261001-ast27xx-adc-upstream-v1-2-5ace57533418@aspeedtech.com>
References: <20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com>
In-Reply-To: <20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790825325; l=2228;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=JoCVKHqa1BfpuBeYRt31i7335+6pSUtxVcgJhxASgGg=;
 b=ldmeVaetAGKZ06YJ1o/8zPnc4zn6XrJp8cCAd9zJTPmYq0EnTpDeYPJhv+TOKHiiSiKyY3742
 vaEMd+l1kiaCcNBQR+Uc1EUfLQ/iBPA72VVzMOFiAAkpkQ3Y1qlIpKT
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

Use the new "syscon" phandle property when present to look up the
correct regmap directly, falling back to the old global by-name search
when the property is absent so existing device trees keep working.

Fixes: 9d8b88ffb773 ("iio: adc: aspeed: Add AST2700 ADC support")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Assisted-by: Claude:claude-sonnet-5
---
 drivers/iio/adc/aspeed_adc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 6169ce28261e..d195bc3e155f 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -206,13 +206,21 @@ static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
 	u32 scu_otp, trimming_val;
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
 
-	syscon = of_find_node_by_name(NULL, "syscon");
-	if (syscon == NULL) {
-		dev_warn(data->dev, "Couldn't find syscon node\n");
-		return -EOPNOTSUPP;
+	scu = syscon_regmap_lookup_by_phandle_optional(data->dev->of_node, "syscon");
+	if (!scu) {
+		/*
+		 * No "syscon" phandle: either a single-SCU SoC, or a DTB
+		 * predating the property. Fall back to the old global
+		 * by-name lookup for backward compatibility.
+		 */
+		syscon = of_find_node_by_name(NULL, "syscon");
+		if (syscon == NULL) {
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

