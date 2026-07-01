Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826EF192D8A
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919265; cv=none; b=PjG1HwTCjDzY6D0XzvhWzdwoEq/HBawTXxlRn1GnniCinaRGA5JOAaY4DfSke7wAxVpSwg8LEx/UEQOUu/rIBz4R1HCWrd/fpl4vmpFBqSxSVGFk90t+vdbL/fKeNs1Sdlq0n74rD3Vs2fkf+sAfr+OP8Wz9m/tKfq9rLsvVElE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919265; c=relaxed/simple;
	bh=ImeeGYvfBmwwdtRYM3UTpOEo3+31ExYXTG0uuYq6wFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a9B6Lz+4ddRhfFaz7ETB04o1ZB5wp74zod0IQ8TrQ3285npfDGPRKscCIui2CPWZMbpVZyQ9LWaAhg8Nrcykwb9lAN40JDT9wGbHOzukooSEn2o+bbvUzAf4lYIuBW3hkCQ6IFD3vdAhEfYeIilBeXFriG+jJwePo5Qdtcd7I88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORGEph6b; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORGEph6b"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30c5fcfc947so90923eec.2
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782919264; x=1783524064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OtSFW5CXFXNF1fKrfWvLYf5SjgLc6mHCqOf2ueXia7c=;
        b=ORGEph6bljDv2lacQbOTYyI9CnjHFxcHnoqnZIBZ8MaS4MbIxgL2ENkAT3ZUGTcgDy
         2OBgEnBsAW7wr+0Km+HPvv6pm1m2k51N3JXAeNSErarCEoRJJDOQ1rBva99LLozKVA8b
         RuAqapZOb0VfLjvDBM1wotYHfeaVepDMvdlLXfmNatJPUs/u+9I9oe0WzJoCy04qPvmt
         xQRw9JvxjHSZc7Gnu66yklWWgZKDWLUr/vN6XdUbUlj8I4YLAIzfD5POgCTo3FxNwgei
         c6Oygo3fTQbUyJ5d5Mb+Xq2hmu6J5APjh6vVbp3riUFX5eVhwLobUS0UKX6HkqJld6Qf
         +7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782919264; x=1783524064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OtSFW5CXFXNF1fKrfWvLYf5SjgLc6mHCqOf2ueXia7c=;
        b=bz993Mh+h4m68UGTa9t9cupZrPjGxtd8s+HzpsJEDFqGTznvGwTk8i3S37x4TqEeK/
         hk9bogpVSJRJxgLvrhM6LZ0rWoBxFvn1z5rm2cL3U8mtcNUuJzljXl4NZ4gb2QUzF/0C
         AWnu27DL6MixtkC9NHol9Cka4vnIkJ86+loVXtnRFoTYbCVAxO7TYZpYvcbk2iuH9j27
         SxujOI1qjtHo32F3OjVekgYWYlqSRb2oP0ZQAyS/2Nw4UHs7A3I5hEqvQgPNhKZhECbT
         BLG9aLhOReluZxeV0rE/WTXV0dix0ppqYPZRmA1x9TMlBH7RzEl8IFx/kmAKscKlvoVY
         nZWg==
X-Forwarded-Encrypted: i=1; AHgh+Rqe5ygbKcfwdq5snPIsk8i1X5xbXAFTcxXQD6lcWHfBXP+ASf+SXDkdz7Mea7CMx0YnKm2e62lm0so=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJM/WB8IIWJuhree6VrK9cjF6qBpeNAErrImFVG0+5O6ldbmf
	57qeOr/pec2um5ZU6quNx3txMwfK7vsUUgBJdPF8hzDCDoxQGxejKJ6T
X-Gm-Gg: AfdE7cmp3BldfzfDtZO5TVig6+ij2vCVPC7YZM3laHRu8OKH3T+Tju1Xzbc7idScGSX
	JndZoKBWIePFp9NBM5QQWvpwyBrgTZbgmW2mGtnxhABNCXuoeYHbNwgrxQjDtTGJslw5+6nlziR
	415fVpKXF3tTwGeYks4NIfObyurP2d3ID0aGWYiUXYSAlbKaHWSCjn7dh/03J6tyq07tJNHkOFM
	uOEd8Tj8Qx8305lc2F1cNxXxdpEeSc+9dKiaCX8IjNjpsGeodY/GEtWq7hiaMp8xwVxBbN7NYQy
	6gf+p3geUaNcyH4b0z7HI50HyA9eaqvmxXE+Qs6kcSPFadmYKWt+yFQ+Mxulqc/YGrX4DUHTf4x
	uY3//W4jI2i+MXr93SiMd1/ulEi/sx4VpVVtnoXz6tmrBshRJLv8rd3ZdqU6TyjOsqhW+pnrMJD
	6EPTLPAvlchaKDY/H+Dug5s2AI0Ge4QmnUVmiJMO3frmu+F7qDjkPbpl+ZjSwEr8F/X73+w7he3
	pO+iSHX+zKDXROfWzbEHUzCgKLMzmaG6EbB6XLibnK7fEujn0ONaqgrJyrA38pcHEBs6z0+1RYb
	wCNX0e8F9BW3mligZTbJFcBD5bLuLjZxW16w8eTqTJ1d5IAQ
X-Received: by 2002:a05:7300:748c:b0:304:e327:aef8 with SMTP id 5a478bee46e88-30eff04ccb0mr1264157eec.2.1782919263472;
        Wed, 01 Jul 2026 08:21:03 -0700 (PDT)
Received: from midnightair ([2401:4900:1c94:62e8:bc10:77d0:2fda:415d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee327cea7sm24904275eec.31.2026.07.01.08.21.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 08:21:03 -0700 (PDT)
From: Anas Khan <anxkhn28@gmail.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anas Khan <anxkhn28@gmail.com>
Subject: [PATCH] iio: imu: adis16480: fix 'temprature' typo in comment
Date: Wed,  1 Jul 2026 20:50:54 +0530
Message-ID: <20260701152054.22748-1-anxkhn28@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the spelling of "temperature" in the comment.

Signed-off-by: Anas Khan <anxkhn28@gmail.com>
---
 drivers/iio/imu/adis16480.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 543d5c4bfb11..36f4eec899d0 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -1468,7 +1468,7 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 			 * We need to perform the padding to have the buffer
 			 * elements naturally aligned in case there are any
 			 * 32-bit storage size channels enabled which are added
-			 * in the buffer after the temprature data. In case
+			 * in the buffer after the temperature data. In case
 			 * there is no data being added after the temperature
 			 * data, the padding is harmless.
 			 */
-- 
2.54.0

