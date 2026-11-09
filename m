Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198571;
	b=hhWxyfBXfRqlCI8Uov/VKmi7RIMh7u4kY+HFWESDGETSWEAZckrK7N2BaYA8ul8tiFYY
	 2MGPEzZnB1g4/pL+nLE3QuJh9/6WeOFVA/hEBXn4xMIwtzBSJju7k9kF/e9GhlVRSXH99
	 1pWXLZIjAqi7TMlIjx0EUQjEQns1WLTlcIpZ2plJK551eVYH4qLAIzOF9BTKh1hxY97Zo
	 DGBp2F79p5Z7QuKZCIY7++LWRceznDWRiIZ0OitlyqN5Zg+tUagbHuHcsc78olhlG5Zbx
	 3rdN6pdL8ILlRLrJL1dIG1dttlVRSmWy78OrnZPsU8qOYR20s++MHfDdGwtVJEDkbOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198571;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NTgwcRzUf32MacA5MXJuOZ03d/Y16YM755ndq/T6KZQ=;
	b=EA7ia+eqbt3Zd6wMER9bDrDq8ICyu7eX0Q/DD05e34Jy+SDUTItsjZ9S9j/MINNCY7tO
	 rpnkkFo2XEUJjHIZjAwyhLYnsXpq1h6Vj6JaYPZfB3438/tFBlcbdBW7D7pFvqfT1bHV8
	 t+UL/l7N/W6v5OBBNcqPn1wYEXyAfVUiA4uW/2JmAlm4msfqjKznGStIBQ1BS68UY4bpo
	 QYXQ3vwmS6EaQ00K4mQ6odADxkmv1zTFDDtkeXnNRHApzlmI6En5jH3W0esAQszIG1qVD
	 H3EH3WdNczbFTJTMP/lY5/YjNLKhTXZkzxYpKBtg8irdTY6Lqg/IvAnZLCRP50X0PoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SH8jdfYV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F4606A321;
	Mon,  9 Nov 2026 04:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SH8jdfYV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD281F008BD;
	Mon,  9 Nov 2026 04:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198570;
	bh=NTgwcRzUf32MacA5MXJuOZ03d/Y16YM755ndq/T6KZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SH8jdfYVdX41W8VbijnoaMIyyxDQx2ZEVHL8Hn7+wakpo26vAGs/QNIs4GAaBXAgt
	 pfpaGM1vbT0N/kBcUd9BYfMfo2X8+mW2q1Iz/TDiIpFa6N6BSqum7ua4kR/OBhStNc
	 BSllz/NWzlJ6VVNgc86EF9kbPtCcXUsAnsHrQ+FnMz/sVIAKtpxUW7gLWXyZU6KMgf
	 DyiwxptPZko0NDRI0LZzCgfTlShmG6f6ebrU2QGv/PV7YFHnmjqOUKQ2qqC62oUBVz
	 OQH5W2ctGa+SRyL45jSwlsTmZ/NSnkgER+d5FklDkhcSW0Xwk2/YQdgq/DF8NmiUyF
	 aEYjGDGVpg03A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Song Qiang <songqiang1304521@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Erikas Bitovtas <xerikasxx@gmail.com>,
	Waqar Hameed <waqar.hameed@axis.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [RESEND PATCH 08/14] iio: proximity: vl53l0x-i2c: poll own trigger from interrupt handler
Date: Mon,  9 Nov 2026 04:28:45 +0000
Message-ID: <20261109042851.1326940-9-jic23@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109042851.1326940-1-jic23@kernel.org>
References: <20261109042851.1326940-1-jic23@kernel.org>
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

Poll data->trig from vl53l0x_threaded_irq() rather than
indio_dev->trig. vl53l0x_validate_trigger() only accepts the driver's
own trigger, so with the buffer enabled that is the trigger in use.

This removes a dependency on the trig field of struct iio_dev, which
is to become private to the IIO core.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 173e69753df7..6c595e647d75 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -107,7 +107,7 @@ static irqreturn_t vl53l0x_threaded_irq(int irq, void *priv)
 	struct vl53l0x_data *data = iio_priv(indio_dev);
 
 	if (iio_buffer_enabled(indio_dev))
-		iio_trigger_poll_nested(indio_dev->trig);
+		iio_trigger_poll_nested(data->trig);
 	else
 		complete(&data->completion);
 
-- 
2.56.0

