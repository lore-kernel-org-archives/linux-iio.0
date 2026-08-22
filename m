Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C0331EC1
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385840; cv=none; b=fHyMPVx0YPaz4qGRb7I8ANVxtC5SU1amj3d5oLDxEOoCGihbrMGjSyKyvdtUH9TXYSWhX+7AEeFfkbtOiXAAVj/2wNe8/SCBiZclCnfPLxG9/3sBH5LSIz1hRcv9zWaPFXpm4iflb74BvPUqt68fYtHEVt8khAqYfJW3vEgvf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385840; c=relaxed/simple;
	bh=Uo6EX1JmseXrXlIfI8C3VQKVC+6rdjnNJDxKBsAYvQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eCthPztkmXd+krxaKmbSt8GAoiXqCCYPs1gx9sVljAduIz0fMphi8KMqLUa21rIThDfMeEWm+7hsBARZbfiksYssw2IEoKKhiuXEPwGnu+uHp3bd0kApFDJPGrDg+3zv+ta7QiNhjA5Nwlk1AEhLS7tk8yIx0vJa1dOYLbyvonw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwg5wdwG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwg5wdwG"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so3466939a12.2
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385831; x=1787990631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9AqQ4z6F96H3cgRC2zHe8aALXLXX38dahLcpxKr1ym8=;
        b=Wwg5wdwG4lXk1hG42qW4vL5UJBnfQvnvNb5x4eTu4aocVDtKSfR69mRaXtXVMAODJP
         fyj9SJcxEAld1onuy4I3D2gzavOZv+E7j7lY4knTWj2H0//zS1aERr5wXHgAG9m8jvF5
         nUE52GzQebjt8vmT9uxmu775Gs/F8Gyx0OkRdwJYIfIqi/kWcOUvivpWrcaku/wO786a
         W9KjJM6ElO6pTam5Ju1J8wxzlqmMSjYofJ4wOUT1CzRvv1mA3Tv3wqqlz9wJLmfeuMfx
         brtCVxBY8AjORyz2QlfjVxKRF601iGXCOx1ysZ5fLT1V4GOOKMi3YS1ShXUZrxNecWgx
         9BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385831; x=1787990631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9AqQ4z6F96H3cgRC2zHe8aALXLXX38dahLcpxKr1ym8=;
        b=O5ms0sM/cBNw66j8YUo3AiXzs4cKwXhX5dG4M9AlqhBnZGWh3VTMwQgcS+aphlL7wB
         +LoKdpOpt43UXYl/Wq1p5f3EpSvvhtY+jDRqtAmKRGzDN4CRfxoiEaiZt3Vo27QCD3nv
         ZGXikhiiBlX/IKGCcF9/g6wzZnfuN6qkgRXTKk7rv7usWeTQvA/aZyDv0zr/PbVzhI2U
         UOKnEm8kvLn+L3xmLjvdeYOt9gm/fnP7hHfknAlF+gGYdBIbd/CHLnZZF/gds9BIo3MZ
         3M9TX1UtzSaA6+c7rVj+VWYvNbnrZ1/m/9ZMZ+TiWb/l4uljUcNPgF2NfVo/CT+VcQ/g
         saHQ==
X-Gm-Message-State: AFuF++mGNYDwtmygf5tatSvT/MAFBBFZEYaGIkb0leFxhr+b2XGye3EM
	HDLK1z9kqyqAGttZyRp8yrTzZx+JauKr1Ra6JO1Ck7yF+G1oW9pgd/Ol
X-Gm-Gg: AR+sD11sD1Qth9kX5s5dWizRd/CkCPrc5sFi4JVApM4mzyXudIEhVrrlIb4HYlcn15f
	TegjALUR4Ibw2znJhpC2xtIK2dTeD5Q4n5fg1925jZx+grqBpeVAUz7IQ/RIrWH9R+Bvy9eL63n
	/eVw5mGMgIeyOtjkW7/JG3ZKO5jL1Vow3+2+eW77jlw3ks6l/vwHZmsWX/82oivc6T4YAGkqTwB
	tVkntHpi9XIOHnFiHr+SFxv6bcW8n6ETP9rKdjB71YbX4qePG/LvTgDilj8AZ4sOL1N2gXqv4Mn
	NWbtTK+bjPN6K8mKfaVBJhitXcZvCBlmYx/Xq9W4IDqKYiri8DOrJLI19Q9G9Z0f6CHR1bY8Xgu
	Df7EQo8wGBnC+uQAoijkui6doxDKAAWvkUyrbYFSFuLhc9uTdUWOOkFevzrVq68cCpqcpcZj9bJ
	w8oEN4KLdPN8OChNF1dyeJjL6l4V6zZSaQ1UM708Jma8gxuFZh7OI+tLfasRW9N+wXkD4LOvFa2
	+mWO+N5yMD10E6e+OwGiPegWv4XpURalgwYarXPU/a80RW9dv/P6vFbCtz2h/5lhiy+texCkQSY
	WwQZ7qxN7j4XEqTiw/P9KDZsqGkOEzclVSPM6ogMUHNiJebLiby5Xm5Bb4PGKrhHrvk3mxchXhJ
	VXTcs0JbGxiHzAdAwGnXR0C5DnPM8WFB1ntZS
X-Received: by 2002:a05:6402:548b:b0:697:f6b2:a94e with SMTP id 4fb4d7f45d1cf-6a582b9b9d0mr4704481a12.13.1787385831027;
        Sat, 22 Aug 2026 01:03:51 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:50 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:34 +0200
Subject: [PATCH 07/14] iio: temperature: mlx90635: sort headers
 alphabetically
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-7-ee31b124be11@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=754;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=Uo6EX1JmseXrXlIfI8C3VQKVC+6rdjnNJDxKBsAYvQ0=;
 b=NfK5kybZPlmfJje5KeyGm74Y8IDcKb8mqtnk+s1mmhdNhAwnu3rSi5TKCYzLp/dZfdq9G/XhO
 ujtDHKHvkvaBY2gdYILdSo9uwvbhsRv/A4FBelCdxjVgghvle2ddqny
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Sort the headers alphabetically to improve readability.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/mlx90635.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
index 0f31879a4f64..ecff00634271 100644
--- a/drivers/iio/temperature/mlx90635.c
+++ b/drivers/iio/temperature/mlx90635.c
@@ -16,8 +16,8 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
-#include <linux/module.h>
 #include <linux/math64.h>
+#include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>

-- 
2.55.0

