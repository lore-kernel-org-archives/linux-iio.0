Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793857;
	b=xtTY6DJc6Iw9QAka8NfQ3cXLvGboW7PusJdxHW71Pc7VvVa0Q+GVQWPWosz6hc2n4Jrc
	 c3xj2YnMcR5scD7dFobljPD6sPVRPpZR0CPj/IFDhFuFsjywDtUC40lVwEqxBsMsaZufr
	 XCjqfHNV0K5gqrzG2v4B1oi89gzuc5q6ljl3hAPeIejdbfAZDmKidFuivpIsOj/jEB0Tr
	 MY4iQxyYB+eb+lzaRSj8QkypD6vAnuIMvGMf/10w3SgTmdYtrSmdfOlkpCs1xqddy8nS4
	 V8RnHMV9AZASXyZfbY2ebvY/kNUyK9OSrR8+Cr1hrt2ldZw9zLHMxkDOPL8sOjn0GcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793857;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QCWZMEbDTADULGdTU/F4iEFzrUxsm0NIppGFv8Yh3AA=;
	b=znrCWgE2pCzhg9jUSiSX+iL6PLIqgcNAPFDoCyRe0kDoyBIHV/Ntfbm+XLSl0cy/GAlD
	 W4xtXd1q6TkgEFzyJ6s1YCcNiVz9FJhjeWuVMNkkXnArxmXkb3GneEXydfQo/Q9KukrmJ
	 AizkQFL0l+dDk69gSZLmf3dZgQHyOMAVgkuMHHAc6l9wkoy1OlF4lh1aPRst9TEXTOWsb
	 YIRtHqxYnK5XiLuJvsl13ng5ftfodF9icQtwBtDCfjC+RNeATJXRR1UaM3bGxOzjahU9n
	 4Q/TRBmmUgSsGcVmRfo94JX9ENVBJv0UY83GXuRrY6js2WSOzeXCWdwOGgNnlK2i7jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nr8SlhXj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E960A6F63;
	Mon, 16 Nov 2026 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nr8SlhXj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A801F0182D;
	Mon, 16 Nov 2026 01:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793857;
	bh=QCWZMEbDTADULGdTU/F4iEFzrUxsm0NIppGFv8Yh3AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nr8SlhXjmAnPw51zC3UcQimFD1MHUAolwrnB30F3bXvz+HdOW1O5XrfmP+CCsqKxM
	 pBdregb3/0Vsu4zRkaQRlfqM2UHdltBCZt7g166nAC+Hm/O9SgCEsq6Qsnqv5pofow
	 KbpPbcZJX/x9BcOwL1smvWwlK/3uswNpEEuY6ttClH38dOqr4wLeX4O1IVTxChBHhT
	 gOxqngn2KBbvc8pUNBWUmp66K2IZjXB+Dyt+FFTa8ToLM1SxVlNptel+6sOxkQCATW
	 7iu6407Gzkm+TIIcPxDKIkuvVoRy4FtNfJUZ9jjTlaOMQ9j1JYs1ESeuqUql8qv03D
	 uH+k9au9hXzBg==
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
Subject: [PATCH 34/35] iio: accel: mxc4005: use default_trigger
Date: Mon, 16 Nov 2026 01:48:22 +0000
Message-ID: <20261116014823.3132576-35-jic23@kernel.org>
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
the trigger is set up. No actual leak in this case due to the
particular ordering. This change relaxes that ordering constraint
and makes things less fragile going forwards.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/accel/mxc4005.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 1559888e0995..2d4d09377397 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -502,7 +502,7 @@ static int mxc4005_probe(struct i2c_client *client)
 			return ret;
 		}
 
-		indio_dev->trig = iio_trigger_get(data->dready_trig);
+		indio_dev->default_trigger = data->dready_trig;
 	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
-- 
2.56.1

