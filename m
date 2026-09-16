Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3190750C28D;
	Wed, 16 Sep 2026 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568362; cv=none; b=U0Gij0adSjQqhgYauc6EYi9avk7GFCHs5edEQiKXPLVWwkhCUeJSOaDgKxISmO2oNEN1gXvWeD+DbWXDket7ywWtQ8HC+SztK9Da6ZFEjPGFcn7Bm5VxZkWE4ve/usLUMeGDcRt4lnVEgcLVVJxaHKQhtbwauwZu9WDrp1E8SI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568362; c=relaxed/simple;
	bh=3SnBX6s92qYDiwvlb6kNwIVXgkXJjcnAWpZqIHcGjJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=E6bc9hpMZvr/TiZlPkVloVfm8fliOxpSN5ZJT/sAZMJGnOAjvvlEw73Wec5bMVvSYOrA/1+kTLzH/5jY3HOKVUBqVpjrx3k3X+tUdIaAauZShiME7VJFASxRSCqQziR/h4PZV0xTjBVEUUVv28hBGlKoR58ZP1QbAcup3J0YBtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=V9x2QN2j; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="V9x2QN2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789568362; x=1821104362;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3SnBX6s92qYDiwvlb6kNwIVXgkXJjcnAWpZqIHcGjJE=;
  b=V9x2QN2jZl3NNeFibL2SMrn8ID/5TsvaPdlM8cQd917RgRxtQxPSnOyq
   R4Fd9KEsfAJ36nZEnLsBFrgsX4yAVVY2YBwb44WceCUc+ODuXlMUQWQ+W
   G03MDz0m+kWrKLLgxYs8tD6vVj1hEn/3EXlsScJqA+poXcRQz46cGrAs0
   2ojL8HUVIOjPz62xxCbpY9zgJ2k42NzkUj0fdbnXFAj9BRYQcnGWLsiVo
   vmG2n9dnFYNUlm42cyV0Z8fWKRWOHb862ghtvTu86x4XSanQ1ZWFpbdHB
   zxDrkEir9ELbIIqUzHAUuvZOEydJYVRNfgvfg0BC0PHF+PY2tId5F2CRk
   Q==;
X-CSE-ConnectionGUID: s0QkyWdyR0qAe7aC6lQrCw==
X-CSE-MsgGUID: Rh6OxDcnQeuZvCVcgk8Kyg==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="230816063"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2026 07:19:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 16 Sep 2026 07:19:07 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 16 Sep 2026 07:19:05 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 16 Sep 2026 17:16:29 +0300
Subject: [PATCH v6 03/11] iio: dac: mcp47feb02: use field_get() instead of
 custom dynamic macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-mcp47feb02_refactor-v6-3-285464651f89@microchip.com>
References: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com>
In-Reply-To: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568335; l=1507;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=3SnBX6s92qYDiwvlb6kNwIVXgkXJjcnAWpZqIHcGjJE=;
 b=sq3uFtgNICL6jdb8nFM4eE6py3dCcQ50SNbTFz6Okp2/RTOoBQiu3GexLQzE02fgWf66aMHU4
 YC80WRd+lzVBqdOhQs/I8DXcw0h7fi3gYEd3pBkaf9F8JfhgR0V0YhC
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Replace manual bit operations which select channel corresponding bits
from a control register in mcp47feb02_init_ctrl_regs() with field_get()
macro used with masks already defined for regmap operations within the
driver.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/all/20260913224339.490d89ba@jic23-hlaptop/
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index fa4bd1df954844da35a8496758489189aeceb60d..81aa9063fcf730342d4af114da73ac2fc550243f 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -1025,7 +1025,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 			return ret;
 		data->chdata[i].dac_data = dac_val;
 
-		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
+		data->chdata[i].ref_mode = field_get(DAC_CTRL_MASK(i), vref_ch);
 		data->chdata[i].use_2x_gain = field_get(DAC_GAIN_MASK(i), gain_ch);
 
 		/*
@@ -1069,7 +1069,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 			break;
 		}
 
-		pd_tmp = (pd_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
+		pd_tmp = field_get(DAC_CTRL_MASK(i), pd_ch);
 		data->chdata[i].powerdown_mode = pd_tmp ? (pd_tmp - 1) : pd_tmp;
 		data->chdata[i].powerdown = !!(data->chdata[i].powerdown_mode);
 	}

-- 
2.43.0

