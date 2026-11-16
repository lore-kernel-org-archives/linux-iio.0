Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793775;
	b=n9IXB9uQAHSi1OJbF+ZDbMcNgGF71fi15gxDEuFk63pQQvtHF7gl7Wap2TIUdul3G4rq
	 y+N+cgqGk5ja6BW1rshW7rUuJ/7afddo9cKlWdl6iV4vK9vimSw2N99jXadil81Zik3uR
	 IGqDiAE9dOe0K+c4sEDuojzanxX6RxShYplDP3nl7O0R7qtUsv7cqdLenUjdQShD3YQIV
	 IEV7rD0I687/ixTWojcJQNwvmD4gfUJRBHVDaE25ExGURDOJmBd3wIXfDHhBrfmDbc4FW
	 IPzIhlAwB7K7CR+5Ti9kQnj2RjfBELBB1WbmRkRlstKO9C8svl0aai3dlmOllCjfUFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793775;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8Rf3iwhNIezEbxNy3Ak+ireWD8L9UwuVCMGYulNpaXs=;
	b=uz22pHqf2EuE1xR+aSbLwDk8lpbzyrIcrInSFZKV2QaiY7YsxLFmJ0fo43EBTCiQuvwo
	 +1yw5bygPXOCMLSoboUkltPJS6FYL07Xx1v8trz6N4odRK5jFcX/MEnmHz4WfV6xf+7jt
	 u4GqYXv+EOKKiNp16qKscjywagVLsXJYuZyrLaaeqThMzcQI5V5wGxQYEwPWJrXSh/WRE
	 QPXWDC+f+n115qpHF9sdu53v0XXsKI2nhdcUDxOVY3+WI/NuEoeQQUgSjZx41SF1MS5MH
	 jPdMFjdB4MasXqwNIWA3F5eprr64ICT73wN6SQbxdDdlkLS94btwatPgGgXmk5u/6rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frLQHLXk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D0E606A321;
	Mon, 16 Nov 2026 01:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frLQHLXk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C6A1F00929;
	Mon, 16 Nov 2026 01:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793775;
	bh=8Rf3iwhNIezEbxNy3Ak+ireWD8L9UwuVCMGYulNpaXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=frLQHLXkkquTHumBzikM4ZkKCBxSXjmTAQsY/3g4V9XpZe340wF2CR/Dw0JfiEwJr
	 p4ugwffNsG+aio60TOwv4nMPsJXBHjcVeBRs0y8paMoLUmWpLsSHpuaKTIRY2Or23n
	 Bv9TIZxX5V31Gl8izPZwKWQnrFffcDeMmsz0X+ltHxpbN4uuD8Oj5YBvA5/i5nkSCi
	 llCAATvacYPcXVLfyyWx6r4jNwwiKzQgBQ6mDazkvxAKx7cJTVerH2N0RqhqReD/vL
	 PU3FoyIdXmjhTLYJiBSoLNGs4paFvLcT1tQcvBaAfJDietDC+Fs1rg5IzVtvyBiHQv
	 tkffMn7KHSmbA==
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
Subject: [PATCH 08/35] iio: adc: ti-ads131e08: use default_trigger
Date: Mon, 16 Nov 2026 01:47:56 +0000
Message-ID: <20261116014823.3132576-9-jic23@kernel.org>
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
the trigger is set up. This avoids a fragile ordering constraint.

Fixes: d935eddd2799 ("iio: adc: Add driver for Texas Instruments ADS131E0x ADC family")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ti-ads131e08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index 1d25f887cadb..df8620ad2a57 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -851,7 +851,7 @@ static int ads131e08_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	indio_dev->trig = iio_trigger_get(st->trig);
+	indio_dev->default_trigger = st->trig;
 
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 		NULL, &ads131e08_trigger_handler, NULL);
-- 
2.56.1

