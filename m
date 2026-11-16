Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793804;
	b=dikscbc7ml20/8udQQaFBgLRQZAH25Koo5Xnmm/34BA//Cu0VzzS1CeTk89GHQZKYui6
	 PAtG33yveCS9hWksyX57PjnbNA6Ot7Jk8oe/iav4x9GGxHNLJQ37ReEnAT5N+fFnO229W
	 xl5Zi2pYwM6lLs1p7CaL+xWZGm++aTo3VBnTdhp8ghtInexUQVN2yM8BzoFBuTfUgyUlX
	 9iEHwvo/Tu8xGTwJGCI6rePIZ4XwezHB2qxd93jX6EIEeaR1WbRycwITw9gMHtBt+u9X1
	 r1bapUPy/sl1N26qk2kCF1DdmKbFtK+XgsNOGsU8YEmuRjZ3kwEsKmDwepOIiTnmP6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793804;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=G98+1k3ZMeGiQjRkUgCTPj95EaKFOQTBjxy/EBux5FY=;
	b=02GVrik0jEnwih86YRegTxdy0cs2KFKyrQyw09mzA4QcoOxikDQX0ssHUezStARmAH72
	 fmRGqzsTRXH6g7GNLcEXNDm51NvbyWWRwSO8gA2n66JjJfMRXc5I4kY/XQjPcnZqNUOk3
	 dyg7K/ve1rDO5Hydfat9zm7+XFJV9egJEIUAXdNGzmDr/TPSVdUc6zxWNegllgEJHrseZ
	 VceYFpFDVJHVK9rfbWzfQy/NN9aCqwZRRVZdpQldP/XAAKN73pUXWCfScM2JpBMsZ2IR+
	 BqmllkZIiMbwef6ieBtefMaUHMmHI8/STh9XuRtD9fZzuYV0Pqqqz+tM23mKD1ol2Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlLxuQfo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCC606A331;
	Mon, 16 Nov 2026 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlLxuQfo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F4E1F000C4;
	Mon, 16 Nov 2026 01:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793804;
	bh=G98+1k3ZMeGiQjRkUgCTPj95EaKFOQTBjxy/EBux5FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TlLxuQfofqAUnWsMJddMMnaH4s4CK/veg1QweqxKicABYwZOcxmQZI+sA53kw4pJe
	 wDXl6rYd5CbT2HZihxNQQdnyNvjBwgliGiBqyg+v2ACGs9b46uf+9wTimB8019cuTn
	 BkfpqIiyBe1f7TQHPfialWEvRYzc02HG9aFsEP/9EtRJif6nPqq4P+6mv9bud5ZJeJ
	 I3IQn9nYhFk98xD++fip68N1Bvf6g0g0ZXz9RLfpHIH05ADP0dqX4EGkv6MEx2428F
	 xW+xgE2vHZBBM7KWg8K0wGcU+ESL3C798LJVygNzq1TVeH0hIKsYDnaOcy4Sc096vk
	 wqVqtq6yx5/3A==
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
Subject: [PATCH 12/35] iio: adc: ad4062: use default_trigger
Date: Mon, 16 Nov 2026 01:48:00 +0000
Message-ID: <20261116014823.3132576-13-jic23@kernel.org>
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
the trigger is set up. This removes a fragile ordering constraint.

Fixes: 23cc92280302 ("iio: adc: ad4062: Add IIO Trigger support")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ad4062.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index 8e5984055b15..cb11d15fe84a 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -745,7 +745,7 @@ static int ad4062_request_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	indio_dev->trig = iio_trigger_get(st->trigger);
+	indio_dev->default_trigger = st->trigger;
 
 	return 0;
 }
-- 
2.56.1

