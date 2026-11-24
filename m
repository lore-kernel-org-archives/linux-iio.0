Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503029;
	b=bgLWcRzqUPP6JeogvECNfgvspJ+hJ3D9tbLf84GIrjgEIfNAObLm06MGyvwfJRpGquUF
	 zmERS0/fY1Z96oWeXUbG1RzRcjpRiTYIKoVbZ41hSgLBaTZsqnjP7zhJBmYFy2D+6GJDm
	 vA7/Dwa3RvR0isbxW0iExhA5awMlj3lutDymN+1ex/lfEb2HVpa836L5i9MEQQi1eng2z
	 UUqdOnadEYHGlQ9vMiL/HnE3QtP4MI9v/GzlXUlOoy42fkRqX00mqmlP2CJwl6aP6Pi4L
	 qp+3os6ce18Zpotf2LcqxQ6wWqxWSnk8OmL1p7eJQsKIcy+Ago47kzHK9WquKv1g+Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UOn4hDwfQTw/XYPgE2jhZm1AB2+X5E33KlJWlVFviUU=;
	b=cBEttnNFX41xWoHWUzl4ceWO5wA6HqVovj3VARExLA3EsTZbMj9hUCSIxElnTkmOtvhi
	 NxPqmccJs/wtjKnXbTjeN/KpE+WRGzTwU3dVlAVpjRy5b8s6YtA8tjeRzEkWpQKwn7Pki
	 EVe1kzdH/Tsl1ugh59AhR+hI/nPtOp4s34p73v2Pnib5RlQ5V91UE7lD0By7gZU0spKTd
	 RyeuM46rVjTmLVotN97scFKvmoAw4wKx+vFDIf1vppOalx9h//FJe0RgnDpOhdmeYOZEa
	 cv0KdNyfA0h7Y4JUfVCWwP+sPo0G1A68rQRYWjUcl2wbnC0Czs9RonRWN13sZPU8abQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R988hr3O;
	arc=none smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B560A2606
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 06:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D58B560A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R988hr3O
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c14f3dab09so2027157e87.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795503027; x=1796107827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOn4hDwfQTw/XYPgE2jhZm1AB2+X5E33KlJWlVFviUU=;
        b=R988hr3Os4IeqdwhkRpwxXQAWDAar+YYhT+uJqAPhgzJZ2bKJSuWBNr7bBCq16YaWZ
         ZNiA4so9QiTCbRiLpFwWO85Ik9RjiyCFy+z9kyRf+vnAnJ7Mma7lUhNLMnqz64Nop9pi
         lGm6mKyGsyrxWOIrwbNA24bvXoAcCJa4bHI/bexoowh4moJSMv3DaSEAdtbbtrkA3vZ5
         uXnELVA1zmNYgSJssKunscMhnYKK4AyxSRDWmcBS0FMijKiZg6yN9Cu+P0NEkLV2XhzV
         gyf9gtWGVkw5dvNBRMFaIqivSW46H7E95nwWLCgzWv0fXzDjh5KrX4O0SCnh6HNmFt/7
         Uurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795503027; x=1796107827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UOn4hDwfQTw/XYPgE2jhZm1AB2+X5E33KlJWlVFviUU=;
        b=nW+Iw8/tTpdouZL8HX4mMm4NDrLh+U6UKR7TPb0WDr/XZEWCf7EiFu84GZGvIurflr
         4N8P3+7G1EI7hjBPmruQkezcEVwlwaGITTAQePhknXj2o0IOOJU8LPsI/jnjh3u7EfaQ
         sPLBiY/qQGvdm4pRF02Gx4mZhX9Hvl0GZiSywGsS2xfeFFJAookzu/xzGrZfLc4iQQDE
         0SwEb30Z3MHpPRf1LgmHJmgJICFy/w+Nl1osaE/ENTmhDRTqaLkP3Ypt4x6UzV6+ly4V
         M6ajUDsfOFhHkkqSRyhd97dRi5GOf6Ljt9gOTMFOo7nEuo1MlkVp4hsvk21H0NCHfwfI
         V2Ug==
X-Forwarded-Encrypted: i=1; AL+hErGNIrPpQ48NCsSb2wKqjbKGQgTJYL9jsHH8hUffOuOLauSl2xNdzmgZxYj5d1fY79tE8wyvgjAkUoQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XpuGhPq+x5pnLcgis1zTs+xevfvGnLJE0DAszK6oyutdBPaN9
	c/Z+d+4Ycw33zRPjfVC9znpMliKMXeRHOlhScrl7nUT9RV2UoHPih3Ls
X-Gm-Gg: AZFdTZcYduc+2ybr6SLHZ39cGdwn7pXgO5viXvPcJ5YcQt+8lE0C1nP+TNy3cBUbG5R
	e8hLPY5WCA44geZOV8xXIO1B47so0eK4oyKLczs3H6yK37nGQpS9kSm/y4WCrGqs+VlgpgA+J54
	+UOaHDoK79IG7gLiGp7oumvUlqxO85yakiRSgoSg+9+89SgLqoOXp6Zb+zqJeBbM/BML9mA58p4
	VJxKWXCM/2gGbxbEajF9TsXxwnAS7bJBOm/uxhKVg4+jBdaNrX3tsS13ZfAVekDJx9exOSIt8Ue
	s+bZ15DNmzHVjoGuhCGDSqYt2CNk65BkNqzHP5qk1q6g2CXv4lMCjAdqPU3NpW6qxkz2mFqclvj
	R2xOO5fAE+pTOKFehogFEW6wQKw/jpndgty4Fjq24LJyKq4UYVrBy9sQDjqstWbQ+s1DAfkGC9p
	SF55Los25A3mrKLX0y9pb2MDVqQedQuWq1/Aqymy3Xry/CFNy+AvfOuiUs73wRHLobGb9NJ9JPj
	OmQe2SzYohJ3hx6tTuL1X/IzuH4Q+QNmq6LFSypQKtHqTixJhihwQFGe/7JFhm4XulNo7JS3kJp
	L2w9VaxpH9pkqSfbTgys7+ZOFAXIt6D5i65KmawulnEVsavmvWLfmyZf9LnH/RupS+yFp2xUKrZ
	QFmgSXLLpG+4enB4sg15Xc+WtYsK+EfqgQpDolac=
X-Received: by 2002:a05:6512:2255:b0:5c1:4f2b:a2ba with SMTP id 2adb3069b0e04-5c1bc7da45bmr4469860e87.34.1795503026920;
        Mon, 23 Nov 2026 22:50:26 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd018b45sm3538556e87.41.2026.11.23.22.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:50:25 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 6/6] iio: pressure: dps310: add debugfs register access
Date: Tue, 24 Nov 2026 08:50:16 +0200
Message-ID: <20261124065016.185124-7-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124065016.185124-1-zoone.rupert@gmail.com>
References: <20261124065016.185124-1-zoone.rupert@gmail.com>
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

Expose the registers through direct_reg_access with the core regmap
helper, so the configuration and status registers can be looked at
through the driver's regmap instead of around it on the bus.

The access is not serialised with the driver beyond the regmap lock.
Reading INT_STS or a result register clears what the driver waits for,
as it would on the bus.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 9ffef150cc4c..257fe25c5ce1 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1563,6 +1563,7 @@ static const struct iio_info dps310_info = {
 	.write_raw = dps310_write_raw,
 	.hwfifo_set_watermark = dps310_hwfifo_set_watermark,
 	.hwfifo_flush_to_buffer = dps310_hwfifo_flush,
+	.debugfs_reg_access = iio_debugfs_reg_access_regmap,
 };
 
 static int dps310_probe(struct i2c_client *client)
-- 
2.43.0

