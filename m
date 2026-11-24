Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511445;
	b=0V5oKMgOEpwQiICIiAthj2ce8DLBiJFkhGLRk+5f5iFsXGRzqxZMuVIVMw3GtHai/dIO
	 yn9oG52p7qR5UqhYywywq9p8QjnxX82Woltf7ZWetHeQSZnBvhyLlEn4z5tkBBLePBHHy
	 Y2FpnliErP5U7j5cQ3kZpwhI8GB/SJef+Fy/YqIOmMFUIEjXqPL42vVZRfDjrTuYPyWjQ
	 wwVFYI01hqC6isFmIkNwxS/JAKG8q0ObZCMCeSjORP3NDP6fnpVB92c0fEX5pjC8HbPYX
	 oksTGQu5yKI48zE6RacC0NlyGgIoWF0eh4JruMvSoTFY/CtoE4/C3pDMCqEuMdE5TvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=yUsPMfI898FWLLgta0g0lTJQqLkwN13wBnF+5PDzMVY=;
	b=Qzo+R6nrNWFGcIUWgLG9arYhpkFByXyQsow25tpw9MlGZ8Odxmfv3tMmVaosAJ3ZBav+
	 KsbQIWkHYrIteUZZ0tlZXPtWb+QJtkqWvknENlya5eK9yCzS8kC7sECl5NaHJgZSwRHwP
	 Z13dKByMhUJl9V7pY7DocbzwoCy+49a+PzWV1p595zMCvBIyHXT+TMFqQ+i5vSc6nVBFs
	 Gd9D/8LmOUFwZyMNtg7TLeWeliHteGDCXIpqiuLL5LSEG1qU3zyYYypj+d1K3Ov5OwIdQ
	 ZwH8jY0vO3ycGATGutDl/PtVuPdwAsPFPLn9mb+0ON5v2MRZU5sC/cBg7X4xtEmY52Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CVLFixiL;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147D606A321
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 09:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E147D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CVLFixiL
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ccca948203aso3502784a12.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 01:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795511444; x=1796116244; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yUsPMfI898FWLLgta0g0lTJQqLkwN13wBnF+5PDzMVY=;
        b=CVLFixiLDyElBqWh9sFUDLHVDzjWEiOXbLSrnWLShHiUzEKxDPKzk7Il8UbYRSZBZ6
         g+WxrRdk0i6SVW9W7/Oeob8WkNmxuyV5IdmcMWY9z/lWVcklBdZk14JRQmnp+vrUgQsm
         NrWoIA+ZKKTYW6m/74dbxlnoz/d2+AtnCe/aJ6ayDogxcCzo+rg7yVNgvbsml+Ghc2xH
         IYhkhetwSyU3v9vFMWHCgx0m1skFSbKBhvn54s1MpJ8xBCFtXgn0FlIMPvzNFQzBah2D
         E8TjtMf7v8juUxRex6HsqgpTqmud7i1z9eiXVohk08v7F/5n1ksWWESE6InXFu0N6glA
         T1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795511444; x=1796116244;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yUsPMfI898FWLLgta0g0lTJQqLkwN13wBnF+5PDzMVY=;
        b=kC9H+4ONmzGHKGR2Sf8WYk/TJ51eFNJNnxnnirj0kCGofGnqnRCfPUPUPU6GAz7b7h
         gHj5ram/hLWuBf4CmEzE6kItI2nd+1uMNLW+SpNxwXqb3aGIMM1yI/neGnEmG/lnKbj/
         SGn1XktV9elGZzWSoxmo6ODz7Uy8k6w4GgxgN9WiXVG/6TSEDrmuUfpo2fNZEEveIMhS
         q1D1z1ntVjJ8JqY3Br6jKLTgDGUIcNyUmAPV+1pkLiB+NEutX90PtjzzI7TyBwBHR19j
         oDXQIy0Vb1P08+MkT959Ke+W2dV9OsIyyKwZ7ydyxF0ddjYoxHimtkq9x+brc99pG7Sw
         5t7A==
X-Gm-Message-State: APuU4Z+f8mMzwELNrN9IlVbffcIt/qffUnhPu5Ge0CCaLkI42JPzrMlb
	HT0xuA3DhXrpsAe2Tubwd3LuqHP82Rc88mk0VHJWtL7a8OT9EZbyNK3SlEikWp6/ZmaRLA==
X-Gm-Gg: AZFdTZfdU7SvXNHLIKhmRCuEJymj5M/ksV4f4OrGAwCXJZQFkUTbfMSxzMrCRi7abfI
	JBlfklPYn9DymHeHi3Q8DOEQb3Vxksh2t1ck7rJb+S9dJ8cNkQuUTmXkWAzGqiv4SNFgMioXDA1
	CSZsghpzeyX03FDk7SxUulpFuZZj1QmvyXIpBoGbtjwKZv45hVM2ltpdEEYJt/sEVq4lBPRQQwO
	zVdwboD7098g5K3vRV8CRk+7up2TT8TFzkM2keMoUUkaMsRhRmnd2knPt47R2H2JWmpxVpH2w0X
	jntpHR/Hb8RAP85fwlYLdOx4mDcigD5Bj7ea4BMJXiVNhyAAFubmVHla778N7bqYADUhDSL/y02
	GkafxCdW6U8BjeF096FxM3fRWq5aJ2X6Q4JJzLc6Us9Ut5bqmHDQWa5FKvLA20rvM9DpN7JLGPc
	9Yn4lyYXeA8nki/u9pU3ch4nAnWNpiQTbgEWY5simoOsVSoa3IANWP/U7shyO+BzWZKXvUSNDps
	jCRWGZ/2xjM9+eRiLhgqFKkbDdf4OP+oBns6AwPS56rQ9cwvV5AAoFk7+kmVY+7JvuCUU/1bRv5
	8ehPuMmn5Rgjr/bc9pi2SXKkwe3bLRmWlKYfyzakzWcNshJGrRyxNwQ8MzNw
X-Received: by 2002:a17:90b:2516:b0:3b4:c9f8:abce with SMTP id 98e67ed59e1d1-3b4c9f8abe0mr1746956a91.35.1795511444107;
        Tue, 24 Nov 2026 01:10:44 -0800 (PST)
Received: from [127.0.1.1] ([112.6.227.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b457a58d04sm8446914a91.0.2026.11.24.01.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:10:43 -0800 (PST)
From: Liu Yufei <lyf98405@gmail.com>
Date: Tue, 24 Nov 2026 17:10:07 +0800
Subject: [PATCH v3] iio: imu: bmi270: fix zero timestamp in triggered
 buffer
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-bmi270-fix-timestamp-v3-1-6356a5467d5a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAG5UBWsC/4WNyw7CIBQFf6VhLQawL1z5H8YF0Nv2GmkbqETT9
 N+FutCNcTnJnDkL8eAQPDlmC3EQ0OM4RDjsMmJ6NXRAsYlMBBMlZ6Km2qKoGG3xQWe04GdlJ5r
 Xistcl7LRnMTp5CAKW/Z8ebO/6yuYObWS0aOfR/fcfgNP3p+LwCmnUhoGRQtVw8ypswpvezNak
 i6C+EQ4K39ERIzUShR5BVxIpr8j67q+ALCBcrAPAQAA
X-Change-ID: 20261028-bmi270-fix-timestamp-48a194b69db1
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Gustavo Silva <gustavograzs@gmail.com>, 
 stable@vger.kernel.org, Liu Yufei <lyf98405@gmail.com>
X-Mailer: b4 0.16.0

The BMI270's own trigger uses iio_trigger_poll_nested() from
the threaded IRQ handler, bypassing the pollfunc top half.
This leaves the buffer timestamp at zero or a stale value.

Capture the timestamp in the hard IRQ handler and use it when
the selected trigger is the BMI270's own trigger. For an
external trigger, take the timestamp in the threaded buffer
handler before reading the sensor. Drop the pollfunc top half
now that the buffer handler always supplies the timestamp.

On an Orange Pi Zero 2W, the original driver produced 256 zero
timestamps in 256 samples with the BMI270's own trigger.

Fixes: a1854d55f54b ("iio: imu: bmi270: add support for data ready interrupt trigger")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Yufei <lyf98405@gmail.com>
---
Changes in v3:
- Timestamp all external triggers in the threaded buffer handler.
- Drop the unused pollfunc top half and the timestamp resets.
- Match the selected trigger against the BMI270 trigger directly.
  Codex identified the shared-trigger case during review.
- Link to v2: https://patch.msgid.link/20261106-bmi270-fix-timestamp-v2-1-8a2547e1290b@gmail.com

Changes in v2:
- Capture the timestamp in the hard IRQ handler.
- Use the IRQ timestamp for the device's own trigger.
- Fall back to the current time when no pollfunc timestamp exists.
- Clear the pollfunc timestamp after processing.
- Link to v1: https://patch.msgid.link/20261028-bmi270-fix-timestamp-v1-1-99c0e5fe7d0c@gmail.com
---
 drivers/iio/imu/bmi270/bmi270_core.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index fbcf6bb87acc..6983d80efee1 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -157,6 +157,7 @@ struct bmi270_data {
 	const struct bmi270_chip_info *chip_info;
 	enum bmi270_irq_pin irq_pin;
 	struct iio_trigger *trig;
+	s64 irq_timestamp;
 	 /* Protect device's private data from concurrent access */
 	struct mutex mutex;
 	bool steps_enabled;
@@ -755,6 +756,16 @@ static int bmi270_get_odr(struct bmi270_data *data, int chan_type, int *odr,
 	return -EINVAL;
 }
 
+static irqreturn_t bmi270_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct bmi270_data *data = iio_priv(indio_dev);
+
+	data->irq_timestamp = iio_get_time_ns(indio_dev);
+
+	return IRQ_WAKE_THREAD;
+}
+
 static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -840,8 +851,14 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmi270_data *data = iio_priv(indio_dev);
+	s64 timestamp;
 	int ret;
 
+	if (indio_dev->trig == data->trig)
+		timestamp = data->irq_timestamp;
+	else
+		timestamp = iio_get_time_ns(indio_dev);
+
 	guard(mutex)(&data->mutex);
 
 	ret = regmap_bulk_read(data->regmap, BMI270_ACCEL_X_REG,
@@ -852,7 +869,7 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 		goto done;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
-					   pf->timestamp);
+					   timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
@@ -1430,7 +1447,7 @@ static int bmi270_trigger_probe(struct bmi270_data *data,
 	data->trig->ops = &bmi270_trigger_ops;
 	iio_trigger_set_drvdata(data->trig, data);
 
-	ret = devm_request_threaded_irq(data->dev, irq, NULL,
+	ret = devm_request_threaded_irq(data->dev, irq, bmi270_irq_handler,
 					bmi270_irq_thread_handler,
 					IRQF_ONESHOT, "bmi270-int", indio_dev);
 	if (ret)
@@ -1630,8 +1647,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      bmi270_trigger_handler, NULL);
 	if (ret)
 		return ret;

---
base-commit: 09f742b49cb2728086d78be2b0b35e4d1d71fc85
change-id: 20261028-bmi270-fix-timestamp-48a194b69db1

Best regards,
--  
Liu Yufei <lyf98405@gmail.com>

