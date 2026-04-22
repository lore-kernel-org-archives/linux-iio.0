Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC093D090A
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856937; cv=none; b=VFF6HEYYS5P7lgeRiAXp44l026KG8TfODUaxYEvEyw7AfFc03hef1XPKQO/w0oiLEJPBha2Y7fNW/U8m3Dt1zENGwqB7oC+pl59k+clfOtJVBQ8FbnDhstTcZv0yWDVdgijAtk4VhwxFs5xJPvE24dxxKosuCR3Bycj39qYXCpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856937; c=relaxed/simple;
	bh=FXkg1mDV4oShaRG/em7GPYrPJkJsnXYd+nfmQQqhljQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnJW16LDBbSHYuG8XYjRqocX/bf0jpR+I1OzMwUBxGIiStmvHFoXNw2zWHwOMTQb0/CjDRkRfBCubi1DxYGl1tru/jTl7W120uFyk8HFi4j4wSnOJGoysOCCNSm1Be5RnTxBwUuSPg0svpUVukj+Op28Vrq4JHoH1dDFqPeTyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvh+nLlk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvh+nLlk"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ba67b332bbaso536047066b.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 04:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776856934; x=1777461734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1c9LXgbLAuQ4e0T++vPNz0EYWZY1AH5pL6BoRfnQbtw=;
        b=Gvh+nLlk0RTy8xlUOvrZMfmVdaPAWcqs/9ynOsws0diCAJVUu0d7yAlSrmNK1LoO/F
         MsAaeA/jRCo/b+AxAUI4zIGh7iw5zX+68na2+C9uNdKe2JPOpFy1MDCMjHQVxS0OW5kG
         6m8qpnbSiClVRShYr2nLM0JRVY2IcnLJd3rnyso+QgzRDo0xokG1jJvBlwIFcgyc75IZ
         v0FGaNj15n1a1qgYwuiYYE4IJ1jRXw41hpX6pRA2IKhf3Wv5lWlyke5N70E0em5jeYH9
         NP27JR3RKHlGirqut3orX9t6wpRExw/Nu8gLipjBCfxlOd6bp8YW1WZaOshejw+APZbj
         ZLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776856934; x=1777461734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1c9LXgbLAuQ4e0T++vPNz0EYWZY1AH5pL6BoRfnQbtw=;
        b=XZUeYyuYMhF3yViWIN3y0zKTmOfH8qvNwaB889tKxu7/5CmtWatIxB8eOL1Bivqeju
         4YG6dYnab8fp0sR2M2Jq7WnkNt6rjZa1fhuypJM4O4eavS/qlchMNYnBQj/Ybx310lgS
         ztR7QoTRasqreLyGrr/mheVaWZYBqLF60d46voDe3dWSCUhpwSRfOwoiGKX92cgPyI0A
         KsXn9DpEAblYdtG2oMMgKIwCM++IFrAiFg5BW3EZyIovGFW3aLxo0ByqevrUOjctUx59
         CGeSaSpVb2pE40psXgcuODrznS8Ywm9pwgQsF9EcetQjghrsWaXMoXgVJRKjn075e/ZZ
         5MDA==
X-Forwarded-Encrypted: i=1; AFNElJ/WHXzZTBnUBQRTBSGafbgwBqqYnZjY8KsLNSkXEFqiTJy4V+7orb6ka+ofIT8pXDtxWyToHN578jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXwfpYFAcmXjbCD5SxafYoy3cHrsXb112Do6e+EBUdbi3bVT6x
	z6sGU+WRAu/NvOpumuEg7RsQ2UtA+KNApSy93yRfHZCuo7JlwyLXPS9J
X-Gm-Gg: AeBDieuNyczl6YgR3P9l4X6gJoSXPN3pAV72/CZ6V+RnEcMDWFyZ7+DfmwBMySQ3ARh
	1Aruqd1h/nYqXD3mPWH1GSnaPgRVHmpBOKVMOv1RmVWgo+z4B1usRUpFp2pKg6Pj1fpAdUjaOWI
	KQlAPF9gi2D0fOm7KFP/R/CWUozUkkyLIi3ccbW4AI3lZXBfD0x2wHQTFVrmGEampfMSPSsOoEW
	XomJys7TG2eriuw7m8wCRocLc3YgkAiLRkIXX7wAQjhGv/5hpei5rA1lhJTS20/+udvhkTRaGYo
	Xqf2Er0SoUjEAjFZNAaqsqdNjymCDYrM1QlcHjOz+jqJLTp+0AFdCHX8NiQulSCEmj26DxvvPCv
	qF+ZYpQKv3aUumj3vXAYtB6YEdnHpOBAQij9e29B3RGjPGjBimCIjewvcZrx7b540N+JwvOQB2K
	33tHxkLnteuRFycHJz7UvnvqIgT8PUbBETG/TGzhmepSSAy40myPOGoIh/2IfuHQ33eQXb3+8aT
	zTktv7u+8bhjQnPSuEjj7OrxddpUgm5bCIwMowt2bBju0ExSDC/SbOJSI26liBM33CbwX0lgD20
	nRSRp3HsFmJrtJKso6t+/A1tsKL9QJ+5vLXOJXA5M0K0NbXz+EFbTQUEiRIBFsJ28Yk1uI0kmzU
	/vtlxjnj9gmfe4ON2xwo0YcqlNui0lpJu3jppaFi8V9zzO15X5gCF0M5RVNT3P1wrsPj2W0pfUm
	YZqMz2uH8o8CDxllV17w==
X-Received: by 2002:a17:907:3f14:b0:baa:93ac:bd94 with SMTP id a640c23a62f3a-baa93acbeb0mr212935666b.16.1776856933553;
        Wed, 22 Apr 2026 04:22:13 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (25.236.141.34.bc.googleusercontent.com. [34.141.236.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba6366452c6sm395156866b.11.2026.04.22.04.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 04:22:13 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] iio: magnetometer: ak8975: change 'u8*' to 'u8 *' in cast
Date: Wed, 22 Apr 2026 11:22:05 +0000
Message-ID: <20260422112207.1313-5-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422112207.1313-1-joshua.crofts1@gmail.com>
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change 'u8*' cast to 'u8 *' as the former triggers a checkpatch error.
Also fix the indentation of parameters in
i2c_smbus_read_i2c_block_data_or_emulated() function.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index ccd71bfc8e1..bceab47e5af 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -759,9 +759,10 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	if (ret)
 		goto exit;
 
-	ret = i2c_smbus_read_i2c_block_data_or_emulated(
-			client, def->data_regs[index],
-			sizeof(rval), (u8*)&rval);
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
+							def->data_regs[index],
+							sizeof(rval),
+							(u8 *)&rval);
 	if (ret < 0)
 		goto exit;
 
-- 
2.47.3

