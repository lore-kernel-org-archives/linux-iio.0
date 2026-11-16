Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793810;
	b=Ap5BQ6U44WtBSbxtexqWRAG5U6pJt9/UYenuKLCrHqQc95QR4TCMAS6INkRTs1lWmn9B
	 3dLy1NYIvYQLago20tiIlSTKykD4YZf/pvgptLHc+OnVzC+TfIlLKo5HTOa1NP2VqJMib
	 EpqKRw1B8hqkrJGn17dDBMlGIYcQmAJtCDdBl3k3OPnbJ8Ck7MIG/QBP24p1yHib1mFgz
	 MAc/9P7A0xHk3Zua9xBu8W5O80D+FAcv9ix7kvPb1NlAPKnT2QMOyG7AErRx8y32t6ctn
	 QDJifHP8JLW/TkZW1iRezp9sd+iJpeWclP7W6BnevmpMrGRct+FHo7sqra20zpEXAAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793810;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LOcBZgWKVdIRkd2p62vZPtORjS73eqsvFLLxIFkLJHg=;
	b=T9ryyN91WoRDZs9Ne4nV9fR/oLNpkOSRkR1x9tNjtqOH+Dfd9BgdFmTPX8T+gDgtK1fL
	 qzwzQI45QCUyLTdJkmpBdgtV2GYMQ3S9J2FHYahdALrdqr9FhrI90A5kIpyim9I4ioIWF
	 cCXncuOpRVwwnfMwbImFuRhHulIsTGPzIu1E0q3diFSWDtFTZKXHbB5dyCXC4hBXvmAx3
	 4lZYvGLJkblFIsy+P7buADoQbUIxMpC2JoQ7rWzJ/Y6f/cBhS0CPxv5h93KFtgVwVZ92V
	 BiU9nrtSenIIJ7WKxfTsP+satCyXQ9Ntq/cG24R4OdCmmba7w0/XFVLZ+LUetSqZmDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=difTIFUV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92839606A329;
	Mon, 16 Nov 2026 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=difTIFUV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E4B1F000C8;
	Mon, 16 Nov 2026 01:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793810;
	bh=LOcBZgWKVdIRkd2p62vZPtORjS73eqsvFLLxIFkLJHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=difTIFUVX+3y7KXfi1qh2Cdn5EzJYePdAU61zREzdlrgfM3BW23Ds4I15KlpAO8SV
	 zAVeKLPquFC8kNwcqpTCK7Y6UAI0Rbo1FSU1LHjYHUhc9725RuQ7S1dA4dw7v48+uP
	 cNTLokySNW+VABLNxqEgt+c53HEWjrE4s8fcyguD0JJl3ODmTCptCK3ccNz+JjUy1Q
	 +R78nOiFW6pcgs0OM2JtEHEiJrJyQYUm9lNRe1W1JHZ0JRGq4ixoK9avzOPylglxho
	 B1riOFSyNYeHHMXGWZbBh12imxZfLgE6kYlQS+1BK6pDYaO+TBI0DH557ZlkXfabTs
	 rm9aSpz16OgBA==
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
Subject: [PATCH 13/35] iio: accel: bma220: use default_trigger
Date: Mon, 16 Nov 2026 01:48:01 +0000
Message-ID: <20261116014823.3132576-14-jic23@kernel.org>
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
the trigger is set up.  Whilst this patch closes the specific
bug, it also makes the ordering less fragile going forwards.

Fixes: b7e17ca10793 ("iio: accel: bma220: add interrupt trigger")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/accel/bma220_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index b83abfdd84fd..23eff578158c 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -539,7 +539,7 @@ int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
 		if (ret)
 			return dev_err_probe(dev, ret,
 					     "iio trigger register fail\n");
-		indio_dev->trig = iio_trigger_get(data->trig);
+		indio_dev->default_trigger = data->trig;
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 						&bma220_irq_handler, IRQF_ONESHOT,
 						indio_dev->name, indio_dev);
-- 
2.56.1

