Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38235B135;
	Thu, 12 Feb 2026 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900587; cv=none; b=HxKJavJ8EjIuWhl8hTCc7W+IW2clrxm8Y0uu07eSq6Obv4nhXUQLD7j6C8JRbAXKz5dONp2eTkmYz6jRVWFAPp93kdx7ZCODSoNCDKxgRs8xFtBjun8jwEfno1TZAobA9YHentwZN5aexAX8OB8+Prl8CRsGqyZRQ32BDJ3H+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900587; c=relaxed/simple;
	bh=iad303l3zZ5l856PlUqr23aq5DlSy22IcAjaZGkyz2o=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=cxbC6dCLC6W5kcTGiqDn0akfO84FDmIXr6Cc6wfJvV5xRtHvhi/JEytYaTT89/Bd5vfFBvFGCGHWGH9daFgEOZ3H09uXeQC+Ki8Phb+2Si+t1IsL+asbnI+cwThMQIwNj3ehDUR8qd+qCBLkrxHCPr/I3JwgczrhiVbNEbkkHwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XTmxgW+r; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XTmxgW+r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1770900584; x=1802436584;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=iad303l3zZ5l856PlUqr23aq5DlSy22IcAjaZGkyz2o=;
  b=XTmxgW+rU5fyfDjaBows8MJuTGxgVIdd/cmp4LMIEYACwoFfxYfpdioO
   opAwq9IvrRUQNMTjc1NrSFdhvHxoLTUrhdNW70Fg8WFPE7bSIkZlgh4Ku
   1CjDY9048TAsBygZ4pC78W/OhP1r+g0NuE5sPvRpckK7OPOsbQYhjMH6Y
   JYucpOgO5pu6mP3CDTw+Fh4A+HZQGvnROMA3BOEP9h81BB2LpPyeErm/K
   G318S83hSrKCd0nWVwi58O9dQBWFuN8ambipWoNkgKA42JR7XQA4xdYgV
   6pcQQ75oEdiBi4kHFdeCXGXXF194lmW+FAmoWgDCwnUDONzwbCEN/aXsw
   A==;
X-CSE-ConnectionGUID: ZgyXXBmlThOzT7Jg+y+Ymw==
X-CSE-MsgGUID: mgzrG3JkQHO6M9Xcn+jO9A==
X-IronPort-AV: E=Sophos;i="6.21,286,1763449200"; 
   d="scan'208";a="60610914"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:49:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 05:49:05 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 12 Feb 2026 05:49:02 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH 0/2] Add support for Microchip MCP48FxBy1/2/4/8 DAC with an
 SPI Interface
Date: Thu, 12 Feb 2026 14:48:33 +0200
Message-ID: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACHMjWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0NT3dzkAhOLtNQkAyNdkxTLNENzC0NDMzMDJaCGgqLUtMwKsGHRsbW
 1AFHyEMxcAAAA
X-Change-ID: 20260115-mcp48feb02-4d9f17811660
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770900543; l=1410;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=iad303l3zZ5l856PlUqr23aq5DlSy22IcAjaZGkyz2o=;
 b=kRdydXxxxRHKg1yWPxPit6nVJZytb6/OF2653EeijhscTpj7UXoFbDRe0un91g/cvGXgPdD9A
 QPoeguc6oC5C4NtNqrGMCxczX9CrByu3Napgf/vKpi/iwibwI6RGx0E
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Add support for Microchip MCP48FxBy1/2/4/8 series of buffered voltage
output Digital-to-Analog converters with an SPI Interface. This driver
covers the following part numbers: 
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
      dt-bindings: iio: dac: add support for Microchip MCP48FEB02
      iio: dac: add support for Microchip MCP48FEB02

 .../bindings/iio/dac/microchip,mcp48feb02.yaml     |  299 +++++
 MAINTAINERS                                        |    7 +
 drivers/iio/dac/Kconfig                            |   20 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/mcp48feb02.c                       | 1243 ++++++++++++++++++++
 5 files changed, 1570 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20260115-mcp48feb02-4d9f17811660

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

