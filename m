Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CE338E8A7
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421371; cv=none; b=cZtX9iQbH7+9Q+zpufb7Cx3GJ7pYskAs+myjNQEyOHDK6z41Cd4ifa4lqluIq9VGquOERWNHurod2KcePVJHSEWMd7aWyeyu0HzvC3b1in3ZJShHBFFR0apygOyayLJ9jwP+5lAhaFZB6RXsDRih82rchgfxyNffj9eiUKQl9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421371; c=relaxed/simple;
	bh=xa5Oy/MOGjty2VAEj7N4ZNdroBueekxG642XjGEeo8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPoh3jW9HCUjnC+zeewUbF2Hfg0t4Y10HN9VkEFhq+L7kHgSRGxsrdxFsKRhnL1Y+zO5t6FCteKzdbL9qyXzx7o3caX5Ke0ZVMUlGcwlLOJwx/lohBLVfU8IC6Tom4Ujrb8SIVMTQfjWpxJ3yw8U4FZi/+gJhLLmbuIhcBqNd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cx+vODH8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx+vODH8"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0b9328c4aso17199525ad.0
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 00:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781421370; x=1782026170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQpCDuMxakljX0z6oHih9q1noq/+hfefR1O95FjQ9QE=;
        b=cx+vODH8FN2Zh45hRQNuHVCU1/qG6eWbsLvmI4hpMZRQNtBmS4jWLR9Qn0NQt36J+V
         pHvXA+SHTSNQ9D3BQvfkVg12svdftkihAVNt0xMA9QrKMFaxmWlHPSCjmDyVCIi27umT
         EsZ8MT8V56p3iUEfOHR340X0nHZhdjMMqg0slfU/LkKzLgvZLIwa20ah3pp83LgpNiIV
         mJfR1it6U9TKLrQJtLHRr41QomikNZKvaTmZxI7gZvNZ5c9/CChzsu2Lhdcci/JwTiIa
         xilUj2GEmLCJM5yLv4d6qWcu19U8mx2DtgNdcAYUJyUjd76NzY40KgkVG4arBR/9pnhv
         1Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421370; x=1782026170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQpCDuMxakljX0z6oHih9q1noq/+hfefR1O95FjQ9QE=;
        b=Xc5/q8GZPK0sh0/PGRg69zWdyeLXOdX99Y4SCPQkV6rqv8lrdLzEHnCQ79YsDR+TlR
         qsCv7nyUekQenJuZgg+T4aCPgMQEW5ie/AZB8Quue0RdIbPfM5Dnrrj+4ObtM2U5cZsg
         W5VcvYzUiSuwoYCXKZ+OEJd25eZ+vxk/yCJnigq6y9eVImNzB1wDadbD6J9JH2/TmxHT
         istx7c2jOsA1upBQVOlvNY4XuCIWJbsq35pXJMLtcfLGe256lixamkvf3SU3ZeQcZVtK
         Z7x63Xgia93PKoNMcfRnkiJ260Q5Z1EdQqn13vHpUgyGCRfw67zymbz+FtcgqVArcveW
         7yvA==
X-Forwarded-Encrypted: i=1; AFNElJ9NUduys5cx7hRTBgi2IuCxDexrlByaxa+7hFOu1lg2KOMDWdd9M/vsoKi+p0m8g/42Qhd+w+qCgOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydCAKzlCrN3jHRE4KSzQ+Hzc5MhQa0RUP7NIqJpXP7JUqJMjfz
	6oXPrxiUzeoRTVHmWyd8BXg6ZbhDGdC6teR3m5fQUFhxqH07VrNUDE1U
X-Gm-Gg: Acq92OG3/LOSsd/Q79S9JrKyT1uPqE3CwJSxUQPcdKJucyjmL4a8v+LOxKhV9wRtUgb
	eaW8q3DJhhze4j30+0MabaTZSwdzlG9ngYt8kLn6NYyfD8s7ymIJPbFz/3BbmOdthbCCxINOtNX
	ZWNkr+Da+RBgFyTtUU1nWjwZuqP/k4QRtFCCh/5uR6b3WIPG3ak1DTlw0dXhPs3WJ5k8fKW7RQd
	lg1ATgTV2gw83Ev8LxP6veJo6J0a4mSyvqMqcsS22Img5d/NfbLAj2ooaxAm3vINlPCvkvQz3Ri
	5hDPQh9vfcvuw8uPOHv8KDfjoiiJmpvOtbAugubtXMpky6m45R2MJpGnF85m0+lNyOa7wrVUxPT
	aEP7mcth6n5/EGnOAwGyeCVZMec+xZ3NymapS10/JkrupP4RZzaKWB0xFhUxDYgg+n+LqnLAFQ4
	OicQ2GG9rGWlGnjjAORhnx13j/VHZqLCyO4EVKuYmcGEnOrTnW3Yh8
X-Received: by 2002:a17:903:3888:b0:2c2:7baf:139f with SMTP id d9443c01a7336-2c41255f17dmr105953765ad.30.1781421370143;
        Sun, 14 Jun 2026 00:16:10 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac794sm65595295ad.46.2026.06.14.00.16.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 00:16:08 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH v1 3/4] iio: pressure: mpl115: fix runtime PM leak on read error
Date: Sun, 14 Jun 2026 12:45:48 +0530
Message-ID: <20260614071549.81920-4-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260614071549.81920-1-birenpandya@gmail.com>
References: <20260614071549.81920-1-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpl115_read_raw() takes a runtime PM reference with pm_runtime_get_sync()
before reading the processed pressure or raw temperature, but on the read
error path it returns without calling pm_runtime_put_autosuspend(). Each
failed read therefore leaks a runtime PM reference and prevents the device
from autosuspending.

Drop the reference before checking the return value so both the success
and error paths are balanced.

Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Assisted-by: Claude:claude-opus-4-8 coccinelle
---
 drivers/iio/pressure/mpl115.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 830a5065c008..16e112b796ba 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -106,18 +106,18 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		pm_runtime_get_sync(data->dev);
 		ret = mpl115_comp_pressure(data, val, val2);
+		pm_runtime_put_autosuspend(data->dev);
 		if (ret < 0)
 			return ret;
-		pm_runtime_put_autosuspend(data->dev);
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(data->dev);
 		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
 		ret = mpl115_read_temp(data);
+		pm_runtime_put_autosuspend(data->dev);
 		if (ret < 0)
 			return ret;
-		pm_runtime_put_autosuspend(data->dev);
 		*val = ret >> 6;
 
 		return IIO_VAL_INT;
-- 
2.50.1 (Apple Git-155)

