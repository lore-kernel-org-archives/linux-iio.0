Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF782FD1B3;
	Wed, 19 Aug 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143288; cv=none; b=KvVdRKl95MBEr6CoyCaeSoY4aWNXgWD4lKJVb+zLXpo7NBaqW4qUqenEs1FZZSAJSBcWI4qPMrsyeKQmc9jsdx9ja1Z2b1EWU/FaAkX5oIT+CCSA8hPDt88DOplwGGbw089qeusAY4OjNSAHaesdIGJjMIqyQUP0qnjhPQS0Me0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143288; c=relaxed/simple;
	bh=sbbf2gMwT2mQ4hsO6RqswvgeptrUSaK86zqfyIwZ5Zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=b3GaLxmW1frnETpcXg/eNgzScx0/CcpSLudGuzEiMg0OtFwGTmhafsaY5aDWS8EcUonKjn8CBECcNPgOAmejy55jl4VxrZPEF4mPo3ch0WYXN4rqi3T7A13wv3c/9RqS5QHiTQ+eensRlW14PHNCvan/f1HyQJKYVYrxeLN60p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=btp5NQX3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="btp5NQX3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787143287; x=1818679287;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=sbbf2gMwT2mQ4hsO6RqswvgeptrUSaK86zqfyIwZ5Zo=;
  b=btp5NQX3/rIe66fZ1ewktd9IGQTQ68UCil0MtzwkluPnnVVD3kAkcXmw
   4bqsvWtZDV0S13ycEacdWGdE/1bCgBv7BlenAPWC+6p8wQYSZdCtjLHXy
   gUkE4JzTrk/IhMjOXk24zwI2uLZBQMS0Apy1xc01H65EupJa2hafdGqdi
   sSlwQMRMxGACuNh3nJL9wOL7waBKCenAFwqlAKVzsTpVhqz272sSPfIuF
   U/6vP4MHaJJ3nYUh3Dhu3upeMepKLVAJuxMIATXCoGII7soaHte/TUuiE
   KRJ933ptPB6G9fO0wjpGahpeIzYkxsjj4T6BjprgvH/IAbj+PBDHQPRny
   w==;
X-CSE-ConnectionGUID: AOPnssA6RL+h3CbT8rDvzQ==
X-CSE-MsgGUID: aiBmtNpnTruuuGPoFfC/hA==
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="293736246"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 05:41:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 19 Aug 2026 05:41:23 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 19 Aug 2026 05:41:20 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 19 Aug 2026 15:41:08 +0300
Subject: [PATCH v4 4/9] iio: dac: mcp47feb02: use dev_dbg for invalid label
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260819-mcp47feb02_refactor-v4-4-beb2aa3bfd09@microchip.com>
References: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
In-Reply-To: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787143269; l=1115;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=sbbf2gMwT2mQ4hsO6RqswvgeptrUSaK86zqfyIwZ5Zo=;
 b=ZFkQmyXPtwuJ2MosB4jOBCo2Org4/lxpG/7S04JX/PPzHnFjYfCOWympDa9ccgmyGE1lxY+DX
 9gDdj6oDcFNCtn256LxSKG3K/5luh1QZA0mcpWKfiSHwTnVvPjii7iL
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Correct unneccesarry probe error returned at an invalid label with a debug
message instead.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 2ee981393aa1a2dc0bf65d25ab937132fe2e7bf1..e5533fa3c31c0006d170764791177879c1e794b0 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -15,6 +15,7 @@
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
@@ -978,8 +979,7 @@ static int mcp47feb02_parse_fw(struct iio_dev *indio_dev,
 
 		ret = fwnode_property_read_string(child, "label", &data->labels[reg]);
 		if (ret)
-			return dev_err_probe(dev, ret, "%pfw: invalid label\n",
-					     fwnode_get_name(child));
+			dev_dbg(dev, "%s: invalid label\n", fwnode_get_name(child));
 
 		chanspec.address = reg;
 		chanspec.channel = reg;

-- 
2.43.0

