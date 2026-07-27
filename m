Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8C4028CE;
	Mon, 27 Jul 2026 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155262; cv=none; b=Bj/C/8TdNLLVirysE5B7bg2Px0HozivnIcILhTI27hBvxEL8Gdppd6cQO9A/9RaEhSZ/REMp9+8ZOOodYTx+SzgNzS9xFBmBrP4MZd/dqu4nnLbh95vcXM+U/B9Cd7YqAXXLPb5L+H9QMUhZpA8hAyYkkE0SYxsXR2jx5B9Djhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155262; c=relaxed/simple;
	bh=Zwd1mu3YCT2AqP9YqitXwSUmD2qgS2CTbBwbtUQ5TaQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzYtjzgEyi/fQ2MDJ1RE46L/cMpbYUSQNc7sR/f8j9xUyWhtJBnpShyPCIH7iK3/XU0QiCG0orWlQN5nhdS0gpZFqD5CwJc8IKE9bG7ALVWqZbqSSjYrNyXkQ1j7IRp01ypWbzDHEmtmvFXNaRMiHG+EwaBQfKuX7Lbm4Sh4ABs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YLPGPjh4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YLPGPjh4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785155263; x=1816691263;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Zwd1mu3YCT2AqP9YqitXwSUmD2qgS2CTbBwbtUQ5TaQ=;
  b=YLPGPjh4MfMEeijBJ43IsS2phnQGvxhl63eh4xBYfTMtgmHLj5A8Nuv1
   fzPqRyODqBTfu2jgWhA/T/2cTpwUbfLa40LsISMWURJsuudOh+/a6Ll1/
   VUCegyipvWWIjWBaj1VxgA2t6h1ZNinkNQb5wUNnzpUOaB6n4wWh3LjKW
   y73RCTmz2qcbSDgfpQfccYStqwi3xQYE8Pz+z26p+Wj9u6z/2DfW/ltBW
   UfEz1Q9QIrMQOaQ2lhTH0bGQ06SIj6IIGMuKP3hCe/dUoSbYdVweNQrdy
   YyDmvoII8CfteY6wyuyl9c++SRoRyxiPLpSDzxzqagmUcRYHT0E0+lM1A
   A==;
X-CSE-ConnectionGUID: +0C84djJT7muJgfuPtKBzg==
X-CSE-MsgGUID: nmmDJL0WSJSxjscx2lDhEw==
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="228368847"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2026 05:27:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 27 Jul 2026 05:27:37 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 27 Jul 2026 05:27:28 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
	<Jonathan.Santos@analog.com>, <jorge.marques@analog.com>,
	<joshua.crofts1@gmail.com>, <jishnu.prakash@oss.qualcomm.com>,
	<antoniu.miclaus@analog.com>, <varshini.rajendran@microchip.com>,
	<mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 05/16] iio: adc: at91-sama5d2_adc: remove unnecessary casts in of_device_id
Date: Mon, 27 Jul 2026 17:56:22 +0530
Message-ID: <20260727122633.117435-6-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727122633.117435-1-varshini.rajendran@microchip.com>
References: <20260727122633.117435-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The .data field in struct of_device_id is 'const void *', so explicit
casts are unnecessary when assigning addresses of const structs.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 15dc88f4961b..63481ecb94f5 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2628,10 +2628,10 @@ static const struct dev_pm_ops at91_adc_pm_ops = {
 static const struct of_device_id at91_adc_dt_match[] = {
 	{
 		.compatible = "atmel,sama5d2-adc",
-		.data = (const void *)&sama5d2_platform,
+		.data = &sama5d2_platform,
 	}, {
 		.compatible = "microchip,sama7g5-adc",
-		.data = (const void *)&sama7g5_platform,
+		.data = &sama7g5_platform,
 	}, {
 		/* sentinel */
 	}
-- 
2.34.1

