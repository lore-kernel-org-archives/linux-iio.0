Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D53CF041
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921558; cv=none; b=n2hJV2YSuODSbwib05zdk7vD6PgSi1G3tt7dO6dwDoOY3X3VBFGhgDcTAGgzfNYdPshlmfa+0eJNQj/ltzSmhq0kpV8pdaSavd0ku9nR43JkgxYXIoy3taUP6cN6bCWobp8Z5ol+yXsYAkamKSaviyc+qsIxBNrpPnq57J0rmCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921558; c=relaxed/simple;
	bh=vP7EEpgruq7jb0BDTrxCYCk5LMVt/Xx+6zryX3dg/1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sPFVfN3kqSfywo0JKZbk3YQphsKLGWA1kShx2xQYGKnB2WOuQejYhvzIdJLAHXBI/5vZKdkZd1hqngSCABs81nMtc/vrDH6pCKHVS7evhFQF8J2AHpzEF62TQ3p5gXg2Lqbn67v6LZFBBr71WnxiawJF6bL4jpsh9qQkUf/A/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7OQDXqI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7OQDXqI"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b97ed4ad579so138795666b.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773921552; x=1774526352; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmQLMk8d0z4Tj8kbX0Ny9TubbIjksPecuXhm9eaS99k=;
        b=l7OQDXqIkrquyEl9F9P++NtxrMfAcBxbuN1XXy4/TavPtiQQZz/KQ6Ltr9bdn4scDm
         Y6ASrV7Zf8b2dZsYPVqXSwAIzTkrqKurpGeHR+vHxBHKDEo38DO7WVL05AHkEYP8DxVW
         cgPT3Cm2a0vG4WQ16j7HZhZdVCigCVd/H8JowXiOpwxs8xYTvG9ombgdSx+rWrlmALyY
         S7N320pFRbB7AM39GAoSTMgpSennphYZjQujPsl7AXcu+tjP84HHLLCorEg0Hj3mA3tx
         jLGm7VTuCagDBbCVdRMjme2ymHcHc2+yj6j/fAhEBEDKLgluL6/pXzvhDj7/EJ419dm+
         BQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773921552; x=1774526352;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kmQLMk8d0z4Tj8kbX0Ny9TubbIjksPecuXhm9eaS99k=;
        b=bQWUel0OB/4aqLrmnB7At312loEvEru0QV4aB7TvTji9de44NK4mJmgKyHpHjOJ9PH
         Jx2ox9oCYY/YVrwXdnLZ82FUHZYoF2RY2/byXnEmDWa+cmzOYUNQnK2sc9Dt3a6q3LXn
         7OBJA6lgFhc7BkLNhfdWrwZadPSH+kEz67jiWGMnBabANZd1UDxf9S9jAUMFJM2/gXRE
         QJe5jga2Wk+6GJwFuYFPWwEwLP+iF1f0MgKZOzKEwHHXr2Q9jX4bX8aTvlvj7fajN1Ze
         rUgMKGQpQyLgFvBAbC60Zk2aM3jzUR+iHItmWhUpBzdFQq7YfLQDYE5GkHlkVSOx3lPu
         MN4Q==
X-Gm-Message-State: AOJu0YxBCwYzbjlv5bZi/0avGmGwwjxPpIOw04SD8pv/VGXkOqmxSswz
	hd2tgNMXcwq2C19tQEAeBI86tP4xu2N/R3HUXKWg4y8QKp9c8gspxzOY
X-Gm-Gg: ATEYQzwE77UIa+9OCzwqWutgesNsLan0iaJSeMtfa5ulQHd8S9lh4alIQMjCKENByiB
	V6oukBDdTS1DyTJyniIvl4BuIasygdhQ2VMGN8K2YxLfgIf41pNrPSqJNS3Ch3W/N/WT/KCFjSm
	/ZXiMKWCTsPSAEjgSNW2+vp0UvQfXSGeyv3iO9MY5gEitiuGwgkI554kZQk0xPPLxx8m0fv0DkS
	oo8ncNLwiBaPwiymnvzA9ladhrzkC+wBiB286xzvOPiydSAODsvfJ2PSWmGYBAtmIN5aQ/v9/Rk
	K7YHB1v3cWb33X2b1U0WacMcEZGAfaa6zYJIMDvikPZVZYciyLGPlbFCfUEfDyjzYRq3IuTV3cc
	/vp2IKimHjXFU4SDr7+khQTvHdL4dwjy4p1GyievXjt3Nm73yMHE0fsmLzFKE7u4cReXm1sfv1p
	arfBZWuAo92DIXHGZH2LTRFxeH0g==
X-Received: by 2002:a17:906:1d01:b0:b97:91c0:fc3b with SMTP id a640c23a62f3a-b97f48c1dc4mr394199366b.16.1773921552076;
        Thu, 19 Mar 2026 04:59:12 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16d3380sm461399166b.42.2026.03.19.04.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 04:59:11 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Thu, 19 Mar 2026 13:58:42 +0200
Subject: [PATCH v5 4/8] iio: light: vcnl4000: replace mutex_init with
 devm_mutex_init
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-vcnl4000-regulators-v5-4-a025d3332805@gmail.com>
References: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
In-Reply-To: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
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

Replace mutex_init used across driver with its device-managed
counterpart, so all assigned mutexes get destroyed.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 287ccd89cfb2..cd7e6ee42cc5 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -356,6 +356,8 @@ static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
 
 static int vcnl4200_init(struct vcnl4000_data *data)
 {
+	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
 	int ret, id;
 	u16 regval;
 
@@ -400,8 +402,14 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	}
 	data->al_scale = data->chip_spec->ulux_step;
 	data->ps_scale = 16;
-	mutex_init(&data->vcnl4200_al.lock);
-	mutex_init(&data->vcnl4200_ps.lock);
+
+	ret = devm_mutex_init(dev, &data->vcnl4200_al.lock);
+	if (ret)
+		return ret;
+
+	ret = devm_mutex_init(dev, &data->vcnl4200_ps.lock);
+	if (ret)
+		return ret;
 
 	/* Use 16 bits proximity sensor readings */
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
@@ -1979,6 +1987,7 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 static int vcnl4000_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	struct device *dev = &client->dev;
 	struct vcnl4000_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -1993,7 +2002,9 @@ static int vcnl4000_probe(struct i2c_client *client)
 	data->id = id->driver_data;
 	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
 
-	mutex_init(&data->vcnl4000_lock);
+	ret = devm_mutex_init(dev, &data->vcnl4000_lock);
+	if (ret)
+		return ret;
 
 	ret = data->chip_spec->init(data);
 	if (ret < 0)

-- 
2.53.0

