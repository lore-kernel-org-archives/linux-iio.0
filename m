Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5333B95B;
	Thu,  5 Mar 2026 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705639; cv=none; b=aL6YxgUUiNyVTTadCgKFEoAecPVpeghWiOW3w3wglGjyXmbRTciNiny4XOgt5vPXEDyg3ttZzOUIBCoWJl06rFclxf99iUFzRBTj/XL6RstVHv6Tm9YTmpYYOtuBuunRnNOilm1Os/ynX1ovxKDS/i2vl70jGRTL1JGcsZkVM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705639; c=relaxed/simple;
	bh=UGIm79EYYPlF8m5xf/G+ht8oyvOVFJ1pvSpqwyBcxaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BF8i/4OwR8lg57UUtu/cFaO16mTp5gGBxLk0tiYfgI/s9aKWlWfJl8EFdiP32vfqdj2aWg+zmBrPEKb2NhMHO106LHn9c6Kwzd/eaVH9tOSaOEpww7CQFBD2vGratIbXhmOHQiuojW4Tl3L5Z7WW2nSQGE+HGqwgOTlyf7i9LGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE2DC19425;
	Thu,  5 Mar 2026 10:13:57 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iio: adc: rzg2l: Convert to FIELD_MODIFY()
Date: Thu,  5 Mar 2026 11:13:55 +0100
Message-ID: <d42ba403c1fb1aca88b82ba3020ad0ec442a455f.1772705608.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the FIELD_MODIFY() helper instead of open-coding the same operation.
This requires splitting the double OR operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iio/adc/rzg2l_adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 1010e0511b3e09c1..dcbe112efa863419 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -401,10 +401,9 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	 */
 	reg = rzg2l_adc_readl(adc, RZG2L_ADM(3));
 	reg &= ~RZG2L_ADM3_ADIL_MASK;
-	reg &= ~RZG2L_ADM3_ADCMP_MASK;
+	FIELD_MODIFY(RZG2L_ADM3_ADCMP_MASK, &reg, hw_params->default_adcmp);
 	reg &= ~hw_params->adsmp_mask;
-	reg |= FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, hw_params->default_adcmp) |
-	       hw_params->default_adsmp[0];
+	reg |= hw_params->default_adsmp[0];
 
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
-- 
2.43.0

