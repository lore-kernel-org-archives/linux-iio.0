Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243506;
	b=Xm/6FwfP9V6J+CuH4bYUFS0AN6phCwQhgETcK1FJ5wQxEPLTvwsPXD+K0oEDY+HwFX9c
	 HwA+66aRhOBrqe1nOqQEq/qNkCoBCNEdfxa+XBrWzZCbAEkVhsZJ8ECfrzVX4TXwodn4U
	 mTACS3k8r5DO5AEuijbOdxyVsdVB38JuTQa6FsFqluP4N6DkGxxqdIgPVGvPU4dinZzqp
	 GoUg8foYWgi8ZQ3BB99u4cIEXBETUIYzISlzs/lF4jAy8doJI5zGE2cBgQmkwJUKi/tJu
	 I36nH2mB6x/Wom8Gjxd3xVHnz9X//lZ57FOzSYZLj+9/syNKtR8w+m7OLnvWCy47VAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eSAwas4dJBF9jfHCYoC/64Xh0kqrlKU4nkHL6IJyrS0=;
	b=Qq5+zD0EcKYvI1XUBVo+f3gmG1do17kXTvjUPLE0ijGnPjikJBYtx7XWI829QuS03ztM
	 8YsAZAMUIWVEdY89IIQY2w6YY1PPOWhCBO3jMXedHWKFKJGwGJhEzo3BkYAHgPsizq6We
	 xU89vR3dBLxq8QLE4QObRwPl1833Wo3wY1HrXi9tke+5oAb3DVxXlHM91kKIhvH4kCSxR
	 CYhl9blSP8R69cKkZLMa2kZsrq71gs5xW2nEtT0VYKkJdRTPruEFhyOreoOxo1j0qOJst
	 UJTrRcmnmtErEX39plbUKx52QCgMaV5/tj8h1Dbmi7UpXbDnafOu0+G6095SrZfybXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r3dp9N24;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A0606A8BC
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 135A0606A8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r3dp9N24
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso431370a12.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243505; x=1794848305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eSAwas4dJBF9jfHCYoC/64Xh0kqrlKU4nkHL6IJyrS0=;
        b=r3dp9N24PFEyp/UvhA3XPI704Kxlf70Ecf9UvwKfhF8hM4MiVRmKhFFRuBOqJQNqyD
         1tgkvRJPV2MarvKoD4DY/LHKP4ZqGcQyU4VoMxEOCp1yLlTYgst/xPvdhx92TKaHz8nV
         OS+8DL8VrmPzVL2mK8wIpYpZeAWWyTgieiOO28NHWUJUSSDqZDzHat6Qv8rwmlUKVW7A
         /Rz2la+v9KLGkRlOUviU8gv7bp3HlWwcxX/sP7N+yvgHk1q7bcsPZ5NY0dT1bqooBpZU
         bvZVte/dT8tD9a/MrpP1WbT8KNviJS26Zz2eJhHkAayjRGEyPuZSGRWV6DKH6hg7IRwO
         fvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243505; x=1794848305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSAwas4dJBF9jfHCYoC/64Xh0kqrlKU4nkHL6IJyrS0=;
        b=s3j40J6SZpYb/F96wljYLp6JvpdkYpsj3K6ym2N1RcPOfjmF+cQCVj4cltIg5gWlWa
         nrvnfT4HvB0PA6DIzQHlwQMjL4Mgeiz4RV1JYw4yhnnBf5x67NGhHZqhk1kjinGDwVJS
         9is0DZki/Cx8vzvmL1zo3za4l/zK6U6HTnpyCjK3ocZcC8VL13yqYNnv+iqaUxnOkISu
         8ChWMnc204bwtfCx+2lPm5Z6FVRDfxZlcTBUYL1YF/aj9gOGmWYvPAh+Rc08AsXTa+xW
         tFIhPk4iU8T/D3WIWwtcLGxo1m5RaJS50f++2bvgqDWC/Fgp2LlN4p6Bb+zi9zAaLN7Q
         V/Fg==
X-Forwarded-Encrypted: i=1; AL+hErEbPonX7POtMJTHiciBlOPBz3/GzUYMAXQuM3to7Q1MhT9PP/sjOwDw+KgmfqLxyFaMohDfHpjaoOo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1PKqozOAOfL5MeIvCtg/p+Fc7ReJpuK/dXbdQkFwTrhunKjA6
	hHBWbnDQ3m4dLXM+4AvxyCpln02HkQwhg4xyg8jikYOmA8LqFBPX9NimE0VdsnqR
X-Gm-Gg: AYBFou2V9tvn66rkXK/w/Bd7HYguBYaPiRby7oFkjQ3aEPT0/m+OyTq2xahH7dGsg1h
	z74/CJUilRr8IwyP8SNPuP5fhp8X47FxxtY626a8tXdMrWa5zUJpCloGWVQmiH1kjsLvr8JEISn
	bvkX6JJc1C9E+a4eRMNXqztA612VTMzJ3wQk+xmJ8K8adloWItjUyD+ZYcY48b5iPET3hmxZqTJ
	gpt99vRFgvNjqqP6bAUnE/K8lS8XprOBl2/IdLZDIVDJaEOmOHpRwM65O/xE92yvTMGAjw2p7vh
	h9k/JVtaTJVogb5vRhIaN0s7cRdR9eSmoivWnauZ0SZrkUR0vynWKoAJqsQJk5D5p6aPtxOi63U
	2aO2J4wjvnwM4fKwr+l9/XdtAE3fLxJQHvd7BPFxOmMpnfoyl+3RSSNVg6EahpI9iEce3C5BU/z
	7IquCRw8DClwm1kYTzMFuWHxgdX3Tma6tiEatzii7nJGXCSCS7W6/0uR39foFv31iDvVAm0CNFK
	Vc4i/4ULZ+cLXPyRPZm6aaGDMLrjMh4UQD3stOGcOEil3WetR9rQDlh/QMkjkOWZTIaCU+3/NX0
	E2yhHeniM8eWa/3k9QrRagdO1D2QDVfwPkxj/TU4U8kr4iJ73x34RSWLvSo3r1hKPdC9K85BqWc
	NPQQw
X-Received: by 2002:a17:90b:2d86:b0:3b1:2237:3c93 with SMTP id 98e67ed59e1d1-3b166c93125mr212316a91.18.1794243505322;
        Mon, 09 Nov 2026 08:58:25 -0800 (PST)
Received: from debian.ari ([152.56.156.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16779cf05sm138766a91.3.2026.11.09.08.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:58:24 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v6 07/11] iio: adc: ti-ads1015: drop unneeded < 0 error checks
Date: Mon,  9 Nov 2026 22:28:01 +0530
Message-Id: <20261109165805.31160-2-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261109165805.31160-1-architanant5@gmail.com>
References: <20261109165805.31160-1-architanant5@gmail.com>
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

The devm_iio_triggered_buffer_setup() function returns 0 on
success and a negative error code on failure.

Use a simple boolean check instead of explicitly checking
for a negative return value.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 2e6bf45871340..1924c1b2abeea 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1012,7 +1012,7 @@ static int ads1015_probe(struct i2c_client *client)
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ads1015_trigger_handler,
 					      &ads1015_buffer_setup_ops);
-	if (ret < 0)
+	if (ret)
 		return dev_err_probe(dev, ret,
 				     "iio triggered buffer setup failed\n");
 
-- 
2.39.5

