Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589E35D5F2
	for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907560; cv=none; b=EZfjUXZ5nmHJFfv26u2IVQTsRjmnd09MWO76bRKiuStJFfFZhtxafbSAxLGayl/gZ2qp3+hvLjPzjo+tQ/DITS9schI8+l6ewD27vYpYScCNtEeIs3k90iWblMRKmfDnLcFYmc6ltXQE7r1MCyJR5vP6IE54+igeRdLaY6gUXe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907560; c=relaxed/simple;
	bh=fy4LXU/WUrRSUNC3KYSIjdzX5OzOC+ZS//OJBVtQK7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MTV4HvyyIp4PlV0R4WqwRnW3Vvo5kahId2y4r6O77XFRWpLrlYaazV8hP/HfKfinqOtje6nO6wxlp76DeV+MgHUsUjxF7x866kVHZ5mFoCvNrJBWZpUatJxUTuw/yd/QKQYIlrFsPi980YHaBU6D86NG3zT8u4GhUF6WdV0TuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij2FT/i6; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij2FT/i6"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7950afac0ffso20398657b3.1
        for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770907558; x=1771512358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JG1I3xYlNRfZ4lCELzjfItlxHeuT4mtPnRcvecqAwg=;
        b=ij2FT/i6ctE7yOV/dNstWG7kJntnWslehKJtkBctgjhWLobYRfIxA0yohUJWFDJNv2
         N0GSMGXtNU4NAEnfBe1LHfoNR19e0DR73IkHjH7mspRoQ2ryX5iyUB8Eh0hSA3PvFTuX
         lSMZbHBXmEK/hLeSD6IjN+7cqWisp9HshVL6P/5t+Yl7i80nFcl9zs1JR7r5J5iVoEoG
         vKHy8kpo01NF4HmyS3vCtxIu8x70tLyd/iVzzlT6xc2IGBoNYJ91bALAYMsa40e2hU4v
         QqoOQwGqMcxUHwNWh1h8irfsysXQLfZm5tAy9a4rzltPyliS2NnqbVF1HojXeUd5qY8X
         oGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770907558; x=1771512358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+JG1I3xYlNRfZ4lCELzjfItlxHeuT4mtPnRcvecqAwg=;
        b=U+1Yd6QRMIcyINr91LicICT6Yz+N4THMgWzZboQUX06MqQixDnrV3UcwmatWLvjnu8
         4GZEsydnD32XiiVwgWjfGYjB37M3/FfZY3/MCNyhv/sY3G+SCVvTFPY2wX/mXaDaHWFc
         0GhRk58dKwzmxt9hl84cIpWDKhkpKKwCxTgfd6Ysb+zBsAu4WqwmfsC3kscSnpyWHVSD
         wjtd6o7TZHgNAqoxjcSqbZXFdlNnN5TqlYS3YeAK4rhas/Jw+Y75OpsGTIhMBIrlmSH8
         UeUDP29TaxPdjzWtYqVPLuHfy4VmS90CA7Dd7vLtttLvKZc5KEdgbx4bLePPal7E9Kd8
         vUtA==
X-Gm-Message-State: AOJu0Yw/ql8J5OxohS7VgNKVb4b1p1dsqPVGC2W+IT54zo17TDcOrCiU
	+w+QH5H7tfUGcUeYxvbNQrrLrGHhKdB7UgWi2Ppy0oIRcsk/d84V2g2q
X-Gm-Gg: AZuq6aL3Eq1JpVDfELGVbr5F/5jY9ND+k+uOTwdHDuCtbJBouknSP4wN67fZYJGpiZV
	9XTGt26dQ1Xg5m/QFYtUSbSm8xX1X7Y7yHgYgUMCJrRHtoakl3ntS8y3a1vpfMtWBbT+FEYrqve
	GNeURhH+qVkwxWlTch/kHupj8gMg0VFB5m81a4RA1fcWJ77EbmcuCBnAWPkwGHEh+9YMXfu4r8z
	dgABwPNNUmnmmouoGbQR8YdcQLeoGED/ZMoyV1VjUgfZs5mzZzmyV1YHsC/DFOwZ1eMUhhpjqNu
	1ge6lO1Aim7TfUrWd9W2ZFKZh4vy2uiQ6aU7Th8+hwOjNZN9ir+0tcD0NqcxWSyIJlLVI9lsXbW
	3S7IfQ3obSy5LtNn9L1eX1kmkXTeF6c/1MxDuB2j1a9/8w2rfXB88i9Gyi89hkGBGEmtQbeHH3q
	BBClPRnPXoGn7n/L33wS6pC3SKQw==
X-Received: by 2002:a05:690e:144f:b0:64a:d716:c8e8 with SMTP id 956f58d0204a3-64bdf2f7ce1mr2097988d50.13.1770907557758;
        Thu, 12 Feb 2026 06:45:57 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc83c201sm4897318d50.3.2026.02.12.06.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:45:57 -0800 (PST)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Thu, 12 Feb 2026 16:42:48 +0200
Subject: [PATCH v4 2/2] iio: light: vcnl4000: add support for Capella
 CM36686 and CM36672P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-cm36686-v4-2-8f587d4a72bf@gmail.com>
References: <20260212-cm36686-v4-0-8f587d4a72bf@gmail.com>
In-Reply-To: <20260212-cm36686-v4-0-8f587d4a72bf@gmail.com>
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

Add support for Capella's CM36686 and CM36672P sensors. Capella
CM36686 is an ambient light and proximity sensor that is fully
compatible with VCNL4040 and can be used as is. For CM36672P, which is
a proximity-only sensor, also remove the IIO_LIGHT channel.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index a36c23813679..1f8f4e4586f4 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -185,6 +185,7 @@ static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
 enum vcnl4000_device_ids {
+	CM36672P,
 	VCNL4000,
 	VCNL4010,
 	VCNL4040,
@@ -235,6 +236,8 @@ struct vcnl4000_chip_spec {
 };
 
 static const struct i2c_device_id vcnl4000_id[] = {
+	{ "cm36672p", CM36672P },
+	{ "cm36686", VCNL4040 },
 	{ "vcnl4000", VCNL4000 },
 	{ "vcnl4010", VCNL4010 },
 	{ "vcnl4020", VCNL4010 },
@@ -1842,6 +1845,22 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
 	}
 };
 
+static const struct iio_chan_spec cm36672p_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.ext_info = vcnl4000_ext_info,
+		.event_spec = vcnl4040_event_spec,
+		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),
+	},
+};
+
 static const struct iio_info vcnl4000_info = {
 	.read_raw = vcnl4000_read_raw,
 };
@@ -1867,6 +1886,19 @@ static const struct iio_info vcnl4040_info = {
 };
 
 static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
+	[CM36672P] = {
+		.prod = "CM36672P",
+		.init = vcnl4200_init,
+		.measure_proximity = vcnl4200_measure_proximity,
+		.set_power_state = vcnl4200_set_power_state,
+		.channels = cm36672p_channels,
+		.num_channels = ARRAY_SIZE(cm36672p_channels),
+		.info = &vcnl4040_info,
+		.irq_thread = vcnl4040_irq_thread,
+		.int_reg = VCNL4040_INT_FLAGS,
+		.ps_it_times = &vcnl4040_ps_it_times,
+		.num_ps_it_times = ARRAY_SIZE(vcnl4040_ps_it_times),
+	},
 	[VCNL4000] = {
 		.prod = "VCNL4000",
 		.init = vcnl4000_init,
@@ -2033,6 +2065,14 @@ static int vcnl4000_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id vcnl_4000_of_match[] = {
+	{
+		.compatible = "capella,cm36672p",
+		.data = (void *)CM36672P,
+	},
+	{
+		.compatible = "capella,cm36686",
+		.data = (void *)VCNL4040,
+	},
 	{
 		.compatible = "vishay,vcnl4000",
 		.data = (void *)VCNL4000,

-- 
2.53.0

