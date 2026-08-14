Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8CC44C66D
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698474; cv=none; b=I6NGolKR13nC1iT8Rml6ChDuS1LqTsQ3eRHRYYt4o6br1GtP+dgdUUisI2bB5wzV+PCsxBC89r00aQC6jrHg9qIb3i+5j5aRbS/alS3UN7rUDJo09ZyyolbREpaMx1yzcWi8QWgme3CxGrvc6ByUHOhmZJNyZqBEU/gAnhEcWc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698474; c=relaxed/simple;
	bh=iAJCdSqNMd1RPknQKw3FBj+sKj+LYIWlnNNynbxmDs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=doSMhUnIossTq4u/RAMG2EtcEYz9NaL0TGKaWbERfb15JosPeqs7WTjEAbhSLyvYkTSxZqScAwJo4a8S0CrUjga7bC88MGBIWR8sLzEloc4b1YeDdIRm5D4UOCitUPC7Xuyw7j29uYTpA3RGImsMv6qzn9pRz7Hg2hxF2pSSjoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmOBKDSA; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmOBKDSA"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-836cd7310f4so11333147b3.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 02:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786698472; x=1787303272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ObvL5SEFm+tixGTtsLigZChvOKxNiOQI4cdDw1tb9Go=;
        b=gmOBKDSAOdeSSm00965+sKSxKe4HPqXJ0OWGqVITyU1a37wkTi1n4NCA0mrwQHzAx+
         R3ydxDHNmtDILmvMrN+1UswEu2Uw+WTA29t5mbQ+yYRX52LUue7f3qHbf3tmnWI3qMk3
         50zKCrKTGPvffYyMSFm8ItovRh6yIiv02MzHy44bkEZTzOkabf7yV/4GJBjesFpiphit
         YUmtA6g4bQWOXsPnS92IQxmm/Jh/khCo+VW42hP/ukHwynjgBt68Ia/QzpzARBkvqNlV
         1w8v3Xif5tL7RsvftbuC+CK8vHIrKbmVik6kg27mPDer7wZTccn0trMXO4ylAX1yJSk5
         Zu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786698472; x=1787303272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ObvL5SEFm+tixGTtsLigZChvOKxNiOQI4cdDw1tb9Go=;
        b=XvttSPEmQt5KmkgN0m3Y9BLjOlLz/aFz4dWXx8b5JduQQX1roTAmxyCUlu5PRzIrof
         epsYqxdQ8SLC+E+vr8Eyjo6YlGRygoDzYWBWyHYcuxacU8jORR00aBzePLKwsHb3Lpbj
         XMUpQvo4rIcPU/dI5eqSy75xVxsEXCyP1UHMewy6cd6CLsPVRZB5By3ro9OIU9fLv7i/
         rip/SlnovbvPQkmUu8787+M7YWC2g45hS/YBeosxWsmYmFgk6XzoNd2qSvOlLx18Pc8k
         GQS4O2T/hK9HBLSyesuhOAYV5VjVkLFBkEROYXi8cH3iuOcR6Uzkmzd9KutfYaOEQ2O0
         tfaw==
X-Forwarded-Encrypted: i=1; AHgh+RqszR2324V2cUP5r021A1Y8t/70chkQ9A77HIUir0msjsPa6XyftQgwvT9pU1OH5aX7E25aY50qHYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2xLreJmqvaGbygcaHi3ulNwZFFMKOXA1b19SiiGnXvlrbZ8ge
	os8lqYar8487MM5dvPNW2HFJ3p56LLVk9L45DgNp8qd+VncVkzeHKcU=
X-Gm-Gg: AR+sD11Fy+LTeO6Vc8vji6IMIU0yQ4/lRTzDn8xT1JqULTKg1ToHftbPenZIIKq+fPo
	L8XGwYMdU7emlJqYSN1a0gKmKu7bDiMoCKNPKaNyLyP7xemH4l/uZYCGS3RlEs9zHZMzROSHOrF
	We0t2lY1CJi8l4REfcokugVkkUPlQy5dkOdjSLwFjzA3AWHw1vh385Up2duHqpZVNCOUPdZblU2
	gnIVHtfmCF6adADhaZ7w0X/RMELJ0B7L8kE9iVSGHPY4kOhBbCpjQz/MlVMsoV15xcb87rlKdl6
	I5dIj0xJGu91APb4Cbz6mYWq9x/GJPDllqMsmeJdStMHYNozXRalyUa8CGPPE7hLJtZj9pS2MBX
	FU9HaOu/dZoNhvEvFhEBFAHqale5vj5+B6HCuWMLNLIFp0ivvo8KsmFkGfSJxEl+3EwrFn2Hr4y
	sVCHpgxYqjkVZpfWKpUuOTZfhU8WL3aKnZLps0cGTGVRR2zNrp0uBqb9CwxNqP8Jd7m9G+9FWlV
	bbjuQV1KQbMG4IhLgY=
X-Received: by 2002:a05:690c:a6cc:b0:80b:9f4e:a70 with SMTP id 00721157ae682-837124de3b4mr13978267b3.26.1786698472177;
        Fri, 14 Aug 2026 02:07:52 -0700 (PDT)
Received: from daffodil.tailc06997.ts.net ([163.152.162.75])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836bb3ecef9sm10801267b3.4.2026.08.14.02.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:07:51 -0700 (PDT)
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
Subject: [PATCH 1/3] iio: imu: adis16480: fix unprotected debugfs reads
Date: Fri, 14 Aug 2026 18:07:26 +0900
Message-ID: <20260814090728.965922-1-arkamondalofficial@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware_revision and firmware_date file operations are open coded
and never call debugfs_file_get(), which debugfs_create_file_unsafe()
requires. debugfs_remove_recursive() therefore does not wait for a read
in progress, and unbind frees the iio_dev underneath it.

Use debugfs_create_file() instead.

Fixes: 9bf94f836e32 ("imu:adis16480: fix debugfs_simple_attr.cocci warnings")
Signed-off-by: Arka Mondal <arkamondalofficial@gmail.com>
---
Compile tested only; no relevant hardware available.

 drivers/iio/imu/adis16480.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index e009f3824768..254b7ff25b66 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -309,9 +309,9 @@ static void adis16480_debugfs_init(struct iio_dev *indio_dev)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return;
 
-	debugfs_create_file_unsafe("firmware_revision", 0400,
+	debugfs_create_file("firmware_revision", 0400,
 		d, adis16480, &adis16480_firmware_revision_fops);
-	debugfs_create_file_unsafe("firmware_date", 0400,
+	debugfs_create_file("firmware_date", 0400,
 		d, adis16480, &adis16480_firmware_date_fops);
 	debugfs_create_file_unsafe("serial_number", 0400,
 		d, adis16480, &adis16480_serial_number_fops);
-- 
2.55.0

