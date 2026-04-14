Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2623E275C
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170246; cv=none; b=R9X16tiJrZE2lhpYPndZHq5PKm5ygwUKbD5IbY9N9j8TTqQ+gF6C/yibFEzfFtUZEDaEhlQJIye720AcFh0TLw0U8iE64oZKfyY5GpgRi2DI7gpi6Zro13fwmyHjvM7rdeBRB91mgwQXtmwnF7Y6qrmmQiD+KVVMk15YpbMM7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170246; c=relaxed/simple;
	bh=v2rZtfsGEcqvkNleqRX3XjmSo2Lct8wNsREjYiEreN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fotd6dtRHYeffUdRMYGxGixull1oDbGRVuq+jn+fcLM/Sv7QFka+cj7zQpvmWPo+VRopNHLi2vgCNGCfFab8xS2RvvUaMnjJTAjxml7TRu3dWubb+ofurqfwpcTK/7NBprKvQXKMxatQASp0UtKWoP5ARzZ5yG1RC09bw5j2yQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs0p5rNi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs0p5rNi"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso5642654f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776170242; x=1776775042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdS8fPV/eM7tvbU7iuT8bTWahQQCYtva+pfa9FZ/WIw=;
        b=Xs0p5rNiLVrqhDV8+XTIZeXZcEQ2sjMpUhG/t1I8Nyp7zrvD1fJs3E8SSHJ7B+d0bL
         tkKtbYMN/ZSAHifB0Xs2tJ6PFi3TaAeVqCPr3Vim3avhyuAxo+BCUNsfqzdO6FJSf84c
         a+lWNUFFmK/UYMTAfWHuxLraa6BOuQcFZIejfiteOL2sIhPvbEeAu25amGW+eMm+Yqho
         nz5OuC6zOT+rbONvMnU0HNaC0ypB7w0nifi4CSt6vJQApuoJC4UiR+8lFpGjHLo76C5C
         Oj9zwG3rNwnR5v1+3I5p4l2GAJVsyc6r19Gtd8Vi4E46qwLBHIzqujMRkm4g2hMAC0hc
         p0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170242; x=1776775042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AdS8fPV/eM7tvbU7iuT8bTWahQQCYtva+pfa9FZ/WIw=;
        b=kdLXop4Zmc6sRE53Ai+eZ+QUgPMslhg/CdB9OsLZT5/rM+aag6g6n/0jZVq4H8sZKU
         4esT2J6dKBFaMy6lbsnSCZsF2lojIjyOZBoa2ZwPfhBpj/Jy+CuitA11DQmSlppQmDqt
         lEIHDWxthhsHjnpcE3PRA2cIznVBBBr9vdmc44VDrYIC5M1dpstB+p+86F6un6tckf7C
         lfSQMDpkumT7uw4krXHNWsjuWO1pon2Pw80L/0WfHSH9ibY1V4NyC0cuy+n2XWMFokPJ
         +VcobeipsCg/v+RCl/2OIjkYIPITrQzNYDdNHv8AieM54uNtPIpwxsgr28VjooU9S601
         qBGg==
X-Gm-Message-State: AOJu0Yzn4l5ndVchiDZcTY/N/rgu2kjgPtyblPySit3ZuatCxRZwZFXm
	/KKnbN5YnZ1yQAgLLOU1Vpy5DajfL9/f3ZFEORKAL9n+AWQ4Z4S+WB4/
X-Gm-Gg: AeBDieuAGHHWIO9fva3wLt6KlwD0idq0HOWywwnqjjbwTwwTtOqKCgOfXmYRTC53U9h
	B7qcKBaO6jf48kx/wtvzSNpnvCuwbYbJyN9M3smeimBgQd2U4Q7lhk79DMFNQadE6L1iC062neD
	PDP1w7+cZ8yhl9U3P7THhLAOVxGv3c5Gie4UoPcnVrO4UEFnOHQoFpvgOxJtm3Y6zOFgk1b+Cxe
	GzmkVV3Yq7R9OeNrQNMylIrsufsg2wRMhhl7PLsKd2IVjZuTMchu9SsgHOAMRGsms3DzVo4B/vj
	Kfv/F2O2TQqEakSrF/OCujKmeVad+8PHAlEXYD/an0HRR8USEMwK8O3SSf+6e6bhBifr8dRXBz8
	w+u+p7pWr8hOCqkqXmLIeXXgZAtX7uge2oKBCk2d3KmIvjwIbs7wysuduhYp4nany2nba2J6lgK
	QHUmpPz5viku/4b1XjLS/N4VJa35EBnV3I9R5HJ/ic
X-Received: by 2002:a05:6000:1acd:b0:43d:c2bc:21b4 with SMTP id ffacd0b85a97d-43dc2bc220emr5518320f8f.16.1776170241076;
        Tue, 14 Apr 2026 05:37:21 -0700 (PDT)
Received: from [192.168.8.79] ([2a00:f502:260:5bd3:9217:8960:5f33:aaab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46a85sm41552729f8f.24.2026.04.14.05.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:37:20 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Tue, 14 Apr 2026 15:37:17 +0300
Subject: [PATCH v4 1/6] iio: light: vcnl4000: validate device by prod ID
 instead of table ID
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-vcnl4000-drop-enum-v4-1-59fde2932a0f@gmail.com>
References: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
In-Reply-To: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2

Add a new field for vcnl4000_chip_spec and check if we have the right
device by that instead of the index from enum table. This leaves the
enum table being used only for picking the right vcnl4000_chip_spec,
allowing us to drop it later on.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
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

