Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158709;
	b=2piOZAjuJsG93Tw4BQl5Bh67WQ7yGNhMkBBelpdTOe61XmtPsOq6K8jMEMCbidgXU05X
	 V4lecpogIGybMPi8dJmxD75/kp1h3Rs/U/8b3ANr9cTQN781RvSWGu8Pp126YubiwbDiU
	 f1tSwknAtP1qB+suQjFLuNdI+WgMCiS1EQYWL7NldnUWhbVpvhH5vHQp9XCyC4bp8nRBz
	 sebpf5PnwPohLzJj3uMxYV7AsOydslU5LWZ1crdf2AFtNVlgTNPcm3tmF65Y2ziFiV3cN
	 5pKyo4f63c+45WVxrotIYHF8g3q9J00maSNu+W0BtMYn46DCH4qUtQw2Jrl4Ei6CrYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ZYcSEIgCONYtlbHqnci5fk7UF2V8SzY7hNlrKIegE6Q=;
	b=QHS6pDXNsBqhAv+Khn+Y2OV76My5qaONb9j0QUo3J5DVuoCfppQCZVANI3nnvjbvUE6E
	 8qDWquAeDz11QgDsN0s85yF8D+ezbaSwZZ3lJ5ftbsMOBcCAjeoVir5IRNkIbOdczSjLj
	 F8XHCWdzaSutrpQFwTM4tborBNIwbj9AduyWKMiURw6JeAgyQZCn4F3komrW7DTJSfnd1
	 CagHvtM+NrTdFvfnGQvVpqnSwAqDA5LXqtSZ9i2q6rtM1W3ikl7wwxCyiIPkhMXbXm5Xr
	 dDjDf6aQXvEMeqBUL0PHCFr7IK4wMqhcDIGgVQCApg5MxYFr/ahzS69NPaaHzJyFsGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cY3wVExf;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7E606A32A
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 07:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9C7E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cY3wVExf
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so414170e0c.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 23:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795158708; x=1795763508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZYcSEIgCONYtlbHqnci5fk7UF2V8SzY7hNlrKIegE6Q=;
        b=cY3wVExfxPZ2HuYD1gC6SjxY5aXrC/FSRO+d99hIoE8PeVm0DkEVbGIJmLgwoohWpn
         OWt35bs3SUZF4STy4RlGWfInxxHExlO9UeyvH6Szbgs9m1WzuXgc/9v7Y4FVNzHCj+Pr
         3lrt0AaTObx5a2bqjEunTN6Gq7wgMEu2bksHIyBcJIfYnXXZYU5nZSk//ucnHoOGP51g
         2I8/k28JRjUlUGwzERiPryAd5gT8opa0L8QAlWe2szA7TytT2CUmcpXVyKzVqoesKla3
         OUE1kqBSJ6qdzH+GCSmFi7IMLJTG9XkwbOqds1Ddbe7vuL6zTMmOstJPBUAfAvp6KB64
         d8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795158708; x=1795763508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZYcSEIgCONYtlbHqnci5fk7UF2V8SzY7hNlrKIegE6Q=;
        b=XgIEAeHQgMKLJuZJkV1w0gUqVASyfspCiBfEr7K4vc4NR1fOtGrmc0GAzQwebi2cYA
         tVahO/+IzqAM8KiH0VNJ3dYZahA+Sxdf3rWXy0RzQDPUaGc8P4mnFNeBkGyzLf+NTXYn
         2LrVvk+tNfCWPemt6AQBx6JnI3sU+g0kgCQlkq1kGwSIV3MYBHBQLe0j9FPkUK4K+uFt
         u96CtjKBwQHfoxAkNtqTAIIWCVetMvgyjjbWX1nQcsTHXFHkpH+bTNf6olBfUlO7LS7h
         preKAqOnwtoCb/tJoRMFIdYN6d/stPabGjKb3y48gJP31zo/i2sVYpLDkVjeLKBgWKhR
         Nf8w==
X-Gm-Message-State: APuU4Z9tHth1XvBmdwfBN9ZsPpO2ob7VWkVtuZR+bI1IqsEaNoBMrAtq
	lGUNolwgrsACRynLQc5PhbExaJLWRO19vpQDNUfKpS1EwdgQb2hz6qkI
X-Gm-Gg: AZFdTZdm80qpxk5q2nRoJOGt2g96ihKxno45VnCRLpWIHVswtxhS2e9PZ0dr20cbpYM
	EDp4noRs76tcUmRyu6LQScsDDqqNiKo75KMEDerNnNjnwtO8f2bgQZr/hw3ixa1hr6MgQ4zjZt2
	Ftmp5cVTAsR0tWhTKdrL1OwhX7mAIHZ3XS+Ty7Nzt/mV/VfMw91HagoOSR1v0by1jqaEprDdLdc
	4jzwTyYlsWt0XzzcWJ1/0HLaXijQNRPl/QkD9PQk+IV4eJopaw5D/4ocBresZYYT4fCOVo6vG4O
	iqD3a6f1RHi/RmU3KTdYCqRDw5bp0DON0nI8SoA7XsjU3PUybATK3zNZs5JVvtv6iHXrxV3W0JA
	xBUwSoo3coPz/J3J3nWSbtzQqpOZmqd3wUzHTYfIJZXLMibyN0+EbwYlnoN6kzLrFk1IHjCv3EA
	7vPEPQPWOv70E4m7uuNDqCRc+nN/S5fWAKkJZM6hqDqOSuOD8B91vwViGVsUhSmJFu1G4xL8kDw
	yFyLAUn65e7U2h08ov+XCCM1iy00Z40R+Hv/J+hgL9ayjSZhNtgza936qmShtF0GlNxvEFNlgF9
	y9LLQrdBY7mXb5Omfw==
X-Received: by 2002:a05:6122:78c:b0:5ec:d84e:3833 with SMTP id 71dfb90a1353d-5ee8af37b8dmr1178516e0c.14.1795158707829;
        Thu, 19 Nov 2026 23:11:47 -0800 (PST)
Received: from [192.168.0.9] ([2a09:bac5:565c:aa::11:204])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b653081sm1773611e0c.16.2026.11.19.23.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:11:46 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Date: Fri, 20 Nov 2026 01:11:38 -0600
Subject: [PATCH 2/3] iio: pressure: abp060mg: Check for short I2C transfers
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
Message-Id: <20261120-b4-abp060mg-fixes-v1-2-2baf026cde47@gmail.com>
References: <20261120-b4-abp060mg-fixes-v1-0-2baf026cde47@gmail.com>
In-Reply-To: <20261120-b4-abp060mg-fixes-v1-0-2baf026cde47@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Marcin Malagowski <mrc@bourne.st>
Cc: linux-iio@vger.kernel.org, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795158700; l=1282;
 i=aleszlucero@gmail.com; s=20261104; h=from:subject:message-id;
 bh=fHqYDL4pQxO3curEMGvuqzCHge379XjsqyMv//0YabI=;
 b=2SQ7/WHVucdoREDR3ZgJw7rnFxKohm30F6jZz6wTj+2HbGJTIJcC6W0RcRpHTMWwglj4qh4Gg
 EjddXHdGm1/DnKcV271WtPEdUkhO3tvuBERfbxP8OHkZymjMVzkAp/P
X-Developer-Key: i=aleszlucero@gmail.com; a=ed25519;
 pk=zRzEBMID7l1FXqr2CjfnlIn++3m3N05FuNYb5zPA3cw=

i2c_master_send() and i2c_master_recv() return the number of
transferred bytes or a negative error code. If a short transfer occurs
without a negative error, the driver currently proceeds to parse
uninitialized stack data from buf.

Check that the returned byte count matches the requested length and
return -EIO otherwise.

Fixes: 9ecca12edde4 ("iio: pressure: Add driver for Honeywell ABP family")
Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
 drivers/iio/pressure/abp060mg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/pressure/abp060mg.c b/drivers/iio/pressure/abp060mg.c
index 9a9dc2bfdd40..895deaf24427 100644
--- a/drivers/iio/pressure/abp060mg.c
+++ b/drivers/iio/pressure/abp060mg.c
@@ -108,12 +108,16 @@ static int abp060mg_get_measurement(struct abp_state *state, int *val)
 	ret = i2c_master_send(client, (u8 *)&buf, state->mreq_len);
 	if (ret < 0)
 		return ret;
+	if (ret != state->mreq_len)
+		return -EIO;
 
 	msleep_interruptible(ABP060MG_RESP_TIME_MS);
 
 	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
 	if (ret < 0)
 		return ret;
+	if (ret != sizeof(buf))
+		return -EIO;
 
 	pressure = be16_to_cpu(buf[0]);
 	if (pressure & ABP060MG_ERROR_MASK)

-- 
2.56.1

