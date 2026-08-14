Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993EF4570E8
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698482; cv=none; b=gTsEFfADethDV0N8F8HXkpqJMHOJTvQHAAgEY3GFhX88OxH0zj/Xs5Y6Fk0AnBowVmQdi4HVKwg466+Ao/YxwHJYm9fhINpg1Q1fdxCg5klrYop9iJXzaONrD8OsXR6L5DWa06HLxCYfQdnok8vX4QQSJrtI2LhEf3SBHHWZs2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698482; c=relaxed/simple;
	bh=c5zqYhJS6nAZfrkDxvenZRqtScpjEM/6etjEtFeQX8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kelLcn9Tr+K9rg/Ju1F08vm4e5ApjoXKqWa/07Ta6YJJKMYsjAvl8POdtYMi8P0IONkUPyU0OdEq3Q2Jw22fPP0qbs+8OECfxgcUZWBqxv/kjkgy+hgh38VIpexjDn7tcr+eXQSlia7FOdWzL6M+WkvwFnvzjuV1qC/LzQ2Lsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruwVOV+M; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruwVOV+M"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-82e475fe54eso23699587b3.1
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786698479; x=1787303279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WbN6em2cKK5xDT/p4wJl988YSi484u2kYUvbHsH4u8o=;
        b=ruwVOV+MHPcpBzP11uZljulANT71POgj8SfbzsedmVzxOr/+gDko05WV3EbSyBzpgZ
         WP8Wg90pPJbdqKJOGbuHMTu5cEA3ED+KBLW3gFFV7TqLVazhkVKuApmgP0QPN5as9ZKf
         Q4fU4BKO8eHSeUln0hAhIr1/bjtF2wbCAhCzpb9quOHLg45M04gLf0UpewkvRKiTiWZQ
         zc9Pq0XvUOuPLAHGDV1rVq6s7brnrINCIoDTg1hl19v1oVl+JKcy6L7ljzt0gnu2gR6a
         ki9R1EA+zqWzvyRVYBUfgbUxOkk4pKtxe7dBGEyzJ3mnSORKrbQM9bK/BDaJ2Qs1NBGX
         4X0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786698479; x=1787303279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WbN6em2cKK5xDT/p4wJl988YSi484u2kYUvbHsH4u8o=;
        b=Oc3nquUqrE8J/5Rmv6l5IzyA9ggQT1cJOtkJWpx0j2RgDh4L1vFryzhYOQx/J5S3dn
         8/L3qVQM+17ja5dcZe+LRRad8jD9VhDmZQL9gfb57xnaXgVhPmuDpbtBUQaV/vIKJO/8
         8yC/rrSUrmW37xOhaILhxcJ5KBWkDyVlK/XLE05yIBNjt9BPa6LyOLREe4vbG0MBu1bp
         /tWXloT/fqnsObrfwNQLjjEHjb/IuX8pSPXHnwlAzN4yhQBH31hODE6LuSxXQMVYGPMG
         h4S7j4LMrHGMF7xQPzvcCVKPiFEp+KeDGjyUxkbEvQL6fPpXES1JjRgSLzTbPOBRGdS6
         G/+A==
X-Forwarded-Encrypted: i=1; AHgh+RqTov38KHiyAFTQ/8+OO5NMXvcFzcKE7nNpNJncyQMuS7zdoAmpgFVcfhVsEfwR3xcqv1MbT5rcg/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3WkkjtPGOWvPJbsHwt6JSZrD0nALaaTp8Db6ENseGbMNp7wYv
	kDY1vncqJ6bVI65HtLnXiJpqc8CQz05uZtpSGpAnY10NGQFNzP+5b2M=
X-Gm-Gg: AR+sD12MidYVP8NPgKr1DNs1nAXrIu6BSiQl+kg9z8FOIc4YnFdJzX1Ede8gawkrtNi
	seT8cbpawdMMWA8myRyUdKH8hOL53+9Z/XUjIIdL0jhS2M0/VczIXy5zG6Zvg88JK/lU/hGnIAM
	fAhVrVaAXiXHIYMmMJjIxgy6qatw8dQc2eTKi78mnEePFyQQ2holOK8qSSHNCp/6jBFGzPl2Dk9
	y/guN8c5VW9NNzZVjLvCH6kSR9KoIlq1MZuJ/9fzAb8RhrLPFhN32iL8p9OlyGPLG012Npi09u4
	U+iWpCHim4pq3mOipmPBviwQcuKb0Z5SQOEU/GOHPUUEJd0LWls0s+Pm2NyJcQtn7vbteH2xfzC
	+3lV0nDbrVS1t/EzDEPp0If90jMFUkvoT38udyotG4u9aiVexKaCf0w4psuN92kHDVv3VMToHKd
	Slp7rptaFRYElMuaEhNrEKieDDTWATyGsMrLZVa/04JSclrKSZomXA02dJNfoh4XThDf1TsKcBg
	ixDhE8dmLhLb0qfp+CAl0cKOzT11g==
X-Received: by 2002:a05:690c:60c7:b0:7f0:38f7:6ca6 with SMTP id 00721157ae682-834840e734bmr54735737b3.5.1786698479513;
        Fri, 14 Aug 2026 02:07:59 -0700 (PDT)
Received: from daffodil.tailc06997.ts.net ([163.152.162.75])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836bb3ecef9sm10801267b3.4.2026.08.14.02.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:07:58 -0700 (PDT)
From: Arka Mondal <arkamondalofficial@gmail.com>
To: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	venkat.prashanth2498@gmail.com,
	rohitsarkar5398@gmail.com,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arka Mondal <arkamondalofficial@gmail.com>
Subject: [PATCH 2/3] iio: imu: adis16400: fix unprotected debugfs reads
Date: Fri, 14 Aug 2026 18:07:27 +0900
Message-ID: <20260814090728.965922-2-arkamondalofficial@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814090728.965922-1-arkamondalofficial@gmail.com>
References: <20260814090728.965922-1-arkamondalofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The serial_number file operations are open coded and never call
debugfs_file_get(), which debugfs_create_file_unsafe() requires.
debugfs_remove_recursive() therefore does not wait for a read in
progress, and unbind frees the iio_dev underneath it.

Use debugfs_create_file() instead.

Fixes: ae1d37a9bb4b ("iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE")
Signed-off-by: Arka Mondal <arkamondalofficial@gmail.com>
---
Compile tested only; no relevant hardware available.

 drivers/iio/imu/adis16400.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 36323ad149e0..7e85c1b8dc16 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -280,7 +280,7 @@ static void adis16400_debugfs_init(struct iio_dev *indio_dev)
 		return;
 
 	if (st->variant->flags & ADIS16400_HAS_SERIAL_NUMBER)
-		debugfs_create_file_unsafe("serial_number", 0400,
+		debugfs_create_file("serial_number", 0400,
 				d, st, &adis16400_serial_number_fops);
 	if (st->variant->flags & ADIS16400_HAS_PROD_ID)
 		debugfs_create_file_unsafe("product_id", 0400,
-- 
2.55.0

