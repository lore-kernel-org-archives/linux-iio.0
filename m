Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793851;
	b=0Uf5fo5hSPdxXf2WN5Jlv/wzGs0vA0dlQU5ge1MuG4TknUr2cDmIiFBXa7xioJDCO5nk
	 yFBuuKtxR9NADgXkFdP3FcVrGxIPqNpadkuAGntXpsWreSzYdxZk5vVnhwomZd4o1ScvR
	 Y9VldCadCOTQ/mvgI0GIM4SNBHnZT+JPgpgMjTXn6ogrzgaxBWBq7wvP4KkYNPIz0GOtD
	 oZ52L6zvaP3X0n5MAb8Rn7VuxrVbx2DSydzXHnqiV1jDx8EdXVek6o4K7D4dyF9zjGLPi
	 bmBqleGniu7ttVAOHwC2tGYWAGRzEqZ3czOm1eUkPl+Ead5sMY0AqZQdFGO1jt9DeGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793851;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r0CToGD+vm+ySLaOR41fA5bDoDm1NBZL17YRO9yUHh8=;
	b=ei/UHwBtvV7oOGtuXCJ1LPDaXTsjCKP1NfoatkuG/w5n/v8PLVzf2k3dKce4ufT/Q+/a
	 iyF/026z92W2r0MwxQJWZ1FcstRAXqLKoBPa74fKhQcgHBguzOO/BePEbL9fHknWg/gXN
	 Hji5gv+twZ8IyvtnwT2hBY24qufp4+gY6upYv9cDdX8GTvYM8pUvxvlpnq/6HrqFKNV+W
	 8l0QVtNb20Y79rWF5z2euzFeb0rmaeIRwZZ0hA3d8ogfgf9apjwB6MABzNY6NBW0NUOw0
	 XbipX4tNXFwEeZLjCjuwJ+hlokqtJhbLl5iNJ1zrE0bTZlCHjK8h1ivYYkwzUaHjwjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IW0HMNa0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A719606A31F;
	Mon, 16 Nov 2026 01:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IW0HMNa0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B2D1F00926;
	Mon, 16 Nov 2026 01:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793850;
	bh=r0CToGD+vm+ySLaOR41fA5bDoDm1NBZL17YRO9yUHh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IW0HMNa0G7MBfPjSH68gpVlx7XZFZ2Gpwh8t+VH/X0LC1DVdl60ODCB8mh/aJbeYb
	 S7Deb765+QR9ImB4uNfp4zrxTKUyUKKKpEYm7nGxirq1wV2dgClhzcGRAFB2DStO1a
	 /1vTogohfHcVKTPRO2Vk74X4T000b2zCbiDYwdGUGGsMheRcB22zQaWrj3RCUVWZpB
	 m6+1KUKTm/dZz34a3clAi+Ndfxn+q47+2LwEfvC8Tcf2NfBg9EhQ/YL7CmfDD1MYCJ
	 UZWpQBPEyUTV4hNnJa4jZ0SOfYweQTPFhk2KqxO6s9zDYTesKJ6HSsqfDMTlmTI1X5
	 MR8CG3HoyQn9w==
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
Subject: [PATCH 25/35] iio: pressure: bmp280: use default_trigger
Date: Mon, 16 Nov 2026 01:48:13 +0000
Message-ID: <20261116014823.3132576-26-jic23@kernel.org>
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
the trigger is set up. This particular case does not have such a leak
so this is a case of making the code less fragile going forwards.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/pressure/bmp280-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 3940b8e61a06..b2768a314c13 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1345,7 +1345,7 @@ static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
 	if (ret)
 		return dev_err_probe(dev, ret, "iio trigger register failed.\n");
 
-	indio_dev->trig = iio_trigger_get(data->trig);
+	indio_dev->default_trigger = data->trig;
 
 	return 0;
 }
-- 
2.56.1

