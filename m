Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6461A3B52E2
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038989; cv=none; b=rRPW2ZqBOfO3jEOMLqXd+Yd/Kepui/cDd+VtKZPeHE6Vv9Mg9PPSh9XgkK7Wg66kcPCroKkJ7KpU2y4tzl93yP+DofzV7SMscmX9yl9y7dgjq/ldD8XOgKA+TyJwMmUs8PQZDEKOei5syL5hnW+i18iZywMYXSTgMXhC6KQvdak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038989; c=relaxed/simple;
	bh=gI9Qa+0FX6MW+k4Waqa3+sdkAAHH7+qtlArSwsFJIGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eothgx3tK2ruFwKZVC7ICL41/5XAi2EBN0vAoqebUvK+GuzDAbUnYkMLmFBM6iOz0u4SjlGNGof/Vc9Y4dUcnzWhfmpG1UwKeXIfvimev8ziHmCDLEG3U0+6u7nU9fkuf6LiOkTZ7AB0HPlTPKfwgH8J1YnzyxnFIPUBDd+RYCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=u1B6CFGH; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="u1B6CFGH"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479d593a0c3so1306885b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779038986; x=1779643786; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ywxvi1BG7jNA2WEwyvZurk+0uxEEloPnQPfniOt8ztw=;
        b=u1B6CFGHyA4+7EdzaBeXBIcF8Ln5l8+0B7aMzgGiH/Uyc9tfUCy2RcUwSXG8fHE5gV
         W1v/VtDQ0wHfDe8hcV6IEsu/Ra3kp+lAmupiwAOyqG6CNKEaA8xklidtn/y/rQno0Yf7
         REoTSeorhcMgFUvCaa/F6N6G0tAHRH89vPIhSimiWWiPCwkGLlNrXOvz4oKL8XkGN1r+
         V44mCqrhjg5/DULh1ugY19Vo9oiPRzL75EOzwDpX3H8zxtKsU+eTxgoQk0oh/GaB6K/E
         j3jfq6h8SNOtVaTf9aWTtY4yPpmbdQfLE+bkZ/EiuQ9lPwuxRX0sO04o0f2Xq3Hg7nAe
         95Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779038986; x=1779643786;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywxvi1BG7jNA2WEwyvZurk+0uxEEloPnQPfniOt8ztw=;
        b=bfIMZ8DMYX7hQeAphwDRgn/h3iFm9Psex+rvIUUg72rONTfCQO2CvSQOMTteKInT1B
         jyy0zwoQR4A5DlFgyado+NUXdEP+9ApPSGuyFdwt0IhXDmAZlGqVqlIK0I5Lm+UJkLya
         iX6JhuMFYJVyMouBWefwYfryO1UjLYcrX/7JMzKvCWhnMd22Z1ccr3BulVV8BD/O3BAb
         Lr7VWlEnmdGr4VqqK6Yc/xcxG7c/LtJFhRdwxa270qfTblzRF/zTPr4jAUw+yUZLjfPa
         4nV5p/k/zltAHR2yE5lqjBiisHMV3ZrbfNZrdW68KiSMb/k63IH5wev5kf632eX9BBat
         Ab+w==
X-Gm-Message-State: AOJu0YzDC9b4jLGrhepC5VvEgkmrSYEgLUu+otBw0abY27SgYFLidsKd
	o/pmYaoHRrPfX3/B8vVbw+c5yjSk4PC/RG0Sik3CBBdp9V2yF2LOlz21wmHxMs5Z7Sg=
X-Gm-Gg: Acq92OH7EM5jXfV96KcsvDNwob29gqKvd1Bt2RQJ10N1IelY1mhJTl3+y8cFhc+et8r
	BqYDw5a1Y06qs5JBwVpBsUv6Rlndnpi7v4DN+DzpST42slzihpfJERweyoUNbJ/+gt6rVttxzXi
	p5gZrC0kJGH3K0rmiWD+EVGXwezyrhVVrgGgTG7e2Gc12lyg3TTeNP/SHLTBAHCH1YjFizsdYW7
	cHEk7nz1WrQiLvWr2CYOVLuw7EGcPZZUXtBlivdhKPnJWDPQ+u3izBHLiSH5HjZbvAywV/L4+Mm
	Stvwg38yVfH1dxlxSVoO1/PcQViBRT/HqKtzoNieLJN8M8sCNle5VbKmF04JIWD/edHkBBNl1xZ
	jIQ+FrNHU+Bn2CM0rRVVc+J5XjxVqjoJq9DdImj2ryvOM0XrnzLbrqXgzDKUF2M8lMfOCbxTJ4v
	5alps+WVkUTkv+3jL+cgdo7k+01qNxCm7JNQbhoQ==
X-Received: by 2002:a05:6808:1593:b0:468:bfe3:17b1 with SMTP id 5614622812f47-482cba83285mr8738768b6e.23.1779038986364;
        Sun, 17 May 2026 10:29:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee4fd036sm3884059b6e.12.2026.05.17.10.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:29:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 May 2026 12:29:35 -0500
Subject: [PATCH] iio: common: ssp: remove SSP_CHAN_TIMESTAMP() macro
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-iio-ssp-timestamp-v1-1-228a9ed05c1b@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrB1IIjHoVcSFP9N2CmrIRBEkd
 ze2y2/x3gVCgUmgLS4IdLDwtmbosoDpM6xvQp6zwShTK6sdMm8o4jHyQhKHxWPdOGe1tpWzBnL
 nA734/D27/m/Zxy9N8RlBSjd37v2PdQAAAA==
X-Change-ID: 20260517-iio-ssp-timestamp-697751153752
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=gI9Qa+0FX6MW+k4Waqa3+sdkAAHH7+qtlArSwsFJIGc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqCfsBOBpbwqxXiZe/V5O9AQsi4MUFIM6cwX2Q7
 JZfXFQ2q/+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagn7AQAKCRDCzCAB/wGP
 wDLnB/9fHFeMaUwOo37zhkE0QmIU8eiw/7nYQU6+Xqoszx1qmNc0r47L4i4TF7BeF1Cvs+Hks4P
 kU32tMP9/l38+KKFwEpVeIKOMSa+Hka2sM3nIUlRaU71YjW1g6NNShHgmlcsDL6rFC4+J+K5Oil
 4JLnSuur74BBYzRff+t687CRfESPafcISakLQ9T1/wTnODRs+TazynJGrXSoRT83OUrpaTLs4BH
 8UPRDa22yV15uqPzKmvbzKbwFFv4Zg0c3l2nkKkkyriOu5ns1zr93izZjjPQVkpR4tCeTn4kSUG
 ZD+XrB8BnWyxp0kocYMuplcaAk0uWjeyzGURw7Iz1fMAmJdh
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove the SSP_CHAN_TIMESTAMP() macro and replace users with the
IIO_CHAN_SOFT_TIMESTAMP() macro. The SSP_CHAN_TIMESTAMP() macro is
identical to the IIO_CHAN_SOFT_TIMESTAMP() macro, so we don't need
a separate macro for it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/accel/ssp_accel_sensor.c            |  2 +-
 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h | 12 ------------
 drivers/iio/gyro/ssp_gyro_sensor.c              |  2 +-
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/ssp_accel_sensor.c b/drivers/iio/accel/ssp_accel_sensor.c
index 3e572af2ec03..d1687cdd33ea 100644
--- a/drivers/iio/accel/ssp_accel_sensor.c
+++ b/drivers/iio/accel/ssp_accel_sensor.c
@@ -76,7 +76,7 @@ static const struct iio_chan_spec ssp_acc_channels[] = {
 	SSP_CHANNEL_AG(IIO_ACCEL, IIO_MOD_X, SSP_CHANNEL_SCAN_INDEX_X),
 	SSP_CHANNEL_AG(IIO_ACCEL, IIO_MOD_Y, SSP_CHANNEL_SCAN_INDEX_Y),
 	SSP_CHANNEL_AG(IIO_ACCEL, IIO_MOD_Z, SSP_CHANNEL_SCAN_INDEX_Z),
-	SSP_CHAN_TIMESTAMP(SSP_CHANNEL_SCAN_INDEX_TIME),
+	IIO_CHAN_SOFT_TIMESTAMP(SSP_CHANNEL_SCAN_INDEX_TIME),
 };
 
 static int ssp_process_accel_data(struct iio_dev *indio_dev, void *buf,
diff --git a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
index 4528ab55eb68..05fcad61c848 100644
--- a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
+++ b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
@@ -18,18 +18,6 @@
 		},\
 }
 
-/* It is defined here as it is a mixed timestamp */
-#define SSP_CHAN_TIMESTAMP(_si) {					\
-	.type = IIO_TIMESTAMP,						\
-	.channel = -1,							\
-	.scan_index = _si,						\
-	.scan_type = {							\
-		.sign = 's',						\
-		.realbits = 64,						\
-		.storagebits = 64,					\
-		},							\
-}
-
 #define SSP_MS_PER_S			1000
 #define SSP_INVERTED_SCALING_FACTOR	1000000U
 
diff --git a/drivers/iio/gyro/ssp_gyro_sensor.c b/drivers/iio/gyro/ssp_gyro_sensor.c
index d9b41cf8d799..1acbbc1eeec3 100644
--- a/drivers/iio/gyro/ssp_gyro_sensor.c
+++ b/drivers/iio/gyro/ssp_gyro_sensor.c
@@ -76,7 +76,7 @@ static const struct iio_chan_spec ssp_gyro_channels[] = {
 	SSP_CHANNEL_AG(IIO_ANGL_VEL, IIO_MOD_X, SSP_CHANNEL_SCAN_INDEX_X),
 	SSP_CHANNEL_AG(IIO_ANGL_VEL, IIO_MOD_Y, SSP_CHANNEL_SCAN_INDEX_Y),
 	SSP_CHANNEL_AG(IIO_ANGL_VEL, IIO_MOD_Z, SSP_CHANNEL_SCAN_INDEX_Z),
-	SSP_CHAN_TIMESTAMP(SSP_CHANNEL_SCAN_INDEX_TIME),
+	IIO_CHAN_SOFT_TIMESTAMP(SSP_CHANNEL_SCAN_INDEX_TIME),
 };
 
 static int ssp_process_gyro_data(struct iio_dev *indio_dev, void *buf,

---
base-commit: 8678fb54958893818ddeccd05fea560a4e1fc759
change-id: 20260517-iio-ssp-timestamp-697751153752

Best regards,
--  
David Lechner <dlechner@baylibre.com>

