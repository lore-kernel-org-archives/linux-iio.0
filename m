Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F23C061D
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308728; cv=none; b=dy+Eklnj1XfrJ1fronAIJEEVLQayr/k8sUt0n3HQSG/GpaKmdptnXkHidJvBu0d6fslMW9xNb2l1gLRMLm0WCcsOYHJYil8pUBmROOBLsKSc9cOJtFjxbWjkaH3DpDkxDLlAZu3NMNCKpFyEyUIuzzO0EAh84xOSJ5LyVyPCZZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308728; c=relaxed/simple;
	bh=DkOQpD4lRejOxmK9oIvR5xMEtCH7MLNHROWYAAlBnnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHtsSY6CthQpt8lIWH8KK7lK6eEgiBp6uAMOvMR+i/EbuuI09ATB/bAc5uvbesHQi0WeaDGM98yNGAt33TyDzVM61ZRrPDMHUwFKcLX+XdtvL/XwSmTZe8qC35mFTHk9aFW/aJy4znG4SQ4buIfFda1zbxm2OPQ8ioDT3ZMQCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeZMPxGg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeZMPxGg"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so130023915e9.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777308725; x=1777913525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o3ZI0LJNGOCBI20WP1P2qZ+bTqh4ah0JmxhMCroQ3y8=;
        b=CeZMPxGg7ozGx0sT+Da9d+K/KeBdczvEeUoP1G+GkWXNlsdk+N+R94+x/DHsXBNnoq
         1aRs9UzzloIzXeUYfuilKt3+06Cb104QqlJQM3AvEXX9tC7c/1R0f1YRSjqYCJPPYkfr
         faosJiVIOS2lJeTOFHIyCmSdTn1eBFKpiP10B6LfcRuWq33Vp14YSYIi6WXz3urPTXmt
         2Smqirody8uQ4Fc4hJMo80PZpQO4kZDABI/+85MpZo6Y53UCt3F88PPH9vvLHoREaTyr
         hqVyMp+Gh4eZm7gouh0NXFb8m2PbmGbBheNNqLjKFXpNlHMN2uJ6amIh+iKGu9TKahJG
         Lgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777308725; x=1777913525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3ZI0LJNGOCBI20WP1P2qZ+bTqh4ah0JmxhMCroQ3y8=;
        b=k4XAXdQ+aW3MdLmIbtR6fgUzZOq80gafmvdrI2GIztQ2eMcNkqTni0c6LRcaHNnfyi
         GJkFE/2xhfvXzNSIpolp5I30ED6zIE+3ETU8CuwyECH4ppFNExIHfCaXcNvWGJj2ZR86
         vvSDDTlSvdjGHybFUCW1nD9dfxBtei6/yOkARXenLUCkWYfEd/V1qb2/G9yQOKDhXV+e
         dB56DvVUTuoCLrSXP4rpXvnkwa9gdx7CX7yI95OpM8OkSc28yqmX5dTCXhKclldFol05
         XtxWPK7npjP52Lm0IyYFuu6SJMXxJuL/L2/cStcWEYD3xZr2N+/3FX1NaOyEQ7cAbUVw
         M3QQ==
X-Gm-Message-State: AOJu0YzAlYGHfffi9BfkTO0nuaHJbjQqHIVWLHY8nJ8cpaWDLR8/UuIO
	roxis0eaAjYL3pvJiJHEVcroNLLGRO90IyfETLVx3+glMa4yNoyuY6+E
X-Gm-Gg: AeBDiesNQsotH0Z4PxiPxUP8Ncih7wGprk9nBpkNPr3UXPIrn0v91Ple4hDnxjd7mRq
	kR7xGMs4sP8ovnmfkY0wLjUYk941SOoHWgwi1iFEpxVW79y4VsERzKsyM0EFlWZUaGGCgd80SSm
	bkvTG1owSVpcJ4+Y8FbS485Dkh+LQLEwGj0YTxLJpzraZqA5OZ69LZWPraD7afqyILdcCUPPBGn
	eugCEUVMoYJMwacwojd8O4lFK4IYWksrzSZMISdnjh+jmvsbcsJmNTHjzPTJrrCDoVRifTfv4vL
	D0eBCevY/X0+yJcJb4n+NXpCcEaXBJ3n7c+DCLYqPgTtcIg/fwt+qXNqcxkZ8TIzNLJw+sXEcas
	kDqdUuVRZYggj5njUvq/mn/kWxeVdNLu31OPBYE1MD2tplpTt/wpWLTZPXSHvXppX26owXc6/BO
	0JwfdOVCEQl/yT3lhXAML8FHDZ7/7FK83N3XhuTCR+HsDZbHK/
X-Received: by 2002:a05:600c:6216:b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-48a76f53addmr2241825e9.9.1777308724693;
        Mon, 27 Apr 2026 09:52:04 -0700 (PDT)
Received: from localhost.localdomain ([196.235.239.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773aeb6dsm1483495e9.5.2026.04.27.09.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:52:03 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: adc: mt6359: fix unchecked return value in mt6358_read_imp
Date: Mon, 27 Apr 2026 17:51:51 +0100
Message-ID: <20260427165152.5583-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mt6358_read_imp(), the return value of regmap_read() is currently
ignored. This is problematic because if the bus read fails the variable
val_v remains uninitialized.

The function subsequently assigns this uninitialized stack value to
*vbat, leading to incorrect measurement results being reported to
the IIO subsystem without any error indication.

Update the function to check the return value of regmap_read(). Ensure
that mt6358_stop_imp_conv() is still called to clean up the hardware
state before returning the error code.

Fixes: 3587914bf61 ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2:
- Added Fixes tag.
- Re-examined the entire driver for unchecked regmap operations.
  While several regmap_write() and regmap_set_bits() calls also ignore
  return values, I focused on this specific regmap_read() in 
  mt6358_read_imp() because it leads to an uninitialized variable usage
  (val_v). This makes this fix critical for reporting correct data 
  to userspace.

 drivers/iio/adc/mt6359-auxadc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 6b9ed9b1fde2..f927bff4a26a 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -497,10 +497,13 @@ static int mt6358_read_imp(struct mt6359_auxadc *adc_dev,
 		return ret;
 
 	/* Read the params before stopping */
-	regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);
+	ret = regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);
 
 	mt6358_stop_imp_conv(adc_dev);
 
+	if (ret)
+		return ret;
+
 	if (vbat)
 		*vbat = val_v;
 	if (ibat)
-- 
2.43.0

