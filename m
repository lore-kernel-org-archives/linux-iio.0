Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E441DFF0
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773576993; cv=none; b=RsxrZRSUUmkMSm37E9n54metYRqUiLFtD9AEANyCFB9x6ONjcf754WbTnbvw1Cr9V5qnqFFInt2EZxJipy4c+b0qx96hEEgJ2YoGjGZrSGhKsxG/mwCWMNSkzoCM/cluHEf//RMgR0puB/G/3JrdRlhlFvbhl7qUsMyoY6TsyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773576993; c=relaxed/simple;
	bh=o6NEd9Qnd0g7VXaH4C7X9rM2Y51BJxI8kXsEauLUPA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D6L8wJGIIJ04LZQ65CVwAr1RlAXd6VEwZ2KZGmrzOhpsO6F3zEfuKbUOHsA/X3Jo5fbuvmVZcrk/O+vrO6TgtZjRIOyxcJddq8ihiGrjLRz0Mt4y9vjNxJ19NRWilkv5w5S9PAyCQfeqqZEG6fM4FoGun9qccHEhIp5clHbFrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ML+FY1J7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML+FY1J7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so45289395ad.2
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773576991; x=1774181791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ENF5X6gQPPCvifGOM8Ukl253KdBOejJZcQzWq1vd7AE=;
        b=ML+FY1J7XbtqtqdVX3WHWlaIm21Qiyv6/djpE9Qc15IXK9wSDvDQbQ9LGQ7Sv/jCnz
         eSObeITxaRu/8py7nqABh6CFMRKMtvP9iSkHlww4kzvovSzbqbCbgEzTdhOIk1kUIgFa
         +85RBXUKBVquDnb2tNv41aZSelf94VnGpXbX4YgpJOJALCrK08UTE5UP+oMA/3EHzZwE
         WDqLX31aOFulfjaqzr6YJ/Qg02a9c9vfPbdv/AeG+3riMy+ADH70B6pLCQ8sDHMsUXoc
         9dW/Lt+ZdE6U3xAxtV7820G5QYMejW9HQYXvdXaexL2VdZAKU6nrE3744c4dDtLSPZS8
         E72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773576991; x=1774181791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENF5X6gQPPCvifGOM8Ukl253KdBOejJZcQzWq1vd7AE=;
        b=RZ4iPjQfQ2BmxuNpuMt8HV/nip4sSgRZCTwH8p5YgKEDNg5mAy52hT+2/SuaU3Rc6K
         +F1r2cN28/UuYJtyIr3kSXcNsJDN5SJiwd9nkCriYeychrmVjqqoQfJN66nZKznPWIcU
         Ht5KUyrTYHi4JkDgENSWGi6KWSxERrECExn9Q5LSA+/pfXNwNIVo2/4MAunPWjM4J6AE
         BP8+o+omrNgf6wgSyb+eLRa2t+4dJJtEX3lpWjH7xsepklCF8V/w7Y1Cxf/loDB5jYLC
         aK3ml+nJbkHC0We9/gylOxE33maCYTciUbzGn9sbnTITG/06iu+oFxA0Oze/rdaJDBIT
         ScTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0+TA5cZ7BD4N+X2ufvt3sN5OkEnlc/r1mDV9eYnMpYK1TJnseAV2drFnmKm3Az/D0TmbbVSwmsAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuc7yoMgNG6P318jqv7gFbDj7m4WDyL1RlBD0CPkiY6qmcpUOu
	L5fW4uLp881m5YuKZr2ribKS8qw1VHqkNRDLwzxaT4Ik6HWL1SVmlZku
X-Gm-Gg: ATEYQzxDQgcxM1Oe3qEKVH5CgpV1FurmPZjxJd9HFw5BdXgnKZG6fswa6fJrqyCGtzN
	5YC0wex22KmjiieuplQ2CtnQO5h1DBDsmXU2PLVOLwZw5toWt8qjkOZLNGXh+5eVaUBr5zM87Vt
	GqnuOBg6+L3k3SrVyIzK6+GD8nPQQowiktHZin5T+HwwJeRNuQlwueXVheYhjlQCNJGqtbJrfYB
	nPeOj+5B4PVZf2cBWwzQ2RJmiBDVMqunbnXEhUcB4rBdzthHppfcZJ2FybuBBhTr5P2NoZpZx1A
	U92kBFln9H5s6B1Nnukp5yUPCNWf9aez/reTzJwMdI/IJ5iXb7dZmAIzes3ao0S5o849t9Fpjql
	DWzOBGtL7+UAp2S/bHKxw8fZgGOqSi87AZsEKTDiGl7dgJ+gMUXi26XRr60L5PdTwZcDdTVbjqi
	7u3EmLCW7JPiWn0m/LOUcFmxFO/uGLgvkA9vS0SF1LEHmJ+4lt
X-Received: by 2002:a17:902:ced2:b0:2ae:5776:45f8 with SMTP id d9443c01a7336-2aeca91d8acmr99613065ad.3.1773576991515;
        Sun, 15 Mar 2026 05:16:31 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b04e5cb3dbsm25883095ad.25.2026.03.15.05.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 05:16:30 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sanjayembeddedse@gmail.com
Subject: [PATCH v4] iio: st_sensors: drop temporary kmalloc buffer and reuse buffer_data
Date: Sun, 15 Mar 2026 17:46:25 +0530
Message-Id: <20260315121625.840769-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace the per-call kmalloc() scratch buffer with the existing
buffer_data[] field present in struct st_sensor_data. The existing buffer
is DMA-aligned and sufficiently sized for all channel widths, so using it
avoids unnecessary dynamic memory allocation on each read.

This simplifies the code, removes redundant allocation and cleanup.
No functional change intended.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
Changes in v4:
- Rectify commit message review by David Lechner
- Link to v3 https://lore.kernel.org/all/20260312063424.3846945-1-sanjayembedded@gmail.com/
Changes in v3:
- fix variable declartion placement to follow kernel coding style
- Link to v2 https://lore.kernel.org/all/20260311182050.3467471-1-sanjayembedded@gmail.com/
Changes in v2:
- split series to individual patch
- address review comment from David Lechner and reuse exising buffer instead of allocation
- Link to v1 https://lore.kernel.org/all/20260310200513.2162018-4-sanjayembedded@gmail.com/
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index dac593be5695..dbc5e16fbde4 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -501,14 +501,12 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 
 	byte_for_channel = DIV_ROUND_UP(ch->scan_type.realbits +
 					ch->scan_type.shift, 8);
-	outdata = kmalloc(byte_for_channel, GFP_DMA | GFP_KERNEL);
-	if (!outdata)
-		return -ENOMEM;
+	outdata = sdata->buffer_data;
 
 	err = regmap_bulk_read(sdata->regmap, ch->address,
 			       outdata, byte_for_channel);
 	if (err < 0)
-		goto st_sensors_free_memory;
+		return err;
 
 	if (byte_for_channel == 1)
 		*data = (s8)*outdata;
@@ -517,10 +515,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	else if (byte_for_channel == 3)
 		*data = (s32)sign_extend32(get_unaligned_le24(outdata), 23);
 
-st_sensors_free_memory:
-	kfree(outdata);
-
-	return err;
+	return 0;
 }
 
 int st_sensors_read_info_raw(struct iio_dev *indio_dev,
-- 
2.34.1

