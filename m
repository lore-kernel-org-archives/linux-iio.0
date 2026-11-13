Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794608857;
	b=QwXYYe637NedOV6CBmzfw+UBc3KRRZc2oEcy2SyGPQvTa/R3FjgimaZBoTj/bXEGkQQI
	 yyCDy5GmO05PP1pGpWOLzpJjHINbY0Xci/Ag4rJxIBZgydQ/gnpoj5r1W5ucOFGoJaJbx
	 tCJlvNTJc7JUsqOTibK3ZIy+vtwjTkeQUgeGW+QtAFRZNBjjcXfkxgCL8GREuQVwX6kzz
	 O21WSe9e6WQM4sT6QjQwJYOIeS+oQJ5Smtah3AkMlxUIlljIKDjcOYaz6TAyLxFntVwB7
	 8l+G3SO7GUcYgZHF9OjjwbexjkU2q0e0qkTg6EqDK4N3pwerURYiyfrFDx9voSfJ21g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=OeBYMLqvn2SfxO3PVYzGyoQJDU+e7YEFRkI3J+GdfZU=;
	b=TBp6Ls2aA9Kar4x2gcuGpChEU+9ElQwlgZRt2gXuJ2FQ/5rGaghs89sr0HZf/mbyOY7s
	 Ewfqj9WS7swhyY5uDcUJ4/iJY58bFgrbW7KXK56nwHUIv/GZFhVaSZnsTNaRNbiEaH8pC
	 oCgNGEABE5lY/kXNacx0vPv8qg2z4HmmkCGD9FQpO1fis0pvgRPG3xAsCLFef9iDTjtbS
	 zTcyIWwyl5nMYlUL7L1GSggM5+M6SU+HjI7FlJMXcd7fAkA9iVRlUZ2vnjjtFHluvxXrT
	 Tf2AIWcNwUE9RYmNBptqTm16qDYDsDKzfHdtZQh+8Z9SuLEmCd9ohWZoegePs+N3VWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=reflexrobotics.com;
	spf=pass smtp.mailfrom=reflexrobotics.com;
	dkim=pass header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HkqBE0Dg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59032606A88E
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 22:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59032606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HkqBE0Dg
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b577addee9so2935453a12.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 14:27:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794608855; cv=none;
        d=google.com; s=arc-20260327;
        b=YSXLJxkJyuZdF/Ms107+liNlOIWbfuAJb7swhxdbolmUcOftBGV1NBTj1alHBQy374
         o9LcD99eupoXiFqtJFNm0KZnB6gKIO9paSYOA3j4Or+ACsbiWiGU4dk2Z0DHe3CMM6r+
         EMLG61xI3L1MtdiAD+yOD/p42oVc0ZtWzaja/OnVgoeM4DsCwFawVgLOEsmiKslL+twK
         o79dgcO+AqMp6amRV816Tq8g+5kkdTFYlAU9hCVgsmUbDJSWlrznLB7imX+amIvyaEM7
         2sbi32HyGS7tbPTqAZP6w97bJszAhhls+aA1cwYXu9LpORqaLzme4tQpaH0iwnQDHIlc
         GQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OeBYMLqvn2SfxO3PVYzGyoQJDU+e7YEFRkI3J+GdfZU=;
        fh=Yl+5qAR6kt3jg0jAyACLjzFPuqpuVWjmouZnQ8M5qbE=;
        b=HTUvss0FEEnG6FR5Icq5lI8TQkO0mBg29nABU0iarmgrTEOPU9EuOcUWuS9H/MOgVd
         A8JxwXWGLJWpx/QQv4H3DDyb+8UDbZd0XS7oxUxyex15fQGw46DXchMgxhSSrPbYP7hU
         jR3/AMjQVfCxSn6wv+sRKdJfCSpOyNrc+5Fi3eEOBlbdwr7PEFcaJRZHNsB/GnjZu+L6
         mW/lK5fksjVVzqfOVxP+ywTPMvWIEn6qOjDf6j7Q82TWiCUrt/FMv0vmDigN11JtyMT8
         nxoejlX3pHP+Ci3THCIq3C4d+0DYDbKWNayJ2Nn1KC16q3DWaZNwTCdjbTPVYQSVF0nF
         BXpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reflexrobotics-com.20260707.gappssmtp.com; s=20260707; t=1794608855; x=1795213655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OeBYMLqvn2SfxO3PVYzGyoQJDU+e7YEFRkI3J+GdfZU=;
        b=HkqBE0DgfXH0J+M+zP1TuZcvnGNc2kR9gMHHiIVyxAKrBDFVWwWLYZxmQjGTME4PZT
         TKZXlxX579nhewI65oXnlQHF8+zX+7rmLfMzUaa3Kf3yzR4Y7YmTFwC5Ygib2ptt455o
         4IEB5sWmlWj1EbcnPu0XfSJDAxS+I+FlhE/TuXjz/fenQoM7s500tE2JChsaGUs8A4tl
         0vbp9S8QxhDW/OPhK/4woCtW0drldCx2zpk+dGnevPNKIDEK/jmbhVknmy7U23d6IKvW
         K8Qf+kjWEQwQjFvq0Nhpy00z0BMGdI5iZy891p9H/Aw9AYv8EFWtBM4HkBNGG8oAgn6z
         XAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608855; x=1795213655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OeBYMLqvn2SfxO3PVYzGyoQJDU+e7YEFRkI3J+GdfZU=;
        b=zOVQJZNUUSnhQtq5ZYKAlJhjrhk4UBug80KNEF5TRImqzAtvkGV6nbNYbJkYWxT5lQ
         qBnKcGpdxU3Vk4QKY3h1/NalP3vcp9sBh7/LrOQSkp8SQQW5FBxfoW3THT1veeWZxsUH
         GRERzUVUoOee3kago86ce+R5+7adsfpn4Egjq8C9G2jifaaeOQe8YEQnBjZ6Cqo3aJDf
         U683B8slAPv9Sw27BD3bVlEOt8PMrq9H08Ay1KgOTrGPt7JWS3c7ptvLODjj8AWvvKYq
         s95GsJ3rQB6AcqjDDv7ULOTMLmEVIZ5s/QuR8riek6eJbzdfC6KX0R3qYaBo9cURlg97
         qsLA==
X-Gm-Message-State: APuU4Z+gMOyh5lDXQaUBgVnhfKBd2UDlciroQmSQARzzyTt62hqhhDhN
	jVVjO15TREvN0x2B2nSt/o+ZUD2xgOVcxNVzC6tPNgKL323NsV3ggt3joct13udhhs415vK5dTR
	iC46UzpJOCnPvDS49evikiE0BRtiDkXpm73MQvA+AVi+WCuVxLhPimTvOCw==
X-Gm-Gg: AYBFou23bRdbQeIzRYQ0w9a37fxSd0gi42B9vD+niiadRFxYB3xjJ0a/XROR64fm0Xw
	X3um9v4KK42zBqwFomBotFMVnUuPSJ24Pwb2Xs8sk5hI74F1uC7nZpL1ngYYYQgeujHlP7eAbD8
	qDB+2D+2e+WQ9J3qvatanKhZg+xFI+kmSuRFFByCdpm6GNkGklB5aoZWyYCCsme3eaoWsAraMjn
	/aiwKjZJnqHVTSbv7ybPGfLgvccsThBv0Wo1XiZ00twcdSCny/DAQH2iASSfYOFSDG7DBQpK269
	rh81hgfrT41ssni4/SOv2+jzWl2lgnhW+e5o00lONBKUvxScS9XcOXkz5t4fDqIuP2CTRnJLJ3h
	bqIhU77/MmQq1xh/7+0COCrNKAWTAsvPHkY3GhnG+jEkpncBe953lriSJrylDkvY5uEyS
X-Received: by 2002:a05:6402:5483:b0:6b7:b872:27b4 with SMTP id
 4fb4d7f45d1cf-6b7c0c1bd4fmr3498045a12.21.1794608854760; Fri, 13 Nov 2026
 14:27:34 -0800 (PST)
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
 <CAJLMkXYB9NjwN1ZxfkGPE=y2NESRc=ir7B80cVpVk=d-tyPoVw@mail.gmail.com>
In-Reply-To: <CAJLMkXYB9NjwN1ZxfkGPE=y2NESRc=ir7B80cVpVk=d-tyPoVw@mail.gmail.com>
From: Joe LeVeque <joe.l@reflexrobotics.com>
Date: Fri, 13 Nov 2026 14:27:22 -0800
X-Gm-Features: AclHuK8mQzcWtdwa4xwJzhZ43h7xvYnakeor9UKSVD0VA0ZoNSi3c8isfWVGu0s
Message-ID: <CAJLMkXYNpRWWqNbUn72J8p7Fqi1jCy4FC2fdAtjkzJ4eW_9r2Q@mail.gmail.com>
Subject: Re: iio: imu: inv_icm42600: large gyro offset with temperature sensor
 disabled (ICM-42688-P)
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Baptiste,

I've implemented the change as you suggested (temperature sensor always
on, temp_en, set_temp_conf() and the TEMP_DIS handling removed, FIFO
temperature reporting unchanged) and tested it on my ICM-42688-P (SPI,
i.MX8M Plus, 6.6 kernel with the driver backported).

The gyro reads correctly from the first read after boot (about 3, -6, 0
LSB at rest at +-2000 dps), including after runtime suspend, and the
accel is unchanged.

Regarding my question about temperature reads with both gyro and accel
off, testing shows the data is not marked invalid. The temperature
register retains the last measurement:

  gyro and accel off (runtime suspended), 10 reads 1 s apart:
    3598 3598 3598 3598 3598 3598 3598 3598 3598 3598  (about 52.2 C)

  gyro running (sysfs gyro read before each temp read), 10 reads:
    4934 4956 4950 4958 4956 4958 4956 4958 4962 4958  (about 62.4 C)

  gyro started fresh each time (reads 3 s apart, autosuspend 2 s):
    4952 4960 4964 4960 4956

So with both sensors off, a temperature read returns a stale value, here
about 10 C out of date, instead of INV_ICM42600_DATA_INVALID. The invalid
value only seems to appear before the very first measurement after
power-up. The fresh-start results show the first sample after a sensor
starts is current, so it appears the separate temperature startup delay is =
not
needed.

With the patch as it stands, inv_icm42600_temp_read() would therefore
silently return stale data when both sensors are off. I see two options:

1. Return -EBUSY based on the driver state: if both st->conf.gyro.mode
   and st->conf.accel.mode are INV_ICM42600_SENSOR_MODE_OFF, return
   -EBUSY without reading the register. Small, and maintains the documented
   behavior.

2. Have the temperature read turn on the accel (for example in low
   power mode), wait for its startup time, read the temperature, and let
   runtime PM turn it off again. A current value is then always
   returned, at the cost of a delay on that read.

Which one would you prefer? I'm happy to implement either in the patch.

Thanks,
Joe


On Tue, Nov 10, 2026 at 2:28=E2=80=AFPM Joe LeVeque <joe.l@reflexrobotics.c=
om> wrote:
>
> Hi Jean-Baptiste,
>
> Thank you for the quick reply and the explanation!
>
> > I think the best solution would be to completely delete the temperature
> > enable/disable feature. [...]
> > Deleting all core temperature enable/disable and make temperature senso=
r
> > always working. And we keep enabling/disabling of temperature reporting=
 in
> > the FIFO.
> >
> > Is that something you could work on?
>
> Yes, I'm happy to work on it. My plan is to remove `temp_en` from the sen=
sor
> configuration and the suspend state, drop the `temp` argument and the `TE=
MP_DIS`
> handling from `inv_icm42600_set_pwr_mgmt0()`, remove
> `inv_icm42600_set_temp_conf()` and its callers in the temperature read an=
d
> buffer paths, and leave the FIFO temperature reporting as it is.
>
> Two questions before I begin:
>
> 1. Temperature read with both gyro and accel off: since the chip turns th=
e
>    temperature sensor off by itself in that case, I would keep the curren=
t
>    behavior (invalid data reported as -EBUSY). Or would you prefer a
>    temperature read to turn on one of the sensors itself?
>
> 2. Should this go in as a fix, with a "Fixes:" tag for stable backports, =
or
>    as a regular change? It is larger than a typical stable fix. I'm plann=
ing
>    to base it on the IIO "togreg" branch unless you or Jonathan prefer
>    otherwise.
>
> I'll test it on my ICM-42688-P board (on a 6.6 kernel with the driver
> backported) and mention that in the patch.
>
> Thanks again,
> Joe
>
> On Tue, Nov 10, 2026 at 6:57=E2=80=AFAM Jean-Baptiste Maneyrol
> <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> >
> > Hello Joe,
> >
> > it seems to be a good catch. With temperature sensor disabled, gyro val=
ues
> > are likely to not be temperature compensated internally.
> >
> > I think the best solution would be to completely delete the temperature
> > enable/disable feature. There is really no interest in disabling the
> > temperature sensor since it is really bad for the gyro values. And it
> > would simplify the driver that is already quite complex.
> >
> > Deleting all core temperature enable/disable and make temperature senso=
r
> > always working. And we keep enabling/disabling of temperature reporting=
 in
> > the FIFO.
> >
> > Is that something you could work on?
> >
> > Thanks for your reporting,
> > JB
> >
> > >Hello Jean-Baptiste,
> > >
> > >I'm bringing up an ICM-42688-P (WHOAMI/ID 0x0007c1f2, on SPI) on a
> > >custom i.MX8M-Plus carrier board, and I'm seeing a gyro behavior I'd
> > >like to check with you before sending a patch.
> > >
> > >Setup: kernel 6.6 (NXP/CompuLab BSP) with the inv_icm42600 driver plus
> > >the upstream "add support of ICM-42688-P" commit backported. I've
> > >compared the relevant code paths with current mainline and they are
> > >unchanged there, so I believe mainline behaves the same way.
> > >
> > >Observation: right after boot, reading the gyro through sysfs
> > >(in_anglvel_*_raw, default +-2000 dps range) gives a large, very
> > >stable offset at rest:
> > >
> > >- Temperature sensor off (after boot):   x =3D -139, y =3D 379, z =3D =
-229
> > >LSB  (about 8 to 23 dps)
> > >- After one read of in_temp_raw:         x =3D    9, y =3D  -7, z =3D =
  -3
> > >LSB  (under 0.5 dps)
> > >
> > >The large offset does not decay with time or with spaced-out reads. A
> > >single in_temp_raw read removes it, and it stays away as long as the
> > >temperature sensor remains enabled. Buffered capture with the
> > >temperature channel enabled also gives the small values. The pattern
> > >is reproducible across boots and power cycles.
> > >
> > >Looking at the driver, the default configuration has .temp_en =3D fals=
e,
> > >inv_icm42600_set_pwr_mgmt0() sets PWR_MGMT0.TEMP_DIS whenever temp is
> > >false, and inv_icm42600_gyro_read_sensor() enables the gyro through
> > >inv_icm42600_set_gyro_conf(), which passes the current
> > >st->conf.temp_en through unchanged. So after boot (or runtime
> > >suspend), the gyro runs with the temperature sensor disabled, which
> > >matches what I see.
> > >
> > >As a fix, I'm currently keeping the temperature sensor on whenever the
> > >gyro or accel is on, in inv_icm42600_set_pwr_mgmt0(), just before the
> > >"if nothing changed" check:
> > >
> > >if (gyro !=3D INV_ICM42600_SENSOR_MODE_OFF ||
> > >   accel !=3D INV_ICM42600_SENSOR_MODE_OFF)
> > >temp =3D true;
> > >
> > >With this, the gyro reads correctly from the first read after boot.
> > >
> > >My questions:
> > >
> > >1. Is this expected behavior for the ICM-42688-P (gyro offset
> > >compensation depending on the temperature sensor), and does it also
> > >apply to the other chips supported by this driver?
> > >2. Would you accept a fix along these lines, or would you prefer it
> > >handled differently, for example only for some chips, or in the gyro
> > >read path instead of inv_icm42600_set_pwr_mgmt0()?
> > >
> > >If this approach is acceptable, I'm happy to send a proper patch
> > >against the IIO tree. I can only test on 6.6 with the backported
> > >driver, and I would state that in the patch.
> > >
> > >Thank you for your time.
> > >
> > >Best regards,
> > >Joe LeVeque
> > >
