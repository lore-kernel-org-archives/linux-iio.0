Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6B849659
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041905; cv=none; b=Mw71r3pz/wZ+qlA+s1WEZ885GQaS24G3RSH2ZzSw1tyd8FzHEWND7NX1jN7bI3kt133n1MOLAKS0pJR8XKZSYNmNwt5cfOdzaoc5BlBN1+IBPkapabJp2BKhMFaIuAe9IGVte6VIE5iGUqt6D2TSFAkO28qLMoopyTS7oUAxYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041905; c=relaxed/simple;
	bh=MZIBkvx/lDO1bwCjTF68CpPH6+1oeby0gOD1GNgDaLg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IhqFD6iW0yJnhC7skP+bzwDPf7v9d4VrRtk90vODCxiBKz2OmG9p83avn+CnvUtbakDIRPsrn8DG6/BImijdNdhNen/ydZXqu1D1LF5uIIS3lG748AvPgXcMvKdivpiJqefRS2O5dk8smXMjQcYMUeFmuKp1YC/EWsQO1Ri6M1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=aWDKYZua; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="aWDKYZua"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6948e6bc30cso211493eaf.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779041902; x=1779646702; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsZdJm4r4wPMlOdbscvoNtCvMluN7DKgMfAmDRA1Fe4=;
        b=aWDKYZuaDj441HEHt/6iB6EXQxa4kOhgs15UeS815IexLpwe55DHXwI9AHp71ttTb2
         311jvkSfr5D6PYbELDu5d1XfMn05GeZdywz9MSPmEJ2b1Q+7NtJMsXgLaZLcaJyjYGzp
         +17m4QQSy7/dhcumWVyRVAtg9MqLCbyOL2W1/ExjJ7R51ekpWm88I90Ha9qa9dBvBDgL
         cc4O8XX+4RhTk7GA2gDoEM2EcNwnugE5/0hD4mrsjhJpuStkFGiLNh5wUKIQwD3r2P9e
         uCZNXsVGHHcOwS+9WrogD+RsIjBU3++Y+pSH01aqoZILIZYHH+mCpyUwS3hk+anPYI9w
         oUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041902; x=1779646702;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsZdJm4r4wPMlOdbscvoNtCvMluN7DKgMfAmDRA1Fe4=;
        b=RvflT/evFrn7r12uAKGn5xjTpLiJ6Q536m+I9wz6xraKHrBWqgTK35HSP77H6W1Z7L
         fdj3lz9lZDD7F08u2z2JKzjIHKvLOBC7pBBnBeqMKzZiSMHM+BBto7qzc5Ab+hC+MWh+
         oMmcx5UTLF95liClC3eYpZw5gZXe8bmI/G+KdpH7+ObR1qoXV1pbc5zdGIcJlwrZ5F0H
         h8ds+8Zgqc2C9nbQLTsocxC2PRvBMJr/YeY/ZLNquPlW/JEnjVOul5z0vBTaoOK9UGMK
         CR7+sPvZnUv1l7//xkymSP688Ybr0768Ap/qsh7J/viLBtpojY7s7tnS2sgJAwQ601bp
         oa5g==
X-Gm-Message-State: AOJu0Yznrxqp00TBq8k8o0DAAJgOzBRFNSqJsP80wF7S8ZzFgsyLpI8F
	CmDjtO0j4rKD/v5v15mADwXCiEdnNUV0HP/8y8Z0w8HoP2fM81YWx1p4MOtDE/FNKro=
X-Gm-Gg: Acq92OF3WSNHuBtE+QvbQaL42f5rdbhOXilKNNQ13/Wxc08D8tHQBteYoUnqwKEVZr8
	HEQBMIn+KXMjvqZ1bI/41LU9Mir/lxcntLFHvy4LY+uikz7N4N/bb6HSrBnYbH3Ep5gGfUoeyUV
	k3+P3RCzTnbsBz7m1diTqlVli5Ungjq6UI7q0tvzJ4I+0n83foJKp2AIjv5AaOYrUZ77mZzEjpI
	BiHTFeCm2Dnw/bWo59+B4F6DdgCD02WV3N4lpWSYsDfb8Fnge46J+R+zJlRmGoPFLi3dkAwhFhS
	pHpEn0MaPwteP+nydDEJ6x+ZVf+vf2evXX73gtwIY/ZVCd7RhcKBpn9iluBlkv93qmHpmY5vRz2
	B9SHnntFm/MTBnnrU30jXNc4SXJ+YdSeYCz8C6pgJf4TiwIxyv8bJyvufJaXmfAL8/jYllicxMf
	zjI5s52SIgSJFiP3mVTUsu6mEzs/ChLuT7idaO5DIHQE3rFO8N
X-Received: by 2002:a05:6820:2210:b0:69b:8ff9:f582 with SMTP id 006d021491bc7-69c942ea069mr8317738eaf.14.1779041902495;
        Sun, 17 May 2026 11:18:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a95766535sm2085539fac.15.2026.05.17.11.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:18:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/8] iio: timestamp declaration cleanup
Date: Sun, 17 May 2026 13:17:17 -0500
Message-Id: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWXcgCdgWryJdxPhXR2waMqkIp
 Xc31uW3eG8jRRYonZuNMt6issQK2zYUHj7ewXKrJmdcZ062Z5GFi8zQ4ufE4QUf18QWGNxkBut
 7Q7VNGZN8ju9l/FvX6xOh/Ga071+ddszSeQAAAA==
X-Change-ID: 20260517-iio-timestamp-cleanup-1ee82f081a70
To: Jyoti Bhayana <jbhayana@google.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2130; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=MZIBkvx/lDO1bwCjTF68CpPH6+1oeby0gOD1GNgDaLg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqCgYvvz5e3v6t+m0Wx/sHGclkR4moFXIFRNL5j
 Yark2JG+RuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagoGLwAKCRDCzCAB/wGP
 wL2YCACJAC5NP41M0YnHAqSNkQZmeewP7XoDQMe6oGaErE+EeI/S4A/ytTbQDa6svMIA/r63BzZ
 uDS7S/8nbyVhwAsCra78MomRhRpjuZ+CbozTwamJHbIqHsw0MgU+tot4UZveWPlRLBNr/RMimSu
 QnGbYsInSPtIo8f0cQY458S6vcMkqGQwNoqfx4d8AZ+pX1FdO6axfFyMhOR4i05M/eh1uwCel1n
 RYmEHw/N6RX/1kq9CLVRQ1/l+m2rp+VYZ43fGdfmWrwXmgvAVNflkkSZqSs4vKkrk6UR3TxF1UR
 V8aTbiassPuhHkFYW2x/L5AvCqT5pn3gp5r/sgESNDAnSEyT
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

While looking around the code, I noticed that there are a lot of places
were we are manually filling all of the fields of an IIO timestamp.

This is error-prone (as seen in the first patch) and more verbose than
it needs to be.

I went with the approach of using the existing IIO_CHAN_SOFT_TIMESTAMP()
macro for doing a struct assignment. This does require a cast, which
makes it a bit more verbose, but we were already doing that in to
drivers, so I went with it anyway.

If we want to consider alternatives, we could make a iio helper function
or macro like the first and second patches did.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (8):
      iio: common: scmi_sensors: simplify timestamp channel definition
      iio: adc: dln2-adc: simplify timestamp channel definition
      iio: adc: at91_adc: simplify timestamp channel definition
      iio: adc: cc10001_adc: simplify timestamp channel definition
      iio: adc: stm32-adc: simplify timestamp channel definition
      iio: common: cros_ec_sensors: simplify timestamp channel definition
      iio: light: cros_ec_light_prox: simplify timestamp channel definition
      iio: pressure: cros_ec_baro: simplify timestamp channel definition

 drivers/iio/adc/at91_adc.c                            | 12 +++---------
 drivers/iio/adc/cc10001_adc.c                         | 10 ++--------
 drivers/iio/adc/dln2-adc.c                            | 12 +-----------
 drivers/iio/adc/stm32-adc.c                           | 10 ++--------
 drivers/iio/common/cros_ec_sensors/cros_ec_activity.c |  8 +-------
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c  |  8 +-------
 drivers/iio/common/scmi_sensors/scmi_iio.c            | 13 +------------
 drivers/iio/light/cros_ec_light_prox.c                |  8 +-------
 drivers/iio/pressure/cros_ec_baro.c                   |  8 +-------
 9 files changed, 13 insertions(+), 76 deletions(-)
---
base-commit: 8678fb54958893818ddeccd05fea560a4e1fc759
change-id: 20260517-iio-timestamp-cleanup-1ee82f081a70

Best regards,
--  
David Lechner <dlechner@baylibre.com>

