Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53213CFF61
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681597; cv=none; b=lU2VNP6CIZtBmf80HrpZR6yGnn6XzxVi9MjOPd+rArztkaepF1UxqH1zzFunjB+yC1Hw9PIyQ2qH/lxAxQLBGwrKDjw/LiicLIFXiMgopUyzTsH1kjDse9V6mtBncksK8mqZlVjcxPRncOSN4ZC1JvvAJD+IBg/LGPfZLmV3l8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681597; c=relaxed/simple;
	bh=fwyYVczkGGhNbbtuDw6wb0iPQK79Hav8hEBxFnyoihs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HWj1WWvzlNZWWSPBNqb1WgLaH9fMYh4sEBJ4OpNLRVYFD0aSv3L0ImKux8DR/cHCNrEMClEoOnecxti/1uOFSLmjuQxinyLBjfdzn52qvFYNaokOnbG9BDfmF1HYliS2ElPZOQKQ+xuoMgStP4do8+ZK3BxAk35fGJsFaVPeR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4jO7IqV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4jO7IqV"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b96d784828bso735334566b.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681594; x=1774286394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5lDxPgHMLUWf4KOAgcF/BaGDb9kL4QT6S8GOy/ie+w=;
        b=l4jO7IqVxgcgLUJJZSXH+fqmT1n1VQSP3xwRcXDBMj0sVhNGdUL6jHWoaUjETIDdaM
         uGQzxXGnitAcjqy71ublk7gqpi+vbU0KEYBKxcYRD7qkhdcX6MQ1kdqHRsJQLhRLL4Nt
         Ulo2YYNjFnxDkEcR+BNVnEhQZrhQLpURiaDuITnb4OgDi1/8V0miq814s013JPr3NHPE
         xlFYb0RpcFbOWyt9lVwfnvkC5pl3lXsAQ+mMlAP9yN7jcQuPaOhxeY55dRwMLNYa1g1b
         43pzma+5Wz7FwVVSITsXn2eHqb9Tx/0Vt440c2sHQ7f9AwfASz7Nh7RKLiNv/WGjgsdW
         IIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681594; x=1774286394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l5lDxPgHMLUWf4KOAgcF/BaGDb9kL4QT6S8GOy/ie+w=;
        b=Kqaq8oLOvC3uoaRbaQwAC2CUtmACa5moJrz/hbCozPs4iUvYAPyv5HsSq8iys9ak8w
         mHBysjollKWsi66XEQ4axK5Eft3kd5kRUAtB43JB4q+8EOsToH6vg5EwAwIxi6zrw3Yi
         ajcmospaxUsh73aC29tvLbUfBdoNGj8z7UGiTnodZFiY7D+kMrrlKRVB4EgjEn4So0XV
         8B6NukUMnTj3JWpHuruwa08zqCeob3EP+A5DKwzwr/8YoFw7f61O4xXi7y6oLe1Uxiio
         52cRBrJcGQCUK4X7wdtukgwDtjDAs6rQcciQw1rkBaVNDrmAu3GD/pwVj/Y4GYy6bd6q
         wJ9A==
X-Gm-Message-State: AOJu0Yz5vVZr5dKplbOsSS5ooO8JqrRooCXkp3qKzUSyZF+le0doMIqp
	bAzLeCrj/7TCCs0rw+iVZR5qkdmH5Fr+jSN+/jJZ64Bs7bF3V2caIA/yN7aa5LpC
X-Gm-Gg: ATEYQzxsTfirJficrqnnuWLRMAvwGfa24HEivM4JSccOoEZjoB3FTWJEkQXezkgbuOS
	182IPsiHa6zAtqX8UGNeXkadiRGya6UZH4oGETizhY0FTfpIVoWMONUCSE/bzAJCUhYKctFaf50
	Sn+jNUUwUVsouvHNvKR456XtHyJOkoy0HGCEGmOeeVB2W7mlGXrRHGhwo3fV6Wwo7RLpZM/tbyo
	mZQCqYCRGGt7frvzLdOq+GvIQjif+d/iV6vSVRGV1Vrc5wtMUTzmUMGEEzQ/Kz692/FD/8LNpvs
	pp0z04EDoeQmNtjHp2iYNmmQj9J7JaEKio524uv5nj6t200GKIjRtU1ymWhbQPB2WJkXCXhCfvr
	oRt3mlp75ZB9W5BxbOUypguyuEwkibK+4PtWs6ReMIdK4kDumgaBHg+K5RTLMsrwpnQSPK4WS/8
	NB+EOHBk08r6k2mhALj3Kp/ZpXCQ==
X-Received: by 2002:a17:906:3396:b0:b97:464:956e with SMTP id a640c23a62f3a-b97651d0b0cmr575179866b.34.1773681594087;
        Mon, 16 Mar 2026 10:19:54 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97846174cfsm505940266b.22.2026.03.16.10.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:19:53 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Mon, 16 Mar 2026 19:19:47 +0200
Subject: [PATCH v4 3/7] iio: light: vcnl4000: move power enablement from
 init to probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-vcnl4000-regulators-v4-3-854fc2eaf54b@gmail.com>
References: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
In-Reply-To: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
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

Given both vcnl4000_init and vcnl4200_init end with
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

