Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793856;
	b=hcFZj7q8nFNB6tbOxaGeRgvIxKBqArdHSDjTkg/LYi/1C7CMr+7m4IkDz2MaPK+2l5wI
	 Z9svY4bg3FeFh8epXO+htQedau/yaJTOvX6pxS189yIAZXmQm1XJf0iaSZ8CaYh4weMxq
	 iXxoEUKTwgNbguSrIw9y471Y+jSN9n/E3PUtd3RCuHhjtMxWH1df7ydoFSc7wsRHeB/Bn
	 SKhzuOnpoQ7L+WLFyYH7OqnBWVj/j5Mq6qsWpCNq6kdjkXvGhypr+rMuPR0Y4w5Fz/3kj
	 cJ03pOUiXTgOaKFr8NU/ryivx0Oec23xXnERcA6qX9/+t2Fs4Z5djy8ncUAKbVlLedA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793856;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NA2WPbMsSF9Vb+39rUVltD8lcd6ZGsqb59wquimKCTs=;
	b=Eq0w0QoD28ZwwT96K+EG0x831I1j4bLfQKC+h4pHQ95OboLc3mcGUYWfVI+J81QaqWR9
	 g0F+hth1olVmfRcyQCw2/u0ZRHiMO2GrmRHHFTjRQ6+OntCywnSFc7kEH/n5GlZE7c5rU
	 vO2J4cWmksavZ9xlVRGXQSnKxDUE3gNbyf7QAWLvx6JWfKnfiSOCNjq5lfvW/aPpvvkhC
	 Ghanca3AthSGpoESFzJ40Cm5kFAu1BZvT2atUAg6g9oMZszGekmK9EZ/LAjJMaLnf9ngJ
	 7M05jDfMMRcheg6tOO9npxqlvaMcgQiMT/8IG4JWDrNcDIkXCAysYN+6A54Wf+wrWew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iz7IJO2o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796A360A5BE7;
	Mon, 16 Nov 2026 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iz7IJO2o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B82B1F0182E;
	Mon, 16 Nov 2026 01:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793856;
	bh=NA2WPbMsSF9Vb+39rUVltD8lcd6ZGsqb59wquimKCTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iz7IJO2otNJuBqCEMv2yby2O1jHUFDTiSN8T2le+TyXiSuuiIrbR7w7LMjg0wu90I
	 0BFCHPTHwGGtPqMj5maGH5AAw/Eya6SsIhnU8bXVFFP6HEFdVSAjpfUsvsO5mbbqoI
	 U4oh2TkngsEfhFyZP4hVqxEb1JzZRdaZHTMy046ZlVT92tTqlUN6kUuQkxz/MXZAsv
	 RLYjP+uxqD4Q8CpLULM3zW8oj2xXCjUPaGWkMIBYIUMHdGZ8FymI1QJHH3EF92oOmR
	 PRQjxHFEUl3qaiPAsEBr5XTN9nTVHYcGSEr6p+tTavqr+7bzrxW/Elb9ykW8+TPJWf
	 XkRQ95ONuaK2w==
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
Subject: [PATCH 32/35] iio: light: si1145: use default_trigger
Date: Mon, 16 Nov 2026 01:48:20 +0000
Message-ID: <20261116014823.3132576-33-jic23@kernel.org>
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
the trigger is set up. Note this driver doesn't have this leak.
This avoids fragile registration ordering constraints and enables
additional refactors on top.

The copy of the trigger pointer in data->trig is only used during
probe(), so drop it.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/si1145.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index bb7c99041819..b160dd5dba86 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -166,7 +166,6 @@ struct si1145_part_info {
  * @scan_mask:	Saved scan mask to avoid duplicate set_chlist
  * @autonomous: If automatic measurements are active (for buffer support)
  * @part_info:	Part information
- * @trig:	Pointer to iio trigger
  * @meas_rate:	Value of MEAS_RATE register. Only set in HW in auto mode
  * @buffer:	Used to pack data read from sensor.
  */
@@ -178,7 +177,6 @@ struct si1145_data {
 	const struct si1145_part_info *part_info;
 	unsigned long scan_mask;
 	bool autonomous;
-	struct iio_trigger *trig;
 	int meas_rate;
 	/*
 	 * Ensure timestamp will be naturally aligned if present.
@@ -1258,8 +1256,7 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	data->trig = trig;
-	indio_dev->trig = iio_trigger_get(data->trig);
+	indio_dev->default_trigger = trig;
 
 	return 0;
 }
-- 
2.56.1

