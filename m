Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793814;
	b=UnOSGKfUzaFj3aGcKPxkKhtFbMCvHucw7EGwsuiLwklw5pTEjtmz2kOLEb5RYfLLEiMC
	 xbyjgW2dixhAIrs73Ey2KJmd7k4NbrKGYf7OyrHq6HxIgp8bH7V/jhbe/HV6vfyt9g6lx
	 tJKE2OIDF1nDGCzRW4i18+wBLLuERZRsKK3/NRHCeUan0IB/jupm2IrXV16RTAb2uugFy
	 drwFIdiPnJxHQby/8DCP9FgfaIqDzDpvLkp4jhdn2qf4UxRJRSSHOXhKkY3rnV4d9hegS
	 oYDgOf9Hafw1UBFGvngrZ47mJyDz6vhMm1lT/vF+EULYdbMfjkKiuEIhrr/6Bat5smA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793814;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wnqQz077KfdIvGrpQrv4lr4ajHBQf3ESLBpPjsjQUQI=;
	b=Bynh2zOf4az5amPVmVDBgLkGfLbqoYm1hJ7Q6MZKnUtH7GV8g6H+/uSrNYgWoJfZKDY0
	 GUMEM9q1iwkKUabrLcJhTb8IQIWdJpXaEXQEVhic+fd1fX2UJQpcypYPvnnf+SVjG8CsV
	 ldu6H15sSeGkl0a1TG4KIrrtcw7oHizx+yDp47D3fPQMZizue3tkxcumPtv+8GVUaJRsf
	 vkZOWSbACJ1zX8mRhCtmjpBaANONtbhM1CUoXEiQQDJTjqjoSOCdqbRawz+calfj5q8pk
	 iuxslWsyuh5mAb65wvRJRTBrjVNv/jOBX0OcyApDdLGnTGKs2uMYCLDH9juHRJ4Imlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DmD/mdBv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FA606A31C;
	Mon, 16 Nov 2026 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmD/mdBv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5664E1F000CA;
	Mon, 16 Nov 2026 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793814;
	bh=wnqQz077KfdIvGrpQrv4lr4ajHBQf3ESLBpPjsjQUQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DmD/mdBvpwtCjfIUkmFXQsMOaF3oo+uMEjFNlGwtVRlT/KXgrgiF6VQyX5V24ybUY
	 LEuV7GYW8JsocJllXaPh/OmE5jrRlfksSFPPM5rp+/o641fPv6CCO0ocaRvj5Yjw+Y
	 Y26dCcWt5HR78SKNHayUiTosvQFbnC0267oPmdZjSYjWn8tGTlzrYefjKCqcupFmHv
	 AJfGN6mX9tI7isvkT0bz3uFjLOrZH59WxDD1xqHilWJpliRkBhUCSE9WU9sgqINY6I
	 OHTeaur4XJBI6CZ0zAoSCZm4WpGZujJgiPZKljSJ3UyLQjCfO0VSWNzjtEXeb8pI1Z
	 XyM08aFy1x8+A==
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
Subject: [PATCH 14/35] iio: accel: bma400: use default_trigger
Date: Mon, 16 Nov 2026 01:48:02 +0000
Message-ID: <20261116014823.3132576-15-jic23@kernel.org>
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
the trigger is set up. Whilst this closes a potential leak, it
also makes the ordering going forwards a lot less fragile.

Fixes: ffe0ab6a9698 ("iio: accel: bma400: Add triggered buffer support")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/accel/bma400_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 6bc64ca87f4b..7c995c9b691b 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1781,7 +1781,7 @@ int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
 			return dev_err_probe(data->dev, ret,
 					     "iio trigger register fail\n");
 
-		indio_dev->trig = iio_trigger_get(data->trig);
+		indio_dev->default_trigger = data->trig;
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 						&bma400_interrupt,
 						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-- 
2.56.1

