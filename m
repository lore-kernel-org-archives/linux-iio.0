Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE363D1715;
	Thu,  1 Oct 2026 03:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790825378; cv=none; b=lNbKhwAfujn+M0kvO19CBweNEJ6RJQGcn9ZvqkY7sGncUpdO2T/Hp07XSJWnbdAUIRKK2tz8r3EoWw6K7NediMqC/4PC4OjgaAg1ewjcoeRnY6k7P7fD43k6+dYP2pSN1S/Q/atABiNQCmv81PyREFMGcJZVylCjKCzzqwyRWMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790825378; c=relaxed/simple;
	bh=Efyja0txl/66WV+lz753WdzkL4tiz5+OqqKjmEnE3Rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NfkqU8cj9PVO2+6cXnruXYSkhInPB34K/bi5yyp1miQKhxK+0OnN1XSczxhSloTjab1LGYSFuSoC5ljfasoHpw91+9N/kXBvTeMK8aXkSBBodAAESd9uPvSgX5SY0+FL5/oRJGWvjzuGuSYRcO2fXECZnFwR/KkdcGWEMVHau9U=
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
Date: Thu, 1 Oct 2026 11:28:46 +0800
Subject: [PATCH 3/3] arm64: dts: aspeed: Add syscon phandle to AST2700 ADC
 nodes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261001-ast27xx-adc-upstream-v1-3-5ace57533418@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790825325; l=1190;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=Efyja0txl/66WV+lz753WdzkL4tiz5+OqqKjmEnE3Rc=;
 b=SgzgZ4wlAzPIAqLhOcEZ3MhdMXqUwhAP0JTEq66ya5R06NtsVkK8v+ZBROIu9FQ2NnHqoLbZ3
 RtxNjtbSehDAGwJhkkEQ5iGLe8W6+uitnZ8hxnGku7hatjanUPVDUcx
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Point the ADC nodes at their own syscon1 so the driver can correctly
locate the reference-voltage trimming data on AST2700, where syscon0
and syscon1 share the same device-tree node name and would otherwise
resolve to the wrong SCU.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Assisted-by: Claude:claude-sonnet-5
---
 arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
index bc990f79e693..cd25fa191806 100644
--- a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
@@ -246,6 +246,7 @@ adc0: adc@14c00000 {
 		clocks = <&syscon1 SCU1_CLK_AHB>;
 		resets = <&syscon1 SCU1_RESET_ADC>;
 		interrupts-extended = <&intc1 80>;
+		syscon = <&syscon1>;
 		#io-channel-cells = <1>;
 		status = "disabled";
 	};
@@ -256,6 +257,7 @@ adc1: adc@14c00100 {
 		clocks = <&syscon1 SCU1_CLK_AHB>;
 		resets = <&syscon1 SCU1_RESET_ADC>;
 		interrupts-extended = <&intc1 80>;
+		syscon = <&syscon1>;
 		#io-channel-cells = <1>;
 		status = "disabled";
 	};

-- 
2.34.1

