Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC9251476F
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902426; cv=none; b=ZvIfVqyH9A3izLvwo0oT2RRBT7a4UkVGVTD6fUD0rwg+3dk0rYGdCSXXOlXq9KUQzvrejiKTLDtDZSJmzi/8+hc7EjYoIvkSLTuTakbmRr6zwclsIM8zpfsLdnnLwAECsXizzEOv4YC8fpy62hUDXWdK3KgYEjI+fFQEVRhr86M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902426; c=relaxed/simple;
	bh=r7eQ6d7qv9Fd/ilFwfypCuQphuUz0Yf0KwiBkvXRmi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2MfKh5M8Abc1ouCozdi9VHbQCU2GyEYMvGz2bclwYXc8WP9uv6+UkdsYob2pi6pg5PmeZrpvw8AGdJUxDSTS1hJRRbLoTVuPHtDFZIN3A8S5yfwNyrvbXq9jNd4zHINg4JcTlHOyfWQnnaqI1/MC5HnQqN6nnP5Wb2ve4dMOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGGV+QLl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGGV+QLl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so19022985e9.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902423; x=1792507223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dNT9oQ/aVECKcLKoY8+HP5EF3DzEU06F5k2iH3LR0AU=;
        b=dGGV+QLlqM1B89e3MlVPOiUJJ9NrU52VUymwmD8RRKivO8rKTMRfpH/cwsKTFUQNBn
         4eoE7/Lyt/cxRnx+7Yozw/tolVaylqjEMK0dvvYS4MzlUeMiPsLdPCI6onpeUTYgk75E
         htotsYuVewbUdWaGknveK/8OF0hMqDJ+vtVjbRxvI4+3/qw2e9pfoQTz2St7gQheryea
         IG3ioyfdbZtG8tdsljA8VlIvqpCsPWe6I3aysIOuHn8/wPdaFQ449loQcMwP6LCCCIwt
         2ZHyJHsQeW3eWOCY/iAb6zaeae65oDA1hvLoXOjOB2VHESh3dKiq3gsIzT6/ylDe6gX5
         XMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902423; x=1792507223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dNT9oQ/aVECKcLKoY8+HP5EF3DzEU06F5k2iH3LR0AU=;
        b=YCy1YT1xvjb3pom2UqT5eOuOTJbiuXKkqSlVMpxKDue23rjpG36J4CCLbzIK4p8g/i
         yTjjD4jo5lUGrgiwpCeqkylnOC5oEsZ3JIbsgrJzTJc4XwEzQzZH4aOdzegV78WXlAwI
         8V14/cdVI7BAdPfRi4368BTBMSespBU256uybcCNZ74hWYiFXCDDLD+IMO3k9DOnPPTN
         PiG4N5yB2OnOBhSt9jjOSGvhp9qBLYqNQiRX9t6Fu41rGvkG96KZ4vCTVs5DQU31AuaL
         dSgjv+f5xu6pMeRrDeM3DQzKI9Sil5gyp8t8o8zcf/eXgJYY2k7/C0ImcebHRLSZwcoj
         ODSA==
X-Forwarded-Encrypted: i=1; AKwUvBxKTTDfe/BN0KboqYBCeQBR/oOV+1lGphuCTojU0ffKDhXnhzY7Q8C24lkxkQ7dEryJuyrU6ON9TC4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9CpDA/+XNmMULQArGhgl/MYVemBzDMQ1KljgBhkAO9YTbyuBO
	cOlh7OKIWdHTKuh5MV2XNQCdCPB57FXWCE2RUQo60HjU1v20mNRq8QoJ
X-Gm-Gg: AYBFou1puYzHOGEGPRRhxfOD0jfN2r329IThUQXbolmYASPjpXMLj9TSmEpr5VrmLXC
	tDADxpPy8ZltHNaAfw3SPszNhh5xDiV2zIAj+Zl8gtjY+le7L9ArUfhJnaf+rnOa3pqI1QiaGQ0
	MgOX3VZfCt5Xy17gQoYadYTI1OIO5/WTImFwlj75UZZKntwVDuBs5kW2s5q7JCy8mZoLBxucrEG
	OOOBEVIM9C4OzZUK0ihZREI9ZWeRKFkmEbMSUmS/ZjurLNTf05pgzZit302058aME1Lfb7BmUbM
	RN8KwlHnGxwC2UhMNgnpxkwIYHYNUIgOLH6cCr0uiHcJYKVD+AAxKRffDAr9lG1HcOpzhYPr//+
	aATC3WMwpoV4OZX8wsQIX7TMLGqePScvg5gMmunWn+hDQFAWO99qnmiQcSzfW6ihPPtwYwYxqw4
	cMzltc9d76NjoqXFt5D1adnfrXdloSfJjLOtvuV+ZuxwSnolM1uijQWQfMOLy/F2N24Y7kwA161
	RKRzL86gUSZC7UsIRgKYdJmoiHbVCNj
X-Received: by 2002:a05:600c:34c4:b0:4a1:b027:99dc with SMTP id 5b1f17b1804b1-4a1b027a161mr22345015e9.18.1791902423006;
        Tue, 13 Oct 2026 07:40:23 -0700 (PDT)
Received: from mm-ntb-00805 (ip-94-113-240-150.net.vodafone.cz. [94.113.240.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bb6b3cbsm294892585e9.0.2026.10.13.07.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:40:22 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: [PATCH 2/4] iio: light: tsl2591: add I2C device ID table
Date: Tue, 13 Oct 2026 16:39:41 +0200
Message-ID: <20261013143943.436816-3-ciakval@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013143943.436816-1-ciakval@gmail.com>
References: <20261013143943.436816-1-ciakval@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Remes <jan.remes@mycroftmind.com>

The TSL2591 has only the device-tree matching table, so it cannot be
probed on a kernel with CONFIG_OF disabled.

Add I2C device ID table so that the sensor can be probed.

Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
---
 drivers/iio/light/tsl2591.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index f56d31404c25..d9c94ca5aa26 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -1149,7 +1149,14 @@ static const struct of_device_id tsl2591_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tsl2591_of_match);
 
+static const struct i2c_device_id tsl2591_id[] = {
+	{ "tsl2591" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tsl2591_id);
+
 static struct i2c_driver tsl2591_driver = {
+	.id_table = tsl2591_id,
 	.driver = {
 		.name = "tsl2591",
 		.pm = pm_ptr(&tsl2591_pm_ops),
-- 
2.53.0

