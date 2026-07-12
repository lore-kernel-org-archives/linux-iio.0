Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6E2F0C48
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783845080; cv=none; b=QeKTZHE9HxIhdfdPGzeaFYbDjmEsLEvR6gl+n/k69nBijbF+5RJDC1SKzelNr8pxKoUFAaA8vI2WDkCmmfu6knIk5Mq+seSTnNWfmRgvuJ20OEBc7hfYnFosDxPELnR5h4F9Wi1NPO8jEqnEUDuupHtbBNR7mNaPVSNvBDn1wxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783845080; c=relaxed/simple;
	bh=qZZDoRccRriO9uv7+G0TDUWo85TZUmIAExHMsIW0gvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TYuls6mKZAZ36mJ0/Tq7pD/oEkEgC2YklpaHGx9io21K4Fehv/fBx0RSsXPy2Na12iXFk+Tg+UF9Jz5DltUspYCx/I3wyGDQJ3XNqGUgdxni3/pnPdU62/MwGWkYe+2H02A/RNZgHfmm5ccZHD4gLUep+oLhpu7ghezHDSyUqNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqpFkF3p; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqpFkF3p"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caea3f742bso24499625ad.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 01:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783845077; x=1784449877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qwVPE/TFDEf5PRXk0sV1x1p53OMgZZvm6Y22zC3WyOg=;
        b=LqpFkF3pExO/2x5sP0tVFVuqoApHQEeARbW2B8W9auWXMHQy7CytKG7wVvSqBvOcUU
         aDX7VGJpha0+lqdIoQNDLNh3Pw//tKVz2evwPLVZmp8icA0D0ZQSL9b73kNmy/2nrswl
         paG3wKdA1Q/lvbT2bwqHGw2fRsIiK5HYJabpzWpipLFOp6pyhT2Us2Sfr9XuftjrEHOB
         XUv655SL+EfNC9zpKVwJVt+/PQJJRYl7OERhorCIz/5nAyXxP+7wd1KaiCiFwZcv1Hns
         zjy9QFfV1Siv9uup7PVjqPEiZQAm4tbMWFmK8EN2KW0qa4WueDqF6J4eWy7A2VSduIW8
         UHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783845077; x=1784449877;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qwVPE/TFDEf5PRXk0sV1x1p53OMgZZvm6Y22zC3WyOg=;
        b=NrRHxx1+JgVhrceGFfA4bqU85SvkuYzIz+J80fUyoj7vhfbxN82Tla2WUid70zY9sM
         KYrBpxWg8aJvsZWWEwkD1biSbqJJ7HfvdZQgtYf8AxYNpV1Aai70H60FBKX/dDDW7wa5
         IHsDRb6P/oHookQq73jKNkcvOQOz/zpHL9RScgUSs89+OWQK4GaKM+yItJi8EHiFVPLY
         OnIf8h9Nhmzw6YiJTzjA7M+B7ClsAuGcf7f/OHhG0oO+8bVjNGz0F8O/Ah92fEuq22zD
         y3Ujaj+HLnPblCq5M2WieWwmBI+Dhx4bfkODsRxFSDnWXMCFfwaVoNcIv0sCaB5pUlvw
         Le3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrKKOpFLyBnT+jbEEIJx6cCLP2+04rIgX5XLUF+f91IB2Eqd/QV4wLOeEbgewFXMBM4NNyWFB2vJgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNsvafu0clPCbCvjLhmC15Ts+eW2D8VP+mJ+FQhAm/EHp9lUJ5
	U8NL6lDTFOjgg8uGW3HHsUAWz2eE+XNhyoGCeoU3iG60kN3WTNPROro1
X-Gm-Gg: AfdE7cl0rjwLwbHWWx2wKyLNMfUCEC/32qZw7Jp4UvsTwFEIxQaErht3A8V4KOynaGg
	ldPuke5izHjJ4ll8P8+0ifeSdhZkGL3Vqb2w3j4s1l89aa5ibO6Hba2ezEuo0YA0tQnjhRKEVdK
	0cZ7dwSwHdaW5kJfp4x2YLXqpL/DuODreneEGyGn+qrAjujResjBgxVxkRQAb7gR2koQbF3nYyW
	EEheaLorD9ytRy47sNJwqOROIE81CY2gJ0I1hw+jCLN23Z4OHm79lbqhCngWgYmyD1vpwAAv0l+
	hdC6HF13885yoH1FEGkBeCaQGMEpFCOw5tNt8xHU3E7pXc5OYPPVcnyHIPBYVfyROHe6WIcz9v6
	aTnb7Q7Uzr4UdxJkH/Y4pky1tEJLhAbp2dZRJPMNvhg4UwqWDNCxjaChYfIed522fLfGDO2Rb2z
	oW8rSd9IlU6JcJycCmGhCv+w/xQ6mHrp78EeFmLglsyOY=
X-Received: by 2002:a05:6a20:12cf:b0:3bf:6c08:fb9d with SMTP id adf61e73a8af0-3c110b4561amr5540581637.49.1783845076933;
        Sun, 12 Jul 2026 01:31:16 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm100968646c88.14.2026.07.12.01.31.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Jul 2026 01:31:16 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] iio: accel: kxsd9: fix runtime PM leak in write_raw
Date: Sun, 12 Jul 2026 14:01:06 +0530
Message-ID: <20260712083106.97429-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kxsd9 driver previously used manual pm_runtime_get_sync() and
pm_runtime_put_autosuspend() calls around the entire kxsd9_write_raw()
function. If the user provides a non-zero integer component for scale,
the function returned -EINVAL directly, leaking the runtime PM usage
counter.

Move the mask and value validation checks before pm_runtime_get_sync()
to ensure the early -EINVAL returns do not leak the usage counter.

Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
Changes since the reviewed version:
- Reduced to the minimal write_raw() leak fix. Dropped the remove()
  rework (no underflow is possible — pm_runtime_put_noidle() floors at 0)
  and deferred the PM-macro conversion and style cleanup to a follow-up
  series, per Jonathan Cameron and Andy Shevchenko.
 drivers/iio/accel/kxsd9.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 4717d80fc24af..1af04cb4bf86a 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -139,18 +139,18 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
 			   int val2,
 			   long mask)
 {
-	int ret = -EINVAL;
 	struct kxsd9_state *st = iio_priv(indio_dev);
+	int ret;
 
-	pm_runtime_get_sync(st->dev);
+	if (mask != IIO_CHAN_INFO_SCALE)
+		return -EINVAL;
 
-	if (mask == IIO_CHAN_INFO_SCALE) {
-		/* Check no integer component */
-		if (val)
-			return -EINVAL;
-		ret = kxsd9_write_scale(indio_dev, val2);
-	}
+	/* Check no integer component */
+	if (val)
+		return -EINVAL;
 
+	pm_runtime_get_sync(st->dev);
+	ret = kxsd9_write_scale(indio_dev, val2);
 	pm_runtime_put_autosuspend(st->dev);
 
 	return ret;
-- 
2.50.1 (Apple Git-155)

