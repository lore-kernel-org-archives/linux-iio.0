Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170514;
	b=c1G144sYOpmRDVtN/UQLhhG/KyuyLf6kiezdRSTALRMfPwDyqHgvRKwovjBKHhVG6ypS
	 djgnRsnHHxwkxEKpFeDPHYYFcRHW9IPP6wRVygaoCH4baCACX7MoVlxHgVE/dc1PJRdMJ
	 x2SVtJwWSK06FAUP9xCeg9/q3R4cBRPUrvAjPvwwtG1uqPOKS+XVg2XKbkZ9mhFwmsC3i
	 0ONmjtevygKkVNaC+I/3NRlBEefIWWDWbQd3xQgM9HicztmmIHnmVcDDVK3/0R074Tz3B
	 ffb2xvj5WVgnrNz/yljZo6hNwCqG0qjjPfQ8X8d8qddV87VWxBmm0VAUPs7iTZAo7OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=nD4idXOwW52laq8HEXuqvP0Drs2PNQ0ykSPS3rCO4yA=;
	b=JAadNaNwPxp/NSU8hEJ5m1BGmqtytE9mluXxaEOHmM7td5Afj1Vg0UxksZyVxYpLxVH+
	 zp0DaP1GiW8LFAfcKdfY7+ceJfV5t/UNA5nVFzN6y+XNMXNO4ch5BPyXR2kgpx0wV1yVa
	 eJ1JRW+OOvzyEODct8ptZeAbVY0qkRX0cOWuxfiQEjFb/3ptr3U+qAnWns3We63B4IyZj
	 YqwXKYUZ2eEbCDhDcyT0J1cVacHiZAdNx56heVy63C0Ah07fgR3t79PqB2AFkLS+lPm+B
	 CNxU7zEQo/M/MfY5jOCHHe6LsaNTb4Oi1yLAuIUZPGviO7Bvlgy0gxT1p3SlVrswCQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MmIoosC8;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C560A263E
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 10:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 301C560A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MmIoosC8
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-990703f817fso436323241.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 02:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795170513; x=1795775313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nD4idXOwW52laq8HEXuqvP0Drs2PNQ0ykSPS3rCO4yA=;
        b=MmIoosC8skIkw2SZELJcd4XsNqV2f2JhN6hREWvAfOwVOfI2hkswPuQjYCx13i5IuJ
         LZtCe6w3adeAFxyixcQOWiBQSRUdWC0aAYJSK6Df6+c/8OIvHJIGR1o7NYK30dH9xbfC
         GtHhfPlToFpzHI94t6ScVD5djznrIQeJHqALs/F2+voOwoQZzG7V4Z/MeQx6La2Hq03V
         Wp/0kHIZ8G3BqS9zjMc/Ui9pwx52qPVEC+Tw5Xmsl0k4Y0M9yzzRJ5q7pQUJ4oymLS7A
         LOacnvuItSzn8f6hm2ieqRxkEh5unCtc70ap5OGbWAwqhCqtkxngvu7puelZpTGBkA09
         VH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170513; x=1795775313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nD4idXOwW52laq8HEXuqvP0Drs2PNQ0ykSPS3rCO4yA=;
        b=SdW7BYy6eVQyIo4HpsjjJrBKlcOIMOHH4004pHLOU5g/Rz48Zaj394sZW/l460eAjD
         Mx26QL3ki6gAXPSPcguhIYG+/XjcJAxF09r55mjAi62VHPJoeL9OPLqPfz4udfucrpzD
         Yu+1oPjtTjYLBVC5p1auoek+chvc1I0e8xbPeAzWNgKE9qTKq2Kq3oTSXL2XazhKHMjx
         Z2jB0tZ5chOIAAILjioaz1daTGj2qeNXh04WI+EhByWdwQvXVqx1VZS32kqaQQH4oB53
         NPrzJH+EYblGSJSUUGvrAp1xZqmkGpUB5RhQ5aWm5/GUwmY6RL1j7txBQclpqmdLvKmU
         ExwA==
X-Gm-Message-State: APuU4Z9lFNr0Pgt8zfpgtD9lj/AiWOTMAqcq0rIyKU3fWtFqhynzaIGH
	HGLL6bI6uI0WcuSC0In3wzf7tGeh4sjigb2sAodwo0xEeRa7c8lSS6Z2
X-Gm-Gg: AZFdTZeRGalKKL9+lkeTaXiK1J4lxjQQxvyPtSZB3fKkcxNItcRDhP5z5l+GL3iq++8
	4hh2MbuFNtJupM+ttWGDpFtZ999eRIUCCmggPXt/h5UU2PksPU/ByI/wAnKInfFM6Gfr0vFYqG1
	aY8EGEcjTRi6zpG6Y/QCqMvtm9yOFazzMAxcQAwjTVQeCoem3Cm4/lGQ572lB8abIZ7r0iHpVQu
	/2kfKGujx7ED9yzdTz/H026mZkxO9vUgrVQIxuhc1D2MqMAWbAw/m6+JuYdsX8yPDVLI0gP9STz
	7iOYFoUjM0ikzNwVYqPPTtxLFafjAu/WO6j5POpqlJ/SBk2wGr+mjCucwi7SzvOQ7MxiCgHj5rD
	AjUvAisjdxhPREORg5NhjrDpOhIE1Q9PkPUv8GLeoMixeYFWTxX7LBY8Cc/m1AbiqSTxOM+4wYq
	F/puF74UlUWKztj71TOI3GK9tbISZDBt4cI+tsrXgESDiaSnoN/FsiVzYHp2buW9yjkc2Knhx4u
	trjcxmq2nPDMR0coxh9jAGYOb6xqWk1abXYxdRrGM/Dgyyl7AiVPIKknGkphRHScYNs7V7eThM2
	mzlAVFD0zo4ulCA2r5I2Z6lFNvKKUFy4eXmclP0=
X-Received: by 2002:a05:6102:3f13:b0:7cc:7801:b317 with SMTP id ada2fe7eead31-7d73937cc2fmr1132907137.9.1795170513082;
        Fri, 20 Nov 2026 02:28:33 -0800 (PST)
Received: from [192.168.0.9] ([2a09:bac5:565c:aa::11:204])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6e08a02asm2481753241.11.2026.11.20.02.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:28:32 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Date: Fri, 20 Nov 2026 04:28:27 -0600
Subject: [PATCH v2 2/2] iio: pressure: abp060mg: Check for short I2C
 transfers
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
Message-Id: <20261120-b4-abp060mg-fixes-v2-2-89a274d68a9a@gmail.com>
References: <20261120-b4-abp060mg-fixes-v2-0-89a274d68a9a@gmail.com>
In-Reply-To: <20261120-b4-abp060mg-fixes-v2-0-89a274d68a9a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Marcin Malagowski <mrc@bourne.st>
Cc: linux-iio@vger.kernel.org, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795170508; l=1342;
 i=aleszlucero@gmail.com; s=20261104; h=from:subject:message-id;
 bh=I3SgfKE6UVSpQVJFdWA6ZvX87W+gO6g1Z3kgMgcO46Y=;
 b=rKD0S6/Of+jur1fXXYWJ97xvrjROK7DFSqSyicejniJex8wAMR4eRLK5SZ1iFAAjVaWPBqoTi
 6VNEJHY0ZOqD13lqCTVaS4EZncGIs2qr66xiZj+gpDl1RvNf7eUqCcy
X-Developer-Key: i=aleszlucero@gmail.com; a=ed25519;
 pk=zRzEBMID7l1FXqr2CjfnlIn++3m3N05FuNYb5zPA3cw=

i2c_master_send() and i2c_master_recv() return the number of
transferred bytes or a negative error code. If a short transfer occurs
without a negative error, the driver currently proceeds to parse
uninitialized stack data from buf.

Check that the returned byte count matches the requested length and
return -EIO otherwise.

Fixes: 9ecca12edde4 ("iio: pressure: Add driver for Honeywell ABP family")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
 drivers/iio/pressure/abp060mg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/pressure/abp060mg.c b/drivers/iio/pressure/abp060mg.c
index 9a9dc2bfdd40..895deaf24427 100644
--- a/drivers/iio/pressure/abp060mg.c
+++ b/drivers/iio/pressure/abp060mg.c
@@ -108,12 +108,16 @@ static int abp060mg_get_measurement(struct abp_state *state, int *val)
 	ret = i2c_master_send(client, (u8 *)&buf, state->mreq_len);
 	if (ret < 0)
 		return ret;
+	if (ret != state->mreq_len)
+		return -EIO;
 
 	msleep_interruptible(ABP060MG_RESP_TIME_MS);
 
 	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
 	if (ret < 0)
 		return ret;
+	if (ret != sizeof(buf))
+		return -EIO;
 
 	pressure = be16_to_cpu(buf[0]);
 	if (pressure & ABP060MG_ERROR_MASK)

-- 
2.56.1

