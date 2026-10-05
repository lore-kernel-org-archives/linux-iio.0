Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6045518A;
	Mon,  5 Oct 2026 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195784; cv=none; b=J0QZ+8t3c3zeu14fXvOVy7tmjAsYzK8uoCtlmx9XXOJyEOu7AV03qA+E8nWZiCpxFz4qIlsGFw7d1+RxLQuKZqQiFlwCGL0nMwIo//RjmjexHWjcl5iEQtEoesl4cyqrQL+0zyw7og99SuCCumKKGKbxEeQawLDkyEm5NeHiWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195784; c=relaxed/simple;
	bh=MHyVw2ZKEJEd8TJ8ETLosBAMfdGwcfGP+L8N5MhXY2k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=AmR+uPgu/ZZmEASJlIXeyIFyI/rUMkpQYucmQLsjPZFskiP/tDUOA9fZIQCYBOuA0kGfPSIvM2uOvAhmzDtuCYiPYVVYiQ7kZe6+SUul3qL5pUurX0U/suKNfkOKaw3jPlgt7FBx+A3F60eXqxqO/r8kUEugl6MoCJG77CNTg20=
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
Subject: [PATCH v3 0/3] iio: adc: aspeed: Fix SCU lookup for multi-SCU
 AST2700
Date: Mon, 5 Oct 2026 18:22:52 +0800
Message-ID: <20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHx6w2oC/43NTQ6CMBCG4auQrq1ppxTQlfcwLsp0kC74SVsbD
 OHuFrYudPl+yTyzskDeUWDXYmWekgtuGnOoU8GwN+OTuLO5GQiopBCSmxChXhZuLPLXHKInM3B
 VtspeqCGoW5ZPZ0+dWw72/sjduxAn/z6+JLmvP8AkueDaIOlaK1XK5mbCTGQjYX/GaWC7muAfC
 bIE3QWlRhSiKr+kbds+ZsKNHwcBAAA=
X-Change-ID: 20261001-ast27xx-adc-upstream-34b3d9e8e27b
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Joel
 Stanley" <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"Ryan Chen" <ryan_chen@aspeedtech.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>,
	Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791195774; l=2794;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=MHyVw2ZKEJEd8TJ8ETLosBAMfdGwcfGP+L8N5MhXY2k=;
 b=PLwS/wCnfPxX+nADfgg1wNzPo70a7CAhsL3H7u0XTCfapXutbtsVxUdlgGbZIMhueQeui6wjq
 qx+KILeVT7sDxdsA2t22v1DM8uBIvsUffnY68eM7qAf/OcNxC7MPgsp
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The ADC's reference-voltage trimming data lives in a SCU register. The
driver has always located that SCU with a global, name-based
device-tree search, which works as long as a platform only has a
single node named "syscon". AST2700 splits its SCU into two
instances, syscon0 and syscon1, that share that same node name and
differ only by label and unit address, so the lookup always resolves
to syscon0 even when the ADC's trimming data lives in syscon1.

This series adds an explicit "aspeed,trim-syscon" phandle property so multi-SCU
platforms can point the ADC at the right SCU, keeps the existing
global lookup as a fallback for single-SCU platforms and already
deployed device trees, and wires the new property up on AST2700.

Patch summary:
1. dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
2. iio: adc: aspeed: Use syscon phandle for trimming data when available
3. arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes

Assisted-by: LLM
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Changes in v3:
- Switch the LLM attribution trailer to "Assisted-by: LLM", the format
  required by Documentation/process/coding-assistants.rst, instead of
  naming the specific tool/model
- Move each patch's Signed-off-by to be the last trailer, after
  Assisted-by
- In patch 2, use dev_of_node() instead of dereferencing
  data->dev->of_node, and check the new property with
  of_property_present() before calling the non-optional
  syscon_regmap_lookup_by_phandle()
- Link to v2: https://lore.kernel.org/r/20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com

Changes in v2:
- Rename the new property to "aspeed,trim-syscon": a bare "syscon" is
  not a generic property per writing-bindings.rst, so follow its
  vendor,type-syscon convention
- Reword the property's description to state its purpose instead of
  restating the schema's required condition in prose
- Drop the extra AST2700 example added for the one new property
- Link to v1: https://lore.kernel.org/r/20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com

---
Billy Tsai (3):
      dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
      iio: adc: aspeed: Use syscon phandle for trimming data when available
      arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes

 .../bindings/iio/adc/aspeed,ast2600-adc.yaml       | 17 +++++++++++++++
 arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi     |  2 ++
 drivers/iio/adc/aspeed_adc.c                       | 25 ++++++++++++++++------
 3 files changed, 37 insertions(+), 7 deletions(-)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261001-ast27xx-adc-upstream-34b3d9e8e27b

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>

