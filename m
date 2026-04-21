Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ECE37BE80
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810172; cv=none; b=qvzwZcZrSgotovqXXXJozyWy7wBybQtGLTb8lZqbzfoSXXXbuj3p6/FyIQnnl9vCOqAQW2V7ffVPxf45YDBzsEjhxcrvAcUOS7AReILltZmWyX8DMOGKOz7+HicDk8w3gFnV4f9aGxRyQQpLh4VWQvQhwxIXVXVkmZAu1GTqR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810172; c=relaxed/simple;
	bh=pYVCusB/Yg6NECKuEuztptsmj+C8zqJUgjgzSK1ZYmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alc/nyDL7xgQ+79PhYsFsNMpatdmN6v9jmkIM6rS/quUNfqpU8LgtoZpjuS26UKoPYGHM5xV7bIebwi6Mh9jMylfSm3H6x83WFfUcybZP5xv3sVfX70VW0cHtgQ9T5lnLtk2kIi9qTmJ6Th3/GE/m6aL3c9IKPIeU6hBizYW0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=w+p2Ki6E; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="w+p2Ki6E"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c6df0b9bbso2141641c88.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776810170; x=1777414970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EQNgSiI0V8p/6r794MZ3/liLrTK/Jnr7QGMXeuwHUs=;
        b=w+p2Ki6E5drm3ln6xrT98zS9O+6sgZ2MAlsx+8x+147nEtykeWMQOu5TkPRg5WrIwc
         BUP3ER9mq1JMIppMhcdeIKI6ThdeoI2YBsFW0oCNr1fONGwshjrWHUEflfwgkPtgMQuQ
         qPj8A6sEgQcvOWdoM1XKF5Uj/kImeWO8VX7bIHtk+ktW2L3dfmZ5XIQ1XAFB5XqnSIv4
         3IBrkjxpVcT7+OdNdPIZ2h91wl9jWMFGBticWuEdHTIyAput2F+mMO3DhRT//7MhQ1oW
         zikZM8Pj4jQsEflHrMYlmoKBCNTR4XlZdcZOO6xXC+IKM/5lvo1vO41INCfZL++HLSrv
         p5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810170; x=1777414970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EQNgSiI0V8p/6r794MZ3/liLrTK/Jnr7QGMXeuwHUs=;
        b=rIF2hrwpr+buvuTr+v01GO6HMqCd9Y+iVaGO53jBRihxFJjMIlIEDw8/YUlsSfDKJ3
         StSngwEpPhZNyS3jvSIgKNoCcLEpcCKDRQACviEL0xfnkaUjFe+YBP5+Jy1Xl46Q4+1I
         ObHcd261YhIIsRTrEW9QM5OYpec5YlwxtSqIEc7iavhnyuw9yAGcVo/3hnf074vWRBom
         Tvzyopxbcmucc8Yman+dHezINDjm0ukPw9OOUWhvEvKkBLREvjcY7UWS+3Qepo4R3rQf
         zhpjER9kmAB9PTKMv7HGjXb6D1/5wPc9VkJWyp/ALBcaxgVyqQItnSXNZaczCCnQqvGD
         F4Tg==
X-Forwarded-Encrypted: i=1; AFNElJ9nCMka+k+JKiMOMcIWS9f/42/la9QAhCuWTUjNejSiHcVAgb4bZrjFw2SgQAjfz95qrmQT7uripkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhWlCDM+P961x95BdWhBkC+6xV/nB8CR28L6nHIVWqx+LV9UbP
	xqy2iBFZ0FWH1QJpg9yxramiTX65DVvLSRZo57SpzpH+PZ+nQkRtQf93XXe5LKljV+A=
X-Gm-Gg: AeBDieunprSJyPiyCPKHf/Sa/d1C6RuIhR1CY2CgGlygyYpoD9IeIGimfG/qWUh0RNy
	Pzg/W6iVFycaU5QeQLpKSXTxwFNqGdYJQzw+NUfbo5rbrm4iKVtHRqVbGUOrmVCGRFgezLSe98R
	5TVAw3fh9jwrUIXpkb6I2sfBdfvuPZepYQ9z/NLZBPdeDSl5q5UoCNqEabgSKGtJQ5SnUwr0yF/
	fsY62iBLmC/tWa+x1Q7WGKwls1ae2vCaIbzA3/O8hUbdugmidhYm1TcUZdvlJckh/mo62jlJ4KZ
	JVijEhuhlbkoHkEMiFtAytzk+at+TOsqEvafrX+j15MvNaaADbqqYmp8Q+64kbmr44ChJdkLZ28
	DjQUZmXiaWbBlEM1MjfDxiYu827CiIGjxmpJFBYG/4FKVk1VaTtRZxu47GycC5r7P48jAUUvxHb
	HiwUCrw55UhhDeKmCg2KxcrVvn6uUjCqhiMR3Hdw==
X-Received: by 2002:a05:7022:ec07:b0:127:867f:2448 with SMTP id a92af1059eb24-12c73f9f309mr11039454c88.26.1776810170385;
        Tue, 21 Apr 2026 15:22:50 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm20129785c88.8.2026.04.21.15.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:22:50 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	bentiss@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v2 4/7] iio: light: HID: Replace method als_adjust_channel_bit_mask()
Date: Tue, 21 Apr 2026 19:20:36 -0300
Message-ID: <20260421222210.16016-5-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260421222210.16016-1-natalia.andre@ime.usp.br>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace method als_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/light/hid-sensor-als.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 384572844162..16ef9a37aeae 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -117,17 +117,6 @@ static const struct iio_chan_spec als_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void als_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-					int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int als_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -335,7 +324,7 @@ static int als_parse_report(struct platform_device *pdev,
 
 		channels[index] = als_channels[i];
 		st->als_scan_mask[0] |= BIT(i);
-		als_adjust_channel_bit_mask(channels, index, st->als[i].size);
+		hid_sensor_adjust_channel_bit_mask(channels, index, st->als[i].size);
 		++index;
 
 		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
-- 
2.51.0

