Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793848;
	b=iYTg28i97kNXpvQy3GwGYeIMWMAjrGsh4H5hCrzh9pShjwQftccCHPL944UX0VYCFcjq
	 IgG6DyiFZcwARDClboJ0qvV3EWKfU2En4Xa2IIOr7X9xsojI4alvs4cAAt6250wYOrYhm
	 wegjLd4zVoAFXnUJ7Lonq3KqBO4hCFwcPAyLd81EuJ8NRFBmwsh7e7rsNS8XPEsrHJOid
	 acpP2eMn/NMURN4HNny6ypKcecPEgG640BCGGAPWA6qreh8kvjBudiEypy0DamsnZINUj
	 TcoTbw+bKzq87BxWz7iAkSMzg3z2iwdnfML1J5MrjbiS35dQyQITzBKoG51NhimvlpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793848;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kVNQwag0RMjkv5WIRAxT6I6tdX4pMOj9G6OVjfDewBk=;
	b=T28ifFTiguXfQSFKlabgJ8/0oqEg3mAtApVyBR2BH+neFIdTgO7dpOaVSlFXkun26nIl
	 V4lPDaQGmjy6yo9XxDP+hOLKXg7gFESYktEBlsslVDGetav1Y+4Fo0nS6PDFKamIgbLir
	 H6GKb58jx4n4Fo2wrd2xhbeA++ONWQqRmsBQcdHO8lQ6vECgSkbRejzOQuN9IFq135KTq
	 vvuEA5acMdv4KpZlpaRO70P9qB3G/2ilS6Fd4kLbjDbrKMa6Uj2VNupLx7DBmpwuEF0rc
	 C+SjS2KjJze89Q07qx2wkpGZNUho8u5wKSQwEFHCdtCf3uDlWQSRmsnvWn6l5tubAsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CLO8SHa/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA9606A886;
	Mon, 16 Nov 2026 01:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLO8SHa/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C971F000D2;
	Mon, 16 Nov 2026 01:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793848;
	bh=kVNQwag0RMjkv5WIRAxT6I6tdX4pMOj9G6OVjfDewBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CLO8SHa/lmAYUdeX7DX0PtXE02gc2syhbe/w2/sP5ijFYxVPiLQj0lfEpoqiaS63r
	 KepIechw37T+mUxMzcF3dgR9kr2c5jH1l1KfcIkBbpP7DyTm7RpaC4v69mx76VdZke
	 G+8SBxUDyyWe6SJKqRQnDNl6wRM/LvRHwptBLizEqY0uFcdv9SAi1B6Vbl2T72wqes
	 nD60NI4AWfJlHGsoY1vTOqEN3AmNwUumXHUuXB6OkOxZWxLXPBJ+l560vSF9n3sxGz
	 cPtugRc/JoBj98HKdSvtVAfqaAyqt8PKi7eg7kaBQOiDtne1rla9wCTYZM6sRrhcYV
	 fhmVpXx6GdOnA==
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
Subject: [PATCH 22/35] iio: pressure: mpl3115: use default_trigger
Date: Mon, 16 Nov 2026 01:48:10 +0000
Message-ID: <20261116014823.3132576-23-jic23@kernel.org>
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
the trigger is set up. As well as closing the leak, this will make
the ordering less fragile in general.

Fixes: 8464f61099c2 ("iio: mpl3115: add support for DRDY interrupt")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/pressure/mpl3115.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index f20fa6ad16fe..0df979293244 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -686,7 +686,7 @@ static int mpl3115_trigger_probe(struct mpl3115_data *data,
 	if (ret)
 		return ret;
 
-	indio_dev->trig = iio_trigger_get(data->drdy_trig);
+	indio_dev->default_trigger = data->drdy_trig;
 
 	return 0;
 }
-- 
2.56.1

