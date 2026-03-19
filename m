Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05E3D1710
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921564; cv=none; b=kfGe1NNEtXK5Sd75NBOpMkFKEwKw9/hASYGrC8NY9/VS8MjTIC/moJGSDLtx2jVXVBb8b4e0DFjLxEzNKBztvgjOO9xX9PNEBfBSV6ewwVeWcJbhItmw/NEVMEmwGpbHNRLjd7mFYObAhtj9xUrmJlQBekEhX8/gOLEIg4cVUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921564; c=relaxed/simple;
	bh=w5xtoSN57Gl+VyOZOhDTahGIJ0RwHfPPzLNAzvBUd4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ky7IuxRPNdjBsjfiHswA040mhCnqK0m/sczGRY2q1hu4UB7T7DXJAcx+u1EpTevMNLONSJ5vWjZzVRxYik5VSd7Ts8DUngsD0P/SJlKfA1+Jb30UWPUM4obPwbWxsQDICb8zJ7tPC2E+8tu4gjmuIuj1pA/JM9A0RdYufhL85GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zvu8xG6r; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zvu8xG6r"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b93698bb57aso160206766b.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773921556; x=1774526356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0qPqA1xbNhE1Dv/S7BEHSx+8WdubNnnHdrMlRxqcOc=;
        b=Zvu8xG6rcyOuEEd2lpOn5kftwGlhOXPHnSb9o2l+mee9JE4OOS/qZoa76kImD2Fp0G
         kxj2D446KnYb2Sgtow6s5GHVmKzi4ye62m+SaO8t4X2gS2JRl2WyYp2JXLcBAUU4ADxe
         Kutq6A8q8D44EpmqC+Ea5CjE288WYX7q8VOXM7eoUjNVI3xs9/x7FoqxS6hrWgF6lqmH
         Wb6P0Gf+gbsYf5mYU1g8PlI9M2z3cForTawzKAD9fBQ3uD42T8uQGe0w/kTex+NMEhDM
         LCTTfVCo3fNV3/QrGw/nuzo3kpJf0PLc1TA6ZCrW1F27D+cCaiIYrKqNG1I5qXxraPFj
         yGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773921556; x=1774526356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j0qPqA1xbNhE1Dv/S7BEHSx+8WdubNnnHdrMlRxqcOc=;
        b=h6WgHFNigY1xDJFnRx7/s/ZrBGwAjwRY7h0da+Lj1Seat8ehExeVkFouMs+DA6fyfJ
         d0Su006mbm5mcnt4qvlVgPaeihy0QnseIvQ3xb/+psep9fWQZ9yXOJv8lVjKl4htgrqL
         5qalVGrFMeATlMJOs0AefSiZ0xjY4ZFefBHxrtb2WRzUUUxK24LRU9acta5/qx+wYm74
         DcUvhzSHf2nI0JlCqz8cDXhYHr1GUKZBbDsKnt6bI53cBxFW/PAOknPRum+71GUcB6gd
         4+uVjOHtwfnFKLKUZ8pRZn8Um8DdL08A/36KVQAZQsA8+vQ0/39DWIEhJFbNpCnyanEH
         5sBw==
X-Gm-Message-State: AOJu0Yw4kGH0MxmGCX0Ey4kZDDbJKGBrvhY5ELL5gksQ75viXRodm+Db
	bKq0OItuANMx//mZkBDmNUGr/bupAo168emFvGha8IFRdPnJVGO5dZ5C
X-Gm-Gg: ATEYQzyJc+wHwgieoO6EXUYW3mG6fkKXh/zfoc6XJPTnbRNSWEmSy7LV/vjYWdyiDkh
	EfJ6WuwyOoCgpVdro/rivR5d6CDnUo9+39suLExF06Wth4+Y6voNGFFVa/nMhhIA83VxtbVSDW/
	iN507NQ2WnNiGidwlVCxKPUZxmXeGFTteo/5ZgAqvwIleX2mTbqUGN4xNa8mG0fh/Db5MY0yISs
	3rdKc+OiUopOL3MlEdQdNsCEGFold8ulY3v29aaBA1kg9T1zVtx4byGfLls2RcfcqHuHZEDqzPX
	c7HL27iedNhMTnZ5TU0GX5447x2oD+E6jFGCiQNa1pN/gBzKzz+rsCFJugjXiPmWC+nbSduPbMF
	9Ejq99d5cbvEsudOiw8su+KF7Bfub5dRyHsB92JIn1hMJtxgXJ+ZNPBF+sDqkEXD+3wFwfzE/H4
	6OS2ULf/SOgmutgJL5jmAt1i/5Fw==
X-Received: by 2002:a17:906:c102:b0:b96:f4f6:2a02 with SMTP id a640c23a62f3a-b980faad336mr197971066b.25.1773921556389;
        Thu, 19 Mar 2026 04:59:16 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16d3380sm461399166b.42.2026.03.19.04.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 04:59:15 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Thu, 19 Mar 2026 13:58:45 +0200
Subject: [PATCH v5 7/8] iio: light: vcnl4000: remove redundant check for
 proximity-near-level
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-vcnl4000-regulators-v5-7-a025d3332805@gmail.com>
References: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
In-Reply-To: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

The data->near_level variable is already assigned 0 during
devm_kzalloc(), therefore checking if the property is present and then
assigning it 0 is redundant. Remove the check for device tree property
and let it fail silently if it is missing or invalid.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 34b52725aff6..0a4d82679cfe 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2015,9 +2015,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 	dev_dbg(dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
 		data->chip_spec->prod, data->rev);
 
-	if (device_property_read_u32(&client->dev, "proximity-near-level",
-				     &data->near_level))
-		data->near_level = 0;
+	device_property_read_u32(dev, "proximity-near-level", &data->near_level);
 
 	indio_dev->info = data->chip_spec->info;
 	indio_dev->channels = data->chip_spec->channels;

-- 
2.53.0

