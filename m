Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809AB3E9289
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173164; cv=none; b=filQxcF/SzpF8DjuxJzUYW/FZCHXlKss6B/I5cYbaXsCIezfGLb7Q600lQyWyDOs7asxpHXgGonUehFE486TLxpsI4CWYPE0T/9BISyIrk/lu8k7LVe/SZadfT5QZ+1AolHsnD5WrES9XBnTVaZxg0gQ4c/WYf6CwXlOKi2Qkek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173164; c=relaxed/simple;
	bh=NmQadLrlb35menLfcI7cw9Gbg/x58iEO/f6P/uOoiYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sOkS1ffgzeXmlNs1D2/wr9TV4z76lxPIL8GDObAgokQ1Dhgh03naRRSpABmNXv3np/MFKHthq/nl2jychswkm8YnHzyoV1t2Kp5LUP/2CTDlLLaOtDUi5VKm+sAVM+7h3WGM8HZ8XZe/GMWsrxCz+qGqdr8RxsILA1hRQpcyoQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz4rKh7k; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz4rKh7k"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-829a27414a3so2639592b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173163; x=1773777963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN04QOyvuNYqHR2KOr7qmaUFc0qRULIxaBq4auralkg=;
        b=bz4rKh7kOmROroDv4hrLhYXzb9o24Nd6ogZujfa4PDym+LphfHArTmjT2GvZPtzbOE
         fLR2AexW+e20/zfKgRcCGMAmlwGbs2srBzzMM3m8/bMooa4cjeOpIgiYWaSC29KjzRph
         iaC44eP6S5H0RPLT8JjwIeS4t65p0NYIZ/0u0eBGvhGY+ZWvO7WCH4AXXbngJEVn/Oyi
         pPh0gyDvpPmidF8iy7p3n8PghQvYY5wenGUt8DGPmRxyXOBu24sfnep4B3kbai+hmOQT
         jx6qEbgCr3FOdfdxtkexCi2DpeJDpWDVITy3jFUuMiBCTdrmrQ44CkTRoXAAkoamwgod
         qKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173163; x=1773777963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zN04QOyvuNYqHR2KOr7qmaUFc0qRULIxaBq4auralkg=;
        b=BYe/kOnPLunS3bEgltfodFCdH69mO8NZ5NtcwCYLpj75GhiQ9vWD0rEgL/y6fj2yZc
         AHxTRPuBANPbXoy0c/r3V1s5ZJTE9rVJHeaVuLEL2L6JMI8rX9cp+kiu+9PgfVut8HLg
         DCOsHdemewlZc+DEM4WMeCF8udk29+xY6Tn8SwVOx31yvrTI+4/woE4DJSXWKM5ohRsP
         vLHZTgwuC07akmLflivbXC6entEhS0mIVFtRPgAF9jnoLGzprPVUyuRM5Bq+KOQIzfGs
         spSCkdv+NNJ5YK7SseZWtlHjYYtuSxO/YJvjpzaT8qMERhId/cNXtzPZdfC8cJKcCdSR
         uDkA==
X-Forwarded-Encrypted: i=1; AJvYcCWkTRFG6nkNPDKOdNmt+cQAzxho0eyCw0boOQuPVp4QvgRpuWCtSasbz+ENnNRTEGau/pnR2exFEPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ86KCsPRq4xIe0bqwBUp6wj2IVg33YmwxwX9O2fBYij3+5cVX
	sSnJh6m7NcdxxhVb1PmdUHZ+4ofDrRYY6CEr2PTA/mGpSWmlmA2A2wxO
X-Gm-Gg: ATEYQzz0QUawA68m4ICftwuKbOhT7PWTDlnoqACfzw9sZJ6PnWQfg7zqzFUUuzP1cc5
	adWkizZsQWITJQRLiUBrycfwqoKOvIAY8uVdx3kzBmWycf6kp7rV3acc2k2ZOvN4P3UxfbSg0pb
	r9OI9yZEgB6c5o6lT8XOWnKSlT9bzVqZOFLIsbx/hi7EQpEuKaQffe1+LY3Fipi4yaOe3dZUeUd
	tRileqMtxPZZoYCpqlkuaKW1mDx9zS6jtvBgpyphPgybZlRGtuIeVnYVtbDaTvQjTP167TgYzOR
	q0NOWHZKHrgAPZCkgDLeolFof2WLvIh+uHgBC3fNQcBupbzCDnmg3rYAOeUC0++EpAq68lsagkY
	GD1kTU1W+Ntq1ihLZbpn+TnxH4Gm9HWdbN/SGYbslOO1LIefAdru4AnetelJ0rFEOA3LJwjlddU
	nuK4EMqMgziGS3ed3Uv1QynjLF9QWoB2ff27IgaQnWO+9KeQ7g
X-Received: by 2002:a05:6a00:3696:b0:81f:4a06:6f5 with SMTP id d2e1a72fcca58-829f6e71c7bmr133338b3a.4.1773173162881;
        Tue, 10 Mar 2026 13:06:02 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm101660b3a.13.2026.03.10.13.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:06:02 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	m.tretter@pengutronix.de,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	yunfei.dong@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org,
	pure.logic@nexus-software.ie
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	kernel@pengutronix.de,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	marcelo.schmitt1@gmail.com,
	maudspierings@gocontroll.com,
	hverkuil+cisco@kernel.org,
	ribalda@chromium.org,
	straube.linux@gmail.com,
	dan.carpenter@linaro.org,
	lukagejak5@gmail.com,
	ethantidmore06@gmail.com,
	samasth.norway.ananda@oracle.com,
	karanja99erick@gmail.com,
	s9430939@naver.com,
	tglx@kernel.org,
	mingo@kernel.org,
	sun.jian.kdev@gmail.com,
	weibu@redadmin.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	sanjayembeddedse@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH 3/7] iio: st_sensors: simplify cleanup using __free
Date: Wed, 11 Mar 2026 01:35:09 +0530
Message-Id: <20260310200513.2162018-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310200513.2162018-1-sanjayembedded@gmail.com>
References: <20260310200513.2162018-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace manual cleanup logic with __free attribute from cleanup.h. This
removes explicit kfree() calls and simplifies the error handling paths.

No functional change intended for kmalloc().

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index dac593be5695..f641b62e692b 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -501,14 +501,14 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 
 	byte_for_channel = DIV_ROUND_UP(ch->scan_type.realbits +
 					ch->scan_type.shift, 8);
-	outdata = kmalloc(byte_for_channel, GFP_DMA | GFP_KERNEL);
+	u8 *outdata __free(kfree) = kmalloc(byte_for_channel, GFP_DMA | GFP_KERNEL);
 	if (!outdata)
 		return -ENOMEM;
 
 	err = regmap_bulk_read(sdata->regmap, ch->address,
 			       outdata, byte_for_channel);
 	if (err < 0)
-		goto st_sensors_free_memory;
+		return err;
 
 	if (byte_for_channel == 1)
 		*data = (s8)*outdata;
@@ -517,9 +517,6 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	else if (byte_for_channel == 3)
 		*data = (s32)sign_extend32(get_unaligned_le24(outdata), 23);
 
-st_sensors_free_memory:
-	kfree(outdata);
-
 	return err;
 }
 
-- 
2.34.1

