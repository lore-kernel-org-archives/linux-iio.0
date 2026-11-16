Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793849;
	b=waE5cJCc50pXJGAw6FPkqvwGvxZgQvrAB+uXTaxz6Y5xRJRVSVBP0DuWVpFDtjL6Exoi
	 5IJpAjsnVucrewvfhYAJAoRdqhblZOKejD0B3HtZqpSCyUIxqoWilw5Wf0hCreWGtIWHp
	 i/nHiOkiFVbOtt9CnuPoND9lhQrZ3uR05CQd8RMi5Ps6GNoH1+8WZsSuoFyKldnYXOKFT
	 vwDUgfRpdduGxkbp+xeC0nZ76tgEpc7oP8QMXMf/afqPabdpwGwjwmoA+dDkYhL3sUA9N
	 z5TeyQ1qfCrRx4561MKPnwXgbOeHPI90Ye45i0nL6oQuSPPBjkt4wFqfpMeQJgW1wcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793849;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EDthb/j3v6LTX3qxnfQi48xFcZR5CX0H+dpvplf1gDg=;
	b=08XiCQe8j2PkMrsFWCj5tJtb9Na+t8DE7St9qNBE8dctOXjcLl4Yx3Of72P7ypw+l8e6
	 4LTZGkP8mN3+gag8NrxEn+4r33tGUKSTCwqI/jGldmw5Zxd9jpzRj/HWyCKe+NbdH6cL+
	 icjnEgyTbqXyhllg5F7AHFoFT/UPQ977uqHvCNIJLxM358DPBEM5lNdAkTFT5LCC+Z5Mk
	 FAkx5SfVySEgYxiwHYkXRcWJpkrT3Xmwm31TAsOCH6HX5mG+EzP3KRFQqiLMp/TK4Yofz
	 DNT7QgeTPWS1nxvpLNr3l6RdNp0z8gpvDytRb0aUg0hS8PFlgaxShekw6BEXvhsPcbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1U++bNd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E7606A338;
	Mon, 16 Nov 2026 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1U++bNd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D042B1F000CF;
	Mon, 16 Nov 2026 01:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793849;
	bh=EDthb/j3v6LTX3qxnfQi48xFcZR5CX0H+dpvplf1gDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X1U++bNdAv3Oji935yE958c034sL8DS4WJupSBvZaVpyqJrBMZ0pP2taBsNZ3mIGR
	 TjETI9UeH1pitlRlngX+iMHcgxvPft8a3Ic8FIxFZyM16xf0MVsXTN9Vaz3fvwZ8Bs
	 4/gGNN4bwJi8Waij4vS52z8AFzNRBUyD3KcRq0pzaeeprwdGIvQ64t/wqD4macdF9e
	 gEomSSHLrvyQzga/UnmVKoKQp8Q2hoYTTaCQ3fv5lkFDQpbEWb8OkYqxb/h+/LLxII
	 fNgY0Fx+0S7kU0uqtQn8v0OzbhumYaKHpCAHsyItp3oLsmzenyrbfhy2HmqtaYfRv6
	 8KD1Iy/2+ep9Q==
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
Subject: [PATCH 23/35] iio: common: st_sensors: use default_trigger
Date: Mon, 16 Nov 2026 01:48:11 +0000
Message-ID: <20261116014823.3132576-24-jic23@kernel.org>
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
trigger in st_sensors_allocate_trigger(). The IIO core now takes the
reference during iio_device_register(), so it is not leaked if probe()
fails after the trigger is set up.

All users (st_accel, st_gyro, st_magn and st_pressure) allocate the
triggered buffer and trigger before calling devm_iio_device_register()
and do not access indio_dev->trig before that point. The interrupt
handlers are passed the trigger directly.

The ordering is such in here that their is no leak today, but in general
this change will make things less fragile going forwards.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 7b3e9732cc3e..c450b1e2812d 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -219,7 +219,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 		dev_err(parent, "failed to register iio trigger.\n");
 		return err;
 	}
-	indio_dev->trig = iio_trigger_get(sdata->trig);
+	indio_dev->default_trigger = sdata->trig;
 
 	return 0;
 }
-- 
2.56.1

