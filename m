Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A644229BA;
	Fri, 18 Sep 2026 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722483; cv=none; b=mp1XeWD1EPOrTdyxrs+NozI6CRo1d8qNRxc0hjzeajsSv5z4q2EpoOLKn/dxdSfPqBCOR5GdvXJVbkX6BBQmyD43J26gVhlSlJqwoVLAlbjrA2ji1EdHLH2GqQyX2Auv8r17a0x9ZUJXJwObw7lDc/LOq2DkXeqa681JDPZkJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722483; c=relaxed/simple;
	bh=FaODXQpCD/pVNfBOQ2De+KS1r/oxpsS0Ncq5LaCtSC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NOKuYNntvZtpTeTIcInq2AmDog7tqSxskFT999FlrU7acgWh/hZeCHdKhDwWyfi5RT3M2lOzrA+m/S6s8VLDjn2PLINjFtNvX4lzDbzlD4Zjl4rnnuH4+DbnrUdJoJcSwKzTKTy7CBgHoX6I+Xf0FbmHBdjlllOyK+nzmnNE6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PyLEXauZ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PyLEXauZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789722486; x=1821258486;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FaODXQpCD/pVNfBOQ2De+KS1r/oxpsS0Ncq5LaCtSC8=;
  b=PyLEXauZXeQ/SnK+NtkCmEOBSxiOeBQ5BxByM34dZFC6vKnujDfnbAw6
   8UPHXn0KNz8t8f1w+/jgCZe04/vxJSPCjsCQgvnNlNgB4M+rpJshpwY5C
   KgX++qXK/V/EViBxODaDMdDglSnPsSIE6teisQj3x2PWzhA9g6+deuCz9
   qPnZYqRs+ZWP3rKCA7jkMJ+jwB8rxglzV0sEP/Pb7kj9XO1e5qKWfdREg
   ui8CFYQZyAC349MXUMdJoL9rjSqNq9hKxDYDDCy691vVg6Z3c/KWwnli9
   z/tnCTBz0X1/dweNuya+ICBJAsY77SfEP8XEhsILu35uxspi/odg+sBu4
   A==;
X-CSE-ConnectionGUID: N5lDwR5/SG+Kak6R2jQMTg==
X-CSE-MsgGUID: OAzJygZzTlaK7LA4eJJ6zg==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="295219121"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:07:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 18 Sep 2026 02:07:50 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 18 Sep 2026 02:07:47 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Fri, 18 Sep 2026 12:06:29 +0300
Subject: [PATCH v7 03/11] iio: dac: mcp47feb02: use field_get() instead of
 custom dynamic macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-mcp47feb02_refactor-v7-3-82ca794eafe2@microchip.com>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
In-Reply-To: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789722457; l=1508;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=FaODXQpCD/pVNfBOQ2De+KS1r/oxpsS0Ncq5LaCtSC8=;
 b=LdnVyJmDQVFV1dcZKADzA6HRcf34WD9W7pGwcQZQU5DCMNnJKLZVjvBsriNfufao7qFTkaut3
 dVxcq3q1FApDCt89+A067HryjgPgv0JmmXFhQgWe0tH0ztFwqAff/55
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Replace manual bit operations which select channel corresponding bits
from a control register in mcp47feb02_init_ctrl_regs() with field_get()
macro used with masks already defined for regmap operations within the
driver.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/all/20260913224339.490d89ba@jic23-hlaptop/
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 1b1a4972f77196399297b3912abe69efcbf17d75..d910a6cf9718d6c6ad68eb1bb1ff5f3b15b33e84 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -1024,7 +1024,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 			return ret;
 		data->chdata[i].dac_data = dac_val;
 
-		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
+		data->chdata[i].ref_mode = field_get(DAC_CTRL_MASK(i), vref_ch);
 		data->chdata[i].use_2x_gain = field_get(DAC_GAIN_MASK(i), gain_ch);
 
 		/*
@@ -1068,7 +1068,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 			break;
 		}
 
-		pd_tmp = (pd_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
+		pd_tmp = field_get(DAC_CTRL_MASK(i), pd_ch);
 		data->chdata[i].powerdown_mode = pd_tmp ? (pd_tmp - 1) : pd_tmp;
 		data->chdata[i].powerdown = !!(data->chdata[i].powerdown_mode);
 	}

-- 
2.43.0

