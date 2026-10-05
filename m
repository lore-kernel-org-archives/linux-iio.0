Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F7470440;
	Mon,  5 Oct 2026 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195801; cv=none; b=OcYy0w82Z7CTC7M5ykJqk9rUdbVyMtZ8lnCdEQgWYsqeaAH4ZboZeKoFSfkS3tq1z/okpczoTyORxxnm6G6C7O/MS8GXqLp/rcJ64WzUxiCxeV1qDqBsIu9tAAiITwfpsQfQj75+sZW69vA7FXmFYautJhwVQbf++/xVs/Dtfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195801; c=relaxed/simple;
	bh=2PCebKymufPfCOdBtvACM0Cya5M651ViGAm5WV/pHUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iuHc+hzGEYyQS5qNpFJ7/dohKEgezqH3dDo5Dl2stmgspdFkY+yDpEqmK9Cu/6M5tQ2g0oguweWF+FHRLE7Hrq2GUvY07BPzalMz4iu9a4lFupTqdsu02zRlBrVtnoPEd6ucYBAGQv1YHf/BaZ3+W5LO+aJVbdg2zXol18gNMGU=
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
Date: Mon, 5 Oct 2026 18:22:55 +0800
Subject: [PATCH v3 3/3] arm64: dts: aspeed: Add syscon phandle to AST2700
 ADC nodes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261005-ast27xx-adc-upstream-v3-3-ef25552d3a59@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791195774; l=1195;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=2PCebKymufPfCOdBtvACM0Cya5M651ViGAm5WV/pHUk=;
 b=v8ZH1dEb+lgzhh4nrWBg1YBVPVIyuYV34vKxYup7B/syJdac5KUkI2lqRpRwP+6cjqnUePZCp
 KLxB3CXL45HBvCT1uxpf6KMEJjz9zwmYs//RuaSIT0Ew7Z6I0cObAaN
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Point the ADC nodes at their own syscon1 so the driver can correctly
locate the reference-voltage trimming data on AST2700, where syscon0
and syscon1 share the same device-tree node name and would otherwise
resolve to the wrong SCU.

Assisted-by: LLM
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
index bc990f79e693..053673cc4b8e 100644
--- a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
@@ -246,6 +246,7 @@ adc0: adc@14c00000 {
 		clocks = <&syscon1 SCU1_CLK_AHB>;
 		resets = <&syscon1 SCU1_RESET_ADC>;
 		interrupts-extended = <&intc1 80>;
+		aspeed,trim-syscon = <&syscon1>;
 		#io-channel-cells = <1>;
 		status = "disabled";
 	};
@@ -256,6 +257,7 @@ adc1: adc@14c00100 {
 		clocks = <&syscon1 SCU1_CLK_AHB>;
 		resets = <&syscon1 SCU1_RESET_ADC>;
 		interrupts-extended = <&intc1 80>;
+		aspeed,trim-syscon = <&syscon1>;
 		#io-channel-cells = <1>;
 		status = "disabled";
 	};

-- 
2.34.1

