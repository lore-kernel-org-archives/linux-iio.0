Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793858;
	b=nXVgW8/oXiHVMVFQRqX90w075vANx6OYsdvfecSXYusYJ25hqXvfKt58s5hA42m1A//4
	 AYukRpq2D8TUUOCQS9GBPJAoZqvcfLwQjedzH6QjpFSTq0Cwz4+Yj5dSwCxweSFM5o9P2
	 Z/bNpzUB68S5B+WadOSiI9dF3Vh/JqP82izwHflEawSFZZdAWDLzRjJBUFzplJjqTe6p5
	 WpLEposOGbb9YR0wdOjBo45xe1jUaxTru//VPkT94mMNd+OJLQPjGNfusSvCwkV2KonTw
	 7GofgyKwfO549pzM/CzXRboaNwS/7omuhuos8lndk+S3bytxr7H8PIHLhKhFY7jZ9yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793858;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=duWd/BYGrc/SgNO1yjiwxhebtQlS71yvSw6I6HGeNQQ=;
	b=f2gqotXuXXNHsqkWndrsz5VYZ3aisKERLOdkszkbckbqMs/VPdsTJ4hPp+Rgx0o5ntAv
	 lrUJ3W3ZhTKwyS4YE7MB75BfhUqDPA3krIFLhuAZP42hbyMzesC0w/CgL2zF3MryyiBch
	 9aohti6aFKsU6kKW6E8DBBP1vAmSl8RCHSalwRg/QJ9ZtaN4xxyPN7+uHLco7FdLWS47g
	 kPzmh8fwtEMOXNWlnVqBupEas7pzg9jAJYCLPs/AdiQ65TFRl5iIkxAuq19N8CoHzelY9
	 t0g+041ZA4W3S+RdmxXzFti76qJSmO/i0zYKMvDinrE6RsiEdOkr9+RtfPzp1zGlE7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I7Fx4/M5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBC606A8B5;
	Mon, 16 Nov 2026 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7Fx4/M5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CFE1F02803;
	Mon, 16 Nov 2026 01:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793858;
	bh=duWd/BYGrc/SgNO1yjiwxhebtQlS71yvSw6I6HGeNQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I7Fx4/M5SNWErxbC5PG03L+nsDuhCEEfhQnwugK13Y2mo8PhpjDpu8tgPTlZAf/hM
	 pJXkJU/UONbqlxsvspBGuIlVMitzRgXdEZEGPKEJ1F7pYtMEPiUpGWBf3KQ5vrSeug
	 MjpR0wF5aDJ1mB2UJbwLhlkUOuristGR5rK4iryTwOi1QMHhtFyT3SR0zkPAs7UeKX
	 xozwFg8WvmZ96R/kt10wpnOVgRLZhihP8CY/JfKSxSCSrNown6UAjuZJhPE7qT4Mef
	 G4Ae07lioPBlJgmVTfD2xjH5pCX8iUraNoReMDs5ruFCkYSCLNiw30cO5VwSsUn5xw
	 90Rl/uqepmksA==
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
Subject: [PATCH 35/35] iio: gyro: mpu3050: use default_trigger
Date: Mon, 16 Nov 2026 01:48:23 +0000
Message-ID: <20261116014823.3132576-36-jic23@kernel.org>
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
the trigger is set up. Whilst the ordering is such that there is
no leak in here today, this will make the ordering less fragile
going forwards.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 7fbd30068764..954164cefadf 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1171,7 +1171,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 	if (ret)
 		goto err_iio_trigger;
 
-	indio_dev->trig = iio_trigger_get(mpu3050->trig);
+	indio_dev->default_trigger = mpu3050->trig;
 
 	return 0;
 
-- 
2.56.1

