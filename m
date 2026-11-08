Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794114805;
	b=0sForK+eZrgU/kcTRkkSAmMxwaUWm+eCMVrOtTwf7TC97lfYO0WCvnuR6qWdK2iop3ZJ
	 DW7JYJ2JoMczs6Cx0J81u2pR7lGDqOjhewIWOZvbziTzKtJUWcuMNCHij3A8de7t3lDDs
	 KavKM41MVt9JMTob1zPtObjDd+hCmm4O8twuy+KJgtaSQ7pnhDDl9TPe4ppO5OX9HpmKR
	 EI7tXuRVM/ZHSu2ciNUA79SrrDM7wLGf6R7jY1naiCP2lwdUvOVQJXNW9spfbSrEaTEJ0
	 oful7BOYW/IlkbjEwSxhLynO4DyM2J6NQ50C/y7JC1xNCltz1wa8qaMPW4sbtDJx/Yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794114805;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tBv1HO+8MaH5NzZpx2131rviAviguXtqgAPNO0YP1pE=;
	b=tZAqBa9WoMgEQfBxJ0bJJ5QCkPSuJewmNFJg6ko8GglQfEka4N8LlPG5p1H4dNwU0Zpu
	 0zLeK0DNHzK12W1EIe+dYbZahELTz2+vSQMOetk9PE1J8xazBcNfEAuabOZlw9XgoMJM0
	 S0PjRmeffb1v0Edp7jDLs8s87XQFQ067cr95KYkKzG67g3gLGyZnDY5mKrxytcEgOyJKi
	 YHf7X0qw4eV2W75KRkwbhsosb4tv7n43rUHIdT0+QahLOBdCVaqgZJQeuyHQtz27MSwUI
	 7VmKYIN7fO1mJLWV/c1LrF7lm0L/qYCSncBBwV6vnVYoQ3scICKJgbiMTz7NU4oXGEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gr9kI0te;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6132606A31A;
	Sun,  8 Nov 2026 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gr9kI0te
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794114804;
	b=IGugQXJwL22NUY+fjL9K46ALBDNmZeORRyzoptYmKNUILWcL1mC6iqf/AS6w+VynlO6V
	 W48o1cXuYX3Ir96++ee570prCw2t17ZNhNgW6Nh6md1cREC5jB382eOfv/c/716J9qh72
	 Ji0b/Tq8zRI+ZpYcx4+j+5pBLW9hkKh+T4PjOzZpXj62EAAOVKAb/intRX43PI+OEuWJs
	 5yt+Ri8dtAvQ11YMa/JloQxCpvsTkTkTnQXwFaZ1+539lkPdgv6+dJyxS012n8ueUwi3e
	 SGqzN9nnuAqFcuLzZtMgrue30fcQs6nQreZEUVR6EoG+yAAUM2zkR3+NKW4gn7ZCf9g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794114804;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tBv1HO+8MaH5NzZpx2131rviAviguXtqgAPNO0YP1pE=;
	b=jXnGnW1HqQR34dlMLM2jk1tZssyxnQ2bALpanUHP6GMNi5Q6QJu82yI8pLXGVlJ/aMH8
	 3zNgJXhRK2gZ/0OGSqCj5UyV7Tx5mFm2M1HMG9T8cwGdU/IYiTr5zFdYpTE8j1kK1V8Ue
	 nByvgzSTOME/RfMNCxKPnvGXDECrvtcZjO/uysycwu2BMUOSwOZHfhSt/PKtk+bBhdI1h
	 cWR93bBNfZDZn1RP3alXAZZr7Uaxixhogbk5KYR1Cwyp6hld8dLaKG7CSu9390+2oCJOk
	 lKxzOEcmdh+tXA63+pmUHfwR06Efw0j1dg9tLliBeU7eMpiKCCZqdb6th3jrqXTM7WA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A09071F0089F;
	Sun,  8 Nov 2026 05:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794114804;
	bh=tBv1HO+8MaH5NzZpx2131rviAviguXtqgAPNO0YP1pE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=gr9kI0teHy8JYaj0vd2F1tso2yADVFhzDgRIDSGMgm4F4aIWf1rA8TSi0vDyUL9IJ
	 o5L+1SE6/0zBM4RpMh2NBaokEWT/1+M2+J1IrXIsHGtmQT4YYrMNbwof4O93mIicPf
	 RBpBTGuBZZX1WmiI0qEl+E6DyEVpFZDtJ4blEugGiHyk8zbT0zAJnuJuRSI1TvcpwY
	 f08u118C6BVWNNC+d5MYYSTMUXZM+ZrMjphK83BZdNRs5uiIIqmxbM2B2ENtao4fuD
	 VdkNzyonVCYk/ebmSz14rP1SwiKsFQp4aLjk7yom1M8K75H+FostngWXYj4+kbti+w
	 blLQSZyPXzZQg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F20C047E05;
	Sun,  8 Nov 2026 05:13:22 +0000 (UTC)
From: DelaySystem via B4 Relay <devnull+DelaySystem.tubot.lat@kernel.org>
Date: Sat, 07 Nov 2026 21:13:23 -0800
Subject: [PATCH] staging: iio: adc: ad7816: use dev_err_probe() for GPIO
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
Message-Id: <20261107-batch1-s3-warn-v1-1-4fc38341ca38@tubot.lat>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMAyA4VchPdOEjgSGr2I4bKVKPUyzApoQ3
 p2px+/w/zuYZBWDS7VDlk1Nn6mA6gp4DukuqFMxuMZ1RE2PMSw8E1qL75ATOj/w4LmPRB5K9Mp
 y089veB3/tjU+hJfvBY7jBFQOt1hyAAAA
X-Change-ID: 20261107-batch1-s3-warn-289c98c7b118
To: nuno.sa@analog.com, jic23@kernel.org, dlechner@baylibre.com, 
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com, andy@kernel.org
Cc: linux-staging@lists.linux.dev, linux@analog.com, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 DelaySystem <DelaySystem@tubot.lat>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1972;
 i=DelaySystem@tubot.lat; h=from:subject:message-id;
 bh=/dZESaHHxJHhLeUXDlNHKxcjmakcm6DTe+ZTrXLn33w=;
 b=owGbwMvMwCH2SNl4+SzWXm/G02pJDFkfWD4t2bDKqnq67s85Mr/1JV9fvep+fmbqL/Yte2qKN
 LMX+l1P6yhlYRDjYJAVU2QRk+F5X39fJ87aas4JmDmsTCBDGLg4BWAiF4QY/tcG5uh+2zCf3eWD
 zpuSCbnZUR//x5pyS+eEWUWsmdjBfJ/hn+3hwoNS2uoTJBisTGqu876eXBO9la0gSPGTzk32ANa
 /fAA=
X-Developer-Key: i=DelaySystem@tubot.lat; a=openpgp;
 fpr=161C0CEF7FDF2C5E3B3A9CC8E22333A79A058D4B
X-Endpoint-Received: by B4 Relay for DelaySystem@tubot.lat/default with
 auth_id=1447
X-Original-From: DelaySystem <DelaySystem@tubot.lat>
Reply-To: DelaySystem@tubot.lat
Content-Transfer-Encoding: 7bit

From: DelaySystem <DelaySystem@tubot.lat>

GPIO lookups can return -EPROBE_DEFER.  Convert the rdwr and convert
GPIO lookup failures in ad7816_probe() to dev_err_probe(), which
suppresses the error message on deferral and records the deferral
reason.  The busy-GPIO path is left untouched: its optionality is the
subject of a separate proposed change.

No functional change other than defer handling.

Signed-off-by: DelaySystem <DelaySystem@tubot.lat>
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
DelaySystem <DelaySystem@tubot.lat>


