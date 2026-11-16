Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793747;
	b=1Thsrz9Z8snGA40waIBSoNL2gEtCKAxWe5n3jygCdSyiKn3ni3fUQf8RMz5PfHc2lfZn
	 NC1tHEwV9mKt+qUDVq8EFGRAextGj9kuUZqz2BWTcBI6RMH6sUclQUfHuV0mu7VgrpPzU
	 qCA8FDGxlLpQfJFqhviRrntNOPpT9KZCPaQPm5ZSX/FyrZHexd334sQo2o3GwYg+O//Kd
	 /d9zRHlMp1I+QWJK9nCgeoeGM4RVuYChMohRcsgfalFT/tSvxwwM64f1KG1X/vY/vLre5
	 Jj8lMQGCOEmw7oTehFqWmmHiya42crsP22Q6s3JhnniHMcQ2hX+M5DEpT/hoyhP9q3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793747;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SMnlz+UKmlvy+V5NM8eD5m7WpHRvN0c1AJo9dr/OXAw=;
	b=l/TW7kIWaNN2goPdv/5EiyU141Eu9GcGNNx0Gw17wul7Bxr/WZI/2S/jM09YZJtv6Xcb
	 uPXI/OmHpvwwMLhkzo0Ok7tVVup6uU7BiozGAPKie98tQAluLkkvJac0ZkW0kkfI7igUd
	 O3a1DMVIyo9DwsgffDwS3+WfVIrXqnQqefkkXPRz2JfH1rJyjPuuLytmHMsRMXrtWGse5
	 hHlYm4EKQAmigsobk9T+aFKoJNOP1Bwlbl5jEMufUkZ+UHCWIyvW4O/bR3qp5L2U4Opmq
	 AqaN+3i8WM84TZuAS4v9k3wqaLO4IeA/8sPVytko1Z6Bm9O1YZx2vdEftZbVGXCJxCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTmTp9vh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2FA606A31C;
	Mon, 16 Nov 2026 01:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTmTp9vh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F8E1F000CF;
	Mon, 16 Nov 2026 01:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793747;
	bh=SMnlz+UKmlvy+V5NM8eD5m7WpHRvN0c1AJo9dr/OXAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aTmTp9vh5vwc7vw6vQgmqA6obeXgSnsnd4YMXMpsrGDv7UPwdVIjqPPbIOGa24WE6
	 qEp/lMyj+9yxuvOId0AdED7gcxRwWqES7f8E4O21UCBv93gmD6TANQZtaL949hwKu8
	 Zzo0NY5wN/ZTPoYotOXM1JeRYs0IvaE5YUQa6g+Zg8/S879gs1ghdIp6yKMzNeZxAf
	 A0HymrHVncnWbM6fzGwWshQaOas4/xIeL23Rw4wksYT952mQ1yXfXL+jepcbbEWMOE
	 j7QKRYFm/xLel6fIQ+Hq5Q9oZCifE2aC2KHjkSXMt4egBCmC7JyaukQ5oWOlW/azOL
	 c9iwtZfY856jg==
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
Subject: [PATCH 03/35] iio: chemical: ens160: use default_trigger
Date: Mon, 16 Nov 2026 01:47:51 +0000
Message-ID: <20261116014823.3132576-4-jic23@kernel.org>
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
iio_device_register().

Previously the reference was taken before devm_iio_triggered_buffer_setup()
set INDIO_BUFFER_TRIGGERED, so a failure in that call leaked the trigger
reference as iio_dev_release() only drops it for devices with triggered
modes.

As indio_dev->trig is no longer set during probe(), pass the local trigger
pointer to devm_request_irq().

Fixes: 0fc26596b4b3 ("iio: chemical: ens160: add triggered buffer support")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

---
Technically a fix but only for a leak on an error path and backporting
this plus the infrastructure probably doesn't mkae sense.
---
 drivers/iio/chemical/ens160_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index 5e2b15463c99..7325f22ddf26 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -309,11 +309,10 @@ static int ens160_setup_trigger(struct iio_dev *indio_dev, int irq)
 	if (ret)
 		return ret;
 
-	indio_dev->trig = iio_trigger_get(trig);
+	indio_dev->default_trigger = trig;
 
 	ret = devm_request_irq(dev, irq, iio_trigger_generic_data_rdy_poll,
-			       IRQF_NO_THREAD, indio_dev->name,
-			       indio_dev->trig);
+			       IRQF_NO_THREAD, indio_dev->name, trig);
 	if (ret)
 		return ret;
 
-- 
2.56.1

