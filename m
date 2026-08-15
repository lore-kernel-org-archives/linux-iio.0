Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAF53438A1
	for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786818513; cv=none; b=Rqsj2hG4ImeI8xiZELh+p6cIT83HEqW+42SEzmcGL1fVjLwTDHv1ThzbOBmc//KPmVFw5rzMnQEs9JLRkcE/xKGjF6jKcOcvGLbH/H71L07KPCZYfDhdHMxzpRwwH1jd8LB9PcLiHuIKXXZlFCaRTfDZ0Ymi0KzLbpDKq6yAQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786818513; c=relaxed/simple;
	bh=AglfuJjYGVuU1/b1mszIc81oX/HIQ6PLpq8iRJ8r/CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InYffQzq5Gi11dpmfiwdh2mt7cQWJOV/GUzAiRaUCkVVxG7JVQQ5Nc1Ze3QsUECzl7FY7Hwhb0BJAh5NmxZfnzMhygXXE9Wpdgq0v9dIDfz5q3L6cGIEhhPtohT36M4uGhCGJhu8dbp2mBRcvAMwNTVTH1mCuQn32xbP5+viC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcXiNt5w; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcXiNt5w"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66c70e2904dso2357443d50.1
        for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786818511; x=1787423311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LVhZeEwCh3t3Qz3apXzpM8jvwUwGQcQC73T/JHuxtFs=;
        b=hcXiNt5wQuSelF39f0m7tPBPQ0vXMla8hI+1tjCe2xffahGCnF6rtfPR62jr/HUbuC
         VcwJT176mXvz6jJmZsEfJKwzRs0jZQYP5wESykGIJ7HZk3CAESIH6hCMeTVBwwCL3/Jf
         JM09/LIcHRTC7YCjEfMrELqcy0azM627XuUpis9enMakJNAy39tx4ZRhwA74QCkPu6dB
         0sGJyvUEzjdP2ogZtX/fAAG/UF3HnzN2UhUoqMeO4UXMqmQC6JttiNLB/xvp4iG+zeJ8
         GwaJin/O0OW60vnyRbCf1LPTsY3PxfJIPjdYhHDQkfrrcZeNYkyoPK4bPj8nrnVUKM8u
         rnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786818511; x=1787423311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LVhZeEwCh3t3Qz3apXzpM8jvwUwGQcQC73T/JHuxtFs=;
        b=G6hwRkobKEQ2HXKOuSFugX6WvVuwQPH+xfVgJFGlrLnr1R17zVQAY0KOShYVHo5rYY
         y5QKnm0Zwz11nbPGRciwPNZZXgDw9wBitwdZzOM+fYf9uesoyhXi6l0hY0uPIGiZqcZU
         xIqdKnCCYaaWsbvXAtvmYBiLjp2Yq9XKaM9GxMK82/tz8L+Evt7ZG4hocC6+FtYjCtLp
         1pQ9rwkRSQT4YpBKl/g0hxpZy5aKvffc0C+Hjmpvaj/V1cDNBksD5x3nSZO1UuuRoBf8
         DRb42hNAHMjb5nNvKO9iHE9NSBYvY+kGWrG5jmx7KuJcKKjjPIAYyo4Pvfsq6yi+lNfQ
         8WNg==
X-Forwarded-Encrypted: i=1; AHgh+RrQwAzUhev3Yj4tJwjB2sAy7W6DFoVY6+pwGjBs85uO3UMFF3SDCyiOBp7tvFFZy2tc1lkIQCYXGNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypqWhut0IHBEhfB7wFD+9ywTWJRcjAOzIvUbXL6Fsyk9ZpsHVH
	QfR9Zd7NRgwtMNhKnI2OIyokMMe8zgyGbqwZFXw4aZn12ixIKqBP2oA=
X-Gm-Gg: AR+sD11KMNsG8x3WzeTCCN2ipjt77Z8YpjcPhAykEhss0dkJSJcYGEQfleiFfN6wx5z
	5L5qkqDXaiE0an7xwWV3L5bekswckcP+3kAmnNW6p46BbpR35ly9n1/rF7r+Z8YQmgYYEaw8HPR
	KUfcLf3NeePmwBOMQTXMbPUBHX1IcU70FQNldz2RbvcQg1YGcDHyFaciqBUjoxw3HKq1CfAZO+n
	QjFDjO2A7Ot23lYBtkGt7m+qQkL2edr0JwPFmxl5nqLBn047pFqpZigFKRzzYvx6Tzxme9sXxIq
	2RhEMpWBMPFapun8aDgpCzcg0qf77XcunfSa/+avRwFNmLUUBcecINb0POs18XmEpQxampDuFO9
	3hX5rJPieqxePXSUj5xZASVU/TdvrexFWxmXZuqPMfTqheKl5b+dITN2ohZPXz3BfCOwwINrTLe
	SDUdcvQWKL8cM4QC2Sz2TkLYdrxtReitbH4moFsf5xoi/bDFqSTxWBvrBjlNzUDURLWUckV89pZ
	oCuNjaw4a+ybUdc19w=
X-Received: by 2002:a05:690e:1c09:b0:66b:2d5b:9fe1 with SMTP id 956f58d0204a3-66c72d04491mr6346023d50.45.1786818511332;
        Sat, 15 Aug 2026 11:28:31 -0700 (PDT)
Received: from daffodil.tailc06997.ts.net ([163.152.162.75])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c75c5dd24sm2598154d50.6.2026.08.15.11.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 11:28:30 -0700 (PDT)
From: Arka Mondal <arkamondalofficial@gmail.com>
To: jic23@kernel.org,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com
Cc: andy@kernel.org,
	andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	rohitsarkar5398@gmail.com,
	venkat.prashanth2498@gmail.com,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arka Mondal <arkamondalofficial@gmail.com>
Subject: [PATCH v2 3/3] iio: gyro: adis16136: fix unprotected debugfs reads
Date: Sun, 16 Aug 2026 03:27:26 +0900
Message-ID: <20260815182726.11796-4-arkamondalofficial@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815182726.11796-1-arkamondalofficial@gmail.com>
References: <20260815182726.11796-1-arkamondalofficial@gmail.com>
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

Fixes: 9aaea09b4cbd ("gyro:adis16136: fix debugfs_simple_attr.cocci warnings")
Signed-off-by: Arka Mondal <arkamondalofficial@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---

Notes:
    Compile tested only; no relevant hardware available.

 drivers/iio/gyro/adis16136.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 369c7428e1ef..adcf54b67a28 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -145,7 +145,7 @@ static int adis16136_debugfs_init(struct iio_dev *indio_dev)
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
 	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
-	debugfs_create_file_unsafe("serial_number", 0400,
+	debugfs_create_file("serial_number", 0400,
 		d, adis16136, &adis16136_serial_fops);
 	debugfs_create_file_unsafe("product_id", 0400,
 		d, adis16136, &adis16136_product_id_fops);
-- 
2.55.0

