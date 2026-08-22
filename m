Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09353AD50D
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385849; cv=none; b=pccKDBfB6lW1+f4Kqjn8G1EvNMXMp0mZHce+VdZwxHFzqG8DBGf+mTnBgaagffZV4ssEaUHOLHt7VuTO8CYYMFUrb5WKk6fKsE2Iih3V9HvPa6CUhI+Dulk6vw0hwr3EQA+E6DzvwKrDjJfAvtITDHZhAD06nnhiKzrtEna4K7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385849; c=relaxed/simple;
	bh=c1kpDXLLAzdZm5rs2ETbE/7TO3I2DSL19IHJCzFyRZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lx8vQKjSw7FQeIXO9iFN8C8+p1XSU7tugiTWSHlmfeqJAdOZ8+3lo3LS4zd/ktnm+zNUqAMcWLk31/rXcH1S8KVGf922df4tQ7GSbL4vlDbWd1/BHqI9tuo2IfxmXfLS8qOwgLMk2RVweXsq//wpCAF0gmy5P4D6Gm0xKy3oGmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZx+ameP; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZx+ameP"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so3241550a12.0
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385836; x=1787990636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XKzkLe41uuu5Pw2n4p3dvsG3NzOD2toE69Y9PiVCR9A=;
        b=MZx+ameP+m9HHAtJL66qkOsHF6TS5bitAsc6AwP2o1usSfgevSS3yDVYcJU3AcFhXc
         g4vj4lzZqqi57QizJnnDpQuKwV80BSXgGM0C2Svt/hCgmWl0a/XT4pwbItOUXGRcDjNt
         L8Ah8Cji8m5QzFhs2DqG4iRiygZfhgipztzXjKPV58jO/+nK0XT2hdZ6lAL6T600ln9h
         xj7ZNTm4jjZorMkMaNb+9SLEeN/NFASx03DGV6KHmnOs08tgJrrS68ntry3dWZAgEqmZ
         L2ZA/mAtzvo2uNt+hY5P10h5gIKFMRHVklURcrDximdnUi4BWu8LFymweb9pObcuvolH
         M5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385836; x=1787990636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKzkLe41uuu5Pw2n4p3dvsG3NzOD2toE69Y9PiVCR9A=;
        b=Nco8L3gjQJQ1fWXfBksqXLlvKuOZX+YpshqgzKDqYi8kw/iZFQRwlW17m4kmpMgehw
         KY7Afo+rXvWw2+kQ2GDolTiZvabvhhE29408EXv2LbjQK3qinEjqvaybc1QnSf9kib89
         IqGj/4v+5Rm22kzAOg0Hshoz9qj3DgqPhLDPOpp5sdsDUgI6+Sl0yrOEwwI26TUYPNd2
         kIJqq6GYQQJmJXF1NBgYLMtNIG6crDFKUjZabvMG25utsTmbwmULl0pJKFK0lmeBULWb
         l7UWFlNPDzwv9tRFoSYiQxqTb/z4h6WZJGSZkNTWPXhAJEQXq33G/x3ur+hwtcJ8L/Ev
         TheA==
X-Gm-Message-State: AFuF++mrvLHBpPKq35f1ofeXfPP5iYiDffpZ80rND04aKdIX9GAoY8dp
	udWqDCtQAUGMZXb9xp8Ifd5g1LRpRyr+2ygqL1VhSov121TCragu21J0
X-Gm-Gg: AR+sD131HtUZNC+2Cg2jh6CARG5N3CrMA5VPqTlZ0sq9NpLtDxTloyHgUkDgGyGWWlh
	7051bM99vY9I9ltCa6P8SKcy6zTY+62YTo4qF1GWN2PRajoHD4LJdVSzjbPJlXPtXXIWHxSqaiM
	DabjQt9IIBQS11OZGocwvIvfcksX1cgLDpLh7ZmieRnwEXBNCwAb5dbTTk+RfelUhMcNcYbmnhl
	kqz4bxLpWMG2i/UIRY4IKsf6VXXD3yt8Q8UJ6h+3p5o/0MYQ2VxHdvrx9JWX7/3A/N4BquEKI2a
	CL4JpjsGP/T9Di/lpdizISbxdC9iemWMuNpVWXERAlPYoPsRJJ09oKI3d+Pabb25Vbb6H5l0D6v
	shrS0wyZUblVIeWSgCFUYEKEzM3QpEXN+12LXq1R/3AjJp9Nhwr/UDzZa3/c4HYtNN1YQ3XQ2H7
	eTi7QTk1Ops/qYNHB5EqbutYwE7T/A20zW4CZymp7rNcVX1wRit/hFRnyusdQ6enRvUFQhCpPnQ
	5zV/8V7+JfzUrxA4cP5V1Ny6GmXIU2r9uX0e6HjIivFlyM3jXwMhLwVwXEB13sGVTkkJoMCVSLX
	pNG3XbC8nKnS4aztL00RQhSGU0Tu8lrN8wTJznYoGYPxB1OtoUjqC5twx25bh4a8HQKOXR3Pac6
	yrgZ7zINH2Y4bTDb/DyNlAC95GOX9vAQpqtA=
X-Received: by 2002:a05:6402:434a:b0:6a3:691a:9d82 with SMTP id 4fb4d7f45d1cf-6a582af951cmr4924350a12.3.1787385836377;
        Sat, 22 Aug 2026 01:03:56 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:55 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:40 +0200
Subject: [PATCH 13/14] iio: temperature: tsys02d: reorder headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-13-ee31b124be11@gmail.com>
References: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
In-Reply-To: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=842;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=c1kpDXLLAzdZm5rs2ETbE/7TO3I2DSL19IHJCzFyRZI=;
 b=4elucnM9sgVmz4imfxUFT/0OzrFBW+FTZUGQ97NfBVO+ysDJC9RXFUw96dCPge2TK27UoAgHb
 VEUQx6LBib7CRJy0y5GsS8gzKSFS6lChuBNTzHI2nFIAptg4BSQQehQ
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Sort the headers alphabetically and group the IIO specific headers
separately.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/tsys02d.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index 3ef72347456e..377e27b45fdd 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -10,11 +10,12 @@
  *  http://www.meas-spec.com/downloads/Digital_Sensor_TSYS02D.pdf
  */
 
-#include <linux/init.h>
 #include <linux/device.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/stat.h>
 #include <linux/module.h>
+#include <linux/stat.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 

-- 
2.55.0

