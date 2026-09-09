Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1D58FD23;
	Wed,  9 Sep 2026 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963546; cv=none; b=IYt3F4G8J6Ng1CFAx+QYLmkAX4HxAO02RTpVvtgxDLYch9yFWWTgCsGBnimmsdVbnR+dbd1f7DSvXd1q7v/tzWyEMa3XRqeSC/TPD1g29ME3EjA5Jx6DJS9BqmhCOmeNHHBdcmPs3NkmSI2xvw0WNmXXgG3iwBGUbGUHdahKo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963546; c=relaxed/simple;
	bh=XOwHCqaD4UXNhS1G1ZWkzje/ADUwFiyB6AAxXl4VqQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hYSHebjMPoFPQwR4+cgxD0T3RGiPAuz58gcu1xRIYxSm6MgTVnHuKmsJr6Mj68ihmcxKDwJ/PMClHYFuKrmjAmDk7KKYiUuuDncG1xxe6JtqMz+hDyit2PESRqW6Z7yn89Ml8A78xY8N3kmdG5alVcWatzBLvHoaBkWo1S7OWjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KNI0sT6D; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KNI0sT6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788963545; x=1820499545;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=XOwHCqaD4UXNhS1G1ZWkzje/ADUwFiyB6AAxXl4VqQQ=;
  b=KNI0sT6DrcL1GWOwbeqndHkBfnn7t/4r84PvEVF7eV1phhEyB2WpIbZf
   oxZksbtUe3ClfhdjeK61L6ovlUCW15sQZub2v+r1C0u7Kt2Ba/Dby0wbr
   atuQynyVpkZsaiTo9j2nH/7lHQMkT7Mz8gjyD13Zw8taZiRupopOUtL76
   YyV0O71loOJLbwL8dngZds51D3uVe41i004RElyRTWHfmV3egfgrHI0lx
   7ERMA7XdxuAvNTRocw6JShBQ+MAueZJlFe6bp4/XLPeZy8X/Vt/oW+Rt8
   sE33os6EldDvFQSF65PV3Xv0Wsp+eRBwhfu4HEddC6XBBPJ+vm++yvPOl
   Q==;
X-CSE-ConnectionGUID: h738Jf2bRPSkE5xJg0RikA==
X-CSE-MsgGUID: OG+cHa6vRiuQ7IkBs9Nv5A==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="294764002"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2026 07:19:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 9 Sep 2026 07:19:04 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 07:19:01 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 9 Sep 2026 17:18:47 +0300
Subject: [PATCH v5 04/10] iio: dac: mcp47feb02: Increase EEPROM Programming
 Write Cycle Time
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-mcp47feb02_refactor-v5-4-8b67bcab93d1@microchip.com>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
In-Reply-To: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788963530; l=1393;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=XOwHCqaD4UXNhS1G1ZWkzje/ADUwFiyB6AAxXl4VqQQ=;
 b=+BlMUuIdc5yJf5HpM6zATmvHTzhmaMVwfqu+PAbsHkpJB+0+gV6yG5lNpcgGRoiMxL6BLiMlz
 DSu6tMWTd6hBd+XiB7N/06YOolg4malW1OsexzmSIss2M4//EO/Bh5B
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Increase the EEPROM write polling timeout to prevent -ETIMEDOUT errors and
incomplete nonvolatile write cycle, according to the time specified in the
datasheets (11-16 ms).

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 2ee981393aa1a2dc0bf65d25ab937132fe2e7bf1..53a7bf4e71c46e75dff8bb5b16c343e7552f6901 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -449,7 +449,7 @@ static int mcp47feb02_write_to_eeprom(struct mcp47feb02_data *data, unsigned int
 	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR,
 				       eewa_val,
 				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
-				       USEC_PER_MSEC, USEC_PER_MSEC * 5);
+				       USEC_PER_MSEC, USEC_PER_MSEC * 1500);
 	if (ret)
 		return ret;
 
@@ -509,7 +509,7 @@ static ssize_t store_eeprom_store(struct device *dev, struct device_attribute *a
 
 	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR, eewa_val,
 				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
-				       USEC_PER_MSEC, USEC_PER_MSEC * 5);
+				       USEC_PER_MSEC, USEC_PER_MSEC * 1500);
 	if (ret)
 		return ret;
 

-- 
2.43.0

