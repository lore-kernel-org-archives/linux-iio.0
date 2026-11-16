Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793851;
	b=i1/Sdc8Cv0wlVqMIh6he4oktQla7kwGOn8Yjiy9156OcK/7b4o5kY6KmiRgKUn9JDrse
	 nDsJVEmYX0b05VX5zLwDIUo2s89IuXUgDWah95+3H9p4+QqJyflq1JYMw3Ivcv8zesHcI
	 TqvGgMewPPoRqZeSecDnhOPn3amOMRk5PPay4xy/Zn+E1IJQwuSntDQKBXT/kzBUXblW0
	 C8VKn5ORccMcPHLQQMomU54ckgHRZQ5pp+lH/INTCdc23AajhS+XNpVA8pRIXRjbT6F9b
	 FM7iaFQTAu0xAKTpFIKLTPUapb0Z95O1vGszH6N3QLR41YGCPl3BbK9EtoCrz1UfG8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793851;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R/wV5ONXbiUQc77QRLQYTe6JUWsAaji6ejsayor3X1w=;
	b=QAL4aixXOZJzof+A+B6yhUvC6RGhCUZ5UnxuQveCcucfpExCnG7l0R1ZPtjkK7Eudizx
	 FqFwh5PYm4J3wWtet1b4tCYPwxxetTwetjcjcmARFANDqxMGCDp4UIsGVm7Lc737G5qIP
	 zcWB45ygQ4xSCaX0DttUQDgqVy0EoDp2P+VaTgg0Pbu7/fjpk4D2jZkhzgCwApNH8b0Fx
	 fIXD2Ceb6640OZyhssEBiHOJ1Rbz2Gic5W0bBDlzY/dXd7kinlFdI2JnW6ao0Tjeh038p
	 2bgXe/Cn6yf/doZEtaCg7QZkDjNqU0Y2rg0cewuHVWqwv2E+KBGhTRMlnxCTk5yLtxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bblh6coz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB7606A8B4;
	Mon, 16 Nov 2026 01:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bblh6coz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0856B1F0092C;
	Mon, 16 Nov 2026 01:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793851;
	bh=R/wV5ONXbiUQc77QRLQYTe6JUWsAaji6ejsayor3X1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bblh6cozVG+lzNYs1OW5+ah4wEC/T4gFCjFB406zCmWOcjucJEHRF2hJWK57m+Lfi
	 5DBoG5tJQuZLPOBZXjyrTr3jlqhghGElG1iGUYtdnzpreIY+M9G6/EwFZ78aWNrqa1
	 r/Qd6rLsb90xtd4FzYseKpT3aKAVEvSRdavJkoDBlmbs5l3iVDOq0iLc8OH33ai+9R
	 xYy7A83fA5PqLG02/i06781+rvQSw50txl0zU69M7/VIBvKkLxDwffnv23ADXS0SjF
	 rf0lI+a+xJTaRLODWnzWNrFxtk1DCDx01zloLFm7ejnWJtw07+4+BTtzwqQtvo1oAt
	 haZDTyIhDUsLA==
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
Subject: [PATCH 26/35] iio: light: vl6180: use default_trigger
Date: Mon, 16 Nov 2026 01:48:14 +0000
Message-ID: <20261116014823.3132576-27-jic23@kernel.org>
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
the trigger is set up. In this particular case the ordering does
not result in a leak so the intent is to make that less fragile
going forwards.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/vl6180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 44fd0446b583..249d383b5292 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -736,7 +736,7 @@ static int vl6180_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
-		indio_dev->trig = iio_trigger_get(data->trig);
+		indio_dev->default_trigger = data->trig;
 	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
-- 
2.56.1

