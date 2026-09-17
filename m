Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E799950AC1C
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650072; cv=none; b=NHTusSSnOWsM251dyr3R4J56KE9wUW7PB23HCWk0wj2zBmULCE8a4wPsZOFOvs5n+BQLP0cwEWTvrKWlz0A1C5JOjF7kV9+/Gqjtx2Qmww4zOfm3vYjfshVs+OpWc/H6JwK1+OeEPlIa+wyyGlgChdmS4RiFLsO/KJvN4ss27IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650072; c=relaxed/simple;
	bh=vZ6fA7X/Ujep4p6pROxA6vhNUz3bOVdFITdBs3jOIEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FosWpEQgIpho7O5bfvWJCWnjf0mG4RbO/ox8tGDlIDyz+lhiIBBdzcoD3alNEApL7F31tDJV+qx4s20AeNPo5Ktwgydzsk9x2jdSlrPj3NHyKW+CKFBC+lyBRMyarLZTc2RTHfTLN5MSCWi8CLyU6gEtL48RFj3PeZvkM/X0hLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7UfEOOv; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7UfEOOv"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c3ea1f6so416094f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789650059; x=1790254859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNGTP0eIfCOVthvscWL2P3zVM+9TYAbEJ3MaBnL5i7Q=;
        b=I7UfEOOvAQKtn/9oMKLphygi5BQsdAjZm2x5tthGrF0l5/se+N4Q9dV+kf3ij01KVI
         yvALCGt0ib1d6MG8wOhs0Uv52QGyrnEfmDmK215Wx2mrYbBYUisOfe+/UWcwvHy+cjp3
         ZCZRVCelgxkBffZ/uzgSoSsn0gQenQKlNqVkT3f48WRCZsiGMAFi2sjTOCZY/9nVadOr
         E2Q+UKslyu4yQ7WEmqQUV0zV1dot1Z2QWGy+LvKQNg9J+TgYR+/R8bBi7PmHwJfJA816
         BJrqnovgzE7GkfkHjIKKk7f1ra3a9hBVVy3DSY+flGHDJvinxiowCvGtS+11MDHZMf45
         Cefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789650059; x=1790254859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNGTP0eIfCOVthvscWL2P3zVM+9TYAbEJ3MaBnL5i7Q=;
        b=ERReOMCyCwgUZaTZ6kD2nz2X5bbmVKW7hqoR4jko9ND5U3J6qL2Wf70GRy9GGHwu45
         mWqXSmCcMsLSnNymAHf6djp3mVOgnW9AZ37cNDDi8oYz1OX4VVUXWrOM1Re6TmAkoJ3f
         5ghRjkcypgjZnKMiEkxPOO9YmDTDokx/+cfsqmv4Vy4n3mNQGh1UDK1z5bVYp+M3DM/C
         MaGfh9Qj7JCIH5GSmhR+JAizpaNH2QZsUBNQurYuRpPhMx2vzN3PRD5+bZWrQyADnxCf
         lSz4ErNb/xB25UTIU6d1l5VsIh3GsvCGLYT/ZiFktEOAok7/NGpDTOpDRqS8u97oanju
         8Dbg==
X-Gm-Message-State: AFuF++lpuPadlKgGQC3t9Fj2DJs0Ht8Z8NKmSbn9KtpDy0z3KaZag6Ts
	SEhtuZ2b5Uer3XDSVun3dwX99v3e5za2qoQdKYUluZYLdDzASvy/ziQf
X-Gm-Gg: AYBFou1NbGxe1lqck/4F4vBQZZk9+RteDnQmh3sL91Q3gZqr4gcjuekyRr2DLVTzUBD
	IS5OCu5gzK392CDWfI02H48T5Hsv904FOYSPjs4bmvUCL7IDCRufUtoBFvZXTv6mGsUCv3H39/F
	8gmVLVwnx9WSlQlcAsAS/utVCGuZVCquYrP0vCPnXSWVZHMlu3KVENhqE8MIIuXlGJMQZ9E2MbV
	82FBJNcVko1YgT4DMQkxPNin8KlH61fkAH5mGhaIpiCsgTezWElWiQz+PR+/Zzqyn2q2llWsVgo
	tPLxMi/375/NH4iAeYCxHBsJA0YGHr4GdojVg/zXDpYmZcGtOSAt//Z4ekyRHxe4y7tp80OmrQv
	TwcofVoM6usz4v5CokD07cPnTh//Sxw+CZ4JDqfN/Q/Mdv34yCJlKKtjPu7Ie+yhWj+PqoZABt2
	dfBcj0kAPq23kjaO0XWvPDAUBk0Yp/n1UVKpSd4Y9TXpuouMQ+tyo13A3uJP4LPvqevgVCFYgZ9
	PMjuBRsqVuS
X-Received: by 2002:a05:6000:41e3:b0:487:62d:37dc with SMTP id ffacd0b85a97d-4870cf36d6amr8453311f8f.32.1789650058775;
        Thu, 17 Sep 2026 06:00:58 -0700 (PDT)
Received: from localhost.localdomain ([196.235.229.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf37e69sm15462608f8f.29.2026.09.17.06.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:00:58 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: proximity: isl29501: Fix return type of isl29501_register_write
Date: Thu, 17 Sep 2026 14:00:52 +0100
Message-ID: <20260917130052.636055-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isl29501_register_write() was returning a u32 instead of an int.
Since the function returns negative error codes (such as -ERANGE or
return values from i2c_smbus_write_byte_data()), returning an unsigned
integer type prevents callers from correctly checking for negative error
conditions.

Fix this by changing the function return type from u32 to int.

This was found through manual code review.

Fixes: 1c28799257bc ("iio: light: isl29501: Add support for the ISL29501 ToF sensor.")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/proximity/isl29501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index 95fb7238f678..a98a9975323c 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -226,7 +226,7 @@ static int isl29501_register_read(struct isl29501_private *isl29501,
 	return ret;
 }
 
-static u32 isl29501_register_write(struct isl29501_private *isl29501,
+static int isl29501_register_write(struct isl29501_private *isl29501,
 				   enum isl29501_register_name name,
 				   u32 value)
 {
-- 
2.43.0

