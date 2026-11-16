Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793855;
	b=ipaG73/q7EFYKrwLf3IP3GKSNfrVCRAivWi4wks8iEOoO1EMFnuij/oFiOC+2uNy0Muz
	 EnnlJ9KvfVPnCxJAe+tZBdRCwEqEk8HLhizLogn9Qt+qTlsJFw/XW0NrHBBQOSNiLQXSJ
	 LIMYitei4aF9FjcTfYNPat9FTOXrB6dWy6bW1PNmGP7jt6opX/mKZQ32ynY3iOzFW1Vdd
	 BgfAJFkQJn+BVYN1pZZvesXihh8bpogaIOO1mTMbeYVPUE+qrpm3Q4cwgGqwYwkoWp41I
	 3hXZxq1tWAAuc7D85TlrwOXpOQJZgd8vjuvfqCL4ZE9EZr2tdsr/t49gXhfHqRuKgtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Zy8xX3wnGNAe9qrGMuo34icb5PHWEWy+KClMWWCPS1s=;
	b=Dx93UHEMxleHOavKW9/6/lK2iU67KrcZJzoLbecVmJVNkc6xQY+pfOrTPfLrAk0EYbsN
	 0OpuSR8fG+zx28AwPznBJ02HOBqEC0uABgsZzFeh0X5sopq/hV/4oXVeoRTeGmAy9jH/t
	 JPSaVGpSXNG1+LKyGyiiZ7SMylARawXSiJTFG62x8iygcpFtN6Xd7Q0u1/iUafOQLrnE+
	 TsSzPozNCDYkJZa8J0rb2Ver8wx3al/AhJ37047psKFz2HSZs8AXb44aUjQSiyeSbqa6d
	 dpqQ0EzCCu+4RdH0gDB74+OH/cbnCZ0IOPAbV1AJYa3tWfKYQgH72uX/mPi+OPCz/Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TXOzOC/T";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D260A3837;
	Mon, 16 Nov 2026 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXOzOC/T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18E11F01821;
	Mon, 16 Nov 2026 01:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793855;
	bh=Zy8xX3wnGNAe9qrGMuo34icb5PHWEWy+KClMWWCPS1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TXOzOC/T/FwfH4XmLGLFFmkjrexPX+jehNW64vvRV2dI6CF/pyndBKf/NQ3BhwB+m
	 jqBVoadY3OMlxnjgIywnbCdxjGzbnJG5Oj4DFoFy6RQszLXS1X64e7XBok5XzqWalE
	 PxcDuMIQqf7yzjp0LBIoGwwY3dSd2f96OVWVAi0zs+3/Z5HmdZ4fdSxxTYKo2Ktla9
	 +oxJHdMg+kJwraxGCChmz8kVBSKHRcvVshg9c7c8fwlUdk3u6UGxN1Qh1wq/wIpMDA
	 UOxiLHp+7L2SUZl4xHUDLMyxDPJjsGDVi8uQgTUt6aFqvCwLxvLpJ3nx/9z5UEbsnz
	 Yt+JDNGIzcrkQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	Gustavo Silva <gustavograzs@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Esben Haabendal <esben@geanix.com>,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 31/35] iio: accel: adxl372: use default_trigger
Date: Mon, 16 Nov 2026 01:48:19 +0000
Message-ID: <20261116014823.3132576-32-jic23@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116014823.3132576-1-jic23@kernel.org>
References: <20261116014823.3132576-1-jic23@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Set indio_dev->default_trigger rather than taking a reference to the
trigger in probe(). The IIO core now takes the reference during
iio_device_register(), so it is not leaked if probe() fails after
the trigger is set up. Note that this driver doesn't have that leak
so this is about reducing fragility and enabling addition refactors
on top.

Note that this driver provides two triggers, so the default is
definitely not immutable.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/accel/adxl372.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index e375d068a3f5..a880ff4bfce1 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1272,7 +1272,7 @@ static int adxl372_buffer_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	indio_dev->trig = iio_trigger_get(st->dready_trig);
+	indio_dev->default_trigger = st->dready_trig;
 
 	return devm_request_irq(dev, st->irq,
 				iio_trigger_generic_data_rdy_poll,
-- 
2.56.1

