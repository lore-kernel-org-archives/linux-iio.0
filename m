Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793847;
	b=AGATZTCZl3OhEBZNaCuHkgb/qRzAadPoSa/PLf+LU5WWWIT6JLvamVE+S866U583nw+5
	 oX+Q8eIq8QKQ2Yrgu+1HOaSWEnmeK1Q/ZaAyZBuSF/UYGAWLv2NvQSb/q/csgDfB/0tzx
	 /stj/69eoaXLE5Kf5XPEigb/IVQ4DjT4WzID8PRvp+PbkrHxiqVPxUCNOYuKzJK5nSJN7
	 e4FCv8/JqhbPDwZVVGHZIe6/TpqMoLlamB4QtvdCjuY0Oo+e3P8yYNQlbNxF4fVw1rI9T
	 s3dBSsQkau9NgH/VDyH094sU7H0eqPa+cFqyOECiUzXmmyLZ4udtdkjx02ocS/tELfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793847;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nCXqGQpz/uKo5ti3N6sktTSUhyKBFbtoH6Nk77OQE1g=;
	b=ydovBK9CLoena7KIQS1qfdFKQ40wVQVfdO1mm13u0Zov8JxQg2bOrPev+O2vlSKjwRyi
	 eDg/4nC3RQAcLOLlljcvMOW8+o4yIbZXng9gECUnyjrR+PfmQ9DZ8E9zpdzqe8POMDaI0
	 yxzqsHrodu3VOIBVTSToIX5J3HaSme5q2js7gR/CrlONZcMv/ko0t9r5ohzY0Vl7oQ6ny
	 VFG6iAodA7ZqAr0Ke4sTUZAcJLZoodZUHXh8dggucLBVV9fYGmFQ+mXAi7ChsWgCZ9u7G
	 UKmmW+Ssm5PU6NYoQRzfWo1ofbc8z5UBEix2AD3GUjEVE/lSc1mBGY3WOG6kZCZuOFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCWOFBLT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C57B606A31C;
	Mon, 16 Nov 2026 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCWOFBLT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1F91F000C4;
	Mon, 16 Nov 2026 01:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793846;
	bh=nCXqGQpz/uKo5ti3N6sktTSUhyKBFbtoH6Nk77OQE1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gCWOFBLTNWIrxcRtN3i9m9KaBJTLy3MWL3DUkri/KosZZ4Wo3Ym2q8vZzOROhh2ae
	 5wMsby+caHWqjJsjfbihALvNK/kOR7P3uZfIT0DeXOSPq50ZNfrHtQT5YwNQsEUo3R
	 pGJ/q0VE1uddVgiSOluIfSRn8N5AWYvlKk0V6Aux8wBCoGdJwBImC2omtTdjCdkprJ
	 I7c9uowuo1sf/0aBfGeA/J+zOAO0vXn9wqVyaZdVGpcXCQ2rU0xPY2idhFE1wuKZpd
	 DlpQRwwPShVIFhmJiCOPpL/2EYpyqgEC7PUtjLY2u+SUSPhrBrTI5n+spTlCKdUH7C
	 pWIYa9+HvFzKg==
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
Subject: [PATCH 19/35] iio: accel: kxcjk-1013: use default_trigger
Date: Mon, 16 Nov 2026 01:48:07 +0000
Message-ID: <20261116014823.3132576-20-jic23@kernel.org>
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
the trigger is set up. As well as closing the leak, this also
makes the ordering less fragile going forwards.

Fixes: c1288b833881 ("iio: accel: kxcjk-1013: Increment ref counter for indio_dev->trig")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/accel/kxcjk-1013.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 18b1ba365f78..bcf6b019b137 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1487,7 +1487,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
 		if (ret)
 			goto err_poweroff;
 
-		indio_dev->trig = iio_trigger_get(data->dready_trig);
+		indio_dev->default_trigger = data->dready_trig;
 
 		data->motion_trig->ops = &kxcjk1013_trigger_ops;
 		iio_trigger_set_drvdata(data->motion_trig, indio_dev);
-- 
2.56.1

