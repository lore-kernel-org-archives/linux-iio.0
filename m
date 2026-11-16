Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793790;
	b=5e9ksIz500KHRdvUicb0SoJkb9SmG8ePyszxqLPtxZ5oYeoiMJ8s4j/sHJQ9Xa5Uwabg
	 Ev1vZ9JD/modpk1nhf3sKJ2Uyf0WAykmVjZtq56Dbf5f8evTqrxcQ07GB638ITJIOGZ1G
	 oeoch4sKVX/q62It4D0V8eev6vnJ7p1pNJ1j+20GB///tCy4YEWX4xW/5tELqVnHxe24E
	 vYY+qUVnp1tgAmIUYcAYiw4ppbugb2Mvn9yTQMvMoyjvHkerj5r61sbFCIZaAVvlOFADP
	 V2bjPK1vxJGLTwwEFB26g1cFrP56PNEsD+Fu0mxVLv/RLviRtpmFkgkN02joacoof/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793790;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0mP3nns6ON6fSm3e0baH3UComUCoOgYezkFcLGDHpQ8=;
	b=2RccpvoYjUbVe+RutHMak/pWtO4ggdch7AQuu9nnOOh6Iuij58JHthoxJJEp9TLlGsCn
	 gLrTBpbSMoWybouhgWoaZzg4RM2yiCy6/qaeS1eTSSYGECGlR6hCYrAmc1uhbVfCpGzik
	 bDphpqd6jDUiG8nKqyDPAnYWFqIm//SY/hUB7JW3jDlvf+qmnsqnKf8LPzjXQWaSXs7ez
	 ZqTYN7bs0ZqYVI10u5qc9Pdrb1ucpcY2HgTJxsfpEtIycNSmxR9icYXGqXxaS+PT7bjl0
	 k+FYbz60+CEkPdQs7c8DWQIwiZcjOlL2fognAuHwPBgccT877x89z7J3IcgEfg1HoXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhzfNmPo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C8606A323;
	Mon, 16 Nov 2026 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhzfNmPo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AA61F000C4;
	Mon, 16 Nov 2026 01:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793790;
	bh=0mP3nns6ON6fSm3e0baH3UComUCoOgYezkFcLGDHpQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JhzfNmPoUdM99/FFlaArtlsWhwnRnbGJx8FtLZFbw3HCA2aZX1Xw31anZKQK6yV1m
	 KZGG9ZJ7MtZV041LcPzh5c7X3lQoj6TRzqbQlWyrjF99IgwbXAyves9At1NnCb4bce
	 5AoS7AWV4j5Z2JKl4r1WheLp8zcP/scVlIBULUqihq5EVJjojFdrHx5OQO5xfOP+Tp
	 X/rGyjHLFGOCZX4SRJLrICv+zteldJGTHO+TH8jwlMfCTDRfxqtbJQkc7CDUlIOx2s
	 o8dd+WtQX6BWi5cjblhK+SUThMepa5QZY7PSfQNiWkPwLAIbGd+8xPrGy/XYgC66xk
	 lo+6sNpZmRt4Q==
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
Subject: [PATCH 10/35] iio: addac: ad74413r: use default_trigger
Date: Mon, 16 Nov 2026 01:47:58 +0000
Message-ID: <20261116014823.3132576-11-jic23@kernel.org>
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
the trigger is set up.  In this driver there are a lot of places
that could previously happen.

Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---

This one is a fix, but given impact is a reference leak on an
error path I don't propose to push for a backport of the fix.
---
 drivers/iio/addac/ad74413r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 8d9d3d5f09c6..41675ff47f47 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1397,7 +1397,7 @@ static int ad74413r_probe(struct spi_device *spi)
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad74413r_info;
-	indio_dev->trig = iio_trigger_get(st->trig);
+	indio_dev->default_trigger = st->trig;
 
 	ret = ad74413r_reset(st);
 	if (ret)
-- 
2.56.1

