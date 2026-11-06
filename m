Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794000787;
	b=eL4cziPet+0Ru3bkXMwa81ddd+a2j6OCsieJETV300+NaADlmh4IjRpqUx1t71lolTNI
	 JGhe/eELoTpmsmVeRwLq/HsB/KMQk9CA5ahSG1S2jzwExt6f3AQ96bpWI/KaEDwv6P5jt
	 jd4OznNaNIWnLTSKGcDeUHeBAA13jAGepevphTSWMzTWG7bkTUH8OM0wEnql3SXWuqCNn
	 z741nl6kpV4uxBJ00N8pS9xSiMfKkDgolDm7HtPLSU2VrtM167l1Ca00cl9koFimX/oVr
	 xrvPwAm06gGu4mnrt0pNfc5wASI9A1yS68MTX29F0yoWFLaA4hCDxK4NxPM+/+jC5Gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=FWOR1+o3wKRaPfZFZjkv050+iuG5OddHtH2Z0hH0pkQ=;
	b=eN0YCkIYc2B0rS4Z9k0qC2vOM0PQLwmcPk5iRdyOEe9M2pPwdorrtsuks2cS8o+RqtaO
	 i45i+j4KTTHDmZwJU4ipHoT9+IeKiyh4GZIidq7wDEAxrHEkyOLAwdlTbQ7lBgx30oAc/
	 iFR65h/gGGBlFB4ezQMxKxfy1P0VccJhXS6OX5QYXdd8H+2uCNonOqdC0Ea0Fv+AjzpS6
	 dR0aMY5kMjz5I0BKeM/SIJsbpDnh2OCxHsAr53tbsaigw6vrjhwjzqElXY9gP6GIaJ0Pr
	 prMeFc0Ia9G3YM1HB40kW6kP3DHsfqQ83xRuVXDtcLnAEGNNvPuly40s06tD6gY5Snw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=reflexrobotics.com;
	spf=pass smtp.mailfrom=reflexrobotics.com;
	dkim=pass header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=J9faN2dc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33596606A326
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 21:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33596606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=J9faN2dc
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso1538041a12.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 13:33:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794000785; cv=none;
        d=google.com; s=arc-20260327;
        b=lXN8X9pA4QDnSDTuNd0geZ5ZogX0P5fspKDIdhv8dZ70Mu5j8CzPV/QDAT+iTco3xk
         YDyXlAOS2+AvCkUTbBNGXUSd1+bV+d7AIjEQz6Zv5tIA2616bF4rPHMtUsfOp19fOBf0
         iPDOUV4IEbkHShjV9hlB7d7SupeQIVM70pKiK85B6qL0xbF1KvQsa90uhCThHT+8hr/s
         bM/i3x413Dt0SUeqS6VaO4lWnOPlOXe7ancOzy3M1AdjPaBNSMI9Mden8HqJl4Tz3RBD
         RaSakIYG4KD+5vy9c8q7nrsvoN8P5NFd4MGH+HLpHEQqrzTivcca58XEJjAf+qGdAFGX
         e3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FWOR1+o3wKRaPfZFZjkv050+iuG5OddHtH2Z0hH0pkQ=;
        fh=RsEqu7UqtmRcw6sMF1xafPeynvLYHQX2ODda0aOwfzg=;
        b=hsuZv5kILYS4du4Es35mhFsZVItrt86oK4nPqyMKoC4EbdZeID9Lb+GTYBG2C6MSGB
         qRezi8RT+8kSMsmnEjvHJ7ltn75ROCXD7O2cT0dPrPo/1H7wkfnaszUstuuCupi2vZLC
         kf4lVRJzFk0kkglETHZ8wvx+wq2Azt06D8ZGDrJqLlptXL0pDz+GqykTqUneSEYo57JV
         mx2bGiEC34YHx2kvMc2SpiDflekf6Th4EwMbTNH7zlWvvX91bgkGAmGlfawxPUlkbFaQ
         8U5ZkHi/1Ura1rP6SnTwmg3QoszradxJl8SObX/DBouVvlMOhg0Kz5pqxvuf+pySmc16
         2GYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reflexrobotics-com.20260707.gappssmtp.com; s=20260707; t=1794000785; x=1794605585; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FWOR1+o3wKRaPfZFZjkv050+iuG5OddHtH2Z0hH0pkQ=;
        b=J9faN2dcweUrfo7pr+5Tpr5qwZqGSQm2SLCpAD7rI3T+SbJ77MuA1lPsPsK2KCAyhA
         u9BB53D38iKHHkwvHxgTqfcrBmnFchWECXx2yI1k0cjHj96f6N/hT+mpsQOsqVyya//N
         034x7MOF5wEEjkJFo6euLvknQJIT5nx7pcUyn5xi6xNCfZtAhg6rYQSKE0Y8HOLTtRW7
         uLysvS/SlmRcIGgbbbWGr3Y+G/pm7a9YG2bmVjXwicLkFqmev9X9e4jqHap9ZLspzsGD
         hH33DZqtnSpWg2pHYwOh4E7zbrePxLwoc/+sLmPzfYKc8kCNaeEMRsxtp3pFNuOqzNn2
         Y2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000785; x=1794605585;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FWOR1+o3wKRaPfZFZjkv050+iuG5OddHtH2Z0hH0pkQ=;
        b=e0A6mGYGRT4seY4FfTnev/iWEF+WaTiFCssRGzNDyfeXmuizAAnuJ3OjjeQUUdHmMp
         pUoTXSeVUf6OL/oVQ6zvBaLk3hcsLMdlsnRofF2aR2tVRTqDg45/KgxT/tiH08uFiYSY
         kee43pn2h+SVckF8FRe1t68Rr5AWSV/1VSbEuyp0fx8JEPrlZdvVgyT3i58ZDMBmxc0o
         7e32GAG16P6x5XIKJ0gOenzs+RgeFo6qPeUDNhklohA5a/IMzQphUq9ihtdBjqEzqemz
         QP/35i2noeWusGszA5o2VtL0BTfnt8scNAM9OI9dVN/boSEOQlXSSzXhwURKuBhFmBJU
         K9ZA==
X-Gm-Message-State: APuU4Z9iuK2V3Q8BwYBi410BFvGRHF695WJe+D7nsl2aJYQoNjD7I3sy
	qWU5M5UtTqdVCaj6a2vY0VkyilZ4GS/38KfUSdphb+j/JKFmuJL2igrVmGp8cGe8NqY/ok/Zuke
	bU7SOkmrpRbnXwuZMxi2ydc2qNTsbm4fxANJO7Ap9fMnX5KzzU+B6UeNAKg==
X-Gm-Gg: AYBFou082OdXl60msV3pMlWOQW6AC6gyF/WSzfJrm1Xfs4vzsxLPd9MOCwe4I35TuPS
	UEd+VFBXQh9pNUAR0vtSeL9WvmM3wNMQkjk3AEogWky58WLV/S7tiiulavCQ4p9X6RQOFzEY1YT
	4ZTfhB2Or8hpdBt5vmfFSEaaixzyT+DLo0WAovzV4KI6hNR7rTTI0lH7w/gGGQe4sXtphlWvtUP
	oRiCT2zMSSC66YKSACZXilTbYwfeBtZgfvaLqTTLbY0m0QM1sPj52Dqybx2AT6DKWd6ZG4oGEAr
	K0eJoNNdBuns0FxDmn8p8kJUE/h2EJuzZ4hRWNQnRcp+v2racNxG286xX91/rYZoZv9S0Lwx59x
	3tQY7m93fvUpDZCICjYWkBqyigv46BHRWhJx6H9qD7TXHvQQ3Qq84gv6SpckoZlFaO8M/mg==
X-Received: by 2002:a05:6402:5d5:b0:6b5:8cac:c4a with SMTP id
 4fb4d7f45d1cf-6b5977de5e8mr2667571a12.10.1794000785683; Fri, 06 Nov 2026
 13:33:05 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Joe LeVeque <joe.l@reflexrobotics.com>
Date: Fri, 6 Nov 2026 13:32:54 -0800
X-Gm-Features: AclHuK8gdPEfyJnMFjijWf-7HBxydPs1FCEGmwioQepcXIa0nCg3Emc-Xlq8NJ8
Message-ID: <CAJLMkXY6wS7ErVT5YUyp=c0TJDPmGePJiDua4MPw47V83JQ0Fw@mail.gmail.com>
Subject: iio: imu: inv_icm42600: large gyro offset with temperature sensor
 disabled (ICM-42688-P)
To: jean-baptiste.maneyrol@tdk.com
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Jean-Baptiste,

I'm bringing up an ICM-42688-P (WHOAMI/ID 0x0007c1f2, on SPI) on a
custom i.MX8M-Plus carrier board, and I'm seeing a gyro behavior I'd
like to check with you before sending a patch.

Setup: kernel 6.6 (NXP/CompuLab BSP) with the inv_icm42600 driver plus
the upstream "add support of ICM-42688-P" commit backported. I've
compared the relevant code paths with current mainline and they are
unchanged there, so I believe mainline behaves the same way.

Observation: right after boot, reading the gyro through sysfs
(in_anglvel_*_raw, default +-2000 dps range) gives a large, very
stable offset at rest:

- Temperature sensor off (after boot):   x = -139, y = 379, z = -229
LSB  (about 8 to 23 dps)
- After one read of in_temp_raw:         x =    9, y =  -7, z =   -3
LSB  (under 0.5 dps)

The large offset does not decay with time or with spaced-out reads. A
single in_temp_raw read removes it, and it stays away as long as the
temperature sensor remains enabled. Buffered capture with the
temperature channel enabled also gives the small values. The pattern
is reproducible across boots and power cycles.

Looking at the driver, the default configuration has .temp_en = false,
inv_icm42600_set_pwr_mgmt0() sets PWR_MGMT0.TEMP_DIS whenever temp is
false, and inv_icm42600_gyro_read_sensor() enables the gyro through
inv_icm42600_set_gyro_conf(), which passes the current
st->conf.temp_en through unchanged. So after boot (or runtime
suspend), the gyro runs with the temperature sensor disabled, which
matches what I see.

As a fix, I'm currently keeping the temperature sensor on whenever the
gyro or accel is on, in inv_icm42600_set_pwr_mgmt0(), just before the
"if nothing changed" check:

if (gyro != INV_ICM42600_SENSOR_MODE_OFF ||
   accel != INV_ICM42600_SENSOR_MODE_OFF)
temp = true;

With this, the gyro reads correctly from the first read after boot.

My questions:

1. Is this expected behavior for the ICM-42688-P (gyro offset
compensation depending on the temperature sensor), and does it also
apply to the other chips supported by this driver?
2. Would you accept a fix along these lines, or would you prefer it
handled differently, for example only for some chips, or in the gyro
read path instead of inv_icm42600_set_pwr_mgmt0()?

If this approach is acceptable, I'm happy to send a proper patch
against the IIO tree. I can only test on 6.6 with the backported
driver, and I would state that in the patch.

Thank you for your time.

Best regards,
Joe LeVeque
