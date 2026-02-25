Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272933D3D0F
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030947; cv=none; b=WVNFQjdFLPqZbb+hUPXONeA7uRMjZWpagoN4JhX5rTOL8Qm2m5SGYMMRi5pEMNLT2xz4bxwJs+Ro7eIO6QUc8OrLM5/9JPd9GIYusZjndIWzSLGycxNjY7BZBQ8ghhF4rJgc42cNKpylopM58moTJDjEwabYGmGfvAKxJr7HUxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030947; c=relaxed/simple;
	bh=y75xazQSpSSksYn9QYcuRHGrtuGmpnatk6i9r44nA/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IvcVs5+NyHeKUJOTu4tWyty2zV9ldlYEkdd7vmvIx8ZiaQCQFfUt0Z30c4zQ/FniU8GUM1hOqCVywH1ywUgHFLLWFbroLUi2WT8uZZ7dJcBIR2MTRbv0z+H6vTFciCKyhBR3qfGhFo5eDeaVAgKwTR5CIX2vHWDW42q5OwG3sqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3gNcfVG; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3gNcfVG"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c6de0364915so4139476a12.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 06:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772030943; x=1772635743; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGCZKVS6wkPqnmAwoV6u7sPkAZjbMERA2jaYnvNC/3U=;
        b=O3gNcfVGbTNzeGsTnmWIYWxP3F1S90JV3BaBK08K9qmF52allswIZ6oeI27sPi2CxD
         o0iIKeWUm6wsudyqLUu4v40Ei6OazDubzyelvCjhiCaLK/pMRjQgyBQ4jhfnaYFuCBMI
         OuD/3dIDPV3vSVSDGxwbNSp1CO19ibGsd5LBZE3UC2uVhQ53MVwqKhiW1ihkOAX0D9uh
         pQuJfocgckwwyWuG9NqgtJebS1pegBtCV/oLn0BtaoMqGVAINrxxUnLw/bGYPPEWxe5T
         29BxRvwrSFwGLDKaW7XNckOQGSX8GfQbicoz3PzlpnbHHr0nRAXMssYlAQ8fjhpgio6t
         BhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772030943; x=1772635743;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGCZKVS6wkPqnmAwoV6u7sPkAZjbMERA2jaYnvNC/3U=;
        b=tZjXr7AOjPPWeZ77kuz7+A2KKSOH/uX2Qal+KhV2cCdXPNxr12Jq5NRej3O79+MWXt
         zgS23rEXrUIfD7wTfw0fb4kKqqxTDMh2mVBbrHcwvy+6YkKQM/VMGmWb97C5uKodZuG7
         +Eob6jZ27b/2oc4ed2UzEz902bs2RBu5xTIjW3V46aQI2eFNYgAxt3WdGsydh64S3qor
         5WNz6JT6ofbJUN1slH6r5UIjNdT5DkgXrkdMGFL/iUQWDPOCkCJZBI70vJn8AyW+iMKP
         80kdOgfGn/XBCrPIUwmR0KHNTnVJ5jOGJZOIjS/QWUsMaKnGoEItNBjSSjdlUnFreWju
         XNjw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Bd4oDkUJUNAHCjzfYSqa3PaUKBuYfo9dPcST1yyHqP9NhkwxzaXNE4GS6Th0a788KcsyijVFsdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFfsEYzgQ6ThlzKanraWc9t1DnYnKX/sSAFX3u898EsrcO9z7
	UjjT5UYrdO0pv68eeiun66BtIWsiIHvNry3r95T08NwELk4MHsVpSacYahXzxUPxNdg=
X-Gm-Gg: ATEYQzyvEaxi0JstLbQtDB026m9itck65kcyhn0I8jRs2hRJdzQZFbiImeGHRr9CN/y
	WUahO9mKjJZDhvvTcwKbfDpy/RZlhs2X+l3odOfY55EzBgSe6puEERcNfEYP+d6IL+T04XeXw5G
	Mx4dvXtaxFTniAygfK2YH1j6dt/IArf9Y7j2PU/SpNGxtZcNcSiR2yzbFxw8bIOgKQwB9bm0O6e
	84Fj5of+vcM5ccZ/YIefr5l+jUtf1LK6tzDdiEeEa5a2sKSGG52LL/aHy4Q2+54PUhtkTL0S/aw
	55aEAQvE1sKg3tTFVKOXdCNxaVyo9TqpPaXRkulPf4grk6W1zXLRXkPpc7oJPU0T1h+jDjlq+yk
	z2eiRIxp+xlqfLZ6cDAxfrIb9SwwOLpUpJy/OToElv/8MLOIYDyCpTPKfUNTj/HlV1V0TaZXmEd
	J3G/1MWtTo+KjMwPKQ4y9i38MtneZxeDqtWJhD
X-Received: by 2002:a17:902:f68a:b0:2a9:2942:e15d with SMTP id d9443c01a7336-2ad743e2f1fmr159206845ad.5.1772030942982;
        Wed, 25 Feb 2026 06:49:02 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:55d9:d867:54ea:d951])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd692a54sm14438355b3a.21.2026.02.25.06.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 06:49:02 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 25 Feb 2026 22:48:57 +0800
Subject: [PATCH v2] iio: dac: mcp47feb02: Fix mutex used before
 initialization
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260225-mcp47feb02-v2-1-4792dc3942d9@gmail.com>
X-B4-Tracking: v=1; b=H4sIANgLn2kC/23MQQ7CIBCF4as0sxYDiLa68h6miw4M7SS2NGCIp
 uHuYtcu/5e8b4NEkSnBrdkgUubEYamhDw3YaVhGEuxqg5b6IrU+idmupvWEUguSSE61pK4dQj2
 skTy/d+zR1544vUL87HZWv/Uvk5VQwijfSXSIaM73cR74ebRhhr6U8gWK6i3ypAAAAA==
X-Change-ID: 20260223-mcp47feb02-e0bed17e198b
To: Ariana Lazar <ariana.lazar@microchip.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772030939; l=1261;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=y75xazQSpSSksYn9QYcuRHGrtuGmpnatk6i9r44nA/I=;
 b=aYnQbCZO7YV825Ix6ADfbBTnqLhwMhXrii+LV87JbAJ7ZGSYDi2WW53CfbTqN/19/RjDInSJZ
 yGb7n//tGPwC4h8PGWil8Nb2Lx939yrlTSQYT3BRDoD78QA/ML0qVLq
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The mcp47feb02_parse_fw() function uses data->lock, but the mutex was
initialized after this function in probe path.

Since mcp47feb02_parse_fw() is only called from probe(), remove the lock.

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Remove the lock in mcp47feb02_parse_fw() suggested by Nuno Sá.
- Link to v1: https://lore.kernel.org/r/20260223-mcp47feb02-v1-1-41f80bdbbb45@gmail.com
---
 drivers/iio/dac/mcp47feb02.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index b218f0c3a0bd..08fb85359697 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -955,8 +955,6 @@ static int mcp47feb02_parse_fw(struct iio_dev *indio_dev,
 	u32 num_channels;
 	u8 chan_idx = 0;
 
-	guard(mutex)(&data->lock);
-
 	num_channels = device_get_child_node_count(dev);
 	if (num_channels > chip_features->phys_channels)
 		return dev_err_probe(dev, -EINVAL, "More channels than the chip supports\n");

---
base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
change-id: 20260223-mcp47feb02-e0bed17e198b

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

