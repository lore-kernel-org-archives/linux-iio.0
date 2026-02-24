Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCF3815F1
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938017; cv=none; b=h6eegy95Fq8IOJcPuFrcsuurht2+do46qLr4FcaQ4PXnLOr6etOimyuYe1xgaVRi1F9qf1+mz/kqFiJrAc4ZHZj+7VR9xt97yN4cGu8ixWHzi2V5dL1rLN6bg5l9dyXGMAgT0dryuKwLwIyGDQ0vhYtKNX/bmO6Y0ALo2tY0saU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938017; c=relaxed/simple;
	bh=7Ys4FXvi01Ea2XxfJeiKX2dYc8D6A8bPNLQKQIdCg0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S93YJezTq+z41P5CHdaxj8desghW/S7BFitf2x6mIUfp9JqPuU5v4ELo4fWAL/PaNR1XSqL8YytNdwxfgjw7+7ffY4ijh3+qEZawu0JCGDtJ/QugBqnV3spiL64Uqw4RnqwPNyrj4yEuYZCvdPMQMNPTOpelr5CuCxzIQM57MMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHKysuV2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHKysuV2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4830b67aa6bso7045025e9.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 05:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771938015; x=1772542815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RhyOSb/k1oWFNL1d6iCG3EyJQZrMDrdOW4mt/1Xj5Ws=;
        b=YHKysuV20O7gXLJsrRYI8qLozORU4y1hTDnjC0eUZOKveN9hQ13Bl3qm84gyneWG5P
         t5t3R2VttfrLGbX2HOCI2QMCmReIPTX9XoZk0QOiiLx3+3kHSaTYS5fMpvPTPrdr2FQK
         Lco6ek+e34jHKzChA9jPVQKwk6cv9E29dbY7uLQHykBbiJ3iqetyskr3M3PZj++SBX3O
         rd/BDXQPjplnGLOiHcMxkHI5cE9x/jt0lE78q+faM/E7nbv7MtMo+kVNgTqGYLawkRN0
         FO6IttFctPW1Ogmo6z2lDjPszvPzdZ2p1DWlndOBiNxr1O3cOFlw7SWi0rUFDRUMzgq/
         RmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771938015; x=1772542815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhyOSb/k1oWFNL1d6iCG3EyJQZrMDrdOW4mt/1Xj5Ws=;
        b=wTQyJtNBcDb0YPKMZ4dTa0kWVlkwVLguERJoZylBox9JTpb9R2Sc38OlLohoT2YAgr
         eFgrV9R70LfpjXe7t9INQ4OyhWowYmCxvtdVfToRFTrbVajX+vQKyzTZnAMarFkFaAiF
         1MVBVMnd1zb271YwYhG60I/OFpprD+AU/gaaGFjU1eZrv/+iDxhYgswY1ivbSO+kapVB
         vsf8Zq1D4ZPXUiVEJ77Kax2+XtD67mGFw+bjBzrWla2RfvL7uw4oQWsH/RbruSM/DQc0
         IMkNiJkam45a5HSNvxQa4E/CKHS5/LUgkizpyzXFL4/7jo9nYj2ougO7wLxNZbBOrSuB
         YkCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2UFxn8GCKFbehN9yi5nt2RGDvEGotlOFK0p+X/7zV7niA/JZDyjTc9cCn0tw81lsrEtTHB/agA3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYB8GxtZfGBkDl8xekghPOuKiw0nn8n8dsGtA+2qaO/Kuq4wT9
	caSYJ+9OLvL58bFGuL/DCysmzrl3Ko3CQ5prIH0pOOeDtZogF80indUH
X-Gm-Gg: AZuq6aIjU20vrSLU9uj8SfK796XnxZK4eYnrY7Q6m0j1/GBDHvuKvLyvtdcigoIZPLz
	xTpAydt/m26XuzgnWnsLgJZIWRPVFz8hMs5bXblUeP0eJPk3eKsfilr5G6yY8ErvouzGeW6CFSN
	WApSjt2ore/Hulj/IWIOqb3+8MoB7L5WuLGCH78hEW+4xDWb5HdU7KAtuYYSkqB9k7qvPBBjqYM
	Yc95/kRtbfJWGBuq7O7O/VZfAyBwx15qd2NfxGpLlE6bZfWTEZSKhogiPZdlz/R0vI7uYsDw/Ul
	UurhvyrFzGLY4MBNSlnH+uHGL2w83mBXftU+T33wEUccJ5dKyU5RimOxR8VW5VBoB+9PUL1KmqW
	Hkt5toYGTgRblnQRFgrOAghRCa87A+pD1wdnEVP6TwdFeyNTM+G80spA+nGpxhX5paAGZdbAfX4
	bnqCiFtzliIhmryA3cUIkSxMNk0WpJ+osoPO4ZPdW5d4iLq/cBp5pTTxpZQX7JijY6hhQ0D5Vp6
	DT4d5KXQuNSDDOjXPET8ab9xzQlCm3SXVP8uQOLmCD6K3K1k/2Q
X-Received: by 2002:a05:600c:4f0c:b0:477:7b16:5f97 with SMTP id 5b1f17b1804b1-483a95573c7mr132415305e9.0.1771938014791;
        Tue, 24 Feb 2026 05:00:14 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9b668f3sm276182145e9.3.2026.02.24.05.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:00:14 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: ade9000: fix wrong return type in streaming push
Date: Tue, 24 Feb 2026 16:59:22 +0400
Message-ID: <20260224125921.70946-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The else branch of ade9000_iio_push_streaming() incorrectly returns
IRQ_HANDLED on regmap_write failure. This function returns int (0 on
success, negative errno on failure), so IRQ_HANDLED (1) would be
misinterpreted as a non-error by callers.

Return ret instead, consistent with every other error path in the
function. Also add the missing newline in the error message.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ade9000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 5dcc26a08970..07e84c6257d4 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -786,8 +786,8 @@ static int ade9000_iio_push_streaming(struct iio_dev *indio_dev)
 		ret = regmap_write(st->regmap, ADE9000_REG_WFB_PG_IRQEN,
 				   ADE9000_MIDDLE_PAGE_BIT);
 		if (ret) {
-			dev_err_ratelimited(dev, "IRQ0 WFB write fail");
-			return IRQ_HANDLED;
+			dev_err_ratelimited(dev, "IRQ0 WFB write fail\n");
+			return ret;
 		}
 
 		ade9000_configure_scan(indio_dev, ADE9000_REG_WF_BUFF);
-- 
2.52.0

