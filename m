Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FAA33C532;
	Thu, 14 May 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775807; cv=none; b=p2eBRdupnUnHf0/mEaWxImjkJaR/SK5+l+tJQR2XRzT/jNqmRhWqzmodcz7HCSjEkXdD/iPNuwoHa2KBCDve5iDn58vyHHdrfzjdYblZc6y+VNbiJxlc02AvuS/qweDGoNIx8fRL8fiBsqoKpdmfLYf9uiJI3ACxpIc70IJ939g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775807; c=relaxed/simple;
	bh=+Bv5eiBvvnBmA0eM3BYxLe5zZe76ZDBqgaGVnQZsA8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObBVWjWXy9sLizACi4f4R6uEQ0op/mJXE1f9qMu8N5pNLJ/sMJWOjiliJsdYENVAuoEsDW78IWKiT7ut4wbdG4toigBSVbwk/LrInx8kzy9oeodwK0SCjACbuHhHgDl2SsofnpbPy65QaZ9l2oqJgoxgfbXYey/WwkcRNuwoBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V4h5wLIy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V4h5wLIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29411C2BCC7;
	Thu, 14 May 2026 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778775807;
	bh=+Bv5eiBvvnBmA0eM3BYxLe5zZe76ZDBqgaGVnQZsA8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4h5wLIybsTaoXf/+XqIKVRWq5D9xMkilAMYkYkS6QW45p8ZqiET12w336T3hOBYJ
	 Ynt+oRpxOOpTOZs54bFFQ0BcHGImHICBxmt5dFZCXhirnigvxtEFMmN6Lafk1Zxsgc
	 YcKgPEGXBXwL6P8spM3a5IAl7/ygm/ZnNeBTYDCk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Sam Daly <sam@samdaly.ie>,
	stable <stable@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] iio: adc: ad7768-1: add bounds check to ad7768_filter_regval_to_type index
Date: Thu, 14 May 2026 18:23:22 +0200
Message-ID: <2026051423-snowcap-excusably-2b68@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051420-strudel-graves-f6cd@gregkh>
References: <2026051420-strudel-graves-f6cd@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=nSZlQUuq3Oo62ys9TbIblpj55BYjV5T7o4FWuL2pjBE=; b=owGbwMvMwCRo6H6F97bub03G02pJDFms334vsUmbtMYrUTOtpuOttrRI8voVa/+kTu/I5DNrl y14I5PVEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABNR72RYsOHD+cuXHyVf+Hdx t0XmhwehvMElSxhmszXqSESK/hJQvaDTn83O2ClS150DAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

From: Sam Daly <sam@samdaly.ie>

ad7768_filter_regval_to_type has 12 elements but the combined mask
AD7768_DIG_FIL_EN_60HZ_REJ | AD7768_DIG_FIL_FIL_MSK spans 4 bits
and can yield values 0-15. If it returns a value >= 12, this causes
an out-of-bounds array access. Add a bounds check and return -EINVAL
if the index is out of range.

Assisted-by: gkh_clanker_2000
Cc: stable <stable@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Sam Daly <sam@samdaly.ie>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7768-1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index e16dede687d3..52e95017d36b 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -897,7 +897,7 @@ static int ad7768_get_filter_type_attr(struct iio_dev *dev,
 {
 	struct ad7768_state *st = iio_priv(dev);
 	int ret;
-	unsigned int mode, mask;
+	unsigned int mode, mask, idx;
 
 	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
 	if (ret)
@@ -905,7 +905,11 @@ static int ad7768_get_filter_type_attr(struct iio_dev *dev,
 
 	mask = AD7768_DIG_FIL_EN_60HZ_REJ | AD7768_DIG_FIL_FIL_MSK;
 	/* From the register value, get the corresponding filter type */
-	return ad7768_filter_regval_to_type[FIELD_GET(mask, mode)];
+	idx = FIELD_GET(mask, mode);
+	if (idx >= ARRAY_SIZE(ad7768_filter_regval_to_type))
+		return -EINVAL;
+
+	return ad7768_filter_regval_to_type[idx];
 }
 
 static int ad7768_update_dec_rate(struct iio_dev *dev, unsigned int dec_rate)
-- 
2.54.0

