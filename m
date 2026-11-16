Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793783;
	b=uezDz9bKDLlSM6WBgtJEl9NYZxezUyavj8AdkArvrsUMliQucGbmrpX1uebwGSzYboaN
	 6uCWaK12VcLoWimvxveNClVTYHxwEWM4wruLqZUBbLcVJntZCXTNb1JMe++8XrxlNw/gA
	 kcic/RMFGCpGJPBBEzy7d3sHbVf1IvT4ZtjId/e1FgSPLGdycqVlIZtyiHWBvdFZlFEPb
	 6wbyYTxvH5IzicxFht4XFFspoQ78elfRn89urY8Ll2DWh6qPTFRV5mEQ+AJQPWvh3fUPI
	 BisbB0bKNcd3YURE3SkDOj6osu3yqKLUAoA/qbbVSv+f2MKEcs+GJ4rNF0ubmKRpjnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793783;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5C65FIyrQNqwipj77HjBHB8nqVoj2wk6Mx+ST1Pc8ZU=;
	b=ptSROv3QBbER/0/+ao98ydt05QmWCFp8zq1sxsFlRxF98CCZVGnU3iFmuNaQQBnqjb3o
	 Fk6ODHlCGRAldMrberNJnUSEp8j+K/aZb4IcVKATznUB6Xw0zpwnppAEEEVjYLVtJJl2E
	 OrS88XsgmCvIM5XOtpaUytVSCe35ngIpkgx8dqSfm4BEU0L5Tc/k+WWkutzRd/2P8ihWn
	 IgrK2POYDaHtppHXGCHAgGqm9e8K/v/mOyefM77WEMLQ518RwEoTZhAivO3WytptJWkzf
	 sDVgmQmGsBkSTSqPWeBuyKZ1+AT7Y6lhXSw4VYiEHOAOSCy5/EmVhjOlxKEb1/rsEKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MS0azNiX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356CB606A329;
	Mon, 16 Nov 2026 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MS0azNiX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0705C1F000C6;
	Mon, 16 Nov 2026 01:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793782;
	bh=5C65FIyrQNqwipj77HjBHB8nqVoj2wk6Mx+ST1Pc8ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MS0azNiXY/nGpv1DPIVXUkP5EtQUxboJwYmCRw1mNMCPMKzfWfZb4cqqmHBzgKkbU
	 sgxNpEeUCsKGBJ72m5FYLWWiGG+uCXCIDlImB7jMQ8rRnTCHg2/Wjb4S6m3G9mO4c0
	 aaCz6eCMKZR9oCKCkJGK8sFU/tAqLHkKmmusZ86awpKlIc9M7zVDrCJ1eA2fSkR6E7
	 0TnJ9rtQtkxfHRTey4wbbv5Upgr3b04WRN5AW4pRO3VJdIdno8k+rXqTtHha+Gfyrs
	 Bl2RnvwGDt7hgRrUWAb3yomQK3MYhh7fZEJsNQd59NDMaZue4k0+NbknlW2vVP9DP7
	 kL8WvEdmqm4Zg==
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
Subject: [PATCH 09/35] iio: addac: ad74115: use default_trigger
Date: Mon, 16 Nov 2026 01:47:57 +0000
Message-ID: <20261116014823.3132576-10-jic23@kernel.org>
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
the trigger is set up. This avoid a fragile registration ordering
constraint.

Fixes: 48ea75598db2 ("iio: addac: add AD74115 driver")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/addac/ad74115.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
index 9b9d7a12ce87..475822d70ef2 100644
--- a/drivers/iio/addac/ad74115.c
+++ b/drivers/iio/addac/ad74115.c
@@ -1813,7 +1813,7 @@ static int ad74115_setup_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	indio_dev->trig = iio_trigger_get(st->trig);
+	indio_dev->default_trigger = st->trig;
 
 	return 0;
 }
-- 
2.56.1

