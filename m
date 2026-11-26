Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695229;
	b=j3pQlMlZKk/YEY5CiHiepPXavA6BgDYXrSfnQIAWnMRF0e5W5TmvPjv5De31zB2SkpJA
	 wdc/3wq41kvDbgj3XQgWPuMKXsuUrZOetpogOhga1r9A2ltkW1Xfmv7kmqNuCfhA/xi5A
	 kYO18mewD7VqJ4ALuDngzRVfmvA6SthlKKN5dsvX3wWmSP54jHVd473uLBZ2jay0pjcrY
	 dXP4Onh58ZZMFke2M978jq/xOjhlrGlRRhbEFllG7RhMKpBI0/sIjC04NZIcDFwrgRexw
	 LbfNBbWR9kn0+0zU2F8IjcHVh8qXy567XofF9XwYhn7JdFj94B76Q17TuNKkU4JtLAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ywyJ1rCUV3crT1Diyh0F+HIgqAG1RWgKj5oF/WBEKNk=;
	b=OLxkyMz9+o1TdWupZxLBOERL3IGWxq1P8upgppXhyuQX2y3JfoRtknbK6NZezb/FcQP2
	 RCYcRjJyt0YyfoNrR0y6xSs6UcDWE+c4x803hYo+ueqzrznSc8aCJaYEMdnEwC21T+XZf
	 u3W1DL6KzswhsO0KISixwmEHnurTR4r4qYX3JMAVJZYPy0OLBQuGCCh5j7C/zZUNWfTKi
	 teG9kvc87UtmbfeRoomvlo2dNv9XQSb8uu1c5CFvX83aBaMZsJUPPpH3zK+y3O4oA8Zyp
	 LvCf9mTMwrrNr4dej95bOrZGB210VTgYKb6DLpo7YtzSbCe5IMD6oePxzlTC5q92LYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WwQ7j7vn;
	arc=none smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A40C606A6A9
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 12:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A40C606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WwQ7j7vn
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ab4354db11so68445021fa.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 04:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795695227; x=1796300027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ywyJ1rCUV3crT1Diyh0F+HIgqAG1RWgKj5oF/WBEKNk=;
        b=WwQ7j7vnqPOMcAptrGAHYxqiKbA98io5A58SKFgxmCpJjzL5LXYR6Zkcjiozch61dN
         MnIp1P7FX+reQCUB3wWfP1BpIS4BtSlsCa2+Oje80u2PSbPvz1qvki98VzLK9wiTsANG
         iq60rpC8flZT5UjzoqPGSrrHtXtBzNbSZS0UTE5+KiThs312vq2AnMQxB/zJNvzMxATQ
         as9MzdQWA5JmusTLLN6drCBn0AuX01ZpC7WJFjMIDwci45owY53lbr6t521f6rr8u95l
         sUMK3yLmFs6xcfAjz36Re6eQWCdbnAPUUSzboy/xD89w3uqKHhYjDwIZm8j2051FG7gX
         w1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795695227; x=1796300027;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ywyJ1rCUV3crT1Diyh0F+HIgqAG1RWgKj5oF/WBEKNk=;
        b=wF3t03PpfR/KbecKjVL5hvyTnx3GoJos6ranhF19bm0nCTJzfXodq38eFP4dk4H4iq
         25zEpuMa3ss8EQR7PmkXUu81c0OdEY+zeT9vwero+QFezuNmexfUwOqTrGQZ+iZJ1SU5
         KTdBfox27L98QZoq8TnqfejdcbwZQZ/x4aiXWKE4JBolwv4znT4k4+beQGgzmz+/9ohi
         J2Z6BA97218m6Qihd6RTuAO+XhoVNVmEXHekjYPGBJ2CS2wVQpe75sNmkMl5YqIbtLuQ
         +szlSTyl6HvK7oXo/wy9aPD3Xiuhh/HDYVyZZ9sUhOCbKhzNDuR7p1P5AAP1mJv3/W93
         wVOw==
X-Gm-Message-State: APuU4Z8ddKIdM29I7QOTny3uJ3D0mkX/SP6q+wS630QetnGZ0UZtBdqF
	NvjDh1i+1fsp6ocwicDIvvGXXsX625CQIJ6YCdwYsJQNIHE/Is8Yn2fn
X-Gm-Gg: AZFdTZf5qSSfkgbva+AfmwooA3MlfNuQ4FEPDrghDLt1vZc+cuOL8ME8WsccyfDD1k+
	LcWG8RnWvyWgHKR6JfRZoXG3tjArrqHW7JdAFFNIKGu6L8NLqclBX84H++lhNEGs6Oi68mqfj1p
	N1Sdy1T2cif25E3PX9xOyUogZKRE5r8ALMdA2D3PJaRpH0eLs7EkLTZwJPak7jWTDVGRQFZhxMJ
	n5/P76PBT8HIWYGUx+kf8rwceg1cC+0HphcQ9Vb0hGKvj8TYfdRWi9Z1I3Ah6VYr1lMywmN3ibb
	0ryd9i1pQrnDF0ph00XBJl5x935wSrt4PZ5P9TukzdK17ExMvfpcOES2XI8CwmPAJpP4m7PivpJ
	4eoG1Ojc5vy5kDAP0GU/rg0gXFS447NLTC233XbsKohIt3IYETz2y6c5YeOZjvLp717G3Wzb2sb
	kImR4iEkHb3sNQi54WobjgAoJN/A0GwK6vOOEBju1fg94FFUFFvcIS1QuHRV19qQFj0IlLcPK7m
	w/DIJOuQ9RvjgEGgBTt1k76vPQj8/la30/jSHZXMzRiPK44MmRpKzSLvEJRjSjlob0I3k0i4/1I
	fApXj4VWSPiI9OuqDzLXu3rKTDSEcp13nmjdSO400k6w/8Ll0gZ9pwF4lsu1rOmlolGCot5VowF
	k4blI9DcfzDOL7y5xK3Fv2atwIohSdr9pq4jXsHeC2H4gWqfVYoXRzSDHtw==
X-Received: by 2002:a2e:be87:0:b0:3ac:fd58:5e7b with SMTP id 38308e7fff4ca-3ae7fa6a080mr58150261fa.22.1795695227258;
        Thu, 26 Nov 2026 04:13:47 -0800 (PST)
Received: from yantra.. (nekmmqtmzjx8yvukhae-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:68b4:f70:61d8:6e86])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8044e8e0sm56541791fa.5.2026.11.26.04.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:13:46 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	u.kleine-koenig@baylibre.com,
	crofts@kernel.org
Subject: [PATCH v2 7/7] iio: pressure: dps310: include what the driver uses
Date: Thu, 26 Nov 2026 14:13:30 +0200
Message-ID: <20261126121331.10438-8-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126121331.10438-1-zoone.rupert@gmail.com>
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Include the headers for what the driver uses directly and drop
linux/iio/sysfs.h, which it does not use.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
v2:
- drop bits.h and errno.h, bitops.h and err.h bring them (Andy)
- drop mod_devicetable.h, i2c.h brings the ID table types (Uwe, Joshua)

Cc: u.kleine-koenig@baylibre.com
Cc: crofts@kernel.org

 drivers/iio/pressure/dps310.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 72f62a1aa3ea..74d4111b5e29 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -18,28 +18,37 @@
  *   c0 * 0.5 + c1 * T_raw / kT °C
  */
 
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/cleanup.h>
+#include <linux/container_of.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device/devres.h>
 #include <linux/devm-helpers.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/jiffies.h>
 #include <linux/limits.h>
+#include <linux/log2.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/types.h>
 #include <linux/unaligned.h>
 #include <linux/units.h>
 #include <linux/workqueue.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
-- 
2.43.0

