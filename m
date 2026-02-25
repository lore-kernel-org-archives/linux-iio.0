Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82578392823
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014285; cv=none; b=BbiEwwDfzAC3170SRSRDXkVrNIhCvfxMfuCSwVkvYgMyt9I3oXFtxo4TG5LnZ5/DFMZyG2oqEO0QEmT3509cR3kE+cfWtUqADGRpaibrVNzLimzZFGAdcQD/3sA6Ikr8Obe+TqHkihySZPJQbLy/Up3AgGUTqu7uMU/7h4ChhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014285; c=relaxed/simple;
	bh=aBIjT8HJMfYZDveJouRj4sa520yQuhHwAmIb09eSjwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQoUZjFbhXh66MAJTTIaTZ/pl9jCIdX8YdkfiwT+ApH61POttvkZclQ4oaoZHdDVVzAsm5isZcxIoJIIc/9MfdrycVN0/q1Vh4F7Uha5BJtpLnk06QmOqRloNWZb9lWqleNZ4wJS8Vb1ip6Z2laYp8XiQlGjHQkFkfsFPQAZhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VcXXb2HA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VcXXb2HA"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso55420935e9.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 02:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772014278; x=1772619078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHmHZviAuhOhpKSUpCtTa1iFHF2rU7EWwgoioRxdGwg=;
        b=VcXXb2HA0DPZgV7hLbmEfIziBEz1bPQr4I/zaSvXo+4Hev6wtbLCnaKsNbzA5qKRps
         aT20Q81o83AJrNrvUc/K1pxNMjT2e+gfYUmrygBAIbqlzZtv8WcaVuqwjgT/ajPteOUp
         3JLJG1DmSKEdVht37niVRDZzzgTUQ9sk1vJ8LgGEBnScJhCHDlLnH4BCwenYH7nGUxiY
         7XE7zEXJnVWNZGdQPBjcZrEpNX07BZkeSy6NRFr/0JK8mJF2oQYefCfWOS8RlKlaVHYO
         hQEdMKPgQ3C+EG/hory5jqI/dzdyq/fmMYZPPq6P9YB2xcUYAheVUhKeoVNhC7KgOmWa
         2PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014278; x=1772619078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RHmHZviAuhOhpKSUpCtTa1iFHF2rU7EWwgoioRxdGwg=;
        b=lU6sqhls5FcA8z4C6omBkDxKJTZMlKXwysV9RReCT7+tVmh19OlTRN3euKfvJ0xobm
         LQGvKJUUa3Q3npfXIvjsNO4QB0Njjc4Cux6Lu2YCJUS2NXiZ6rGEXSF/NuP2AZAfzdXw
         3iffEnYCdtZj9fr6UjmTzuct3XRZ75EfThmnZFrPs9v0ig/zlXYNJblRDhZreaRmwkcJ
         Iat/tJs2BREb+kqheJK+UEdIR9Bmy8GEPUhqXHjgza8CShEe13KdbL49KIyfC6UW4nka
         fmo7haja1s3ZRg0uNPhnTO4ZdAdPyzR77fN9aKqsc10l2pa1HyZa5n5JkAZ8t+Z+SS/X
         cUBg==
X-Forwarded-Encrypted: i=1; AJvYcCVryCInjUcpupuLhg7+tZehZYcoHD2rFiiUO69uiz2zf79udBnSVftidHEKZbIqa+ceptzBCwI/vKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQitEAacTokMzvSaTGoVhXLAn9bzWwZwntRhg5HjSR5FsoEf/
	XXjNA1GiTx2GEMKjJzSfP2WmkH6iMCutifdJIl1WjfZAh9CCeA0HMsZISyxQ/j582VM=
X-Gm-Gg: ATEYQzy1LlPnFdwUB7+tKJEsFsqlYCtOSYPIukYkn7cMkV6Itc+V2gOSSsyh/30R8za
	xAe26t66r1fmS0bpvVGYYj6TSYqVu086hWyBR9lix99glw5UTzPsc1pSzuWFCo6AaF8GsN3rtOu
	ao5o+rYVgQ3N4+AUNZseOadAnChpIWJ2kPxyLDUpJKZ5KcAP8gFZOE+hghG82vzNWBtDJn6KZdw
	ramaaUY/X+6zvmxiuckXR6wTjA5I+XNyR2xy6YSdCIgghekpq6zfzY0Djpa0fMEM8vEKB7TLitB
	+h/qYcJzcmp97yLO6cQAE+JZvD6HQ4CtSd55JPo9zA1YCJ3r1kga4KWll+Ab/OO3uGqj/vBWpxX
	zmYXw4x0to7k7Sa7hRd9G7Ipd3XpVLQf7/Pc3xvHvQKx0lFY5/nRaF0qBylSOiAQil4QSVdtxCL
	/LrzxmsHNm1WXPMg==
X-Received: by 2002:a05:600c:6217:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-483a95eb550mr234842935e9.3.1772014278402;
        Wed, 25 Feb 2026 02:11:18 -0800 (PST)
Received: from localhost ([151.35.220.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f19d6sm61115015e9.2.2026.02.25.02.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:11:18 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/7] iio: imu: st_lsm6dsx: Set FIFO ODR for accelerometer and gyroscope only
Date: Wed, 25 Feb 2026 11:11:17 +0100
Message-Id: <20260225101117.2367725-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260225100421.2366864-1-flavra@baylibre.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=flavra@baylibre.com; h=from:subject; bh=aBIjT8HJMfYZDveJouRj4sa520yQuhHwAmIb09eSjwY=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpnsrEKHlBS2+YWZdjOWGvX/xqPbpahixKnyHdW ADRDgnr6CSJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaZ7KxAAKCRDt8TtzzpQ2 X4IdDACwcFakHxGhyeruPzOvOIecz8RZYgU0hftyD+MA7TKyz82erqakc376M0BnhZiY2DNJi+Q yeD8OzoDUFtsHVIRZvmv/o7+bA9CaOkYY/uIVQP71kD94kioSZVQdxV6KbjCozqEcrkWIckJFkJ 8LlLKm1sVmtp74Balkf8J5n2J1/Z4Ngg+mLjFXO0+/xnXQuqlmQFVViA0cWYYwtpXxZ+KZp77HT futRXa7FZ3xZCPUb9HoFUHjkPgf5jQC5dh/oz2xJGqfLwThuCpp3bq0RLawU5H/XE7U5DZ6RPjq ck4s+r9nKWDbZKRAofCUyA1EWoU6/t6pfxYUs5SNrF89/x6xvFG12f0hqRaugYD86XuU8mVT/Bk zXQprGqLGkjQLDxXwqteu/Mnvn/Td8wjUpwi7IDfFm5w2CxDfAXdF8qLp7UsvUP+wb147dLPejl qONm+TgDR+/CNbEahFEMuCGr8hbYvIsYJCCgZVAa/t62dZIHdKADSP4Q6NIOlJgG1EVKs=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_set_fifo_odr() function, which is called when enabling and
disabling the hardware FIFO, checks the contents of the hw->settings->batch
array at index sensor->id, and then sets the current ODR value in sensor
registers that depend on whether the register address is set in the above
array element. This logic is valid for internal sensors only, i.e. the
accelerometer and gyroscope; however, since commit c91c1c844ebd ("iio: imu:
st_lsm6dsx: add i2c embedded controller support"), this function is called
also when configuring the hardware FIFO for external sensors (i.e. sensors
accessed through the sensor hub functionality), which can result in
unrelated device registers being written.

Add a check to the beginning of st_lsm6dsx_set_fifo_odr() so that it does
not touch any registers unless it is called for internal sensors.

Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 55d877745575..1ee2fc5f5f1f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -225,6 +225,10 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 	const struct st_lsm6dsx_reg *batch_reg;
 	u8 data;
 
+	/* Only internal sensors have a FIFO ODR configuration register. */
+	if (sensor->id >= ARRAY_SIZE(hw->settings->batch))
+		return 0;
+
 	batch_reg = &hw->settings->batch[sensor->id];
 	if (batch_reg->addr) {
 		int val;
-- 
2.39.5

