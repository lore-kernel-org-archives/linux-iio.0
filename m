Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875FB38A73A
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315223; cv=none; b=egBEkUrf6qwHAj3I0/ONys6wrSOoqODjcplr4jVvimMRrZryJKMzeqXyYT2KpIAx9wkixQ8DuwjCBQpHNiybEDYSmdWfLylic2pLHUVYPS/S5m+LnOM284fWz2QkHYGtgx4z1jjKxrb0rHNMzi8taPdZDXULckq/cGOR7Af6sjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315223; c=relaxed/simple;
	bh=5D0Jeg8L2jdESb77aS2oqSGnOTtEt/jAvaVQVWtUUcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LEb6FAevpQRfafWQkFdfNOgLU4+UCh1vPE+Zxv6qiHdp/jQ/mbCdbOoRhV4zf5OEFWTEtEVfXpaWvt8mnvAb5IpPP2hHHW20RwNBDJjLzcjGqgA9ASyUyIU66e3ilFDQyD5peVqt8WmUiZrC0rrj74uv+N9ylYl4/Rm8aUu76L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh1PjizL; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh1PjizL"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2c156c4a9efso3656622eec.1
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 01:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778315221; x=1778920021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi8OA0S5v0cDkuBo5x3SA05u+r2nlwG9R/S0G51f9EQ=;
        b=mh1PjizLlHeIb7jQTW9dGTi4pcmdEon7aGWfutoauaqLS9PHRTrfQ9wu65IwT/WNjL
         4y5i5V37SY0OFptuNsDzGLy4wBtCYQ35OYByJqj+AsBxeqmqCphq6C1V/ytpEtbZAVVv
         KkhxBi/+VHvwIbUrhR/56VHNn13b/wm7bPdkgFQYhEJWxR144X5etpsn7W0zeGOAc0MU
         1qDBJ4yufmJEVUyrMCexF9rwU+5rJ5NAMWt9Y4/ve0NTNkWENsD7lByvdQSuIIenGDqN
         Ki749QvRSoJk1q0eQk1JsQkgYVvRuWLpmR7XgxbAYm7L2wDWHzLoslG1Rhvq9HCWBkER
         BWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778315221; x=1778920021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi8OA0S5v0cDkuBo5x3SA05u+r2nlwG9R/S0G51f9EQ=;
        b=G+Ix99NfIN+Y+hr+iaAAu9lDXOU7SSQE2u5frhkQHAsI2y5uqkGo9XvVViqcY0odL3
         lr2i292Z92Tm2yRe+uwyIuhtpoqQ8YNePmuhQD+OHwfb1Y96KHLsLTp9oQ3FmqYt9BqG
         ia9hx8IYJitaQJr4yQWhJGjLa/rtFJfBv8MnnJDXBVJYgw93brMJMrd3bNTP8Sv50u+1
         42m3uOYAl5RfLi+xIUdfLAXBTcnTtvw2nEhUpDgSY/CfNENkC74QtG7K+56Nq1RVyOaI
         c8mmKA0cUyGDtix830ZXZFn2oV/AYJfyXtlionkq/cAWoarU0YGSjS4eK3S0CLi03czn
         gcVg==
X-Gm-Message-State: AOJu0Yw1S80wuMrgpL4Y2/LTF1RUIEpeJslNEiO2C8B+zGPXIKukVLbO
	hcA31eP5iLs7evr3HXKIqs7JbmjoVEcIpocoHHqVu1XS8CxTEqLqiwY/X1Nv60KL
X-Gm-Gg: Acq92OEEpArXj6VkqKwj2ZfEtYTwH+UInWIB4xIzC9Sa0ZAU3mRF5znTfIFXyji9/Fr
	NFmbP1srhXt4OUILdXBKSQXDMC3gXWH56Zek0Df060BuGyCDqDrs5EsyffNDuwrUqdIZVoZErBP
	Jl/vD3kK4AGN26A1hvF0AfEk63D0aEXJ2e430wpOB0rkFttRh23EHNlwaG+zNecNPynt3fC2UZ9
	lTMtCDA6Ds3+Tc33r0Ayl0U6nFOg1PKbap6Wx2WlSUP6Ih6x6CggDW9wkxrTdib6RlP+BUETufX
	EUKvyETTgc9Zzq44Efva9R3PzY7uGJwXqIAa0eJdHGmn7bLdzevThdMdwy3F6oxBS0ArL5RmrfF
	D/KcukvLfYdqM3pEBP863BLePXBmqYNnzwLWRQtjfh7RAALN7vZ1HclRUwzSyA/qeU6Lzf/pTDQ
	vIvYPNf/1+tsdPGK8vc+boeHQ9eel36Iy4pcUGQAd9x6YSZ/Gjc4pNgZtjBgdgwE/1RA==
X-Received: by 2002:a05:7300:ec01:b0:2e1:e3e6:2909 with SMTP id 5a478bee46e88-2f54dc8dfdcmr7178290eec.9.1778315221164;
        Sat, 09 May 2026 01:27:01 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847502fsm6522685eec.14.2026.05.09.01.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 01:27:00 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] staging: iio: addac: adt7316: check SPI write errors in probe
Date: Sat,  9 May 2026 08:26:36 +0000
Message-Id: <20260509082636.85114-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe function issues three SPI writes to switch the device
from the default I2C protocol to SPI protocol, but ignores their
return values.

Add error checking and emit a warning if any of these writes fail,
to improve error visibility without changing existing behavior.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/iio/addac/adt7316-spi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index f91325d11394..25b7772bd05f 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -98,6 +98,7 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 		.multi_read = adt7316_spi_multi_read,
 		.multi_write = adt7316_spi_multi_write,
 	};
+	int i, ret;
 
 	/* don't exceed max specified SPI CLK frequency */
 	if (spi_dev->max_speed_hz > ADT7316_SPI_MAX_FREQ_HZ) {
@@ -107,9 +108,11 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 	}
 
 	/* switch from default I2C protocol to SPI protocol */
-	adt7316_spi_write(spi_dev, 0, 0);
-	adt7316_spi_write(spi_dev, 0, 0);
-	adt7316_spi_write(spi_dev, 0, 0);
+	for (i = 0; i < 3; i++) {
+		ret = adt7316_spi_write(spi_dev, 0, 0);
+		if (ret)
+			dev_warn(&spi_dev->dev, "SPI init write %d failed: %d\n", i, ret);
+	}
 
 	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias);
 }
-- 
2.34.1

