Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC382FB97B
	for <linux-iio@vger.kernel.org>; Sun,  5 Apr 2026 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775405338; cv=none; b=X/5gvzWOLntj/WzypT4uZS9JiMFCrbA2gaq7GN4pBeDYKQN6aGHSqrWVOXv5Aa1JoSgXkdW/SF3JI1RmknPFrl55vFxTclK0dRKa5GWPumbXsCmbn5cgESbVYj32ihSuW1YimSjU/h0OYJXckAIy7iQmBsOVKKfWk6dgkCNLUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775405338; c=relaxed/simple;
	bh=VpvLA2sk63soR8le8LkGKvWDcGPULDAGakl1/zSX0wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrRnTz8qYqM6y9pv9oAUaHkm5V9Bt0AV5aX9BdlJpdLDWmbjK/Shff7OFlmRD/Y2amOsFzpoJgCsi/U6VheyGxoMjzy5LiZPL2OTE5IRSmF17WMwyENcnmLhCPVYCJMc3PSp3a/ig+/u5BmzR0A3I7TSYqgpmcpkbxSZ1O16i6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhD1iX54; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhD1iX54"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66e6d960ff5so2110129a12.3
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 09:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775405335; x=1776010135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywiInDy1yFOYubYwYax/CzV6b7EwEWTvrFn7OFi+978=;
        b=RhD1iX54mHKXXFOwg6ZbBG3LTMm7g4soocxqJeirvPlmxn1/SKAvcK9m7WOYR/b9Lc
         Hjx4qRY5TeQ/bf+O/ceW3bukI2H5QrMX6PU8PGlvikWo/4m4HejA5Ne9saXoEF0zkcSl
         yVCbtDqjMqP2WezuoFQXBXGJ2crbN1981YUW1wwwCmAFVHakyt4XfQJeJzavG0fbydAj
         QRQdOhoCjVX9y0EvZF/wDIrGmT7/0UTZ2VkuxqFftP4nv+h69uy0araxFBDHM/TORAo0
         ix2RxJ1KyiankQhVId9V8rB+M2p4aq2z9x4wKs3TfCqZxm/AfN30m/jJ7yqmAqcsCwTD
         2jMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775405335; x=1776010135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ywiInDy1yFOYubYwYax/CzV6b7EwEWTvrFn7OFi+978=;
        b=R5FXc54+xnV7h2v7oHYVlUhfPn5xG2dFmRbapTpTiQTc83Ax0pMwyiNPgbj0ax17zD
         AcADkb4r5G14i7304Pthc/0qyPLg3NIHBF9NlLl/6nnywWIbY8RK48u5DPXFziziJ+zJ
         oJS7X6IltqBIU26/WG/fNhMmBB5Mrwz0TPSCF+Fr0QC+gMF/merflaLz6KyIdXjsFSeE
         Vx5+JCzbQTLZG6AQ0eG8UAiXiF7eP1qslehPZKcNs8PxHn/7MAyE5EOOOUD1WFQON74I
         57R5bnVHUeY5/ntM7m3D+PwnldnRf1ZaATbGqs/zTcRqzeCWNWWX/VrMSMfW4JN4sKf6
         ZwCw==
X-Gm-Message-State: AOJu0YwdUdGyRaAbL60oVhIV7B8ihfFENwSVizdt+ep8C8t94h+4wmMh
	Oz+HTv5nL0bRHBCXMFkmyjIBFjo6/g0HEcLiiSxqDZqmObetuR5NSsQq4JAJudqB
X-Gm-Gg: AeBDieuquaboXgW4LdUX1cMkXyoJRmyHUwI7/zx0O695+IqhCfEPqyukRtSusS1z/EA
	WzIvFiS/cedzjKXRLzxQtJ2bWds4ceq1lthOru3AvwafkUPTWJbqmpiVzZQC9wc3U7LxNFPnLAR
	i2G3uKIPfwKIvL9TXElyZq4Pr3hF0ZwjcdFn+Ueq3YCgKzFLtTz+7gGXeIW09K/oo/zezqgxGI5
	lmx3/Selq580wyD0FXYAfDUUU5HuehdDKntlHiEMoAVztbMIQ57XfAg5I8Nn8nfvYM1+etebLlD
	XjT+Fhfy3ozX8OnPMiBsa3yS3ZlrNenxchG8pFYhFIaMNRFCbcoBsTwI1rfz4xoGQx5rrFW0/Wg
	4wlEhWZUunHPHhPxNKWGZFIQrgEvYNbbiZeJvxi9pwWf2nGmGFJTGndFSocT3d/OgjCf499hydf
	qyp2wVIB4phxmZKsT/U9RGoWYsKg==
X-Received: by 2002:a05:6402:1ecb:b0:66e:f4c0:c077 with SMTP id 4fb4d7f45d1cf-66ef4c0c17bmr327308a12.16.1775405335015;
        Sun, 05 Apr 2026 09:08:55 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e02f389absm3195890a12.13.2026.04.05.09.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 09:08:54 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sun, 05 Apr 2026 19:08:38 +0300
Subject: [PATCH v2 1/6] iio: light: vcnl4000: validate device by prod ID
 instead of table ID
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-vcnl4000-drop-enum-v2-1-7c8dc98c3974@gmail.com>
References: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
In-Reply-To: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.1

Add a new field for vcnl4000_chip_spec and check if we have the right
device by that instead of the index from enum table. This leaves the
enum table being used only for picking the right vcnl4000_chip_spec,
allowing us to drop it later on.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 9650dbc41f2b..72d68d54864e 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -234,6 +234,7 @@ struct vcnl4000_chip_spec {
 	const int(*als_it_times)[][2];
 	const int num_als_it_times;
 	const unsigned int ulux_step;
+	const int prod_id;
 };
 
 static const struct i2c_device_id vcnl4000_id[] = {
@@ -265,12 +266,12 @@ static int vcnl4000_init(struct vcnl4000_data *data)
 	prod_id = ret >> 4;
 	switch (prod_id) {
 	case VCNL4000_PROD_ID:
-		if (data->id != VCNL4000)
+		if (data->chip_spec->prod_id != VCNL4000_PROD_ID)
 			dev_warn(&data->client->dev,
 					"wrong device id, use vcnl4000");
 		break;
 	case VCNL4010_PROD_ID:
-		if (data->id != VCNL4010)
+		if (data->chip_spec->prod_id != VCNL4010_PROD_ID)
 			dev_warn(&data->client->dev,
 					"wrong device id, use vcnl4010/4020");
 		break;
@@ -1901,6 +1902,7 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.int_reg = VCNL4040_INT_FLAGS,
 		.ps_it_times = &vcnl4040_ps_it_times,
 		.num_ps_it_times = ARRAY_SIZE(vcnl4040_ps_it_times),
+		.prod_id = VCNL4040_PROD_ID,
 	},
 	[VCNL4000] = {
 		.prod = "VCNL4000",
@@ -1911,6 +1913,7 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.channels = vcnl4000_channels,
 		.num_channels = ARRAY_SIZE(vcnl4000_channels),
 		.info = &vcnl4000_info,
+		.prod_id = VCNL4000_PROD_ID,
 	},
 	[VCNL4010] = {
 		.prod = "VCNL4010/4020",
@@ -1924,6 +1927,7 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.irq_thread = vcnl4010_irq_thread,
 		.trig_buffer_func = vcnl4010_trigger_handler,
 		.buffer_setup_ops = &vcnl4010_buffer_ops,
+		.prod_id = VCNL4010_PROD_ID,
 	},
 	[VCNL4040] = {
 		.prod = "VCNL4040",
@@ -1941,6 +1945,7 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.als_it_times = &vcnl4040_als_it_times,
 		.num_als_it_times = ARRAY_SIZE(vcnl4040_als_it_times),
 		.ulux_step = 100000,
+		.prod_id = VCNL4040_PROD_ID,
 	},
 	[VCNL4200] = {
 		.prod = "VCNL4200",
@@ -1958,6 +1963,7 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.als_it_times = &vcnl4200_als_it_times,
 		.num_als_it_times = ARRAY_SIZE(vcnl4200_als_it_times),
 		.ulux_step = 24000,
+		.prod_id = VCNL4200_PROD_ID,
 	},
 };
 

-- 
2.53.0

