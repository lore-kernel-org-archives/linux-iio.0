Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57737BE78;
	Fri,  3 Apr 2026 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775213431; cv=none; b=F0w5PeiMx4yG7FsoHjx0ixktKonktZfzpTRTINjUZFA/mDCH9S7DTDjZZR/JVyszJBKKC1egY5InlJJcbGGXkC2rIvIdfxrZ3XzVoEjiq/djQ20yY5zMPLag46JMvAqms3FlUCEtj5SquMgNlUo3opXp6EdRJUnmRv64UGmh8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775213431; c=relaxed/simple;
	bh=5rRC6E6urUgXtIq4f5cpRd2XhoqWcYONb7lAjtox6Q8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Pwwdv5GSESVNcj5Q7vc/MDVAO+m/dUIwYfRZCILBL7RVpM5pOEpOYPAMJnm2RpbbmjfEb3QguWd/TM+LFN3aeCV+08N53El5ocVxiyh3tj9VYC6bWy619ayCkwYO4mEs2P87yF7Hf5CllUMezSwJssfwpL1P1ODKZnTJw83F+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=h/TbMEMN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="h/TbMEMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775213430; x=1806749430;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=5rRC6E6urUgXtIq4f5cpRd2XhoqWcYONb7lAjtox6Q8=;
  b=h/TbMEMNYKuSlpbYPl7aX0I+sw5ySDD+VgmlQ/HeGFGcV6UF+86AF6It
   Z59y3OzblmY0L42mR7qEI53J8D1nlQsh+5ANvvQUze7aiQDEv2tco6tJX
   4PQjWheegxKJquuQEDEBjKzvg0aw9+sjuVcb4QEPvT7pa4Ulf82xgKTqc
   BgVbiMB5/FKFBof/Hv1cZsmyz1VxWikk90FBA7KaHq6inOtrEAxksOmCL
   lHhu30L1hryeQcoDKxCvnT5DE3WV1ORLz5ShpIAdOXRdV7Ils3HJuRhcp
   nFh9ojuAPeyoRSje0l0pWqXI1ikqwwWu1+lOFAEaVhv0uhtwV4tJIOZVJ
   A==;
X-CSE-ConnectionGUID: 6RvH5ARdSv2+bFC8JbNs1w==
X-CSE-MsgGUID: zpdacrn7R7a7oXs/mlcHbA==
X-IronPort-AV: E=Sophos;i="6.23,157,1770620400"; 
   d="scan'208";a="222892585"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2026 03:50:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 3 Apr 2026 03:50:19 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 3 Apr 2026 03:50:16 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH 0/2] Add support for Microchip MCP48F(E/V)B(0/1/2)(1/2/4/8)
 on MCP47F(E/V)B(0/1/2)(1/2/4/8)
Date: Fri, 3 Apr 2026 13:50:12 +0300
Message-ID: <20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGSbz2kC/x2MywqAIBAAf0X2nGBrD+pXooPaWnuoRCEC8d+Tj
 jMwkyFRZEowiwyRHk58XxXaRoA7zLWT5K0yoMJBad3K04Vu9GQVSs8vyql3gzVm9BYt1CpEqv4
 /LmspHxJQkLBhAAAA
X-Change-ID: 20260331-mcp47feb02-fix2-95c6baa7fb2b
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Conor Dooley
	<conor.dooley@microchip.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ariana Lazar
	<ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775213414; l=2225;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=5rRC6E6urUgXtIq4f5cpRd2XhoqWcYONb7lAjtox6Q8=;
 b=oaqG0nnFkDEb4P72oeszCyUh847BKvaNK71namV+ir9rhxjOKdmj2qAZmdNjfhqfrbRGYQs3a
 h/27Wh2CsRBA9W5SxuAVS8U4hzLszpImprHQe3O43IdGgNdkd2HxVSi
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Add support for Microchip MCP48F(E/V)B(0/1/2)1,
MCP48F(E/V)B(0/1/2)2, MCP48F(E/V)B(0/1/2)4 and
MCP48F(E/V)B(0/1/2)8 series of buffered voltage output Digital-to-Analog
converters with SPI Interface on MCP47F(E/V)B(0/1/2)(1/2/4/8).
This driver covers the following part numbers:
 - With I2C Interface:
   - With nonvolatile memory:
     - MCP47FEB01, MCP47FEB02, MCP47FEB04, MCP47FEB08,
       MCP47FEB11, MCP47FEB12, MCP47FEB14, MCP47FEB18,
       MCP47FEB21, MCP47FEB22, MCP47FEB24, MCP47FEB28
   - With volatile memory:
     - MCP47FVB01, MCP47FVB02, MCP47FVB04, MCP47FVB08,
       MCP47FVB11, MCP47FVB12, MCP47FVB14, MCP47FVB18,
       MCP47FVB21, MCP47FVB22, MCP47FVB24, MCP47FVB28
 - With SPI Interface:
   - With nonvolatile memory:
     - MCP48FEB01, MCP48FEB02, MCP48FEB04, MCP48FEB08,
       MCP48FEB11, MCP48FEB12, MCP48FEB14, MCP48FEB18,
       MCP48FEB21, MCP48FEB22, MCP48FEB24, MCP48FEB28
   - With volatile memory:
     - MCP48FVB01, MCP48FVB02, MCP48FVB04, MCP48FVB08,
       MCP48FVB11, MCP48FVB12, MCP48FVB14, MCP48FVB18,
       MCP48FVB21, MCP48FVB22, MCP48FVB24, MCP48FVB28

The families support up to 8 output channels. The devices can be 8-bit,
10-bit and 12-bit resolution.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Ariana Lazar (2):
      dt-bindings: iio: dac: add support for Microchip MCP48FEB02 to MCP47FEB02
      iio: dac: mcp47feb02: add MCP48FEB02 SPI driver to MCP47FEB02 I2C driver

 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 291 +++++--
 MAINTAINERS                                        |   5 +-
 drivers/iio/dac/Kconfig                            |  29 +-
 drivers/iio/dac/Makefile                           |   3 +
 drivers/iio/dac/mcp47feb02-core.c                  | 845 +++++++++++++++++++++
 drivers/iio/dac/mcp47feb02-i2c.c                   | 145 ++++
 drivers/iio/dac/mcp47feb02-spi.c                   | 145 ++++
 drivers/iio/dac/mcp47feb02.h                       | 158 ++++
 8 files changed, 1545 insertions(+), 76 deletions(-)
---
base-commit: 8625d418d24bc0ff463267b26b7cb2e7a612495f
change-id: 20260331-mcp47feb02-fix2-95c6baa7fb2b

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

