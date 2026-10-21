Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548587;
	b=jYC/g0w3VsQzvJcnZi3RmvgyloVfdJuQO8t4OZGBN+dllR7YhhwS6GpupI/4+6u+C6i3
	 I9qH/MnqxVLrjIITKIQ8QSYxZRXclcm0oT2eVRElgJ43HsFb1dvgGG/7fMS0AvrqrtweB
	 WV0b4vLPug59uF11RMC4DIQF+kMSPxd+7vZN2QOKZe5738IoUjIYIZUOxApozmxlMuOku
	 h7cYazZ/F8ntRDgoXzzd909cpdPqD9Iskre60UKRVHYtW8VbuVtJBlu1RtyYsZ5hd4g8R
	 TRLsfavk1uSOZhIxMALOAruIBYrETDBMVo3pJDYQBf+dntutNA1gKLjP7xKH5gxpTtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548587;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zTvHoWVK2MnY6BXYoqcKq7jXZ7I8mh27KAsKSWJ+yVU=;
	b=GexDPKOC910lCEbb9QRDLOs14GiRfn0vA3u2gKhuhA3rsbIbz7rD9/e/59vR48K9owwo
	 3pKtJh+OM7tWHCQCs1EQKRcHFyFl5ZVqPFGqmYS9WuPxw2dbUd8h9NXVU3YB/TErPSQr9
	 0nfl43MfHcdicKYdJBEXBTpibgzDP23AUT09dzJvlax6uwClsANX0VIZwbCsMQBopCGuC
	 RDJ0gtwJh+bhdndyrXyaMhyuIXyt9/gA7tq7mBfKcDHbz2XDiE/S2AmSn2AVKuwTyGBcg
	 GHFbDq/Dm+9zMnlh4w4UtJCejo225Ix0FafdbqAi3QmPGvA1kLQ41F5+9FT86xq9/Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF68606A319;
	Wed, 21 Oct 2026 02:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFF68606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 21 Oct
 2026 10:09:44 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 21 Oct 2026 10:09:44 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 21 Oct 2026 10:09:39 +0800
Subject: [PATCH v4] arm64: dts: aspeed: Add syscon phandle to AST2700 ADC
 nodes
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261021-ast27xx-adc-dts-syscon-v4-1-4fab164f10b4@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAOIe2GoC/x3MPQqAMAxA4atIZgO1/qFXEYfSRM1SpRGpiHe3O
 H7Dew8oR2GFsXgg8iUqe8hoygL85sLKKJQN1tiuMrZCp6ftU0JHHulU1Fv9HnDwS0t9XTMZhhw
 fkRdJ/3ia3/cDMRTar2gAAAA=
X-Change-ID: 20261021-ast27xx-adc-dts-syscon-9cf5d733ed0e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792548584; l=1915;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=IZUjXmUfedJ5IwJ86vwzPPmrXl0gfhcW6O8UO+QoZco=;
 b=hpsOaG9Ce6jXRrKDFl/kBKvsWHyz/Sq5Ys08ygSSCBVLWf1flEZBUOpaFZRR4mkAg5IG+L1WX
 lJXwEwYjufqDQ7syQ+sp8bYGfbzkOpnagPjO5KBXdfl6Ddg2O37HL7T
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Point the ADC nodes at their own syscon1 so the driver can correctly
locate the reference-voltage trimming data on AST2700, where syscon0
and syscon1 share the same device-tree node name and would otherwise
resolve to the wrong SCU.

Fixes: e77bb5dc5759 ("arm64: dts: aspeed: Add initial AST27xx SoC device tree")
Assisted-by: LLM
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
This was patch 3/3 of "iio: adc: aspeed: Fix SCU lookup for multi-SCU
AST2700" (https://lore.kernel.org/r/20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com).
Jonathan has applied patches 1 and 2 to the testing branch of iio.git;
this resends patch 3 on its own, now with a Fixes tag, since the
driver falls back to the old global syscon lookup whenever this
property is absent, so patches 1 and 2 alone don't change AST2700's
behaviour without it.
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

---
base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
change-id: 20261021-ast27xx-adc-dts-syscon-9cf5d733ed0e

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>

