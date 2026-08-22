Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8483ACA71
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385836; cv=none; b=iuvjOaRb7Ye+C7RZkl1QbwGrp2cFPCWli9izj9x5ZLMwpDdzxyV2fx+ybVKJPBujkdILT8AUrvn6Sod5wjf/gzQVIQ3enovsZWpHxvL1dRkpP+OD1KJXlxUu7gP5cZES50e1uVUiuRQ/8IlHGU9jXgEo6F0YEb60oEigJtE1krk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385836; c=relaxed/simple;
	bh=Num4DJ1UYdkKWLpDSIlXSX7SlP1UbOziIzc+Rd513Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PBcT8z2sFNe/kzbCagSxFpGL0GsaLQ6gLfNSNinOJoNIkBEOCFycPJBZR/SWhTEMLE56iPmAy5rxqCFbyP1scQBp0hTJLTyr0becRJlRioet0XL8L2NFeB3vDZhKh8NWKUnHUThrlOMgLiHgR+n5h1WkC6lt2W1ErbTZtXe7CH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc0Kn3xJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc0Kn3xJ"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so3664112a12.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385832; x=1787990632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FxvRiCLtOo4IZ8vGI2ipKWIjHSo4D1ja22OGDCWWq+o=;
        b=mc0Kn3xJCe+Wsb3YqOuziSfCyRIAjE2iTStNmn0yn+87p43YFXGOvQ3kSd/lTHd28v
         2Y9djA8ImLJgWewu6bBDuZ+aDBnkZ5pKna3V0X39XHl1uWON9bYJqdm4ikeX5fm+JMuD
         GHMD4wr3GFgv8TScu5QxDSxpN0Lbd3T8jyz7KPMkfkQmVzeYrOEkR+UkHqonAJEkf9EV
         9SAVWs9mfLKHs4xPImST0uUlSX3PpKaOuSChCIrmq92WvQhm6oUg3/biYaOv39lmqFW/
         h6SLpre5GlCwm9BsmmNINx7+PTjTsw1NUrQYFaZ++6Q/MNi3Ew3NMiIjnrh7AUZOX9Ox
         qxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385832; x=1787990632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FxvRiCLtOo4IZ8vGI2ipKWIjHSo4D1ja22OGDCWWq+o=;
        b=sejBI2r9eUPxX5E6r2TF9LnSpI4VN4eDyYkXAQk8hZGioKk3GnpKrXUY9PBtS85yxz
         7ylNQUayTD8nRdedq3R/rI8HG3pcdG6FClbQUFTCrZZEvDKJm7ujUwfzxlY8w3dOQ+UK
         QkUQ5/S/woC1iW6F7Wa0NBW4nmLMf4VVIhYJSi+hXBZnDzv+0CC+1hafVT+fK+NvsyHN
         SynjRmocD2LxBRg8LRQ00xioBtu2MUzIfQ9M7ioCpUyzgVGlIsf55zU9JKm0SoiOgNYK
         VMpxCV+vr1nOe6w1nOOrqmk5Gmv9CPhvwp95SPv5ua6poQ7f6EhWC7D9Juu5pG25XOvO
         VmsA==
X-Gm-Message-State: AFuF++knJxbt9sDeaLMw+9GxzMyyXnuKyz0bPxh5jx2a5Od9RTdGH0fH
	N8LihNpYcp5g5x6h0HqSCreJ4a1ozu0Z81tA1LASHn4dQ0zX3qlti9/F
X-Gm-Gg: AR+sD13ZVGZD5O95D/DHgZ5bPs5XZ1YB+NF3bY2aKAV57DvqtuegLGdr+a6Ydx6t9Cl
	gZcDWJXc1952gUT289WTBA4TMG/jgU9E2qS2yL6XvS8G813GV2oq83nLzNcHBWHZwzhTMsdtH8Q
	ZaGUFBDIo1Lu8B81jveDORar/4tGKuAQgvVXqLL3pURmw2oOPkutCKNKNO4ucg22TcTQjQEgbiq
	1NFpwObTM6xVC7It9vXPdrvJHIRXEcn4lWq67LbJMVYlMjSf1JThF7o4WE3cO1bcoiwpECgQtaX
	d5/wtXCUwCc3W5QO4w5x0RTyqdtHBiWrkdmdCLYDsjCdYR55EmuqHFl6jBUzOdsfIcdlF+ZTDyN
	cBmyhknHNJrfhN6lK/wgYMoUdBX4mwiwoTROiCUrAyo0oogm09+YZxjET4NnIh1BD+CmoaQM2uY
	Q+I1TQOPV8q9U+AAYa/Und0kgDyNzq7qzPdKcF+3nyqE+LSA5yJoDtuivY7IUPSpzberxQAC+5l
	Kz4Ew4Gz2E/MNbEccWExQm9s1/NBlFnFSTjUvPdt2+7S7VzTPINBVUpNuzjI1Xzv2+rl5qXqpmu
	wU8uUSxOfRNxuE7Kz+fmXcMzw/056LoPGYnU0Wlsr9f5xa4cIfw46UhkmG0qsHLSj0ggprmzq7y
	K0fNpmdlytbLUdc8jieuG5ySMNQ==
X-Received: by 2002:a05:6402:1ecb:b0:6a0:dda3:83db with SMTP id 4fb4d7f45d1cf-6a42eec0421mr12710976a12.0.1787385831972;
        Sat, 22 Aug 2026 01:03:51 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:51 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:35 +0200
Subject: [PATCH 08/14] iio: temperature: mlx90635: make headers conform to
 IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-8-ee31b124be11@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=1468;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=Num4DJ1UYdkKWLpDSIlXSX7SlP1UbOziIzc+Rd513Fc=;
 b=lqsOkEIIeEALEEb0nE5LkpESd5kF5YD03r9vZTqrDwCo0MJzomJABdbh+aCGEsFNJJJLaRSUn
 IkXKhMBQmNoC2hNvYKJt5GiqFLoRA3HRyQZVja0R5XLemQyniGqMSOw
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header and add the missing headers to
enforce IWYU.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/bits.h>: for GENMASK() and BIT() macros
- <linux/mutex.h>: for struct mutex and mutex_lock/unlock
- <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
Removed:
- <linux/kernel.h>: catch-all header no longer needed
---
 drivers/iio/temperature/mlx90635.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
index ecff00634271..b3fa2c8f566a 100644
--- a/drivers/iio/temperature/mlx90635.c
+++ b/drivers/iio/temperature/mlx90635.c
@@ -6,7 +6,10 @@
  *
  * Driver for the Melexis MLX90635 I2C 16-bit IR thermopile sensor
  */
+
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -14,13 +17,14 @@
 #include <linux/i2c.h>
 #include <linux/iopoll.h>
 #include <linux/jiffies.h>
-#include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 

-- 
2.55.0

