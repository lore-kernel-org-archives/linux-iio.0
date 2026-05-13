Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51A3AC0F0
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700701; cv=none; b=hDfuvVbcUdmHJMHqv/BWe07LoqfgEIR70r+hhW5HYr4qqm4aGo7xoMgpWzj03YJOqFzwvWgk+BpPISXh5NbA+aXtvZz4ybBY6AtRO/BXW86Mf74eHZ45+Hsyp0evTsPzExqj+vBJDmAvrYm8HX0ii0z+la1KvIek3Ds/Ap6ajVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700701; c=relaxed/simple;
	bh=umbnwUIl9frFTfgsM6LbA4PbzVggLUwsmKrLc75l5E0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HZhMo9gA72v2t/7S2vvVBhQGjVoStotV+gzxc9Ob7flBMxFzThGYtB68G6Jkddj/H2IY8N3RcAu4DZGi9xqCM8SiV1EE1fgguNfTnlfi+9w2Zd4WZHFPY7dxmXk4Cy8KsvrRe2iKZkeJSAtvE+kI95SSPdUGvpV/6T1qp9n2svs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsqzX+BH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsqzX+BH"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4493cf2f982so516094f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778700699; x=1779305499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2toTd1xQSyQBGtF16IY83ToLBXQpvwDfOkzh0q3FOU=;
        b=HsqzX+BHjtKOB1aO6jB+KPgLWCzfKcjZm8sY8VHFUPiNaY8VmDoqcmzq7cAiMYTjjx
         ujriM0nilIO00o8Tifpwv1h1AhzFjoHxpNskUEki/7RpkGrvweDnTCy8F+enJs+KXMpy
         LWSlcUbBtXGl/UktnOpB1rjPT0vXPwKP2h+z2U2nZ+ItwccVdAZCA7UW7UqQDIQ/tyyf
         GiJ/7Ujwwk2rWFoi4u20VteSMJxhLb7BvunqJYyXKGACnG5K897/cp/+OfSeAjbJpWU4
         b9b++FBz4sXxsia4cg+uK27HBv4G4JuAIJCAH5QOxElHoieSG13ttiFafWQEPcnolllL
         Lf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778700699; x=1779305499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2toTd1xQSyQBGtF16IY83ToLBXQpvwDfOkzh0q3FOU=;
        b=WMUZERAOVkiKtaCcqWa9D9Bs/WvsXdE/Tz+RaEuJZm7AOazrWJMhFMbbyyyyJYcx/g
         xmr9EKCZHL3YBxbPX3jjXA7EVKrjLEgwMkbVo+sZr45vdF7M5Vd+pWS055QKAU/pnQls
         WSUCtpvEyRR5EPmrsKy6QuA6L9qPWeTTFOKknJ0R31FmZa797qvfLkHqL87TuKgRytyp
         cSMS87+AFGvp3a+j839CM9bTsF2473Xcyw6jzstr0eBrfUPy3783w8y8FbvSc3Rc54oG
         fFz+Piu3HT7w+lCwLNW0/xpVF5jD6BTk+Vid0ISwaYphFxlhacECdgMNQCs/zBDkPiLd
         GmYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Yy8MExyxl5ANEuPnjhva/j41SGX6QeyvUCHNXqXntERWiHXRyTp40RDLvbaJmjsKXx1MlILDSqFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+14Qn1nqJBNXPonDwRxERVYytArxQ5LWHlMOL2JWchS805VN
	bEMFUYBor5sOx2dODNPEd+lmiKuP2pH+sV2di8hUiLCvX+U+BmqBOPS1
X-Gm-Gg: Acq92OHZO+b/j2VhWBNf+JPwa24ndsgku1CSfWESfOSRBLtu5Y152RVJR6J5Ja2yhWT
	U3oRowH5h3URKeiFK44YW1deqGRI/1/1KMdTJAfZoRjLn4DvzVGFzhSLMPULKFjpjb162n70rGx
	4Y5/DAXMrT0SE4ehFxWRFIPxdK3hQjxkf/d39trZ8t5fC+l6rTtbg12xJQF7OdwHsL0bm7AKIJe
	yeXs79LGTBOdLJSZHnuHFMuCj2Y6S1HL7HbNocNj8zlIjqBgsr+0D1h5rl2D3x6x+xvJIv77cQB
	t1NAnVQLIV9R1YL03Zh2DVHZvsu1HOd1yZnAyXMKMpM8N2aVcPoHrEE6MCkBCTEEIE+wL85AW6G
	NBCkUVP3paCgr5VVN1BVU9ETUOQomWT7nNorb3RaUHL4sJkdycl35jt9EoKakW1wAK09gy32lqb
	M0FYVpc4Ov0IPE+lQoNQrJd7W+EunvD16QqkDicRNVk0Ds
X-Received: by 2002:a05:600c:3b16:b0:48a:79da:c87 with SMTP id 5b1f17b1804b1-48fc9a51444mr32161395e9.8.1778700698702;
        Wed, 13 May 2026 12:31:38 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64cead5sm9314965e9.10.2026.05.13.12.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:31:38 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: songqiang1304521@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: proximity: vl53l0x: notify trigger and clear IRQ on error paths
Date: Thu, 14 May 2026 00:31:19 +0500
Message-Id: <20260513193119.17884-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vl53l0x_trigger_handler() returns directly on the I2C read failure
paths without calling iio_trigger_notify_done() or
vl53l0x_clear_irq():

	ret = i2c_smbus_read_i2c_block_data(...);
	if (ret < 0)
		return ret;
	else if (ret != 12)
		return -EREMOTEIO;

A single transient i2c_smbus_read_i2c_block_data() failure (negative
errno or a short read) therefore leaves two pieces of state behind:

  - iio_trigger_notify_done() never decrements the trigger's use_count,
    so iio_trigger_poll_nested() silently drops further dispatches
    (see industrialio-trigger.c, the !atomic_read(&trig->use_count)
    guard);
  - vl53l0x_clear_irq() never writes SYSTEM_INTERRUPT_CLEAR, so the
    chip keeps the DRDY interrupt asserted.

The sensor's buffer mode stays wedged from then on, recoverable only
by re-binding the driver. The sibling driver vl53l1x-i2c.c handles
exactly the same case correctly by jumping to a "notify_and_clear_irq"
label that always calls both helpers; mirror that here.

The bogus negative-int return value cast to irqreturn_t also goes
away as a side effect.

Fixes: 762186c6e7b1 ("iio: proximity: vl53l0x-i2c: Added continuous mode support")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index ad3e46d47..7acb94acc 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -87,15 +87,14 @@ static irqreturn_t vl53l0x_trigger_handler(int irq, void *priv)
 	ret = i2c_smbus_read_i2c_block_data(data->client,
 					VL_REG_RESULT_RANGE_STATUS,
 					sizeof(buffer), buffer);
-	if (ret < 0)
-		return ret;
-	else if (ret != 12)
-		return -EREMOTEIO;
+	if (ret < 0 || ret != 12)
+		goto done;
 
 	scan.chan = get_unaligned_be16(&buffer[10]);
 	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
 				    iio_get_time_ns(indio_dev));
 
+done:
 	iio_trigger_notify_done(indio_dev->trig);
 	vl53l0x_clear_irq(data);
 
-- 
2.43.0

