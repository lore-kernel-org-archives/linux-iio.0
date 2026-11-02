Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604483;
	b=P+bD/+cMJ31LO1Njnj5MGo2BFNWxCHSUh9fFXQhcGVaYQs9V06BUYjcY33VOBvA4G2Gn
	 2DZmsXc71TfuEtiH8+CECnTygx70TzPyiN+ruFgrL6r6z+seDDyhEviXuN3mR4Iz8w/6P
	 HYFaH8R4QK0u2Rd2ZkNv9I2o3+hj/NyHggz1RtckqFaaJuORyrl/y3+WvAsmM1rl08V6q
	 Pu9f6fmDAMIz1ZPSNCRg23p1MjFnmNM0TRq+mVUSHKMZAPuRwiIIVY0zw/grgVRoPr2f5
	 iCDLHcrJXuVDjzej4ZJaqFMH3ix5leLryjw0DJzFiv3Kh8i7O07oMauS8e42K2C4h9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2jVbgmKga7DskLxfH8gIwm0upGtwbSPepnoiTB0wtYE=;
	b=IbkOj2ja2taE9rqMdDzuiy7zYDGwxDBEuajaNORulEqTLrYkimSi3EH5RrOC6wZEJ9r0
	 xul/7M2nW9z9B457ROr30n6wLe+LJCJ83vnrFKIiwYz70Y8gRihDmqsYmDYfM4toCI1Vo
	 2MCI6Jiffw/IfGZrZahiuHcKBnimWJd4ZXtMOHbOdtAsnmlbeJ3seObdKWH7aHNeb/Oop
	 XG6yjBUwpGLcmdxsdYOWOtYqUPFfaBKwoQWyYAh1aq5B/OijVszuxDLtX1RPnycMsnzNZ
	 WjjUrGgeyKj33zpT8EprDAwLXcBTnsFHzFKSGACvbuCROO8Ri0BVtkbuBWkEHE9aOpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VbWLWe52;
	arc=none smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5858C606A327
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 07:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5858C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VbWLWe52
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ab3dd9667dso20657731fa.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 23:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604481; x=1794209281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2jVbgmKga7DskLxfH8gIwm0upGtwbSPepnoiTB0wtYE=;
        b=VbWLWe52AThHVc9c+BIwlWvFcnec+XkynCsLxVpRkx6OEckKdr+lLR+3w3jT/+mik9
         zIk6rRn+zFbQhUuyAo4/cWDAQ0yaWNchd2ZwJW1WHiciB9GqoV39o9i8KHeoREnK6uG8
         4AMhfz36m2V//iVbIA0km2CdcYcIdGe/rrp7zs9WpO3UPVMfWWDqSkYPqnaTgTOPyOR2
         7uCdHWdFkrTGGowYwfdAVa9eqiBOujgw+8JKOYqEDGLFSfiDIyG5jrzzqMZDtVHjqxFV
         /lYDyT5XJyzZUbfEFbN7pvy6dZ7QwswLWaTQCvzuIFOmp7iyqMIrA4Lg9eWhK/3NKViL
         SZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604481; x=1794209281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2jVbgmKga7DskLxfH8gIwm0upGtwbSPepnoiTB0wtYE=;
        b=SaLpF4bkELafwWy5zDZn0bWlF7yCs6o3DtGCuj8xJ6feGoGtzZOXn5NwAJGdn0BJH1
         9rY90KGory7GAWWoYIwnevQI+e5txOc5yjAxECsNGDxFkJf+I619/bhnT78FHEbcc7GD
         4MYBOns0yOHidf0jtFO3Ndk7WdSZ3K48EqwsAbt9ufpi7OcMcXK3EBQ99OtbPg7W0LgY
         0vvLy5/ataUke26Ir3zKRyfM+wyzSoAmCidLjlUqq36lxmYMgBvnjUBPc0DUAcugiVVn
         xUmIirgFvr+QFFYv3m7CrUUTXevfQVJmoJaO5ewsYgeBeysIjoGsGpQXxuUIiMXgBNor
         I4Rw==
X-Gm-Message-State: APuU4Z/oxuYwXDpyUZI8GsMhVrSAOEuCP7DRjgOI70no9k9c4vWjwLJ+
	F6lecYHc1wVNai1l+fhM5r2+BXhoZGkRdxQhHKtcXBniquu15dqKUWkV
X-Gm-Gg: AYBFou0ziNltbQddGoheBcsB91YaseR5TqbEwegYv7EuE4nMT5Qv6XBW7pAnfeSzl6e
	uzMxg4sCR+8LTg4fRdNxV6WdMhaEr3pnHRLZiLkIoFBKzPH2PBJ2679GpIHBT8WLUekfi4Evx4w
	v5Zcwv0DBi6x6ZP0ah2Gp0EG2Ixgqd0+YKN5QGwK35rPyf77roDUT1yUtiH1UbtOVDnZpiV0t48
	sx2kX3OOu8Gb2/ZBKxMAQND3r6LJO6FAqzWXFgkGco6xTPwqT55iLD8S5CXaPfk9LVdrImGWFY/
	8fgdYhQ/eGD9vPIQHAjBzhMDtbE1ybu6GyCeGfm3uWUs7TmHWikIkSWIXJ8g3bxa9nwhL8P0whQ
	RMuGIyjRwf16LWlM/TSF0T/oAE4LM9WoqeU4xV/doe5PoVnKLjxhn1GAOMI7lq+tqVj0O6GCmW0
	1Nnqf/T7A5h9F2lvnhOw5kzMW6PWDdbtWaazictUfmXQBFT9aUqFQ4mviSHMwkdvEI0/AwNNg2V
	Gy5pIf1ljMYKbyLZ+Ojvkqp9Mn7Klh4ZeMfcB7/SNnP3QHcNdvmlYePxWKoSiu6BbBF+gAr4oa8
	m0qakvXqi9Z8vcDt+arlxgBz0hjkCkgUuX6sO2waj9oWut6Or8mCQT3xsIZDFeGaKGPC+N5PRLE
	kL0eCWImp9zvck2cpTV6GsAT3xq20u+/Q+VYpz4hQYODF7RYsaOPPieJ0X4c=
X-Received: by 2002:a05:651c:1991:b0:3a8:380c:9fb6 with SMTP id 38308e7fff4ca-3acb7b187d1mr21133061fa.28.1793604481125;
        Sun, 01 Nov 2026 23:28:01 -0800 (PST)
Received: from yantra.. (nekmmqsyzuioqaviu43-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3ce1:244f:bbe9:eff3])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe9856894sm452283e87.5.2026.11.01.23.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:27:59 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH] iio: pressure: dps310: put the chip in standby on remove
Date: Mon,  2 Nov 2026 09:27:55 +0200
Message-ID: <20261102072755.17043-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove resets the chip, though all it needs is to stop background
measurement. Write 0 to MEAS_CTRL instead.

Probe now resets the chip itself, so nothing depends on this reset.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>

Applies on top of the dps310 fixes series [1], which resets the chip at
probe. Discussion: [2].

Tested on a DPS310 on a BeagleBone Black. Written with help from an LLM
coding assistant.

[1] https://lore.kernel.org/linux-iio/20261029220635.18816-1-zoone.rupert@gmail.com/
[2] https://lore.kernel.org/linux-iio/20261101173009.3549f50d@jic23-hlaptop/

 drivers/iio/pressure/dps310.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index c364fbaeb3fe..5cee23986f30 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1391,11 +1391,12 @@ static irqreturn_t dps310_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static void dps310_reset(void *action_data)
+static void dps310_standby(void *action_data)
 {
 	struct dps310_data *data = action_data;
 
-	dps310_reset_wait(data);
+	regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
+			  DPS310_MEAS_CTRL_BITS, 0);
 }
 
 static const struct regmap_config dps310_regmap_config = {
@@ -1449,8 +1450,7 @@ static int dps310_probe(struct i2c_client *client)
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
 
-	/* Register to run the device reset when the device is removed */
-	rc = devm_add_action_or_reset(dev, dps310_reset, data);
+	rc = devm_add_action_or_reset(dev, dps310_standby, data);
 	if (rc)
 		return rc;
 

base-commit: d1425b382b9cc5bd19223fad8ba4a8af3dbe1305
prerequisite-patch-id: 22f0452fa0da955789612d82cac492cb20ca45a5
prerequisite-patch-id: 53d86ea85edbf34082bf9bf9e590c6436994982d
prerequisite-patch-id: f5af50326a55df0acc42474b3fe04e60f25a3e16
-- 
2.43.0

