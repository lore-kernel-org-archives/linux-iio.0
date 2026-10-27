Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117999;
	b=pHaVqzs9zOkPJju1B6dIgMgFWFqsQqYp0nvYwfXrcpEkxy7xlhsjNYYRhsDE0/f3ovFE
	 SHMYCgOSPieYYYHv6Q0OCGQRZLgjximlznmAO/l/AOgux2Izk5O9SPRs+h9QtN1Boh4GD
	 fTCuRykAu9Tsezxi4BJRZpPM7KKYXLdyFaWiN+L20Yg6MyRb0h7Q9NJL9F1HaeTCft6a7
	 IZ2Np/oyjO6U11XmeLMJivoLAExKOsSwD0xOY/xrSCj+wesoRbprT65Q4tDZC08juhZEB
	 8lTTTptQGE/pxwi4N/wEFAK/HqvvIF79izyzmddgfVFnJebhjMzMcj/2Fb+Tp26Bw5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117999;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=yVFg12LLKvsXCmS7PNOfEgRUSO0sJfiG6IpAIexxCuc=;
	b=KyldMLmGczOCXWJnDmfMNcZTw8BocdaBUdh02ru3QFJ3c+ZIB1ZPB/OQ9rHBj2br7tWc
	 w9H6wnrKoqGItov1/DC5GX6EfhdAEhMtBsh0zEY21ikbcOpzFMfpCCNFe4Lod2oth2+IL
	 Z4hLMQLTpj+zPk2xWnfe2R02iQvhnv7hrrXqUvXV8KETZZUjmCFPojaJGzkj2H4cYE31I
	 4BcfGWERKZBUSFAyuonLEFWTrq5zCGBhRJs29QP08cQEiahZD+WFno+M24b7G+YrHjH0v
	 uzVf9wmlbxn5YXAqMp4aBfAjxv2zl2k9hoLkphXKoZxOZGKOC7JWF7DJduPhKdsHA9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fYhDAJ2V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1E60A383C;
	Tue, 27 Oct 2026 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fYhDAJ2V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE2B1F01828;
	Tue, 27 Oct 2026 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117998;
	bh=yVFg12LLKvsXCmS7PNOfEgRUSO0sJfiG6IpAIexxCuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fYhDAJ2VK+nZZqw1azuPg2qY0EoV9Zrddhlgn5eYzy4HJc02h0xsS5B2fkarGoiLV
	 eF2f8kr38rHFBkbbCV1BQzkQwaI7kJZf6bh5B1J7+n0phfyMysbvLFRt0C2mMQhTO7
	 8HP5Y8RIzpSinEhfBQLLioilJTAROTi/rBpMaIsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:19 +0100
Subject: [PATCH 15/15] iio: sx9310: use the data of the I2C table
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-llm-char-misc-iio-v1-15-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
 Siratul Islam <email@sirat.me>, Matti Vaittinen <mazziesaccount@gmail.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, Stephen Boyd <swboyd@chromium.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=2KkR6HPwoReDkx8Le2vwFs4pVbnfBQGeycAiqqATcCY=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjNverjRs5MpfuEvpxivs28mzNZq6fkV/+KhqvrTQ
 zOubmoo7ohlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJJNxjWLAgcaVP6vz522ZP
 WnxGYc4Xv6C+ayYM81Tv7pIJ/JqRnFEq2j/JTqD97X0jNwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

sx9310_check_whoami() takes the chip information from
device_get_match_data(), which only looks at the OF and ACPI tables, and
dereferences it. For a client which was bound through the i2c_device_id
table, for instance one created with

  echo sx9310 0x28 > /sys/bus/i2c/devices/i2c-1/new_device

it returns NULL, and the kernel oopses as soon as something at that address
answers the read of the WHOAMI register.

The I2C table has the same pointers. Use i2c_get_match_data(), which falls
back to it.

Fixes: 21fd3b1373f6 ("iio: proximity: sx9310: Convert enum->pointer for match data table")
Cc: stable <stable@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: Siratul Islam <email@sirat.me>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/proximity/sx9310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 79ba46d8a0aa..2585b9c6fb69 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -891,7 +891,7 @@ static int sx9310_check_whoami(struct device *dev,
 	if (ret)
 		return ret;
 
-	ddata = device_get_match_data(dev);
+	ddata = i2c_get_match_data(data->client);
 	if (ddata->whoami != whoami)
 		return -ENODEV;
 

-- 
2.56.0

