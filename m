Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794960365;
	b=ZEIINs7bGS43p24RcSTaIYgaRwM5Ss0wk3kryiNgN5kunym4Cjgu7iqfBnHLTVVgOrs4
	 sfpRKAzqhfAfr/MnkPJeZ12r1l2unkFqiMcFV7Mk8lBbrBW444zP09g2dmfeM7Uqrt5kP
	 yfvxfFXCn6hFSffx1tN4HMIm8m3zWQwry4vEGyMrJDRoYcsiObUADKUPn4nSEzZnDtYo6
	 MXK+3oFVi3JUBUKOM4HabLq4wNx4kuyOEVAME1xqsEpOWEPQ1OHrn6Ts7lYiMRyPPzil2
	 EwtGREGmia3exwkIq8/HaJT0GsG572UG/Ne+C5yYHDgYhA8H/Ar327WAIzNQaJ2rA8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960365;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=unrS287i9FwKkDsWayC0w5UfBJ3WFgvs3n9HcLvX0gc=;
	b=UmrnlRBVoVDIE/pnZjmXoQkIA+O+0tO2Y54qHSfYN0QwouVryTHJAV7CE3mmeH8w5ba+
	 rp1YjbNe35ue37aLahyM45KGwmPfG29uOeGEmI5BXSThdaCXr5tx78W7D7wOrn0Vg9tBs
	 KqmOgEv/bScrR6dDm2G+7vpPsDoy2GWe9y/nUaH+Q+mr+Qy2bfv+R+6/RrDOWK4PTVoc2
	 6w6SRyxVGCUejV7J393C3P5wmdGEIsmmwcmI/X9j+xqloPWCBhX0PdnDTTRenEtfvWad+
	 MnS8noF9AXopwOI5UxJr+H+ztzoLOp1PUw+I8bvJwnktXnepohrnpGAI7oCrqUr5V/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abvdB7Gn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A852606A31C;
	Wed, 18 Nov 2026 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abvdB7Gn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794960365;
	b=dX3epUhSbn4Jp3m74+IFKMmqMYPyL9ddjoLdZSnifXDAp+HUfGgfqShnFDM1ddMUjhso
	 3EAbQXHcwLWg1rTLhioX6UiCBBOxzf0aaTh2Sx2YdWmByNXqpT3HYs3l1vZLXwcOgNQ8W
	 Wb0RkylgOqtt4icq5uqWg9X0EbA5JvmKS6FU0PZPmee4eztb/eUvQiQfm/T4qDUP6zzyZ
	 wK8ssvDjTC344U+9n4USbI1hFMj1Dh+RntqLe8JIcC08ufc7JMa94Fo157vm4wb8ei67E
	 QfJGaz1puowm285q6qodLpqMZzvCvCGc/FPGZQmCLZBk3mZqOry6oORvsUbZ36CQ8AA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794960365;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=unrS287i9FwKkDsWayC0w5UfBJ3WFgvs3n9HcLvX0gc=;
	b=uVYlDb+RFypOeeejfGlrG5TsZcVCxOOWqKhYHBxqwxUKF43Gy74/ieq6SawuO3en2ZF3
	 U7ElifLycAhSeMQg17ZuY44rOvkJGw8O+gdS+YAUbv1otbece3fy3nBE/RUYW26vduVV2
	 FVKAY7Snxq1mTDQWGT/A7+nJjm9RkvuHgDciYJ9XV748jcyZY5Rfk6RbRqXCHoLt334mx
	 dK28fvtADYIOMC9HCCPhAKegmdU8tsq1xCaf3gA42d8AWYFc2Q8wy2CeEu9Mjrx7CO+XG
	 HI9e5GtC13OS3/Bu0YlAT5b41Cyhmg7jUhU5r8Hbcql0jYAaKDkI6zUk0ovxkZh8Hxw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2C5911F000C4;
	Wed, 18 Nov 2026 00:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794960365;
	bh=unrS287i9FwKkDsWayC0w5UfBJ3WFgvs3n9HcLvX0gc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=abvdB7GnEEJEfaNSa3T8TxLLBlROi7b+SQz4cV84FPx+M82JFKdHnUwc/1EDHp7go
	 xSmbrWL6BoW0rgkkv2kEmfRdOieJ+rKbRZolL2pB0vJlQXR9HBWxWNFV0DyTsHJcAN
	 5kAQ6IrfBwd+/Zhcuv/Ue0SocO5hb/L1vWQnlCqqNLEzmYkg9UA0FpJ0soBxrfyaBr
	 N40eNK3QxELb6kcnZp2AVbSFc45sgZaBCxycS10LDHt7wc3PfdsYtklzaCsI5CG4GV
	 QLhLC4DpUDOlCK45SRWHwzsiLOKaHCqSm+WTEABC3eC4JaIAw0U4kRKELoyUkKCHDs
	 QXmtb1OCGayTw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 70FFC4790C;
	Wed, 18 Nov 2026 00:06:03 +0000 (UTC)
From: Maximo Manriquez Lizarraga via B4 Relay <devnull+DelaySystem.tubot.lat@kernel.org>
Date: Tue, 17 Nov 2026 16:06:03 -0800
Subject: [PATCH v2] staging: iio: adc: ad7816: use dev_err_probe() for GPIO
 lookups
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
Message-Id: <20261117-batch1-s3-warn-v2-1-17f4e541123b@tubot.lat>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0Jm7RimJVJceQ/Doh2L1Bggbakaw
 t2luHb5kvffXyBY72yAc7GAt8kFNw4biEMB3OvhbtHdNgZRihNRWaPRkXvCIPGl/YBCNdworg2
 Rgm00edu59x68tj8Os3lYjrmSjd6FOPrP/pgoe3/jiZCw6lgqWRFrqS5xNmM8PnWEdl3XL2mLE
 V6+AAAA
X-Change-ID: 20261107-batch1-s3-warn-289c98c7b118
To: jic23@kernel.org, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
 gregkh@linuxfoundation.org, andy@kernel.org, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, krzk@kernel.org, linux@analog.com, 
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
 Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2256;
 i=DelaySystem@tubot.lat; h=from:subject:message-id;
 bh=zUcBktwXmCE4oXfyfd9Np1m8huOS/SaVtNAIrPt4qJg=;
 b=owGbwMvMwCH2SNl4+SzWXm/G02pJDFl/Xr/+PSPHu2fBstdXOq22WfBt+3NoU++6/09nl4v4d
 S09bnQ3oaOUhUGMg0FWTJFFTIbnff19nThrqzknYOawMoEMYeDiFICJLJFn+J8gJz5hQ/OaRV06
 pvf/von+XL5yxk3R+Ik9FTeCtVfE/zJk+Ge8TWObqUHYEq4Wvnt8BaeVOdrOyL2cv/OvF9c8Ye3
 eXawA
X-Developer-Key: i=DelaySystem@tubot.lat; a=openpgp;
 fpr=161C0CEF7FDF2C5E3B3A9CC8E22333A79A058D4B
X-Endpoint-Received: by B4 Relay for DelaySystem@tubot.lat/default with
 auth_id=1447
X-Original-From: Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>
Reply-To: DelaySystem@tubot.lat
Content-Transfer-Encoding: 7bit

From: Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>

GPIO lookups can return -EPROBE_DEFER.  Convert the rdwr and convert
GPIO lookup failures in ad7816_probe() to dev_err_probe(), which
suppresses the error message on deferral and records the deferral
reason.  The busy-GPIO path is left untouched: its optionality is the
subject of a separate proposed change.

No functional change other than defer handling.

Signed-off-by: Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>
---
Changes in v2:
- Resend under my real name (From/Signed-off-by: Maximo Manriquez Lizarraga).
- Apologies for the improper sign-off on v1; no code change.
- Link to v1: https://patch.msgid.link/20261107-batch1-s3-warn-v1-1-4fc38341ca38@tubot.lat
---
 drivers/staging/iio/adc/ad7816.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 2a15d7598abb..11292216dfb5 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -381,20 +381,14 @@ static int ad7816_probe(struct spi_device *spi_dev)
 
 	chip->id = spi_get_device_id(spi_dev)->driver_data;
 	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
-	if (IS_ERR(chip->rdwr_pin)) {
-		ret = PTR_ERR(chip->rdwr_pin);
-		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
-			ret);
-		return ret;
-	}
+	if (IS_ERR(chip->rdwr_pin))
+		return dev_err_probe(&spi_dev->dev, PTR_ERR(chip->rdwr_pin),
+				     "Failed to request rdwr GPIO\n");
 	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert",
 					   GPIOD_OUT_HIGH);
-	if (IS_ERR(chip->convert_pin)) {
-		ret = PTR_ERR(chip->convert_pin);
-		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
-			ret);
-		return ret;
-	}
+	if (IS_ERR(chip->convert_pin))
+		return dev_err_probe(&spi_dev->dev, PTR_ERR(chip->convert_pin),
+				     "Failed to request convert GPIO\n");
 	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
 		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
 						GPIOD_IN);

---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261107-batch1-s3-warn-289c98c7b118

Best regards,
--  
Maximo Manriquez Lizarraga <DelaySystem@tubot.lat>


