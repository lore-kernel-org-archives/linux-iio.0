Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89CB3CEBBC
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438988; cv=none; b=kMauveta8sVQfstllFiB33kOuc0BkKnr4dgQ2ADCKJ75f2iGHB0FDt90NlhOgyQLYGCnEmEXqatY9/ImU6ivPj4e8VKIcfz4ZipU3dsmDEk9DTSvTDcM2loYMLcmYtYG6Atfm/5b+ZeoucmKGFl9v1z+FirledZJiVTmhMFV9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438988; c=relaxed/simple;
	bh=Errhj4nqvarB4bR7L42ihMdmjZHZvkGEfEh2AiA7mY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oEy6oe7bHRj/Z9fN77TA4BX8r+X1FqrGzM8JICSz9BRCur4u9qOV1z5wxZ3nbtgwZ7sBeuDlvmjxjfr/GRoyM/Q7M1awMK0kK4qaQMfUEMe690iJSjNE8YDp0k8uZceVxIpnSvL8CO1V/ah6yB/4VDBGaMH7Hh9AQVtnVh62qRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSK6Rnsg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSK6Rnsg"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a094cc3e9so4341400a91.3
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774438986; x=1775043786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeIqQjw3j6V6uN9k74bW2SknjbNp/c13xxutsDP8fWk=;
        b=eSK6RnsgUIkhnxjfnzTxb2/QGQvZ38WzTUtUAlLLWWZD6wgeRx9WZI+URmukMrNXwU
         +mDTzlzUtuLe4NE5oixmxMlRhceloTSJTycc+gpLteKjtZW0txaJvjDLBwtztOMO202L
         2aKh3X3YwfL0xiYUbKjwMjultkdiIHA5xl5aOHrmia33wHy4X1Ulu7SZvdFDg+NF4l+Z
         bAxQ0+XEdE1NjtSS/cIOBXTohgRpObs8Z1pU0oUjXDGt3QUcB8gO3UCRBOfa04AexnYr
         ODvg+iplEKtCeoZmD6vJEfnyskChDVycQKYU8uZWE8m+Vh7keX5tnKO4H+lYgloMp95V
         AENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774438986; x=1775043786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeIqQjw3j6V6uN9k74bW2SknjbNp/c13xxutsDP8fWk=;
        b=LnWZCieryIMCisMc8I9JdZou0B9d9V2UPW6kRqSjz7nGPa4Ez1wMAC0O10FGXgESgp
         75agH+wbxY6klAmUYKY5sjRsdfvpK+xKVvY3EtGLNU3DJxQ3ihde5HQ9qHc5pfK488LT
         S0be2dRe9GwMuI7OZOC8qeA9Ij7A3yGKwg5GfmUETYfxSjJlJlaHYCbXtCBl529BhUbt
         VPqGVvKP2NyD6Uz4VjzPIsxaY9r+VaxRE1bNOl16xmOO6DEoeF62o+iKjX0fXOopjHcF
         qklNsrs1Ih+Vr01AiiqbE/vXhAGXenPRq9vWpWEkIQwCaNnDIOMrgBEwcsr+fDWa2q9G
         C1ig==
X-Forwarded-Encrypted: i=1; AJvYcCWxQxRBmbqAN/COfXdCXrJs0mAXKSVs1JN1pFif9oI/yXEtBDWpJqNxN9RP1cZVWFOMw2SdCfYW4bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeLrPKFs6bjAoLQQNLQ3geSqqxmdfqe2gf6TqfBrWOxe6ABVSo
	gRC10+6x68GZECs2VmYelnJNwbm0WJ0cxhkg7CabiyUkKRpOL6X1xkc=
X-Gm-Gg: ATEYQzwXMKp6fR0m52N9zRoWmtFCObaqCQ/VVq2r8dYhYFTZEONccKf8jrVocswi7aS
	5uKarxiXiLnokuXiZc3Qg2Dtd2BTtOlDM7fRjej+nd+qCQefBR8UnjNG40rSmAWVv760pDhgWtg
	z1wHFDMr/NySAzrZlsrHvrdlb/c15Ay+2IRkxm4fF+82jIVWXu4ebfWj2J55S5elKLqX8yJqjqu
	8YALAnVGjov0tXtTkKyegwDcNZkiQvxm8Ok+4NJp3qsPczuR13Vyyt+eP+YhTpwQcVgC3UJZkl1
	/xxTF0I7T1RghLeAmD6DodwMjsdN7ULOXieWclToB1V8pc/P6qRhhX9NVR28tYoA7QYD+n8u3uv
	OcSU9ZsXaNwnLdqLE6z0fNjefDmfcDuKeexel9nRl1SoZtI+W8kYoQvamacfGcbshZEpj6tScqn
	fPkTKOQO4ENYHA81nG2Ih9JODU7+Wo+4dQjndbqzt2Q2LHbsFAaTgBwQWng3FHNS1uUtI=
X-Received: by 2002:a17:903:1b44:b0:2b0:60f1:de58 with SMTP id d9443c01a7336-2b0b0b1e2camr35173035ad.45.1774438986204;
        Wed, 25 Mar 2026 04:43:06 -0700 (PDT)
Received: from nik.. ([101.0.62.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836b97fesm172471825ad.84.2026.03.25.04.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 04:43:05 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH] iio: accel: adxl380: fix typo in PART_ID register macro
Date: Wed, 25 Mar 2026 17:12:51 +0530
Message-Id: <20260325114251.20827-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the ADXL380_PART_ID_REG macro name where it was
incorrectly defined as ADLX380_PART_ID_REG.

Also update its usage in adxl380_setup().

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/accel/adxl380.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 0cf3c6815829..d7c3dcf8b620 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -29,7 +29,7 @@
 #define ADXL382_ID_VAL				382
 
 #define ADXL380_DEVID_AD_REG			0x00
-#define ADLX380_PART_ID_REG			0x02
+#define ADXL380_PART_ID_REG			0x02
 
 #define ADXL380_X_DATA_H_REG			0x15
 #define ADXL380_Y_DATA_H_REG			0x17
@@ -1773,7 +1773,7 @@ static int adxl380_setup(struct iio_dev *indio_dev)
 	if (reg_val != ADXL380_DEVID_AD_VAL)
 		dev_warn(st->dev, "Unknown chip id %x\n", reg_val);
 
-	ret = regmap_bulk_read(st->regmap, ADLX380_PART_ID_REG,
+	ret = regmap_bulk_read(st->regmap, ADXL380_PART_ID_REG,
 			       &st->transf_buf, 2);
 	if (ret)
 		return ret;
-- 
2.34.1

