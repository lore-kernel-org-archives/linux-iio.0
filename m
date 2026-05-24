Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA131F999
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650773; cv=none; b=qVnU7mI++zSaLTiLKHwgo8NPacG3+tIBsfn4KGkJrVzFhvExs6GRiCYVrx7xTzPH5ZJf3ZV+96dirwAXLeyo4AretFierqkqTonUYrnnGIyb+xZyKzavErZHVzTmAPQaV6ATnLSk7CvqMC5+3TAcRRpsrjeEJNYUMEjF6M5cqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650773; c=relaxed/simple;
	bh=+X03fXAA3jAuwhdLpIw7G/FSO/VmWLrsJgiCP8kvOUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b86pk4D0ZJuwPIzVMoHDJ1xaQhcRL2UbugpBicI/fulO00Mnhn0Fou/642GwIyD1NHq+f6NPJHVwxaE4+NK1KjCXm1JrfY3tK3Q+pr8Clnmc3dxWY/e/hLkowmbIqhkWpVWVT9TWWBmOz1uvr6CwSR0CIPbihR0kJeouBg7HnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gpt9Q/IW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpt9Q/IW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba4efedbeaso67955335ad.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650771; x=1780255571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbdaUPCQECYKj5I8bo/eYv+jpArHLYQ+KNsZa4Mw9+0=;
        b=Gpt9Q/IW4xKd/KwTD2BHG9LMxyBf9YzIPWU1S+uP+lUPQ45q9C2TSrS4EhUVZtK8In
         NRWrUpPkSs0p3cMgV1yJDKXHqEn0KyqcpT6S9PDKW5JORjHCq6rega5d4YwLCikjPthB
         HarPOm5JdtJrM04XOb1BcoG7THRTT854gIs7vpwkW+gEgW6tOHY/pYUc5RGh+0NtB5V/
         Xv3i+tyJ9vs3w0HQbWW4AplfXDHimd66ejGkX/jBmqDQc/uMxZa6lrRlKMRZo4k7/cDo
         eaLZPYnagX0mtjX/TSJ9PgcYICdNSGVyXkDXPL0EaVi+z1MrERLoF10PgIC6tkHyDO8K
         cYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650771; x=1780255571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CbdaUPCQECYKj5I8bo/eYv+jpArHLYQ+KNsZa4Mw9+0=;
        b=gmHb9qFWcsnvYF3mu9af2M8P4ilJghWLSdV5wwYPuC82XArauQQHqMiSwXoGDFSiEC
         p3gep/ZDxp9m1+oLJi9KDsw578lTaI5QUdFXTU/ZF85j9I2Oy1trdnCl5hTtD5PzlhrH
         jIrjtLF5IPPL60ww22xOcCBqqfDXEEhkAuyRHP2byoYGupbce1LPqXkJPZr+HXx3QSlJ
         vjVipH4OLgaQ4EyBCO2vce+QcA1StBtNv7K1+/jeONt3uWO6OPZK/06ls2Jp+ShFPmEw
         VrLJ5bhITR1s5vAMfKsBBfvx/8JwQSL37UfTOfF8wH4QKhcgwT3DF7CRj+UOQYm9WdF7
         OWPA==
X-Forwarded-Encrypted: i=1; AFNElJ/oj8wP/lMciAijPcD5a6zk9KmXZgGLlOVYbh0xuDd2AxImVbTj7YGFIzrEuYb24f6MfIi3SSED9Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPu6091zasKOgpjCcZ+4CA8mRDusrsXZg7WsD0/IMbQW0HcHF
	pSMr5KgFuqXfUAUan7oQV9lkzfOByYcDS9pYzKCSq9DQ3tNqUiveV9n1
X-Gm-Gg: Acq92OGjAWxWYBHlwRTZ1vwZQ9SI6XL2yg+sp6ekljIY2zDNCI24FU1muIADjwBAm9l
	Kz8pN3nVZkyPtN6B9/+bN7tJlBHQ8/lOO3Brme0A26P42cdv+WyeUbgKIysvbnBzU0gD3CXIsd7
	JpQ+ysQzgbKQZuibfLtGocDFEBdKNIo/il6I+23/cNe7hQ4leLB0TkjMqTX86ISidckDFNyvdMl
	7SPUhsewgkl83eI2c/FWOI9ZrdZSfROXPW4L9j6kCFWbfjv1sAjinjtb/eFmh9YrdDJ7cLzxOyB
	AGAWHX7BGNk3E2uONaNP8fAhB+c3d7vioG7zCd3GosIX/XgDU2fR2w0DLJs3a62u4/wj7rGELHZ
	FYi1nEd3DOXjFeab0dSzBI3OPNd2c72SKIhgmO4n5P7Zo+WKm/rsDDhGuKzm54olusAaUxtCsHz
	ZmDTeH9jgcMVOT7RjXor27dSHDN3S7uuSVajOtaG+ZE2dPxtlB
X-Received: by 2002:a17:902:ebc2:b0:2ba:6ffa:bde0 with SMTP id d9443c01a7336-2beb065b797mr126061235ad.19.1779650771364;
        Sun, 24 May 2026 12:26:11 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:10 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/36] iio: humidity: hid-sensor-humidity: use common device for devres
Date: Mon, 25 May 2026 00:55:49 +0530
Message-Id: <20260524192556.1195042-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192556.1195042-1-sanjayembedded@gmail.com>
References: <20260524192556.1195042-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

kmemdup() is used for memory that is logically tied to the HID
platform device, even though the driver binds into the IIO framework.

Using &indio_dev->dev for devres allocations works functionally, but it
results in two separate devres ownership trees—one for the HID
platform device (pdev) and another for the IIO device (indio_dev).

The devres framework is intended to have a single, well-defined parent
device. Since the memory originates from HID sensor probing and is not
IIO-specific, &pdev->dev is the correct and logical owner.

Switch to using the platform device for devm_kmemdup() so that all
resources are released deterministically and consistently.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 6fed019f4099..73120b87d641 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -215,7 +215,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	humid_chans = devm_kmemdup(&indio_dev->dev, humidity_channels,
+	humid_chans = devm_kmemdup(&pdev->dev, humidity_channels,
 				   sizeof(humidity_channels), GFP_KERNEL);
 	if (!humid_chans)
 		return -ENOMEM;
-- 
2.34.1

