Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C749A3C9;
	Fri, 25 Sep 2026 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340259; cv=none; b=dtq955ZLsB9u/dspBIQWSAqTpe/+fmooc12XPoKExnsuPnFhwqZLVy0epQfVtBprAxvh5pGNsoBfhNBI/kJbVr2bvPsMvrkqCkJQiL4WhhM8DQ6fSe5U865jRDFFnES6jkmf9lcrEddApSImA50l6XtAl9EPzrv8CHTPy0DY2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340259; c=relaxed/simple;
	bh=7gGepym9Nt78Y2GzYyl6x8thOwG/U605E3iXWdhkEGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D6ZwR8cCFRQUeVelstDuZjUdpYVT7zggMSymQuN0EojHuEzjvmSUk8xF0/EsvjmYH9otUZeO1udddoacdLDPPtbbBClAeMBqOe5obnC6SO5Bk82y6g1ED2Xm4m/CkEh1oQFtbumIkr71pR4CZj1vSy2gMogdzvkfYiz9P5dlOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gzoKFuDG; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gzoKFuDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=X/
	wE1FFMCh0XOD9Smn2j8a2OeFJ10xoeTV108niQFFM=; b=gzoKFuDGt66FM6PAMq
	BVlGQAlHbGIwDS5+7tlsAKUmmk1p8uvcCFkOzlQ6ZspY3QaEWOIut355/WBELe/m
	O5dNQ3s+s4FdsWipTn3jfz7uoGVfddS8ZcLuTEj3TjjgD/kXrt/DlwVbDE8wJ5Ym
	moTHGqIGFs1yfZLZcZrOH0wnk=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3l8p2bLZqMEjpBA--.27791S2;
	Fri, 25 Sep 2026 20:43:35 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Lucas Stankus <lucas.p.stankus@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Linus Walleij <linusw@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 0/4] iio: accel: reject SPI devices without match data
Date: Fri, 25 Sep 2026 20:43:27 +0800
Message-Id: <20260925124332.2090895-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3l8p2bLZqMEjpBA--.27791S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4fJF4xGr15KF17ZF15CFg_yoWDtwb_uw
	n2yr97Xa4Fy34DGF15Xw12vryrC392gFWkAr40ya1SqrW3Zr98AFWvvr4kA3yj9FWqvanx
	u3WrZw4Fvwn2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtHq2DUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BeAumq2bHfpqwAA3Y

SPI driver_override can bind a device to a driver without a matching OF
entry or SPI device ID. In that case, spi_get_device_match_data() returns
NULL.

The ADXL313, ADXL372, ADXL380, and SCA3000 SPI probe paths assume that the
returned chip information is present and later dereference it. Reject
devices without match data before the pointer is used, following the
handling added to the AD5686 bus frontends by commit 572a00852635 ("iio:
dac: ad5686: missing NULL check on match data").

Each patch fixes one driver and can be applied independently.

Jiale Yao (4):
  iio: accel: adxl313: reject devices without match data
  iio: accel: adxl372: reject devices without match data
  iio: accel: adxl380: reject devices without match data
  iio: accel: sca3000: reject devices without match data

 drivers/iio/accel/adxl313_spi.c | 2 ++
 drivers/iio/accel/adxl372_spi.c | 2 ++
 drivers/iio/accel/adxl380_spi.c | 2 ++
 drivers/iio/accel/sca3000.c     | 2 ++
 4 files changed, 8 insertions(+)

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.34.1

