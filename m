Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08FF306480
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537006; cv=none; b=bI3UpU7fgX+8Uf99OJuQdewRzT41MtIGi8umRA4l6RtLC50yzS/1N6Xx/LvbC1rFdxHUhboemssOPx+bKPscynRSOkUmwzJ/vggQyKAS3MokBmaxv5DUrrqysFsKdW+CeQJ+9o3hZl/5NzCWUVhYP5DjbieIThJL4EI0fTgoROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537006; c=relaxed/simple;
	bh=i42XsvsRKtXY5Ms1pYkF7Kk9twF4AYiXPGCpkIeUt4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNOg+v7vdzDcJVP4AAicFtZHhKBa744RAAHhg6juS8Jf5Ot2f5k0VO7E/l2qMEdvBqixaqtSkslC+IClkKfXJB/jXjwhtY1QbRHlMBBQCNmDoDdwT7lLjZcdWf6BtjnwSPLKWn7iBkieqCvDFoHXiPw+1gwfvM+X2ltPTOKajHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWYBKumB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWYBKumB"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70378ddaafso792170a12.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 13:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771537004; x=1772141804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrKO3/k5oDaHRjx6Mg3pvGaxTLwHymALHGO1vCKBisg=;
        b=QWYBKumBxi0WeK0svfl7Ad02tJTBFt+Zo9of2LKliRyX3+K6FRiC877lGqS23VjNRD
         il19OolD21uvf9giNeGUSFqF2R2w9bqAWjc+N2lMREgs+YuoJySkeUvyyI4b74y50q2v
         slZ6Bg2tqLJf2I6R9lFjQ+Qdehn1o6LMbfzkXVUP2LMFf066hBtNo0ujNxQR4r1v2Bxs
         xBihaWQ5ozccJZ3XvamUitLGyd3jw4DcOyTLf7Zxgm6PrcPbst/l/uN1lkvmf/6Z82Pk
         T/nSl0TW1TzfQhJwiYjc8S8WMrhzki5KNhtO0il3vnFM8mplQ51+uEWWvBFwnEq0nGYh
         gBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771537004; x=1772141804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VrKO3/k5oDaHRjx6Mg3pvGaxTLwHymALHGO1vCKBisg=;
        b=aGfSA9CHToh9D273osIfYJtGCO/2rOzsHtR53qYQlLUtQ9QNA4R6CAQpnMmo2Cx1Yr
         +gSlUXDrQIEwyIGdiPzZ7loIf0TmGcAfjS/J24OaDhgTjpoZvq7ET9wdV7BbeCFv+Cja
         +F6+bigOV1v3y4zmU5UEij3AXY/NjL7SLtlTD+4gfghW6101q3CUi3C3fXgaqO7dnFKu
         hSm33kAnHwFmZBHjSIB+8WzFmCxpr39aSYAslLvO08CXhFNPJDvSGydTMc/j4CDwzfIg
         X+CiogXW1sPiSYqMKpTpTjWFiTC3kod20ZL9NYCNDFFYT9QU7mKke16r7FLOjuI34/n3
         i7xg==
X-Forwarded-Encrypted: i=1; AJvYcCUVq0mpxR5XYmNt0R0zszT7KXiAO/pDL52hE8YboJT97mCaJqkx9R8o9vu5zLs+wPFuQGas40gFTxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3jPABgTDFt8oqMDg7rpMHC6YhFuT4VInmssJgvuvmuYt/htkD
	ASmfGmaL5ano4MwxiD6RQlm+wEeVbmyOfPh5HLLu1RGLtb1GoBuoToVw
X-Gm-Gg: AZuq6aLMxXIo38zbDZqiZIOtTJkDlDFCElhVqo+oeTHr0bvfnDdFxZZGKyVvPfYd2vr
	4i8EmjZuAYc8NjoLFTkBKvbPSzELbqWD5nxp1PH+UdNyZx6kHETPSMyf49cDYgjUyruy3W4fTWT
	LTVXtHZEyQEMgASqRZMMUMafSfPzC5uITMa+w3a+EjMxtYGx/EAgQo3zEEvgjkAgVZ6Z3xJgAIm
	of/af5L00ArG2q0+7DUq3JKwfzkD1MbTcTYUD9kVAT3H+YAFbcRCO9AIS2x493liLFIcehi03vV
	O6IvmHRhe7/otNLakBDlvCBx7SF3zaRZdH8lDOcesohEilqLan4gahd596q9Z5mTxXs9hzTV4kS
	yTAua6D4KNxfsl688RtxM3BIv0SShcUm+jcHd/fnDf1RQzbRNjtqUQCEqmwpaYv4SjCGOxA0JMS
	5V4WFw6NEVsdkOn1Hs+KM/+r43UHF+95pXCAg=
X-Received: by 2002:a17:903:3bad:b0:2a7:9592:210a with SMTP id d9443c01a7336-2ad175019cfmr167804435ad.33.1771537004295;
        Thu, 19 Feb 2026 13:36:44 -0800 (PST)
Received: from arch ([2409:40c2:5415:8e16:49a5:aac1:3b74:3ed7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a7145cbsm238938475ad.30.2026.02.19.13.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:36:44 -0800 (PST)
From: bhargav <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 2/3] iio: frequency: ad9523: avoid multiple line dereferences for pdata
Date: Fri, 20 Feb 2026 03:05:48 +0530
Message-ID: <20260219213549.59645-3-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219213549.59645-1-rougueprince47@gmail.com>
References: <aZd2jAVnTIuz2o7h@smile.fi.intel.com>
 <20260219213549.59645-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platform data pointer dereferences for pll1_charge_pump_current_nA
and pll2_charge_pump_current_nA were split across multiple lines.
Bring the dereference chains onto a single line.

This resolves the following checkpatch.pl warnings:
WARNING: Avoid multiple line dereference - prefer 'pdata->pll1_charge_pump_current_nA'
WARNING: Avoid multiple line dereference - prefer 'pdata->pll2_charge_pump_current_nA'

Signed-off-by: bhargav <rougueprince47@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/frequency/ad9523.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 5725ab62e0fd..6daa2ea354a8 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -797,8 +797,7 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	ret = ad9523_write(indio_dev, AD9523_PLL1_CHARGE_PUMP_CTRL,
-		AD9523_PLL1_CHARGE_PUMP_CURRENT_nA(pdata->
-			pll1_charge_pump_current_nA) |
+		AD9523_PLL1_CHARGE_PUMP_CURRENT_nA(pdata->pll1_charge_pump_current_nA) |
 		AD9523_PLL1_CHARGE_PUMP_MODE_NORMAL |
 		AD9523_PLL1_BACKLASH_PW_MIN);
 	if (ret < 0)
@@ -842,8 +841,7 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 	 */
 
 	ret = ad9523_write(indio_dev, AD9523_PLL2_CHARGE_PUMP,
-		AD9523_PLL2_CHARGE_PUMP_CURRENT_nA(pdata->
-			pll2_charge_pump_current_nA));
+		AD9523_PLL2_CHARGE_PUMP_CURRENT_nA(pdata->pll2_charge_pump_current_nA));
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0

