Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C573DA5DE;
	Mon, 27 Jul 2026 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155253; cv=none; b=BP8Q4EieCeUNAP8oNFri/UlCX9APalQdLg0dOmn3uXXniniIlOFZMvDTPpEwV4KQ0CxD0uCemUFt486BWipAT5PNEW0txRDldXgipb34QsFg2jjASqGEvUtTDTvdhsPTCWEcQFA8ASFbKgtM+5I3hsBYSBoY3A8+UZfwPjkLI/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155253; c=relaxed/simple;
	bh=HA06NVq1HboUGFnrcw6m52P6ZwSDBODfp3HnmxjuWgQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKioOe5rpBzF3J0Bz4MuJHU3Jncl/c6/KDh0VKscYZlYqy4JyrCND9EKWk5pPxYi1XCKg3m9F1qVBpD4QdhLeQWrDmp+hE6qrjyiIGCSycLGoLa5Ocfb9ouksLqA/+7KQtxrKfi7tRrx+yIohGcgf+H/6i4b0MW2ssB93TPNGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=a4Bg6EXz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="a4Bg6EXz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785155251; x=1816691251;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=HA06NVq1HboUGFnrcw6m52P6ZwSDBODfp3HnmxjuWgQ=;
  b=a4Bg6EXzSv4dhVTzy57FbcmSm0ub/fZsHGmL8NgdcHpiGk+eBnFeaw2w
   MouWpVwrNrtpyPIHuECE7LjJAzd0Wvgq7pbmSn2uBBvsoI8+D6D67BaRG
   H/TLtkF7BPIv5xVbzaJky2AmhArE4uw1lKsQTtWAzruSABogCrNbcqajj
   d6BEEq0s5yq7eOnrO8sGh9YfSGBESeK9TNF8gWvPIhgwOiMdSeGLsr2JH
   mI8taNnfW6m7CKkv3vIIfRpZDyF3xuaBz30I2sTL8jZrpq4IgFyeJYb7M
   l30epLiC0plqZdef+3mBBIb8Gqrdy8WMI1e54MGT/BRrPY6No6A1rX6SY
   Q==;
X-CSE-ConnectionGUID: fntFfp1DSnC0xbr9xq5p5Q==
X-CSE-MsgGUID: P0QeA1HhSxmn5fTqaKQdXg==
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="70709551"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2026 05:27:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 27 Jul 2026 05:27:28 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 27 Jul 2026 05:27:19 -0700
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
Subject: [PATCH v4 04/16] iio: adc: at91-sama5d2_adc: add condition to validate calibration data
Date: Mon, 27 Jul 2026 17:56:21 +0530
Message-ID: <20260727122633.117435-5-varshini.rajendran@microchip.com>
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

Add additional condition to validate the calibration data read from the
NVMEM cell using the TAG of the packet.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 798e4d60bf69..15dc88f4961b 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2297,7 +2297,8 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 		return dev_err_probe(dev, PTR_ERR(buf),
 				     "Failed to read calibration data!\n");
 
-	if (len < layout->min_len * sizeof(*buf)) {
+	if (len < layout->min_len * sizeof(*buf) ||
+	    buf[layout->tag_idx] != AT91_TEMP_CALIB_TAG_ACST) {
 		dev_err(dev, "Invalid calibration data!\n");
 		return -EINVAL;
 	}
-- 
2.34.1

