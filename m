Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025A3DEAC2
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025150; cv=none; b=Is0KcnMuSXJLvyyqg2FNBw7C0FlBU3qN2zuE4WepxuL0odhKniFXxD/VlCfaD6NIsp1NGoSzcLI23Tqtjz/csjvYNUm+NpODbPFWIHvHyWpZKVu1qKMYdBSTjMTcQPfe86rjtpWOCTYatTkAly5ZRnM1yShMSeYk5sfzGCd0lWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025150; c=relaxed/simple;
	bh=ZojnK09Mc+1usbeK5j9s42nV+91No9sdCY+jKtF7KAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bz5Yyt4IdR+smHj9eiB+V4U8R18s5/s03NvboRq1AEX0j5eej9T9fS0evGY6YSmjj5r9IGy/CwQadaxMpoO9lAldIFHNfzK9K/kp4/5ANzfWdYiRl3ULq9vCyANPaaWDB/QW1vCw+ITrXG+Ezfr/pwOyEYwGHNTUyefKctm1c5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEqnn9hf; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEqnn9hf"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9793fa5371so283465366b.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025147; x=1774629947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Jvo2/D8IcbrXgv/nfUWpfBkPNW+8ec4futg+Nh84xo=;
        b=KEqnn9hfl/Zx5D98fCEqYbBoxP0HUxhsAXydwTMC7QqJgUsBy0Y48E6fzXH8gGjRho
         wND/w/918KEvsiSHDcH8iPtfmuj243HFANSLLP/3Qkfffy4Iq871eoaHIEzvQLQWuKef
         5jj+R/2vzHRlSimnLj2AdKLjZBDHWG09OldGKzB752QH3QwgjioV6Os9+tzuR8eX650u
         oY+Ou84mlZ/HP+dJk1Z24UMYfGetSd7sn6GGJtTqzKqZPoeLACyODFxSuSb4KqlKJrNT
         xRyW9wSe51C/TYJxRVx30e2O1BN/G1Vw6TFXnTXEf6sUpUtcs+H+1kAGezMkGV/ZXs6A
         VyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025147; x=1774629947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Jvo2/D8IcbrXgv/nfUWpfBkPNW+8ec4futg+Nh84xo=;
        b=r59X6Um5INZU/cHFqIExA2UjZ8vENzq39vHXd09wLJ35EV3DydW9cLQeK8MNWqOP0i
         Vl46Y9Wz0YJlQZMvojugFjO9MIJuKx2Quh43hFspEsaWeegj0l72D+EBmjeeA03tkgT3
         lebEXmuvysDDHiCFEvIfafs1cNQtasekFbwf/mg+A7E/uvxNvMtsykTV2UrgsKwTWF3U
         vRWEH4CijjekNqay50HW4uvtV7kwIlO8J7OqO5q1z46LCsqBcYPuwHiqQQslvxnL7oJ1
         sjFcZOMK+C7i2yZez8nNoqa5utwufXjTrZq7cqMW3pESvBjQ8P+LszbcR9ys0GZGuV/J
         uWSg==
X-Gm-Message-State: AOJu0Yyk8TE3uMBVpvaEtwRK59JBSi4duQtcgflBs2T2dSMLpcw2AvXL
	RjqG9is6adtN1HKVFGU0ADIKw3tix2yyEj/RFKMdBCLs2Wr5XnoZYe/l
X-Gm-Gg: ATEYQzywbqDhXa2Z70qR0VrFvJkLfEfj68bH1lVisDl7R69n71XHRWnNJAOKrC1Qbqb
	6OZ9UW3xGMnG5t3zNb94tJVVmyCvTUiU2eHq3aoDWBYqIw2qokkwi5q+9d8a9INiobXtffM9AhR
	5QY+zGWxfpCUIeQk8DCIhSvaphLa7OqxBc7SkPXHrpHTr737o7QiskifiYuT7Cr3wU7M/vjFTS1
	BMy9lgMoywyHTqRiC+Af/mz1wWnFB7JWdyjcidl3YLJkIqKbXFj+WKUc17zhTv6jZd2KVRgyGW6
	nGMahl2J+uEYjVmyvq8MfqMebq/ABfUd+Zdv7qOfRQ43quNeJ1SndgMrzSwv2QtQQGrjxDcuIve
	JdgPseGeWCzhZS7HNye3w2nr4cUvolIajBEQzpt2VU71TEDPT5+BruI4i5guOY2lXYGbz6z2Y5N
	5Hf2TCCE06jZ8moxRw1Gd2bIQM4Q==
X-Received: by 2002:a17:907:e107:b0:b97:bc30:1bd with SMTP id a640c23a62f3a-b982f1ff0eamr149690066b.21.1774025147086;
        Fri, 20 Mar 2026 09:45:47 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b98335f1747sm176730466b.33.2026.03.20.09.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:45:46 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Fri, 20 Mar 2026 18:45:38 +0200
Subject: [PATCH v6 3/8] iio: light: vcnl4000: move power enablement from
 init to probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-vcnl4000-regulators-v6-3-0d24d20b1a5b@gmail.com>
References: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
In-Reply-To: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Given both vcnl4000_init() and vcnl4200_init() end with
dev->chip_spec->set_power_state(), they can be called once from the
probe to enable the sensors. Move the set_power_state function from init
and call it after init function in probe.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 939ff2d65105..287ccd89cfb2 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -280,7 +280,7 @@ static int vcnl4000_init(struct vcnl4000_data *data)
 	data->rev = ret & 0xf;
 	data->al_scale = 250000;
 
-	return data->chip_spec->set_power_state(data, true);
+	return 0;
 };
 
 static ssize_t vcnl4000_write_als_enable(struct vcnl4000_data *data, bool en)
@@ -425,10 +425,6 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	if (ret < 0)
 		return ret;
 
-	ret = data->chip_spec->set_power_state(data, true);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 };
 
@@ -2003,6 +1999,10 @@ static int vcnl4000_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = data->chip_spec->set_power_state(data, true);
+	if (ret)
+		return ret;
+
 	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
 		data->chip_spec->prod, data->rev);
 

-- 
2.53.0

