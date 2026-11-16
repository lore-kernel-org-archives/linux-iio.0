Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793847;
	b=eFHvf7Kxn7OuzhHXe6e4gXdb8yvpNK1hZfv9QezbSVD9XH3Jfx5sHJxg7e3JrYIdSWFp
	 h5eDh0fmNg4J48I0L7rtugc/4lhtZ2jAo8/y2A2MGJilM/CP/TdDW1bsXLnDb4ynTmhfK
	 K+pHHEY4RtqyDBrjEAHt7r2Vfv25aX2nv1kUIkoQ/M/fYojLnyF4OkIbK3Vt5wIGdMGSZ
	 xZhW1JnsFIAuAN02YWu/0dnpPUA4EAqYoP4cxTQ0Qdr23ORd97OeACduCjs1vmgnRWpIv
	 bpuCSxaqGEF1fqwH+Dhxvfu9f6uybmEe+FCPpgRJTkwEp1s7YwDZkf8n+V3LBnBW/ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793847;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=waFNfACUbHNzABKbjs7ZdKEkg8ns9s99i15JpYpkwnQ=;
	b=xfDpYmGmy+fFHKDtimEtMW+izenSYiHC69jVkmV2acgwmPdpnOwh8QZ4/t6XVIPHnxvS
	 OU74j4LiuDrODcK+SSKZhhTR40xbRFyRdwqFv2ZlyAFwmt2woA38YGnSKQRZWfs/IWAPc
	 BwFdEj0R+pEoIMuRbj9hgmpKdpe+oq6sd3zRnNUXDzcQgHm/i2AdZZGM1KdUz/RSAyPAD
	 eDcvruqarlkf+KddLImUrqd3UP1OJL7BBySWrRi5//5s95tsr89ev5cS7/eMtKj+TXscM
	 cI3FOOFqx6Haei5d/iH8KufwmbRQ/sHV+ldbT8Mb/h2BKUVHAY6e4XElkuKp1bhjpbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLMK3d2i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A8606A334;
	Mon, 16 Nov 2026 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLMK3d2i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11531F000CB;
	Mon, 16 Nov 2026 01:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793847;
	bh=waFNfACUbHNzABKbjs7ZdKEkg8ns9s99i15JpYpkwnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QLMK3d2ibHGOvayWaDGpD+guUChXtOAxUN2zFCRoOzCovmyH3ofxS/Io8JHtaS1cO
	 Tjrg5UrwJxDWTeetLEhJP1qipxJgK2zpdv6aKz7xL7Fw1k9yoEs0xd/vYV0ADKo1im
	 lLsMQq9zAe8Syo0YcuTEzw+BE95E4+G4gn1qMdFCfaCbWfZVBEAmoC25ZNGDYaaGuB
	 +P6mu3Iqhm8CRHnlByDuytjWMA7wnBBjUe9wB8/BXDZf7IWpS6MtNRhmDJLr62hW20
	 Pxnm4qyL9tdSHZ2u2nC+qBo7iEEIyy1Sj/xxuBLJQnJjdfqS40RYHEUlUuHovfJCk9
	 Uk6qAydO2dXzw==
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
Subject: [PATCH 20/35] iio: accel: mma8452: use default_trigger
Date: Mon, 16 Nov 2026 01:48:08 +0000
Message-ID: <20261116014823.3132576-21-jic23@kernel.org>
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
the trigger is set up. As well as closing the leak, this should
make the ordering a lot less fragile going forwards.

Fixes: cd0082235783 ("iio: mma8452: Fix trigger reference couting")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 44962ac7491f..d0b9f2d31fe3 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1529,7 +1529,7 @@ static int mma8452_trigger_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	data->trig = trig;
-	indio_dev->trig = iio_trigger_get(trig);
+	indio_dev->default_trigger = trig;
 
 	return 0;
 }
-- 
2.56.1

