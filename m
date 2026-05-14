Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B0533A03F;
	Thu, 14 May 2026 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775802; cv=none; b=a+drWFp69DdtjM4Ss909QlWd9H+1UNmZloT7pJF43w86tQ6vuFmqbAe1U+4pIvAvsHhh8+xBNhidpxYbVcSNjWEhOQJO+Y9xHNW5Aj4XBk7SaPM9y6IWYRpLaccwBFKJjCrtUs41WGbp3hSWyiwM5twCTTpxefbjzp5dnVioXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775802; c=relaxed/simple;
	bh=fdnm46skJ/bLOPT0IzNZRQ0pAgbYG18LOkRO/M/4QnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NxZhHFXO6J1E7EebzRXcublwPv+akBCph2so7PXwwR9C0REOQDFA7hlLBaOzD2eQJ8x77sORidzSpwsYLFJ49HrJsrFHXer+J8YEvnC1a4qIQYtKSajOViXokVpBJFvfq7FUMwFvLkoThaRg4qQuxnDktiPluX7vBBEOpRPKd3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YaXTz+/g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YaXTz+/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F96C2BCC9;
	Thu, 14 May 2026 16:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778775802;
	bh=fdnm46skJ/bLOPT0IzNZRQ0pAgbYG18LOkRO/M/4QnQ=;
	h=From:To:Cc:Subject:Date:From;
	b=YaXTz+/gThlS0MeiRvKgZCutKVHw4CPNlFrncRMHDkZq5KP6UPkFeCiP5A8aE/gJL
	 26yciSKp6CQhq03MfANekdQm1qbSRJoht8UV/adsZ4YZnZcgULCQgjptA/EHQxucts
	 2yXnujILav4NeCm4F7Fj82AseyC8V+99ijbvWPhw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Sam Daly <sam@samdaly.ie>,
	stable <stable@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] iio: adc: ti-ads1298: add bounds check to pga_settings index
Date: Thu, 14 May 2026 18:23:20 +0200
Message-ID: <2026051420-strudel-graves-f6cd@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=vkHi19utPe+z9Orvdw+/poCKsew8uBTN7j3ETotaSzc=; b=owGbwMvMwCRo6H6F97bub03G02pJDFms337Ifnik+7TOqPrFv/mvLn3pzOHY0x4Yeyhzs/HRr 6KpV8oXdsSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEqn0Z5lm71zH6Z7+IS9g2 MTVz78QbSWsXiTLMd4tneMhwPvFT1Q3DavnNl8qiFC74AwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

From: Sam Daly <sam@samdaly.ie>

ads1298_pga_settings has 7 elements but ADS1298_MASK_CH_PGA can yield
values 0-7. If it yields a value >= 7, this causes an out-of-bounds
array access. Add a bounds check and return -EINVAL if the index
is out of range.

Assisted-by: gkh_clanker_2000
Cc: stable <stable@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Sam Daly <sam@samdaly.ie>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ti-ads1298.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index ae30b47e4514..731792f06993 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -279,6 +279,7 @@ static const u8 ads1298_pga_settings[] = { 6, 1, 2, 3, 4, 8, 12 };
 static int ads1298_get_scale(struct ads1298_private *priv,
 			     int channel, int *val, int *val2)
 {
+	unsigned int pga_idx;
 	int ret;
 	unsigned int regval;
 	u8 gain;
@@ -302,7 +303,11 @@ static int ads1298_get_scale(struct ads1298_private *priv,
 	if (ret)
 		return ret;
 
-	gain = ads1298_pga_settings[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];
+	pga_idx = FIELD_GET(ADS1298_MASK_CH_PGA, regval);
+	if (pga_idx >= ARRAY_SIZE(ads1298_pga_settings))
+		return -EINVAL;
+
+	gain = ads1298_pga_settings[pga_idx];
 	*val /= gain; /* Full scale is VREF / gain */
 
 	*val2 = ADS1298_BITS_PER_SAMPLE - 1; /* Signed, hence the -1 */
-- 
2.54.0

