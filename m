Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793822;
	b=gekYMQkvDnPA04ihBPasEjM5/4aVsuU06LUw3Rr4ZfwFm64RAgQWIFnjBAbWJpoqyqsA
	 8vr1+0Ma9QwM46qn33cweGUJpiuHtkJElbISiJOPmkz6KwKjshIFuvFi8A30NBWoFahzx
	 a5fPZWXnKIWvu0rOV41stoOYS4F5Dr99m2bu1CA85omA5KbxzZKwDj/JqeqckSJJYOIAe
	 BDg5T7ghtE27V5ANYdRTLz6NfRVdRNIAuT0NHnByU17qGS0GyUz4CoxSduy2N9FmXXmk2
	 NsmYeEvpThjZ4LF/g2Ow/xh5JsQKvCBJzF5gICrjlhgFDXyr0ABKoHSnP2pwFlCFyew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793822;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AUqW3sTkO/HA0HuGL21JS9LkoBx0wgTCgRNeOyjxYIU=;
	b=H81blQwUXH8pqa5CnGeB3ruLfhHxSrJi9H3OTH+9C0uqFWd22e1t/RmttIottY+btz9l
	 M0MoH97qbsXg9cjSAG7xc0hfFgNUFyAjI91EIH+0XQhvB7G/gXtlfIpmxGgl5UyK0kr9P
	 b4NvCM1eTtYM9zQNEOzxp99AN/e6jzJszc1NnnTLdIrjfTVf497a75HFLq8e3J5MHS73L
	 1RITfG+tQVSdjwWsEbIXZ0KfgMAo44pki/jzkZWCJFf7NXPvVHKnudNmiKeYOnqNmic8t
	 z0xDPIOMWhZeNGO0wo/+v4XPkmL0In7zsatg2pcsDQrJxP/0q7mjgb6xcL3hYk6dKXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtlkEsUn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581A606A321;
	Mon, 16 Nov 2026 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtlkEsUn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546421F000C5;
	Mon, 16 Nov 2026 01:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793822;
	bh=AUqW3sTkO/HA0HuGL21JS9LkoBx0wgTCgRNeOyjxYIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HtlkEsUnvV+wM77QdLes4Jc6OGAq7juWx68FiMmaYlcbxsOlyFOeaG0Eu6S2JzyUf
	 jZwDS5cpg9WYg7GwSHhmfqWBL5rIPfGn0+Ign7q9rMcMBRTmbrNKJKCUtPWI2EArIr
	 y2ltzc0ZCtla3IRe3OO+TCmDA/Pg4AuAIwk5Ptep3jJ+5OZZ7eWvov24zYMxwluTNZ
	 YyWPONxDhP6DFjxakUTueB/4542MXtDO+z9DK44GwT8mEhkW5Ts563Tv/8YwPY4FHi
	 oH6tRgO+qczpSMVJQYMvKQQSMCXGCTtXxcMRS0lb6Lx3YjTOf4zu5v1culLz5+TiZZ
	 IqU7sRjzgacwQ==
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
Subject: [PATCH 15/35] iio: imu: smi330: use default_trigger
Date: Mon, 16 Nov 2026 01:48:03 +0000
Message-ID: <20261116014823.3132576-16-jic23@kernel.org>
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
the trigger is set up. This makes the ordering less fragile
going forwards.

Fixes: 6f3d8de8886d ("iio: imu: smi330: Add driver")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/imu/smi330/smi330_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
index ef7f00825b4a..de9a0ea1569e 100644
--- a/drivers/iio/imu/smi330/smi330_core.c
+++ b/drivers/iio/imu/smi330/smi330_core.c
@@ -888,8 +888,7 @@ int smi330_core_probe(struct device *dev, struct regmap *regmap)
 			return dev_err_probe(dev, ret,
 					     "IIO register trigger failed\n");
 
-		/* Set default operation mode to data ready. */
-		indio_dev->trig = iio_trigger_get(data->trig);
+		indio_dev->default_trigger = data->trig;
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-- 
2.56.1

