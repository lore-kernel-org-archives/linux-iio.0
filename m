Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158703;
	b=4VR6KqHe9AuJnpW4isyPTub2Sd5+CFgT0LADuV/bjtwybXXEwOG2Rh+tdg0+D7w+GaLE
	 po2507G+8+OU5gU6Bc7D/q5JwLhbBD2QfWHqyP7t3caiVcaSyZlqSuXOtbguvombA6b6C
	 2bD9fILQGE4FW9xzHaugC/Fz6YmtxM6eE2t/84lYy24889N5E/0w2XIj2iueafMgmBYaV
	 XTWeKtYRq7k46qJAayQAFX4kj9v61AsJoXGjqhsLNUpJr65VYjpgKDWo6H+FU96Zt9SAM
	 KTjgofVob6joLws2z0gwZs3dkq+P2KRIN/9kcJj906stuy6Oi93mRO/p4zLxac9kyMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=pxfIT+9E4ZCilKRfonukjPaBBBGUKqoI7TJBGfZt990=;
	b=F774f7FtqGEJW2j+cMXSmxTJmJoSZ8oTP8WTP/R/YFpjWFcTsyJR3kFmpKyzWcPeyaxq
	 ytxoHQAL9OP7xFjyPSbjwhCQx9bDBOzrcEHEAH1ZbgyQiXCQ6rgfvr00yaC/OCHdLcmp3
	 K6M4NYkHmHa2h+4EkvzZWoaATOTQcjxT8Azwr2woTEWPNye7hyVQGo4l80p4oLeiSDl+g
	 PSg4Gt50WhziKC7No11/ykoa3csmVjn8YY6V34QmzkvCKKXyy2ksjlCS306Y3ooA4SyEO
	 vTE/M7ply2mD8CGWpEbd1/lGYxx9o39Xdwu6s2DNreHio4UzZi4Mk58FBBj4+RESgAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="MM3ov/mF";
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F3606A320
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 07:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B5F3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MM3ov/mF
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5ee3a3d281fso355774e0c.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 23:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795158702; x=1795763502; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pxfIT+9E4ZCilKRfonukjPaBBBGUKqoI7TJBGfZt990=;
        b=MM3ov/mFcQg6BT3UDLOTS2BVcSn6G53WkOpmpiJKQzHo8AgUkPDuLDvWYITS5E2xXs
         Ja/D3CfB0NoIqnUFu8WqQTxxTeI2eLeba+JBHrPzGN91/UWpb8hUe9mKq61S32kukw1r
         QWyr7mXmxTomafa2ebuTwOI2HgyyvG0W0cQITius9Tnk9ViQurUcCOQT+n0nmpd9FyuX
         JPTD6LWM6lsn+zHL50bRq5iZ9zx/RNzGB5PJ+UCiKSdxUZLmszrXFx/AKC9oiF6NETdu
         74yt2lm5cTd0x5yzz6yJlhhdmnttW4Uz51dM04ieSAArk3nhBHcn0mwoEWVLx7UxDQAt
         aYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795158702; x=1795763502;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pxfIT+9E4ZCilKRfonukjPaBBBGUKqoI7TJBGfZt990=;
        b=BtIWBGjFnM3HMFem/cgJc9P5VqFLi5l3delIXmSHI+aJ4+xS6Zqp9puBPV1eQWP7V1
         qNYuxM0cJpqQ7TKHu1xenQQFnjRXswK3w73VnH6r0laVee/5ACCr97b/Kg525VrFBZG6
         qCXPp7bJJIlwZSMG9YKyMQPyN9NXtWeQCK5/ldYajvGwGPKJOFLEz6TrQGQCTvfocq/n
         HQIet4P+YL8WRW38ku3j9xaKg6yK+YNwb/1x2/ZVW33jL325vN6HENd3CFaU+NrjeUwc
         CEdukYrgiEWod7daEHZ5TL+U5ck9jzge+F7D3agMXanS3lLWEOanneWB88C96Z8Z4yvx
         vOug==
X-Gm-Message-State: APuU4Z9EAORprcOlaqhO/1NthL36jnskYV7oQZ37fXv90SH3477Ck47U
	duJWQ8J5ZGKuh/QhG7MJ2EUv+giUmidSzA48q6VKELq6+CowU4R/Zs3K
X-Gm-Gg: AZFdTZeX3YCJIxUnqhzDPqcSRshf1u1ODF6KDDbmGesof4ECOj9QcxtnU0GAXAEcUOR
	Kq9JAMKxb+YHWrYKmnK1QikozUYQbOZ6JjpqTgnGhz8X8wa/DmGiLXrPGxGAucQLCqwz0MyxyMe
	JQqmY6U7Y5r/tJt/StbyZ3DXUo531nwUP+QsEiyxrgnATqjpHpR+CeZEaTvnXvjOLpLpIcSUQWt
	VskuMhQ+2OZByzz/x8tXDnts7VaJTYqbCwBBQHAMhDQobSrvtRpbVQDV+R7dSoBmP1Pj1nlN2IG
	ZitFGRd444tVI71WGzD+92NH7xCQD2NikLGxoOH57r/lrhHt73Wj+tlErmqJu4CcBPM5FIzlJKK
	3RAfZiQYhZbUufeog6EHKHGhc4O4gupiCHkGzURZEEt02dLf+39Coo8Wa5HTwejIU/LaliAqaB8
	tdyq1s5kb3Fskt+KYSAFmORRHpTHPdW5Nv+zQqkSs4C7m2BBymd/LX0bjyiBMzkpFMrwcIZXp8+
	6qsEhK4DlYOgXRf4bE3z+p55oLExgeZzFQFodMouSc289YV4d3RirrPgacqnb0ADnYY3S4tj1l2
	iATUiR9qkt+fhDDtGQ==
X-Received: by 2002:a05:6122:1994:b0:5ee:13ad:6c8e with SMTP id 71dfb90a1353d-5ee8af3d2c9mr1090746e0c.17.1795158702453;
        Thu, 19 Nov 2026 23:11:42 -0800 (PST)
Received: from [192.168.0.9] ([2a09:bac5:565c:aa::11:204])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b653081sm1773611e0c.16.2026.11.19.23.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:11:42 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Subject: [PATCH 0/3] iio: pressure: abp060mg: Fix scale typo and I2C read
 handling
Date: Fri, 20 Nov 2026 01:11:36 -0600
Message-Id: <20261120-b4-abp060mg-fixes-v1-0-2baf026cde47@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LMQqAMAxA0atIZgNp1IJeRRxajZrBKi2IULy7x
 fHx+RmSRJUEQ5Uhyq1Jz1Bg6grm3YVNUJdiYGJrDBP6Fp2/yNKx4aqPJFxdN7OhpmdnoXxXlD+
 UbZze9wMZVhKrYwAAAA==
X-Change-ID: 20261120-b4-abp060mg-fixes-fa5c210392a6
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Marcin Malagowski <mrc@bourne.st>
Cc: linux-iio@vger.kernel.org, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795158700; l=1073;
 i=aleszlucero@gmail.com; s=20261104; h=from:subject:message-id;
 bh=Q9zqyQQ3gU9S9tgeuV3q7vBs4Ba38wV7776MeMqDxrk=;
 b=wOp5L/+8Dkb0njNwPosMKItpLH1CvLytg+cXzpbrX95XQHtOfpwjxpytiCk0HdF1op8ZKBeV9
 qV7Qj4y4GTBDQeoXCM/uWBS4afx3DGdFQhIlNWVTF/74aqkDvK9Uu8T
X-Developer-Key: i=aleszlucero@gmail.com; a=ed25519;
 pk=zRzEBMID7l1FXqr2CjfnlIn++3m3N05FuNYb5zPA3cw=

This series addresses three minor issues in the Honeywell ABP pressure
sensor driver (abp060mg):

- Fix a typo in the maximum pressure value for the abp001pg variant
  (6985 Pa -> 6895 Pa).
- Validate the byte counts returned by i2c_master_send() and
  i2c_master_recv() to avoid parsing uninitialized stack data on short
  transfers.
- Replace msleep_interruptible() with msleep() so signals do not cut
  the 40 ms sensor conversion delay short.

Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
Oscar Alejandro Sánchez Lucero (3):
      iio: pressure: abp060mg: Fix max pressure value for abp001pg
      iio: pressure: abp060mg: Check for short I2C transfers
      iio: pressure: abp060mg: Use msleep() instead of msleep_interruptible()

 drivers/iio/pressure/abp060mg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20261120-b4-abp060mg-fixes-fa5c210392a6

Best regards,
-- 
Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>

