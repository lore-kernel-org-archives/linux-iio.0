Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8BD463B74;
	Mon, 17 Aug 2026 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986574; cv=none; b=L4w37QHt2nOjD7ebZ18qS0DX3lt6wxCszxvK0vZy61qLxDc3LkXkUIfOVkobGtlBjzkKefZKy8Q/NZ/d3jGbfov7DUyyVJ7uAZp+yiy5H9fTLG08hRRC6ay4V9rREcGBIowf4tXWM7BMMyc5NlG4DTBpRjVNRkXTgBW70t5B9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986574; c=relaxed/simple;
	bh=UWbyqh4bpm8+cAfa9dXxHxfmaEfW1Oi+9XJLB0ISDPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EIJ6krc4eTDSph7x20Xgih3h02bJyp1TJHsMVoAxUeiYqgYjWORXLi0qGl2bQUhP07m0y1BLdbrD6nCOsgO95DXch8yyNcbUDpBAqj1/wIDitC+cG6+OYERbwFg1SJnHJPQkGbwNCTvzs84yhiSeZPl3dhqN6t/M5fwHLTwvqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=1gXNcxwE; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="1gXNcxwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786986558; x=1787245758;
	bh=dFbW9MGwom17L9c0xKlgzqzd0x2gE+0iK1G6X3CQ5mA=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=1gXNcxwEhXpFB5k7sVl0TxIzsc/sHz+dPugFhwcu8fyQKV21hbQBF+ceMQF5/uNws
	 WC/lBRHUGgrg/voCjozbY2heHshtSZs6MYgeN8Zm76AhIrDAROeLQMZvCDZ1gS9Pn+
	 u0zobO2i2IV4Nken4fxKE1MOo3B8IyNMqScoUuIDv2btdU72HeFPQ6/oKFO6zSA9N2
	 IbEn6QCgYhDPkI1K16i+e6pV04PWzGkk/OM6xNhrXgNGijvDIWfTWHT8PwMLBHEBET
	 Q4EzpAbU99LOiha579KdMC0eGJKHTNkBZMtS/WNEfb2yQ+5A6PIOue+j+fA88GQK5n
	 NubyA6MqEeTfA==
X-Pm-Submission-Id: 4hNzp53Hfqz1DFFP
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 17 Aug 2026 19:08:54 +0200
Subject: [PATCH v5 5/8] iio: light: ltr501: Drop duplicated error message
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-liteon-ltr329-v5-5-6f71ab2b0588@geanix.com>
References: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
In-Reply-To: <20260817-liteon-ltr329-v5-0-6f71ab2b0588@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, 
 Yangtao Li <frank.li@vivo.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786986543; l=970;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=UWbyqh4bpm8+cAfa9dXxHxfmaEfW1Oi+9XJLB0ISDPw=;
 b=y+IXytm5B9BehEeqlGSVdhNSM+oK67C7HNRzJd1FOMifhhmbnzaWyz7BIi853B6TutJPLskbB
 er2I6YbktCtCHPSiTHagnkK9YTy+N/w3zXhEaODah2famFyoIH4KMcq
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The dev_err() message was causing duplicated error messages, as
devm_request_threaded_irq() calls dev_err_probe() on failure.

Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/light/ltr501.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7746d374688f..b36bd10a0262 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1537,11 +1537,8 @@ static int ltr501_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"ltr501_thresh_event",
 						indio_dev);
-		if (ret) {
-			dev_err(&client->dev, "request irq (%d) failed\n",
-				client->irq);
+		if (ret)
 			goto powerdown_on_error;
-		}
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;
 	}

-- 
2.55.0

