Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6731E82C
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297272; cv=none; b=ADF87MwbYpB3dFTHGoX3h3daMNjW9QvCxDJl2+VIeDEBCFihNfVItK1xG8I78T8xc1wfqQH50xe6IFXCUmJhxXmqFXX7l7T78W8kf8r8joC475yG6fNUt0vmImlHLRL6/7YSHAvyaiafIFEhriolCiu4OBajga69I7uooNUzBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297272; c=relaxed/simple;
	bh=u6RgrTM5nGdaNIIJs8dQi6CpfAbt4BCxv0+23K1ivQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mUE6OciD9WOmwpunYnPGVIMz7suLIDz9A/l2XgWxPCCp6kIdlIheQzoV5c1NiidWvnD2vOL++ZwqqHU06KgRxhcWm7ZNEkWVLl/ymu0QW2ciDtTO3n/BRbwOQEOvuT4Zj162C7QxHPhTN+4Q83pqXx76e7hwQ+ZnKntYgEqqVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jywgYDsK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jywgYDsK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824c9da9928so380708b3a.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773297270; x=1773902070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eC4j+QkdYIhkea2GOsCrDBLrX9/9TUq5R1IgUZKPzSc=;
        b=jywgYDsK8YTbUzfr0coXV7Ul4DvqFFt+nE8BeOTT48Lv0C6lMl1U1LhefWddj/YOD5
         YEiF2xcimR15hA4iUoTSsz4VKAzyRlMOEaP37QVWxt90+4CAhqbACwQ4ol3dd2zygGqk
         j2PGVQPuM+r6LPQ74Sgl8YBk5D8Xu1Y1xD5ffXfkbnYf4PySg5l1ERKWCHgu+cJ70IKA
         mmTFkKlHemFhacDCx0SwnasLpYuXQCAqXKdSr4kTpVoS1HNLdCDQu6SJJng6VHXy13tM
         OiX6G4XMnWOvxekHMtpb4oc0jcpbHPMLw/Q3Y1A/CLdh4oXOb9oLTTaiUkAlXv1mKUGr
         kpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773297270; x=1773902070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC4j+QkdYIhkea2GOsCrDBLrX9/9TUq5R1IgUZKPzSc=;
        b=Th5/SkZwsoTah2cWjR2QlDVRBNg73HPmbQSP/mwM6i0u6AJWh/tS1I7vAIZ2Rok/cL
         0D8awoy8w8/xtBSRGP5tlfuTxaAr+HZ0K7jlwaZeLUrU8YZFCgjBbrs+6/WLwn53j1X3
         nTYRu/kYGc0VJwKHmhuZPAsSIz8Zl4bu1/HxD1wQWuJtO2I5FUMgcx7z56Dm3RzgifsE
         RImkquBQPop1cJpVBjvh6lAaOWiA92uXQUl80eBAThlIuuA1ZLJkwi1lZbG8phc1LWg0
         bMNyLWlJaPy+QIlV3t+sIeckOxB4QbeA/9PUOEBVjBZwPA/wEO4PPILNGZCA08tz+HKM
         nLVA==
X-Forwarded-Encrypted: i=1; AJvYcCWph7o40x3rSUOajo/1aO6Q2VJBOnLbGTPbXac36GmCIGWST9bpa5L9nivwuiEFDBIeRfgeqHxte7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxtj147C7R9kVuoNUrZu8vK36Ic+3or9ztAgSbm3Pnkj2Nl1J5
	/5P31cI2ouCkl6FCnOECVfSgsmbGauahKYyVDZw/GblEWFBpFbE2Hfy2
X-Gm-Gg: ATEYQzw2RBJLGoAzred8clRRrr2eLehJ25B9bBkafpn0GP2oLeYO/fKMvX7CPS21ikI
	P0kWDkz77/MQOuDfnIvfbJ57J66fAMYy0rIUFAzF/5vXQRsgKf9KGA1TQSwF7YDtRyBsPrDqUI9
	YHHHv4rjmQ6zmLswntQMChVToB9ium0QiibJKVafWsZ/6A8pAm3L1so2ImAH9Jfceu/5sqlYxSW
	7avtGnir81taxqFQNVPvPQVW2wlTyYzR59aXDyDdbAsLnxgeX5hq8UczlcJw16UFi7C1XGdSLt/
	anuovMw9TlCTMBjpLdn+wpAg6c7zIzBT1dF8q0w9LVBvvRKnSYKMfJuKI7SDqzVh4S2ZWg/lo4v
	GGR8ZK5h1O9xKeGNM0uR4TfWMGzze+l0gdOaR4yjEvHODq6UY9yOrsQjbs38656HyHJG2NhCGTC
	p48lPf1ko8WjHNi53GqVyWMriFVe8qz0Q6YsRsFkb/fn5OVV7e
X-Received: by 2002:a05:6a21:7016:b0:398:c3c3:8686 with SMTP id adf61e73a8af0-398c5e60587mr4571507637.4.1773297270223;
        Wed, 11 Mar 2026 23:34:30 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf0e498sm4062548a12.3.2026.03.11.23.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 23:34:29 -0700 (PDT)
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
Subject: [PATCH v3] iio: st_sensors: drop temporary kmalloc buffer and reuse buffer_data
Date: Thu, 12 Mar 2026 12:04:24 +0530
Message-Id: <20260312063424.3846945-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace the per-call kmalloc() scratch buffer with the statically allocated
buffer_data[] field present in struct st_sensor_data. The existing buffer
is DMA-aligned and sufficiently sized for all channel widths, so using it
avoids unnecessary dynamic memory allocation on each read.

This simplifies the code, removes redundant allocation and cleanup.
No functional change intended.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
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

