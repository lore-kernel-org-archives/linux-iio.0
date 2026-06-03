Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF4733F8D4
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498402; cv=none; b=DS73FIJ9Fj6W5KASi7DoP63UZqMgWoC+bcYgDzL1FxcVtQfQkg6lq/d1/LwmmrHbTrDQw2DBUoRFa9fNIA9oerglPeh/zjV8Pa3vcx7T0QoN1Sed/jrNeYgsToYSiiAjGFMzkL0TnvxMryn2L+ZAqsfHipqgw85dyV9e0sbgEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498402; c=relaxed/simple;
	bh=fl0AOOMrv64Vs9g9S0kA7ww829mKQewnMQR0lDfBafQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ico5A0xXHQR/8WjLFm/DFmn5iVTCWtWJnrBe0IX0idnS76aWbGluEl8/D/6f7Rh+lgj6jh/JVJQ6dwT/uU2qZ4ePquUqmDLf+iaMln9eEFvyJBn6u+DWEJrfr+xyfAjeROVm5l1N8Og1foNNelEiEqnbCMxxUKVaroDnAboh6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6M0N+uo; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6M0N+uo"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7de68222e96so51484067b3.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780498400; x=1781103200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkL0W1MPhO9S/Xxf8ecAvCJWGs8h6NKPNpnFVtd7Rpk=;
        b=m6M0N+uoEhg9DVFmX9q3bLn1S5To9OGJeTU4sEnj26oe5oG249g2u6fMJNxuY7947d
         JRpGj1sFjKioQpO/dACScMhGKHHMyvDhtwVdeeNx7ElVPWT55HcYXpEKWfdBkr5v4nbv
         1aq6NqxeV/YDOhChlftBNGboHiD5RQ3z1LD9riPtR17bQnfCkmvnSDdJMMIAl3DYoU9O
         JYU6WAf2IFRvOMOsvpIl0wHJky6/FkEj9zs4/oGwBZQARibdPiYlA/7Q/Mbzg19aD8N7
         jT0RglIThw+9DxWyK8yJ7iZ8giHC82UxawrlapyYFe73yzmFjhFQwlAoVds1kBIYYnB0
         Vw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780498400; x=1781103200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkL0W1MPhO9S/Xxf8ecAvCJWGs8h6NKPNpnFVtd7Rpk=;
        b=ojfJenGCnY9K4hKzTJFGwgKcVfQpA2Jfq03idfJBvsQmit60BPTqJNV4H/pteNzlzl
         GJqghAR0i6DkH9qWV+etT5QPZZvGOQZErF8I7ToCuc31TlT9viwsuykIdrg3mmaTRHNj
         Edt+JOT7gHGJXYswPO5bV+lH6jc9IuhgwlRzUcn8G0DBZSiCdhxew0Yc+uB3+7ioB1i4
         prQYIMK/Sa0L8tHORkkRH6PfurbDJ5lrW5vX799mzELinzTJlLFFVi7C43NcCcoSF00B
         /Eezj0WlvmivK+8bpA/tyhMHVRBqfBq8Dnl67jsT2Y0ybP/PrqbQJDBlJ5EzbHed26gY
         A75A==
X-Forwarded-Encrypted: i=1; AFNElJ/iwj+f9F9KUHSi6abeHywKLiRrsbe7aMCcIrjOuBW15CGryONX/fcEyCy1b2XR3+8Ui0iIue+zMbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kquailvV9CDItM5jhATtVBZvkBxt3uHuwyQRyF61J0B0CZn0
	w72jaBMu4dOcP340dl2+v3AHS4fqctMpjYieSv864avshm3upnsIVXBu
X-Gm-Gg: Acq92OFcPOTS9mdLUzMXDL6zp6h2C/Xm4knRJrNYEN4S7wlua6TwXcwxSMrRtpork3M
	y0klLbLyYUyyh4KQ8fTdjC2t02mou/rTfj2t84a3dAwBI6VKa+Qj5sSIGFIXrfnZ+2eNwJW4G04
	e0RHPIScjyoU8dirJM5AsNSF7DbtAgoQBpB0ZqENLvguSqRTrlzPWkf+uw6nuxTh08RfRZhwD9f
	NkGJWjXTGOJynCFBmjMFDpa8AuNUhvi+v8tHxF1db3pVDktY0bWQzlAe9ZDTk9a2m/A/W0R+2To
	ckFvmS8Kku821MHt526FICub4IA6uWE4QFhZ81etEUVU5YftqySd23BpeYso/PDIHAAIzoIGpLl
	pY9L0qsqu63LffsKLDGd76uCAEDuXdDiftXqqK0N1leJtUdtbBzQTIPXjwHJsoF1gE2yCaLSDIF
	IntL/i6wx7Mu/RCiUrNuSe1T8qgTd7VkdcqylekA==
X-Received: by 2002:a05:690c:600f:b0:7bd:8ce4:92c with SMTP id 00721157ae682-7ea49b6fb00mr33679257b3.31.1780498400350;
        Wed, 03 Jun 2026 07:53:20 -0700 (PDT)
Received: from i-use-arch-btw ([70.158.100.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2409d513sm17985957b3.49.2026.06.03.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:53:20 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Maxwell Doose <m32285159@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: chemical: scd30: Use devm_mutex_init() over non-devm mutex_init()
Date: Wed,  3 Jun 2026 09:51:33 -0500
Message-ID: <20260603145134.58956-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code uses mutex_init() instead of devm_mutex_init(), which
is incorrect as the rest of the file uses the devm automatic resource
management API. Fix this so that the mutex is set up in the same way as
the rest of the device data structure.

Fixes: 64b3d8b1b0f5c ("iio: chemical: scd30: add core driver")
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/chemical/scd30_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index db5cc295aeab..f00979c0c196 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -714,7 +714,10 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
 	state->pressure_comp = SCD30_PRESSURE_COMP_DEFAULT;
 	state->meas_interval = SCD30_MEAS_INTERVAL_DEFAULT;
 	state->command = command;
-	mutex_init(&state->lock);
+	ret = devm_mutex_init(dev, &state->lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init mutex\n");
+
 	init_completion(&state->meas_ready);
 
 	dev_set_drvdata(dev, indio_dev);
-- 
2.54.0

