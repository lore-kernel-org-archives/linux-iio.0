Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DC51AFED
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788357; cv=none; b=rKxflTKc/D0CHDFewO+IgHZvm+d/wUViDNKrjsfrvtFtTszSk+bF60IYaYanA9lw5dpYZtvVjw5qN66XV2kAx18R94Ww1juY0uh50guEcfA6cNfNORdb1Sl17cZO9+Kp1+jeenRQlMxx7q2hcK/SV/tSMOkXNZqYFcFFqL85FYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788357; c=relaxed/simple;
	bh=vs4c7J9uwvqV0uHuQ1lz5HHxv6HkPh2qTseU5Eo3R48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lxMXvuLXcPcR26Qx66CaHIyaUAkNpMsevwtrrkqqqzKRs35i0cKqvvCNuBH9O/tl3SJMJxoG5D/CW/mDMILGPS7CjvPu/h9FmQ/2JhWQZ6OwjoplUidAy8Re1dG+1y+18G2Fpur3cuUWaVYp8FcC7Q7tNcsyI3tWOCvXd1aHNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF9rg/5N; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF9rg/5N"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-888148d08d3so4537b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790788356; x=1791393156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2alhO75hg38+nS/12HySrHAbmPDF5QmJOTBYPr59Do=;
        b=IF9rg/5NP5AMyG0zBz1ik6xEUzW3pN1UvxKV0tXavrS17BC3Ptoa44kO9h0D0OxR0A
         8M87id8wjyUqBsGYEVY1TcwIkXk38Nlxxe2Gr/oBwozZECagxknjSbuRCoy6yRYaDFr3
         o819H6rMikOzY9MZaVbvMC2r7tLgdyk3uNDPbJaFud6aQYW0tDQRLaFM5c+qJRC31jMn
         4TJ4bWD+l/au+hp3ucMldA/KwTS0GLpqzpQ6HAetZ+TdMW6xeUwXmGDhFcFQiFWeTpsk
         df67lBDEnYQmlrLymbkslKr24J1negnPl3makZCgvpAN/HNDG4jyFSUwaAWOyt5zgRCb
         eNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790788356; x=1791393156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j2alhO75hg38+nS/12HySrHAbmPDF5QmJOTBYPr59Do=;
        b=e54oSEF12i409WfHfpreTrw7Rk0YN57QBv+aui4S3GZ0Epq2wEoBWt4nTfzoNtHkt+
         A9jwsV3olI6x2S5u6nctP7ru1FHgVjoixHM8olxNG+yfBvz/CebhIGIdHhwbfhrh/tRe
         r/B0/kf2mgm5/6uH2247kHXLVgjO3hCHRUu250sjDnV9UQt2OSwtV3rmwbeSFCyJU4Iz
         HXf7TA6BTq5sREjP+3hoCHsrgXIRofdXgAbDUW4oyHuSpQWI8jB7uvSPMYoKkYc4kCKL
         GY1hu1TPr7awhmxjJIoZZn64EwKQOPq2U1M8R3ZlaL8ElN+TEJC7v/o9qQE+CzgpwiNB
         KGRA==
X-Forwarded-Encrypted: i=1; AKwUvBxFFkDplFIpSmx6clLqTDucejKKWOFpWJp5LrcN05ZZIyrapvh2FlQPbbaet8RCMtfMk+iYBE+7rMI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjhLEdsvtHHVqLNa+BeHH8234M19Zs1EK6gEKwxS9kOimoh56l
	VRnuv0tubV+hH7FIlH2B5pIrRjoRJogzf3/AC5GvklvQebQEtXhyzjwg
X-Gm-Gg: AYBFou0Ov5VOQXInx7bLZz+xw3jhIjIzUHcwrAqeInYBVWs8Gt1PEuGg8viHdsNqbSk
	G7WEHJKNMsq3NPQ+POYHmnJqJY4LP+a2ijNO8KTvkQJEkJdrfbSyui97ZcmeNZq1mQ+XoyTR6GW
	6Nz9jtfPi2wApNwhl7ezdSn/VcngxAMTVFvFqbzqUb9IlGKYAN99FipjgPB80VPCG6VPsKk6zBJ
	5IoCL60dWPEAl/km1E6BALbxXN+HVhcOrbdiu0JTklbHeDANZeL0LYzU2gfoVaeqPw/siw6+mDF
	ttk7G4IkBMOBmqka3zlP2E8y4cUbRMkFWXXUqiUCtiVHxY83uNfmYfNJzAPnmXO4YN3S5mudM0Y
	K2H/YurQGIawHqP5/U6LrpCvU1Wrc8/sOPPIIszgHpe82Ku4W6ru9K/HLaXpHd6v5x+2YmIGqaW
	JwPviK6p1yjajW/DQwi3I5/Lvikt3CWSl4O4ml0pHJDFUfWhimhY1gFX4A0uWAu/N6xIm3EDAIQ
	FZqAv5NRW6DwsJ5Veowgf6fo80g4TgekTjsfantmZWxyQcWT24AAgNeXH3A
X-Received: by 2002:a05:6a00:190a:b0:887:17f3:94f7 with SMTP id d2e1a72fcca58-887472d4656mr1716681b3a.1.1790788355705;
        Wed, 30 Sep 2026 10:12:35 -0700 (PDT)
Received: from debian.ari ([152.58.182.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887bc2bd404sm636872b3a.46.2026.09.30.10.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:12:35 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 04/10] iio: adc: ti-ads1015: use local device pointer in probe
Date: Wed, 30 Sep 2026 22:41:58 +0530
Message-Id: <20260930171204.12863-5-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260930171204.12863-1-architanant5@gmail.com>
References: <20260930171204.12863-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a local device pointer 'dev' in ads1015_probe()
to avoid accessing &client->dev repeatedly.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 9479f110448d..85280200d050 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -944,6 +944,7 @@ static void ads1015_power_down(void *p)
 static int ads1015_probe(struct i2c_client *client)
 {
 	const struct ads1015_chip_data *chip;
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct ads1015_data *data;
 	int ret;
@@ -951,9 +952,9 @@ static int ads1015_probe(struct i2c_client *client)
 
 	chip = i2c_get_match_data(client);
 	if (!chip)
-		return dev_err_probe(&client->dev, -ENODATA, "Unknown chip\n");
+		return dev_err_probe(dev, -ENODATA, "Unknown chip\n");
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -993,7 +994,7 @@ static int ads1015_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ads1015_trigger_handler,
 					      &ads1015_buffer_setup_ops);
 	if (ret < 0) {
@@ -1029,7 +1030,7 @@ static int ads1015_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = devm_request_threaded_irq(dev, client->irq,
 						NULL, ads1015_event_handler,
 						irq_trig | IRQF_ONESHOT,
 						client->name, indio_dev);
@@ -1041,22 +1042,22 @@ static int ads1015_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&client->dev, ads1015_power_down, data);
+	ret = devm_add_action_or_reset(dev, ads1015_power_down, data);
 	if (ret)
 		return ret;
 
 	data->conv_invalid = true;
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret)
 		return ret;
-	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
-	ret = devm_pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int ads1015_runtime_suspend(struct device *dev)
-- 
2.39.5

