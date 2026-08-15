Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6433374F
	for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786818477; cv=none; b=T2eKmbm717hzQTFrCoXXrCzT8rwQLp4Bx675Fb9BHxuSa7abAQ1AhuUo40F2fyEllwGxZrfdO/RuNrLd957uahZeg2QlSqsytRf7B/PM6R1r5ywL4wRsaytLTJ2aJupdJaNChp3ILtOno9+so2l8Atnt4jiepwZQzWcD6pivkcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786818477; c=relaxed/simple;
	bh=EZYpRtCk/IWXuA1hpLjgUkksiqsRpGfb+L16mV3/6WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bc9WLS4zm8N57kn6VMrrhgw42Cq9QGROoCcVa4QjtwNrZLDbO7MVlmo4KUYlzUjxiqg52wr/VeHil6vKZKtxJ7ETO5j7KRKHd0kgWN1VJwb+VgGX63y1i8Li0PdXw690apaPsTToSyUH0rccqi4zWEr1bdiXvQzLsrXQQM0Y40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nuta2BrH; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nuta2BrH"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66c70cff944so1871383d50.0
        for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786818474; x=1787423274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NPNqM78QIlfa21ZWXnecQfff0vtz8768AVWjbj/1skw=;
        b=Nuta2BrHOp8fdwnS9HE1H/S3zeegZbPD6H2uKaApyQ0ZRl/ZbLSfPOaq70QiHgYkar
         o0DlSeqfxYvUhMhuTTXc31VeuR1NVyaLI3KGC1S/OTMlSaQi1ShBcp6kbJOfdAJ8GTJC
         DTd6kvarg7P8FIqPRDHi7W0oeOT2dO1mEw+g7DmuUrdx48aPOsvqWo3P0oYY2llklMUs
         amOc5yLcJiXvYJKzT22dSTIoCROHcYGYjCFvN6Fe3jl2KaKgBR5U4ot8jMi/MrMM3t3W
         ImWmG8M0B+1Q0QVtC31nOXW5x2rKcH3A2ZsckS6MJWwsunBndyegxr2o26TcaxAQfM+a
         t3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786818474; x=1787423274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NPNqM78QIlfa21ZWXnecQfff0vtz8768AVWjbj/1skw=;
        b=mboZwQuE2s1UW+yxm6LkggUf/5Px/vZcbuZx3Rw28L1WTL8qPeWpC/Q9jME5zjDVqU
         Glve6N4hv1XzxaUAuB6BCx5IuIhI6LyAIR3thp/yd6ie57/OQ8JvytOIkCyC1eyLREL+
         HnUYl9yEWrMUWziFwNUs1yCaLjGhFuHJ/auK6PESjJjurPeclPOW9MICRZqO4wzE3JYt
         zI/lDHCtLKB5Fw6GjAB9COBnwMZHcDSEW6egXTF0e2gB7DN6Nn7qq3yn3x+ZXdVrzS5j
         UH7tPADAVnoo5OlhONJU5Huj0ON4DZP42uOlezCa9VdATJQSaUzeUVFqSGGcvnUdfD0x
         1hHg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2Jz4ip75vkm4daKI7VllBAegmXqadPQCGlTEL0UwvNzigtcjf6dquBkcIN+P30SyEAEv7NVk5MxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLV6Ex8uyOb0jaFOSZVHCpWBXOrRm2qURVvBZyrbz0zmnQipAp
	SJzhKSN1o1Hj1GF7/A5VXScu0OC5Wt+PGgOmkUO0dgm9DGccFhETYW0=
X-Gm-Gg: AR+sD13CnWNjpp5MoMVMko+wrJBGOfvjm0dCiFRrOnhGoBNaCaoqkvL0t/hMhD93Wz7
	OCRPVG0W7xaThmENhUbCfHwxNmp5SBJi83pgUlR6U8btvjaiF6kR5+1cuJtqJCPNVXBPn6zKHAA
	N1A7PDbhIw6Un7rECeL24i87YPgvDeRXdNkQsRB69JZkMGhkcs7xoTX5FmhZ7TLSeNIndwNwImK
	zMLqN26rv4RQCBfAVWxxFqw1xVul172C5MQHP18/W5gJx9yJ2uvTCG0wEW6Si+9y1v1XpB91zA3
	JuvnmYYX5/pGWdmLXJqmlg13UYuXbGhrdroH26sr5Gj7sSXZbOX9wsLhM8EW5Bm/xQjcSc+G9Du
	elo6IurIGOi1gWuI1SZC6WrcWVgIV7+UChmwpI26pyXWnw1T8ImRkSVeKWG38Mp3uCtVAueyWfe
	G7diRSY7MfU1W3DTtTNWg/L5DWd5IsPtvS3ywCwHP/GAjljFFrbkuak6guTU9vnWm+pcwPzRoZ6
	vqHdx5Hb+4LmVZCZhs=
X-Received: by 2002:a53:ee12:0:b0:66c:707b:60eb with SMTP id 956f58d0204a3-66c72be077dmr3191221d50.23.1786818474512;
        Sat, 15 Aug 2026 11:27:54 -0700 (PDT)
Received: from daffodil.tailc06997.ts.net ([163.152.162.75])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c75c5dd24sm2598154d50.6.2026.08.15.11.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 11:27:53 -0700 (PDT)
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
Subject: [PATCH v2 1/3] iio: imu: adis16480: fix unprotected debugfs reads
Date: Sun, 16 Aug 2026 03:27:24 +0900
Message-ID: <20260815182726.11796-2-arkamondalofficial@gmail.com>
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

The firmware_revision and firmware_date file operations are open coded
and never call debugfs_file_get(), which debugfs_create_file_unsafe()
requires. debugfs_remove_recursive() therefore does not wait for a read
in progress, and unbind frees the iio_dev underneath it.

Use debugfs_create_file() instead.

Fixes: 9bf94f836e32 ("imu:adis16480: fix debugfs_simple_attr.cocci warnings")
Signed-off-by: Arka Mondal <arkamondalofficial@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---

Notes:
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

