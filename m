Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5E3502BA
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973331; cv=none; b=ndIIwqc++VLM5XG1b9+BSOpfVdcjIyoYbgIaiVzatOKhUDgghptzFXfT7M4hg0Z6EuCA/o1XqyQtHbOTBidTsSyD4ZnSdl+tIOo+dDU4OIMRJq3K+pS2U/U1Tc86SMdga641EA33fBHA68TzsVYRCkfjh7citWXjHArleDQuY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973331; c=relaxed/simple;
	bh=87sS0UYgorWoX8zJjAzH+m8FHvNWIjW0Sr46L/Z9XdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeQhK9TCwIY9KTeNG45pZ9VR/Ffihvf/dOP0LMsfHwR2BocXT2GvyOrrPXjVsZxU7QQdO9fSto2tMag1goxGXC0OznaKUjhAUPD871ptEl+3l9BwvH+uW1ttXH2TbdNWdybr+AJ8NcVP+Zs0HwWMzZ8fob8WWMxSUm6+Phb/GYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIC+aRbe; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIC+aRbe"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79863ab8478so7623227b3.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 14:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771973329; x=1772578129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjFCc9fUHwXOM0/lOlNHausj+/UuScSKHK981LKSloc=;
        b=bIC+aRbery+ZhDmzE7VKvnRCzlDUry+tvKnWWLEdqj1SyGYW6k8J5eVlsQ2jqIakAI
         T7+Y5mjr0kFtPCNv3UB/ew4xV6nID1svf7Oewl914m43EZ0BCmrxLi/X7LO+T87kuurl
         eqMO6+enL3gfU9H39IJ8OWHRc29Pi29A/a36AZ5ts7bd9zWqq7cLK8yJDeDKQwQYLCxc
         ziy4WDhVeI6yuMWWZ8xZGzLI1FfvBdLmqWQagpEBrx4TH3ACGnExjpnhPte9kTE96/6o
         n7lcHzL7AQwz74BWIU9Tribdq6u5SrvvpD9+WqPUWdvbeDHok9K8uQpr80RK5AYss8gj
         8clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771973329; x=1772578129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PjFCc9fUHwXOM0/lOlNHausj+/UuScSKHK981LKSloc=;
        b=Kteu7KLWtTaoJEL7FYdosWErrdyBI/meI2QXdFcRSbmh/BjDK0iIqdJKazkdrs1DVV
         IHVUCorUWrxhBsW6dOW3dU1z9qPY8tHxPTHTI7ngw3v3PmCujHzuF9BhLruGi7f+rGt6
         h49ZbjREGal0kEGTXuxs+YCNVNwTQRs7H4evh4jehFUZ6DKIVocztQOVBj9sCYKC26Vt
         oTcwdP5IqvZaAKUkW3+Rx8IIqax1odSdRbT+qdhj7P9el3/LzhJKyyR9awypvxtcaJ8/
         HqdXXoWtSDQDp8opNoCq6/B2VK2+296nBqyCn9UQ2edOSLiLXd41zbQc96WvLZDhYoAU
         IpGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTa5jSff6+CpA/oNLS1+XguIyA6xgkgvurinuuO3K2Lj9KUhIInNTuRoq1jqQLCpg2as7nGrsKzvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoEiWHrCx7Td7Db9TaSjg5qPycbUFvbZNrbljhGUojtnfc4SYI
	JCm/E4lIQQcyhy0AoJss1ppnh85slnvjGHH9XD2bdXlIX0zP58hj0AeO
X-Gm-Gg: ATEYQzy90A+kQIYx8FqjGDzVMfRZWGRUfdftx89iWrwpnJRJiAqAU2350m2qr0Kex4o
	rCi9cbSceArogkYXU2QI/TMMCU5y+Sm94p1FBozESV8pYahuekojxlGhN2nAb3YpmD8xD3rqJl/
	Uc4XgV0u5PwnGNU8ADsTRLssUOY0ECxxynylQxA00PZmbfo5zkd0zOnZO+dDHpo9UoQAdXg6PMg
	MfLXyn/2boUtwgcZyM6EBDxDy8bUZg3AXJVIHZer9hUvwpIdyL+zZPsa11x5In2+mkXHxamvyBJ
	uWMVL6Jn6W3aQJ3RYNgNJ0VHEcg/1oVlV00+gJ/nz+Z/M8pXryFU/S/ATrRjuVF/01m515C2/R3
	+VBEgeCtrLidCjK0GlVLXKGMt994J3H/ml2Qja12Ef8wtg/IbnFzcQwTmj/cNiUpk/CegxV9YMd
	EHVawqIwEwxcXNgzxZupRnDWOXqGbP97KxR39HCXM2ebAilCEnc5co+R/xy6t4fR+kdfUA5AJP5
	vE7DrI9QBtthkjhUd5ivzQc
X-Received: by 2002:a05:690c:102:b0:798:6042:12d6 with SMTP id 00721157ae682-798604218f9mr25224017b3.60.1771973329118;
        Tue, 24 Feb 2026 14:48:49 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd88efcsm48838757b3.24.2026.02.24.14.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 14:48:48 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: linusw@kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v3 4/4] iio: gyro: mpu3050: Fix out-of-sequence free_irq()
Date: Tue, 24 Feb 2026 16:48:18 -0600
Message-ID: <20260224224818.2452675-5-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224224818.2452675-1-ethantidmore06@gmail.com>
References: <20260224224818.2452675-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The triggered buffer is initialized before the IRQ is requested. The
removal path currently calls  iio_triggered_buffer_cleanup() before 
free_irq(). This violates the expected LIFO. 

Place free_irq() in correct location.

Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v3: 
- Clarify patch purpose
v2:
- Patch added to series.

 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index b590cf6709b4..f29c9ce63029 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1270,9 +1270,9 @@ void mpu3050_common_remove(struct device *dev)
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-	iio_triggered_buffer_cleanup(indio_dev);
 	if (mpu3050->irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
+	iio_triggered_buffer_cleanup(indio_dev);
 	mpu3050_power_down(mpu3050);
 }
 
-- 
2.53.0

