Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8BE2882B7
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785600; cv=none; b=FUWW3KXar58gpwVrOyn3rnBDkfQ8jTKe9MYOYN0vvQSwG/SPTqnh51RA9dhFSvcdBpGMxlmQHlsXsPiOLPDqE9SqOVuK1pVWB4AN6VZA/+XyxdSn8pxrSUhMxwuqIJWEO6TOYDrBNyX3Neg2/N5uE4fFdD9XA+v1QRvM7SkTosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785600; c=relaxed/simple;
	bh=qLzTEG0vAb1fVHHleYCIHVSPJN5rRtgS8VUpHiPqUss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mILgtB1TmUZK9S3iCzzYU5byYh6m7yjaOXpjm+d7auNmjZEgMXtkyjbxYNcA2ysU4zAMhLQj/r+grsECThIbMWcioqAawtkJmsUxsD3/TPTF+vfQzg5wT34iRWZH6K+sspNSlV+UiterQcDXF+guljWUUr0Be4YrXGhApnpwFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=XUE+hG7g; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="XUE+hG7g"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-139b5e604b9so4645099c88.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 19:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1782785597; x=1783390397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHXvlgwhzgwaNu3wblp/hnWeWlO47iBmvx2wTGsjZzQ=;
        b=XUE+hG7gXFDxPMdTtrPy+a/YBJLdF1Faeso1sX5Hy40XnTaydijuoClKaHzQLaiZH8
         CAcGQCBsr++uBwaWnlacj5l4zLJJZYdPCMj2lFz4DAM2QidXqcjpldwueb9J/Vkxpj9J
         Orr05ndHlbaopQuE6Z+U7Hrv2XZu0JLddQXfgVxkoQO7hwWiEXc64Qu7Vpr34OUzchiY
         gSzC2opMqz8GAex0rCnIVmMJixEFQybEFE29x5WcoIirvVf+gtl7vGYOlMQHU9eskRtu
         mz7di3+KwJ1nTyerPVgkqzyDiZUtBgw5qfqTZ3SvUrX51bZAjsFZCQQqmo5ld/iT88nc
         bGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782785597; x=1783390397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHXvlgwhzgwaNu3wblp/hnWeWlO47iBmvx2wTGsjZzQ=;
        b=TzwJdWwQnfAh6L0J80hMiNCuOkRm2sjn8BtmRZ1aOmSAVe4i0HoBFZb0b54nweZNhQ
         FqtyEysRbbMT0jG7bDqUrWChhSPzNjK9sm3FT3yTQCB1CIu7izARAUwYFhq7BRuQn1Qq
         sasnQiK/0rCWsm1P1oJHdsrxq2fOzB+vAhdsY9uJyG4j0s9htppfYu94jvNaR3+KwEgC
         qghcel+BLkppwhZqvwEh2J5nDC4tv/HVrMZCwL7cUiGfxGydgGx7gF9zXly8ZR8/Yacx
         3hJya7tOfCEbbql7Ovu86T1Bh2TwgfFKJCXDQDdHRkGvAcAIRiEq7WQuOOZqLyZ8HlWT
         /C4g==
X-Forwarded-Encrypted: i=1; AHgh+Rraq1RF+6Xx1lSx5thFRDxZtbgS/BKpKqE1lKckrvhavbdXKA0/VcUOTAKk/qWXp8cnpzcorxFC0ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbH4c2MLRxRr9j3Gj4YOrKru53GZ8las0h06v3K5x/sL1+UFWG
	JRBHOQaui1W/vwdisqdeP+Pt74gTye9fNZ/kP9PGW3UDHT6ezDYbFnRN78gZYsx7yfk=
X-Gm-Gg: AfdE7ckXKrOj5ihkbhgQjNn9h3E7wjovWOFJheevNrtLZrlEW68a/pUGS3Q7fcQli2+
	afmZwA8KlQ/fL4yk7Lg+OAgg17YtOT4ECZ8i9qrE6whixblHHk2RjDVakJuTUwJltKRqavGJPb2
	OHQPEY2Hm49VnQkLZ0lzHAinRc/h8sxSq4V9c8Q68As5Z0SR3u/kd9Erq6M6l/4T5GYD5kM2Oce
	+8NlhP9n2J4Cci1XrM3AjGXjRfPv5ria4YMXJWN55rIlWpDA5BUoD33JjiXvBPwQsl1zBFoQyMG
	dxLn6Oh3Z4HDLUOeMAEH/TrCjoUGfhpJsoiA73Amymb/q9PSUzBeLY8GNUQF9SpjL2O3yxn6Pte
	W4T+hsQcPavPs7eCPLDCoKMLBvBgpq1uy9am1qKLDIUtDUrA7qWnHg21umikeyn5o0Mc0xlzX8F
	BQpKZp0aSFsr4WQ38K7+jWUU2if1X3YyjZpE7q
X-Received: by 2002:a05:7300:7245:b0:30e:c30f:fc53 with SMTP id 5a478bee46e88-30ee11ad71emr1226622eec.3.1782785597430;
        Mon, 29 Jun 2026 19:13:17 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:ec21:865b:5eb9:80c:c4c8])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-30ee32519aesm2311203eec.27.2026.06.29.19.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 19:13:16 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] iio: dac: m62332: Fix regulator reference count imbalance
Date: Mon, 29 Jun 2026 23:13:09 -0300
Message-ID: <20260630021309.36636-2-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260630021309.36636-1-erick.henrique.rodrigues@usp.br>
References: <20260630021309.36636-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m62332_set_value() enables the Vcc regulator on every write of a
non-zero value and disables it on every write of zero, without tracking
the channel's current state. Because the regulator is reference counted,
changing a channel directly from one non-zero value to another enables
it more than once, while a later write of zero disables it only once.
The reference count never returns to zero and the regulator is left
enabled indefinitely.

Only enable the regulator on the transition from zero to non-zero, and
only disable it on the transition from non-zero to zero, using the
previously stored channel value to detect the edge. Balance the
regulator on the I2C error path so the reference count stays consistent
if the write fails.

Fixes: b87b0c0f81e8 ("iio: add m62332 DAC driver")
Reported-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/r/20260419144958.03394ed5@jic23-huawei
Cc: stable@vger.kernel.org
Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
---
 drivers/iio/dac/m62332.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 3497513854d7..b66b4c28859a 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -43,7 +43,7 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 
 	mutex_lock(&data->mutex);
 
-	if (val) {
+	if (val && !data->raw[channel]) {
 		res = regulator_enable(data->vcc);
 		if (res)
 			goto out;
@@ -52,14 +52,17 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
 	if (res >= 0 && res != ARRAY_SIZE(outbuf))
 		res = -EIO;
-	if (res < 0)
+	if (res < 0) {
+		if (val && !data->raw[channel])
+			regulator_disable(data->vcc);
 		goto out;
+	}
 
-	data->raw[channel] = val;
-
-	if (!val)
+	if (!val && data->raw[channel])
 		regulator_disable(data->vcc);
 
+	data->raw[channel] = val;
+
 	mutex_unlock(&data->mutex);
 
 	return 0;
-- 
2.51.0

