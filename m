Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794349715;
	b=X8s0/UX0+RsncHiQiwMEnJ3QRbNqN+P5vAZhGItT47u7YeD8ahBBidrmTNekwq2m8RaA
	 +K2QTPNVm6yIh89Q8dG2cBSmLPF8Thx+F9KpNVTzAW5GKjAA23DWRJ7/fQ4+wDeNIrAoE
	 R5o/TLGfPJSU4BB1BvFggpFL6Ds8thmDX2PbOUvR+Cebu21ErEInyjvT49eYSa3zMp8TE
	 t9ghJNsLxiI4uTrpDN6w+bnK68tJQS8bL1T10NczUOuR8sEJ48DjH4AcVMSkGFuZNgkjd
	 VheHKboXpn2v7rkiGS7sb6D4IA0xCDSRwd65wYkdJMaa55DhxPLE9i5q85xs4oJRQ9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=qnBOV75X4TNy/mfgPmXjluqetecpw69ABrCfTANvTOw=;
	b=MTA8P892E8knNg6hy3Zu6ZXToD9TtEl2kAbNggkku+r/XYKt6DcSzMAPxaHBz3j2YP3/
	 J+T6lW+BPUk7D5BVkaMml35DjwA+NtcM4Kc33lQhTcH+DJqVf3fUsJYgX21W1VKlwmJxF
	 gJoqcxIFAzGKbDaUe5ihETg0GXZrEQv9zkDNuVKXu3BOjdZHg9B62Sw/aCZvdhJieUBvN
	 owAPKWhndN7fFNNTKh1StWs0nxl4oCQAS3BF0BHGiqVIhz23Zhkgee/9s8sXSD0iOVn2k
	 60VGQJTq2tWeUJ8FAg6vAMHlYQT9QCGGP4YdGTNqI9tM33rQdp01a91TNpTZREdwJoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=reflexrobotics.com;
	spf=pass smtp.mailfrom=reflexrobotics.com;
	dkim=pass header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=k2MnJHN2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8782D606A31C
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 22:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8782D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=k2MnJHN2
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so384699566b.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 14:28:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794349713; cv=none;
        d=google.com; s=arc-20260327;
        b=pXr2kW2m9D7W9Whlg4Qx5mEHe91U+QIv0NE4Tch9knSFCwxIdSjna9llPrZLrG/fj4
         eDMKNhVrt26vU6iIzVjNB32uXZKw4ywEiHfZTFm+XGMgwGx8kfYr3NJ65sKKFxxzxtV4
         2AApnoWLMvNNtH8iB20a2+YWQwR94v6uegHf/91JE75rfpiFiiYmcXQHNuKlEKPmkNdW
         dTW1YXqHpRLnpl0qxOr3ay7aNN0AkW/gBezVU+kK5ncYBh9sV6a/EjSdj1nr0cH/jPZA
         OIFrnXCSiLY6t/H05tk8HDVlRXlzVOQTNiuA4GZybloQt3lkX1H+saQqq8r/yvhmpSSz
         DUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qnBOV75X4TNy/mfgPmXjluqetecpw69ABrCfTANvTOw=;
        fh=Yl+5qAR6kt3jg0jAyACLjzFPuqpuVWjmouZnQ8M5qbE=;
        b=O5aNQ4/M5fKj/i5McuqpYNaGpK6HL5JIG1ULxjLDD5TjP2FiJuUy8/icf8c8tQi/oL
         E+dfreJJvFMB+CRXM3OnwIXx+sQaVmNUmCGiSA51owG46m7YaQBHbv3e+JbhNTHP5NLA
         nK4KdxoJy2tglu0Wh5qLM+dPBJLVwMHT/rJyjvzbLVx55olfvvVIe6Hvd2egu3g8DtmY
         katSXGU2NeUf3KY+Cg+4csJ94Sjx5H1opL/AjgYOgGBgt5Ak919Eg0Ymi2eyiNbTaKbN
         FU6kY2E5QK36u2wCfaDl/9OtUt2pDOjCn+mFRTz9t8bNVAFslAHAMTV4y84hxgz3qesB
         rkWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reflexrobotics-com.20260707.gappssmtp.com; s=20260707; t=1794349713; x=1794954513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qnBOV75X4TNy/mfgPmXjluqetecpw69ABrCfTANvTOw=;
        b=k2MnJHN2Fay6e+M21QXF0eBSW+2tjpXdXJCuxLkWVCsqOmRze39z6qrWVX2nRUYZJ2
         nMfxorsFpmBzNn2pJqxbUplcLEvAMUbfCLkuay0XA4pv5XmZFay6XvkdUXKeR3Mn2AIT
         uGh6wrl9zJeVviu2VH2e6LI/i8c4U7bfQ09bxKYisqBblU/kb3iwhM72Vmixf0zEKlJc
         LEUJbNteUwFO7VTCk0FawCYTj7W2TnGp7NXZhgPXboIMiUV6uIqe8XSuzQIKFNejwyTx
         BrQNZpbOJPpyLGEIm2F+QhkyzCrjodbL47GTPg6hLSaywOP1TSClQMBQAAVgjdUTkgG4
         MHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349713; x=1794954513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qnBOV75X4TNy/mfgPmXjluqetecpw69ABrCfTANvTOw=;
        b=nC+81FIjazfiO2JJ1X5fj2tM4ezC3vTEQdQTlzEf0boTTqTRRLLCOH24ZZvEE7tHOi
         O+f9f4yXAhEw0cmVKXJ0C3D95uTqM2j44LcEqqs03RMX9S7jwrbJtRkBfAa4SB851G99
         VjG6mDfKhDCwo4Zh9rcC5Y/uGnnW88wbg/GW2T/5QDzPI1ioR68rv40l73o/d8NdEQmg
         65mh8JWLyhCwxIjLqzIb/eeeVPJCmtoTrhEOsEMiku5QMlrC5YCL1kN+FJDWioXajwbT
         brVv+wsj4N3EpRvomoM+R+bSqOvD9ugX6Sm2JYq8ifFiGPA41TUB7l2Webh72Nv5OWC9
         Cdcw==
X-Gm-Message-State: APuU4Z9NqvPtmK+CkhVyUFrDEbLkZliXAqJ2BQLw+SD0Gp4IcqFDXIxQ
	4UppvqOP1TC36XkOfqB1/w/VSd1ihSWDSqAEAy4RXFefRnm4L2/WY4PhTAaJUig4SsOtH22AEHq
	MHCaH4pzi8RkDWAX8hBcr8XPTEZOMgKGPZ1q/mi0hLtZyWBjI0nBRlcWD9w==
X-Gm-Gg: AYBFou0EHS4Q7vB+EqIHJQrDouKAHkNdLdke6Ef2UhGWy+tpkovNbFDJKHlLrbCzkVO
	FdW001rQ737riDoIKY/P8Jx9OJL7Nyle5i6/QNe/acTwX4PI1lo6hPFzIlV0Q1wd8bJnQlVMrgv
	BKn7FCBbtDd6ZtC0QRXsJ5J4uilxotbCmjll7R4kQdqJB4C20o+7aKovB4344GLxnYJQvsT2CYN
	7kXtKzY3ejh3lF8WbdGKE0D2xu4bp+nxujOpDdTReVifcmphXWZIiYkaHOuTwJQdVfbd3wTMNna
	tdk8EI8zuIC9kc0HWYlv4dSFnnzS4mni9nQxqQRqV9SWYJPlrVVWwZf2wcNN+/lvyWw0n4jlxS/
	k2Bqtsx6jz4DJrDEl9y/pBEOzDknCHR8agYILyhhlWU1nTffOUZ/mdv3d1CEfyItCyl14PD49KF
	qyeiB08qh+uSOVgYM=
X-Received: by 2002:a17:907:3ea7:b0:c3f:c878:7c1d with SMTP id
 a640c23a62f3a-c5066afe6c2mr40411566b.9.1794349713003; Tue, 10 Nov 2026
 14:28:33 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJLMkXY6wS7ErVT5YUyp=c0TJDPmGePJiDua4MPw47V83JQ0Fw@mail.gmail.com>
 <FR2P281MB310391F1880DC67B2FC446DBCE722@FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR2P281MB310391F1880DC67B2FC446DBCE722@FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM>
From: Joe LeVeque <joe.l@reflexrobotics.com>
Date: Tue, 10 Nov 2026 14:28:21 -0800
X-Gm-Features: AclHuK9oAHT99Kzq54JmqMRLnxFgORC8ZsH4ri8Y_4J_i8w-XtGlSaL-x14-_Vo
Message-ID: <CAJLMkXYB9NjwN1ZxfkGPE=y2NESRc=ir7B80cVpVk=d-tyPoVw@mail.gmail.com>
Subject: Re: iio: imu: inv_icm42600: large gyro offset with temperature sensor
 disabled (ICM-42688-P)
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Baptiste,

Thank you for the quick reply and the explanation!

> I think the best solution would be to completely delete the temperature
> enable/disable feature. [...]
> Deleting all core temperature enable/disable and make temperature sensor
> always working. And we keep enabling/disabling of temperature reporting i=
n
> the FIFO.
>
> Is that something you could work on?

Yes, I'm happy to work on it. My plan is to remove `temp_en` from the senso=
r
configuration and the suspend state, drop the `temp` argument and the `TEMP=
_DIS`
handling from `inv_icm42600_set_pwr_mgmt0()`, remove
`inv_icm42600_set_temp_conf()` and its callers in the temperature read and
buffer paths, and leave the FIFO temperature reporting as it is.

Two questions before I begin:

1. Temperature read with both gyro and accel off: since the chip turns the
   temperature sensor off by itself in that case, I would keep the current
   behavior (invalid data reported as -EBUSY). Or would you prefer a
   temperature read to turn on one of the sensors itself?

2. Should this go in as a fix, with a "Fixes:" tag for stable backports, or
   as a regular change? It is larger than a typical stable fix. I'm plannin=
g
   to base it on the IIO "togreg" branch unless you or Jonathan prefer
   otherwise.

I'll test it on my ICM-42688-P board (on a 6.6 kernel with the driver
backported) and mention that in the patch.

Thanks again,
Joe

On Tue, Nov 10, 2026 at 6:57=E2=80=AFAM Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> wrote:
>
> Hello Joe,
>
> it seems to be a good catch. With temperature sensor disabled, gyro value=
s
> are likely to not be temperature compensated internally.
>
> I think the best solution would be to completely delete the temperature
> enable/disable feature. There is really no interest in disabling the
> temperature sensor since it is really bad for the gyro values. And it
> would simplify the driver that is already quite complex.
>
> Deleting all core temperature enable/disable and make temperature sensor
> always working. And we keep enabling/disabling of temperature reporting i=
n
> the FIFO.
>
> Is that something you could work on?
>
> Thanks for your reporting,
> JB
>
> >Hello Jean-Baptiste,
> >
> >I'm bringing up an ICM-42688-P (WHOAMI/ID 0x0007c1f2, on SPI) on a
> >custom i.MX8M-Plus carrier board, and I'm seeing a gyro behavior I'd
> >like to check with you before sending a patch.
> >
> >Setup: kernel 6.6 (NXP/CompuLab BSP) with the inv_icm42600 driver plus
> >the upstream "add support of ICM-42688-P" commit backported. I've
> >compared the relevant code paths with current mainline and they are
> >unchanged there, so I believe mainline behaves the same way.
> >
> >Observation: right after boot, reading the gyro through sysfs
> >(in_anglvel_*_raw, default +-2000 dps range) gives a large, very
> >stable offset at rest:
> >
> >- Temperature sensor off (after boot):   x =3D -139, y =3D 379, z =3D -2=
29
> >LSB  (about 8 to 23 dps)
> >- After one read of in_temp_raw:         x =3D    9, y =3D  -7, z =3D   =
-3
> >LSB  (under 0.5 dps)
> >
> >The large offset does not decay with time or with spaced-out reads. A
> >single in_temp_raw read removes it, and it stays away as long as the
> >temperature sensor remains enabled. Buffered capture with the
> >temperature channel enabled also gives the small values. The pattern
> >is reproducible across boots and power cycles.
> >
> >Looking at the driver, the default configuration has .temp_en =3D false,
> >inv_icm42600_set_pwr_mgmt0() sets PWR_MGMT0.TEMP_DIS whenever temp is
> >false, and inv_icm42600_gyro_read_sensor() enables the gyro through
> >inv_icm42600_set_gyro_conf(), which passes the current
> >st->conf.temp_en through unchanged. So after boot (or runtime
> >suspend), the gyro runs with the temperature sensor disabled, which
> >matches what I see.
> >
> >As a fix, I'm currently keeping the temperature sensor on whenever the
> >gyro or accel is on, in inv_icm42600_set_pwr_mgmt0(), just before the
> >"if nothing changed" check:
> >
> >if (gyro !=3D INV_ICM42600_SENSOR_MODE_OFF ||
> >   accel !=3D INV_ICM42600_SENSOR_MODE_OFF)
> >temp =3D true;
> >
> >With this, the gyro reads correctly from the first read after boot.
> >
> >My questions:
> >
> >1. Is this expected behavior for the ICM-42688-P (gyro offset
> >compensation depending on the temperature sensor), and does it also
> >apply to the other chips supported by this driver?
> >2. Would you accept a fix along these lines, or would you prefer it
> >handled differently, for example only for some chips, or in the gyro
> >read path instead of inv_icm42600_set_pwr_mgmt0()?
> >
> >If this approach is acceptable, I'm happy to send a proper patch
> >against the IIO tree. I can only test on 6.6 with the backported
> >driver, and I would state that in the patch.
> >
> >Thank you for your time.
> >
> >Best regards,
> >Joe LeVeque
> >
