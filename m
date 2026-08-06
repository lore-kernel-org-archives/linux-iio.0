Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356182DCBF8;
	Thu,  6 Aug 2026 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006067; cv=none; b=L8yGWZILFgxcnfsItcgdVp/RLkOWXIiHyY08kjTVNtTx/fNBWhs0dJj+F/ho67wC+iwux+IAeNbkhtFfyQ6YO+Wb1ntF30glx1Y/pDE2mcQCN24IsaAYMfQuQRz3/LjrHt7Ef0HpmHCKPdavQzSjUUjuxJ4W1sppkVauEeGTP7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006067; c=relaxed/simple;
	bh=qCks5QmHaWli0znQDgqe7ceH6hFdVyHKYF2/F2T/0N0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAiV5rd5Oq1DgfBH+uvOgK980WBtbfp4nYRv7EG0goL5A1b7MtA7NvjrwMgSx/qKxiangdqPjigke08Vi6PIRUfr5PoTjnAuWlLrlvi+gylPJVIZzyIxqLVgEu4I6EmCmZUSuzF4T2PWmrLB6cFTMFyyez5jq8pjRB+Mob2rhBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iIckpWvf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iIckpWvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786006069; x=1817542069;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=qCks5QmHaWli0znQDgqe7ceH6hFdVyHKYF2/F2T/0N0=;
  b=iIckpWvf8Wn41C+eo/S7WsOevSdGB/jvEdFYkuU+flMfHajyR1FuBF+Q
   Y3WGdTbCr0y8WWKVK8oife3180VGtyjh+PdhwmyejScTIN5RyrKgZPGKN
   odLap7MBnfofiFA1e7+j83S46NcfpQEjgZT7YS2VPpDAAuHZR+BGl30iP
   x8U5GDsBkJVeqoCWp5NUOySYex0HbHz/MwroS4OOGNVteSx+fLFiRn0TY
   aKvlj2qwC3Rems06kiMPUcZzwRXWHeLnuMcHl24tLpLIgLaOYzMLdwczc
   DBPbb+L7y4n5vVgB0rdkYmyPmoJcqF94fp/TwdN6obrePwCy+sKlnm8ey
   w==;
X-CSE-ConnectionGUID: mb0tXTfvT/iY9DC6oUULLQ==
X-CSE-MsgGUID: 1QwlM/TuQTqvGgCK0uZpFQ==
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="71343314"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2026 01:47:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 6 Aug 2026 01:47:44 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 6 Aug 2026 01:47:34 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
	<joshua.crofts1@gmail.com>, <jorge.marques@analog.com>,
	<Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
	<antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
	<mazziesaccount@gmail.com>, <varshini.rajendran@microchip.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 06/17] iio: adc: at91-sama5d2_adc: remove unnecessary casts in of_device_id
Date: Thu, 6 Aug 2026 13:10:13 +0530
Message-ID: <20260806074024.531259-7-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806074024.531259-1-varshini.rajendran@microchip.com>
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
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

Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 5b21367cf6b4..3e9feb824a66 100644
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

