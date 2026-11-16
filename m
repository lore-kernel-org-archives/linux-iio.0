Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793845;
	b=rrz3FMEIB0Q4tYoW+OUymmVqwqirjzoObbJ1hTXt0XTprHqkACN7YpIbaOdJTFGJB8Kl
	 HXqDgjGIPi5MYp0vlisaaGRxe+he6yTJ1PUgeEvWKQqzSsAP+fYy8BVs79Ztw3pKqCtcg
	 +f24K/eSkbH2dPH1a3rGFBWIwtclf47v9e1qltdOYGAkw2g86md5HyPv2JhVDn0LAkhQK
	 PrXi4humrN5d1blwq6DBbB2E0iJ2xN1XCO73DwgihWiFW+g9/u2vU4kH1jng9UmluGsAt
	 be7delNkZez+oslt+gi0JhkDa631pd8CE/aHgnRHUQZqjMUCIvSFNXcbxlngpepsPLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793845;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hTR1yvwzc729C0DY1RPrs8AOb2jJEM2ENyRkMpYFTgw=;
	b=YXWu8JKLTAkCLOVJaF/saqxyCoX1GYRDEKVq9DUxgIQ4SD6EtcVuwLQssF/lOf5Mmvds
	 9QlI/VMyiFQAve1WWna36PUvENuNhIy1YDHH+QaeUhUQi5Dzs21BSRfrQ6MYxsPwb8Y+u
	 5NfvXNptta2pFDTzWgq2KWx5O7kgAx87CXBGCZt8GNze6wmsnPk5w1gfpvvOMQqIaQ2YL
	 ssGznG2KFlaR+AbVXyp3nd7UGRm81aacV6IJHgvGU+kW6TtIN3XCa8lUj87uv4mOLJzDD
	 3a31tW6/B5jpRScMS8T9pOq98DWhJFsZDwDT4YllsfclF8A+4+ZT/AySyAcCwgINHQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8lx6lQl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C9606A321;
	Mon, 16 Nov 2026 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8lx6lQl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0778B1F000C4;
	Mon, 16 Nov 2026 01:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793844;
	bh=hTR1yvwzc729C0DY1RPrs8AOb2jJEM2ENyRkMpYFTgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y8lx6lQly7f5veLZXvq70nC2js+VUslZW8g8n1RxLZCYEPXgxpTOzwq0xe5JUJYEJ
	 84Sszbtri+VkPS/3mDziSIxDHVW/RmOE7Z0lF1sfsitIfatD+z9wC9lrlHeniPB3QX
	 TsAIaK0ghQ2l1/lKeM+U2kwH8nuXbFdB74Y7cYjUEA0ogWEtM9h/BzX+hhRHrLJPco
	 QNvye90qxWmOvGLdpBkY+almHdXle6zNxBaVycyQoPQacetjKgdZeGoB7IE6kcG+Oy
	 2fCXbzN6fa255NEwCcaD7NsHtYF/XIYSxJnGI7ZZ2jF53vo+Xkb2nf9CcYRiFQRQxh
	 da7sf2ZHl7d9g==
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
Subject: [PATCH 18/35] iio: accel: bma180: use default_trigger
Date: Mon, 16 Nov 2026 01:48:06 +0000
Message-ID: <20261116014823.3132576-19-jic23@kernel.org>
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
the trigger is set up. As well as closing that leak, this also makes
the ordering a lot less fragile.

Fixes: 0668a4e4d297 ("iio: accel: bma180: Fix indio_dev->trig assignment")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/accel/bma180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index e7dbbd4766dd..fb10e5c2897c 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -998,7 +998,7 @@ static int bma180_probe(struct i2c_client *client)
 		if (ret)
 			goto err_trigger_free;
 
-		indio_dev->trig = iio_trigger_get(data->trig);
+		indio_dev->default_trigger = data->trig;
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-- 
2.56.1

