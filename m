Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649DB34CFBE
	for <linux-iio@vger.kernel.org>; Thu,  5 Feb 2026 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303467; cv=none; b=XxVTnZkloZOkoaHhRO8Y5dLn24f9gARCK01GuAwl8pNT2FhJBgR9QiTEn+hBfu32vGUqwCXzEqbDpAnZ9963VtQgs6Pb7Z1eimEOhhGchQGjZ7OliZf0dBPNQI3Dg5spEd6yG7ZWtRnjjgQqyASq/vRUvAkWLbHr31vk7T/NtjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303467; c=relaxed/simple;
	bh=mqJ1ieL1d6aAkCqbf5Vu4cEJZ6fZhddRL14J3DjLzok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSh1f8LsLzELuJMby7A9ibAX9OOsWwhPjFDDHodFHaz9q0veWYHlSZKI4ASOBbhn+lYJVtOkga99ylZS4dsh+C5Ed8BXi2z7W0uYCVy5yYIqQckXtM0L6OKtjkeWosdc2CYHfLTOaUln3kgRxx4c97U8nBCQ+8vlPazXAH1o7ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIzYL+tj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIzYL+tj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so15590515e9.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2026 06:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770303465; x=1770908265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/l1D3HoF3zgIcHFCwzxTOQvuCZS2NTOWIlmojy1gME=;
        b=MIzYL+tjwhunIoNI0tKy3dUupMIzDCQZ505kZiUaajuVjPGivULTSikKfBhjNqYfNv
         0rvxyqOsU2LrfxcNn9a5Mp9H54nDOM5HNibYTOuRwbS3sIYggBQx1Kl4FRINPJ8F5gQo
         eY4aBNxb0mNq3FOBKkbRBXr76yD8Sj5ATK0toZ7s9uVzVruAQWCmdIZAthirlKTwKdpJ
         nsflDt+Fwdbj7uvdYZg4ZXTBkPMt4XpC8a5GHpTJizMz0xGMSHaY75MYIxtlv9XJdCt+
         B2e9En2JlzShcyhM1vIXaFR8kjqWyFy0AySc9U5w2I+PgrzFVpUDxf9tVFCe+h4sVfM6
         P0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770303465; x=1770908265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/l1D3HoF3zgIcHFCwzxTOQvuCZS2NTOWIlmojy1gME=;
        b=LKolpH4xsBtHO+BbyJ1bg2R3ZsT+f+ZcBw4qanocVCORE94D72cKrXCJo9ey7JKdRq
         NgJw8qLvqStkXI6VnPMMwyewO+KA9fhfLiMuV7IyPXg7YpoxUo4SIRFZNdDfnyWKM+KM
         +rF09QITLZcLpXsTTmn0oPaFfVNN2GbFfWi46K5XE+xiix5panprnl77rJIGEeliLNhT
         yE/bLLTJEbYmmBrgfN8JaRRNHATd+MLexkoSOtucWCKDmQcBinwZ6mpJSHUBIhMkR7DW
         Tr02W/r/RoCiTG1rcrX5vAS0oXxFk15zPOsN8OfZDKdJ/yZ757rzZ1GH/UiAD+qOJX9t
         pD7Q==
X-Gm-Message-State: AOJu0YzlWpWlCyyKPfHJVKRWya1OpSUKEz+lGKKoosFlEC8Pzz/xirZM
	HMY+VJUei9YRXY++Nfq6jQG52/gL9ksYVJuiQ2UTtzUQFamSQTWUIqgb
X-Gm-Gg: AZuq6aLWw/wugGVF/gw9BIeII0hWyk7D9V8BmLokOR3pXsMkUWXN772AFON/+mJaBxZ
	DP9LHJ5n4OSHks3/aW5uHraiPR/l5806TfGTCz2DNHkre8kJ1aDJBgf/1g1KOSaXb4F6JtlZ6cG
	r2++Zxhdi8akTF8UabQmVNQAymlbwblGFKgMfu0tN67fPqrT+t6043LyXucmkaS25RXlUu1ema2
	PFaUhFDdEpzBy9Cw5T4rXpQo7PQLw4mad/iCeAT9ep5EqMPREcDIj2covAZ0wooVasgOQhWUSjc
	mwbSdRMOP020eY1lZpfTXEyp5t7ZVZGWtA/qye+KK6iwV2x3/agVjGwedrTrstJFMIF/cmNhacg
	1/5yEj5QTygZKVlkfIGgD8+83POe9CBWjWbexBZRLp/wsp+5iy2T3CfuJCl6OuXCQYDxHxOD/zs
	7h2NlzM9XmBzm65qFCC+aaRSG5iwA4HSqapfMK7OsAhKN1J+hVNGPbb9StjP09
X-Received: by 2002:a05:600c:800f:b0:477:af8d:203a with SMTP id 5b1f17b1804b1-4830e9709b4mr91969535e9.27.1770303465056;
        Thu, 05 Feb 2026 06:57:45 -0800 (PST)
Received: from chris-laptop.home.arpa ([2a0e:1d47:c905:1800:63e9:a31e:f6fe:74f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618058473sm14464223f8f.22.2026.02.05.06.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:57:44 -0800 (PST)
From: Chris Spencer <spencercw@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com,
	Chris Spencer <spencercw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] iio: chemical: bme680: Fix measurement wait duration calculation
Date: Thu,  5 Feb 2026 14:55:45 +0000
Message-ID: <20260205145703.198609-1-spencercw@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function refers to the Bosch BME680 API as the source of the
calculation, but one of the constants does not match the Bosch
implementation. This appears to be a simple transposition of two digits,
resulting in a wait time that is too short. This can cause the following
'device measurement cycle incomplete' check to occasionally fail, returning
EBUSY to user space.

Adjust the constant to match the Bosch implementation and resolve the EBUSY
errors.

Fixes: 4241665e6ea0 ("iio: chemical: bme680: Fix sensor data read operation")
Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L521
Signed-off-by: Chris Spencer <spencercw@gmail.com>
Acked-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: stable@vger.kernel.org
---
v2: add Acked-by: Vasileios
v3: revise commit message; add Cc: stable
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 70f81c4a96ba..24e0b59e2fdf 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -613,7 +613,7 @@ static int bme680_wait_for_eoc(struct bme680_data *data)
 	 * + heater duration
 	 */
 	int wait_eoc_us = ((data->oversampling_temp + data->oversampling_press +
-			   data->oversampling_humid) * 1936) + (477 * 4) +
+			   data->oversampling_humid) * 1963) + (477 * 4) +
 			   (477 * 5) + 1000 + (data->heater_dur * 1000);
 
 	fsleep(wait_eoc_us);
-- 
2.43.0

