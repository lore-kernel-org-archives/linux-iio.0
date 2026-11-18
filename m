Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795030411;
	b=QWJFHBoMzQ4ZELTFpRwK359gJmNRX9PQrHwYpUL5LR7/TS8uHqnrGMDw5EYJCs8e8LOf
	 V30vXLPY4/YJMRZzcQ3r4TcEKaihV0Wi9KKGyxpizv55XWdZZdld+Sahot+b+fHQ2X3+a
	 0wSroOtNls1msPoLJupKORc47DkVTgzn1XpL2lasc5sBZHf7v2ZIYBllWoszES+6SyXdY
	 mBW0WF/9g/zQ+k7V6e858AEwimsDjzx9UbTu4wOUshP9hmocmYDb1fVKfzd+DuScEpyV2
	 +E6PEdDVH0yOyER3kwQ8dvm4b+Qv8YsZaAGWfWzdpA/v8vKbj4e6cbEzJW/2fxCT/jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=od+C8+XR4gMnpYHuLctmnuFhe7pfsvmysk1bKXa3t2s=;
	b=CVQV73XfFy6jajsxq4iHvdPTW0FHuYODyquSeeo+/WkAT+dOqDVBqlRZWf7N0PpbYoI2
	 OnwJ41LzhD+IKUh7PUb8n7DlD5yzrz3CtN6GKKK0ZGrEXYFKe0f2oCdlB0vmGPeEmnkMJ
	 RSILxr9ec4wDlq3U33iDNcPBN7zs/rLBcJ6ZnNS3Sd0VOCU+qIIHe0Ho9aukVD9E/JMFv
	 XYEgj82mA/0R3FDQuBY/nxA1QGd8zTkmLBagp7LfRV8qW7dVC7dpTL9qW6bojusGDK31b
	 ekBayJ97ihch8xb5ayhijh8fXYY9w1Nc0AVxOt4WNMtkxmBBVj3fQ9Z4z8xFWhVVWPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=reflexrobotics.com;
	spf=pass smtp.mailfrom=reflexrobotics.com;
	dkim=pass header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XAweGZoz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB57606B125
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 19:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFB57606B125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XAweGZoz
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b88bc47e23so1854231a12.2
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 11:33:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795030409; cv=none;
        d=google.com; s=arc-20260327;
        b=ZbXq2OKkC9SISTjcepBiwKOe39tlu8C4USO3Zg2i4u1/0vRb0YDlePddgmWgFu0KAR
         sBHYdadXKHXZBTd2UhcGxzmoF7S5RHw2wI6wMrg60qFgDW/EdZEewDX+O/SEA0dJ71/3
         QJiH9S+4jQoSbZDCulhCDLzMeKD32TNYj9fIe37MFgb1gcz8sF7kfqk0ri+ICNHKiAu2
         dZ5grY12IKn7n32rneAM6GAUrqa6pprlFzjBScBqz1gcu03xVRL5k6LC2iHhGFTARTG1
         VnhhMTukUhOUjKwjg4/HQXLO2qaKqsayoehgLNfiQahcaxfdWfAiT8smhYGC+ZcImH+y
         BMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=od+C8+XR4gMnpYHuLctmnuFhe7pfsvmysk1bKXa3t2s=;
        fh=Yl+5qAR6kt3jg0jAyACLjzFPuqpuVWjmouZnQ8M5qbE=;
        b=p3FaG4XxE6HQjJQzatIRlvxV9S5NMch3VizS2zNUCjC8+mNNX/x8BItIoMXUKl4EVN
         hawOrtHqp1RXqs6kqa5T+Ap2O2xIgNbZwBOOxVFY7VkfltQKcVDa24RGo0dFPtPlN3OD
         mpkLBbRTJRxvMaGtRhlYX3AiMd3YKTg8ltSc3ks317SH75l9XjAg/Fc71Rs2AgZHR2eK
         v2b91lLdOEzRUtHBOhOHy3azsNKMpT8zGXNdphOKUFGdg3L2oJlMt/W7KShzd8WcB2E0
         jGZ2kCSvlEHNwNWgpyLMcKYFutR7i8BnHiIQjS/BoGWxBbu3zD15sLz9iuasKG9wN6/5
         YLkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reflexrobotics-com.20260707.gappssmtp.com; s=20260707; t=1795030409; x=1795635209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=od+C8+XR4gMnpYHuLctmnuFhe7pfsvmysk1bKXa3t2s=;
        b=XAweGZozIciW7toYkS6syzn5isJGWgk3wzFsqTKyBn/geWirsxg9Gzst/a6Dub3IJt
         cNztUUxi/GnFE6/d7+b1lhDgTKpXSCyeu1j87TEiijmB90+ieKWbtV2/eZ+X9JtJT4uS
         HPeWujR6XsuAy9sgnk0YuX7qNjxkPrh1ujtCIr++u3HaPf7Lc2/EQznOU+cDKyP9M4Gp
         TSWuEmYH9fGN96D2nL4Le+RuhSJB2BlvLcP/gPxbCRU5mlxml4jizVYTHSsCmxGrL9AA
         tmeLvlWtA0CzZiEWDpdekcXt2lSKjIEdqKYHv+Gm4JahuGqI4ITFcTY6mTVR9kkqJyUs
         CeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795030409; x=1795635209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=od+C8+XR4gMnpYHuLctmnuFhe7pfsvmysk1bKXa3t2s=;
        b=n/PpWMOLJXQ/+Fl0Q8oh5D5ON9Q2/4ZZt0UYnLu78D+zoC6C8/8YeOy9Aaa1IhFQ3g
         uTAgsnDvkrHkjeKDLQj8eV3AGtnH/94TNT9vQrAQLnYsVmWeV4kHbfqNhvfPZGMrfi5K
         cTimq57vNbfrXCH69y6f0EuHzI0EFFsYCH9iPX/MFzPLJ1zR42seIjuRlD4n9yBbnPnd
         RoC6AIZbReJfiO5LU+0YCuAcH4iuM+BP25zYONVHzPoi00gu9HHnQldiTHpAd5IEhJAf
         JU7vYqrnwZOiFtSldrcdZBEBNG65TY4ZwgWSxySj7vUtPA17ESOAV012Nqed8/ZYOjz5
         ECfQ==
X-Gm-Message-State: APuU4Z80Q0zmkeUJT0zp1a9O3U5htMbbDsDhWaBKLN9rK3LgqRM2TPv4
	2lrlT2aycLmf6gP8sQI4pLASaaXdRpXbePujvrIfFLy9EduHgYXcNlb1JZ6EEHzyCruYirrRP7q
	wFiZeBFgOs3XQKSjxMYtD2p8AMhcUFgk4tmoHi7fwGhPqsUxYLETl2HS8dQ==
X-Gm-Gg: AYBFou3v1hW/2ZzxvxEwXWTt5xJ6pP/6h/qN+YIGtZnBN5rFAHH7DiFc6fvHfTFeUox
	r35NTxT199syChSQPuojmkmop4JtJdDE73wYd1j1klzJWO4JQNbLM67zl7MSpZteXO6cW/qz2nW
	fFEbH7YQDUTw+UqkzVBSDZcGwp6WO6GZYSNu+l9PdDCWJv66gbwOqto0dNSkFIyDoK0BTYFMNtD
	BRB1SkSGdKc0/B6bcWtn0+Nc18JUl+Ap2Vdq63MktHGUS2SjmcaOxqaWZtgwfyKK2Eig/DCNp3V
	yGj/q765n/xzLpctFUr5Ulcd2UMuBONDcRCMWCDaFUUrRRFcEWobsWFDUQUF9nk6E9EWWmAlbPc
	wFXKpc1i75mHXpofLTVCP8+45L+csesaBBObotGOZDrkg7HTFlQeAHjea5zqiNrCMOZAZZDQ/t2
	2L4BbF1yk3c47JrB9jz2InNa/lR4u+bcspR6MZ+1uknDbwmHJpsik=
X-Received: by 2002:a05:6402:a518:10b0:6b5:4f5c:cb2 with SMTP id
 4fb4d7f45d1cf-6b887f10f3fmr2283031a12.34.1795030408883; Wed, 18 Nov 2026
 11:33:28 -0800 (PST)
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
 <CAJLMkXYNpRWWqNbUn72J8p7Fqi1jCy4FC2fdAtjkzJ4eW_9r2Q@mail.gmail.com> <FR2P281MB31032ED88B4637350921FB4CCE7A2@FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR2P281MB31032ED88B4637350921FB4CCE7A2@FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM>
From: Joe LeVeque <joe.l@reflexrobotics.com>
Date: Wed, 18 Nov 2026 11:33:17 -0800
X-Gm-Features: AclHuK9ydGS-eE33xGLrrxCWncSAeMq-lmRqdHx4uhmmiMWPi9Srb2S1TLyd7AA
Message-ID: <CAJLMkXYYXjFwAZN9TwyD3vez1XCpCxuEtmye1vi=jdLSLt36xg@mail.gmail.com>
Subject: Re: iio: imu: inv_icm42600: large gyro offset with temperature sensor
 disabled (ICM-42688-P)
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you both! Since the two of you lean different ways: Jean-Baptiste's p=
oint
fits the case Jonathan mentioned, where the temperature is dominated by the
sensor itself rather than the environment. Here it=E2=80=99s the die temper=
ature, used
for gyro/accel compensation. So I=E2=80=99d propose option 1 (return -EBUSY=
 when both
gyro and accel are off), unless Jonathan prefers otherwise. I=E2=80=99ll pr=
epare it that
way and send it once you=E2=80=99ve both confirmed.

Thanks again,
Joe

On Wed, Nov 18, 2026 at 10:00=E2=80=AFAM Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> wrote:
>
> >Hi Jean-Baptiste,
> >
> >I've implemented the change as you suggested (temperature sensor always
> >on, temp_en, set_temp_conf() and the TEMP_DIS handling removed, FIFO
> >temperature reporting unchanged) and tested it on my ICM-42688-P (SPI,
> >i.MX8M Plus, 6.6 kernel with the driver backported).
> >
> >The gyro reads correctly from the first read after boot (about 3, -6, 0
> >LSB at rest at +-2000 dps), including after runtime suspend, and the
> >accel is unchanged.
> >
> >Regarding my question about temperature reads with both gyro and accel
> >off, testing shows the data is not marked invalid. The temperature
> >register retains the last measurement:
> >
> >  gyro and accel off (runtime suspended), 10 reads 1 s apart:
> >    3598 3598 3598 3598 3598 3598 3598 3598 3598 3598  (about 52.2 C)
> >
> >  gyro running (sysfs gyro read before each temp read), 10 reads:
> >    4934 4956 4950 4958 4956 4958 4956 4958 4962 4958  (about 62.4 C)
> >
> >  gyro started fresh each time (reads 3 s apart, autosuspend 2 s):
> >    4952 4960 4964 4960 4956
> >
> >So with both sensors off, a temperature read returns a stale value, here
> >about 10 C out of date, instead of INV_ICM42600_DATA_INVALID. The invali=
d
> >value only seems to appear before the very first measurement after
> >power-up. The fresh-start results show the first sample after a sensor
> >starts is current, so it appears the separate temperature startup delay =
is not
> >needed.
> >
> >With the patch as it stands, inv_icm42600_temp_read() would therefore
> >silently return stale data when both sensors are off. I see two options:
> >
> >1. Return -EBUSY based on the driver state: if both st->conf.gyro.mode
> >   and st->conf.accel.mode are INV_ICM42600_SENSOR_MODE_OFF, return
> >   -EBUSY without reading the register. Small, and maintains the documen=
ted
> >   behavior.
> >
> >2. Have the temperature read turn on the accel (for example in low
> >   power mode), wait for its startup time, read the temperature, and let
> >   runtime PM turn it off again. A current value is then always
> >   returned, at the cost of a delay on that read.
> >
> >Which one would you prefer? I'm happy to implement either in the patch.
> >
> >Thanks,
> >Joe
> >
>
> Hello Joe,
>
> I prefer #1, since it is consistent with actual behavior and it makes sen=
se.
> Returning temperature when all sensors are off doesn't have any sense, si=
nce
> the only usage is temperature compensation of accel/gyro data.
>
> This is the reason why the implementation was done like this. And #2 is q=
uite
> complex for something that is completely useless.
>
> Thanks,
> JB
>
> ________________________________________
> From: Joe LeVeque <joe.l@reflexrobotics.com>
> Sent: Friday, November 13, 2026 23:27
> To: Jean-Baptiste Maneyrol
> Cc: linux-iio@vger.kernel.org
> Subject: Re: iio: imu: inv_icm42600: large gyro offset with temperature s=
ensor disabled (ICM-42688-P)
>
> Hi Jean-Baptiste, I've implemented the change as you suggested (temperatu=
re sensor always on, temp_en, set_temp_conf() and the TEMP_DIS handling rem=
oved, FIFO temperature reporting unchanged) and tested it on my ICM-42688-P=
 (SPI, i.=E2=80=8AMX8M Plus,
> ZjQcmQRYFpfptBannerStart
> This Message Is From an External Sender
> This message came from outside your organization.
>
> ZjQcmQRYFpfptBannerEnd
>
> Hi Jean-Baptiste,
>
> I've implemented the change as you suggested (temperature sensor always
> on, temp_en, set_temp_conf() and the TEMP_DIS handling removed, FIFO
> temperature reporting unchanged) and tested it on my ICM-42688-P (SPI,
> i.MX8M Plus, 6.6 kernel with the driver backported).
>
> The gyro reads correctly from the first read after boot (about 3, -6, 0
> LSB at rest at +-2000 dps), including after runtime suspend, and the
> accel is unchanged.
>
> Regarding my question about temperature reads with both gyro and accel
> off, testing shows the data is not marked invalid. The temperature
> register retains the last measurement:
>
>   gyro and accel off (runtime suspended), 10 reads 1 s apart:
>     3598 3598 3598 3598 3598 3598 3598 3598 3598 3598  (about 52.2 C)
>
>   gyro running (sysfs gyro read before each temp read), 10 reads:
>     4934 4956 4950 4958 4956 4958 4956 4958 4962 4958  (about 62.4 C)
>
>   gyro started fresh each time (reads 3 s apart, autosuspend 2 s):
>     4952 4960 4964 4960 4956
>
> So with both sensors off, a temperature read returns a stale value, here
> about 10 C out of date, instead of INV_ICM42600_DATA_INVALID. The invalid
> value only seems to appear before the very first measurement after
> power-up. The fresh-start results show the first sample after a sensor
> starts is current, so it appears the separate temperature startup delay i=
s not
> needed.
>
> With the patch as it stands, inv_icm42600_temp_read() would therefore
> silently return stale data when both sensors are off. I see two options:
>
> 1. Return -EBUSY based on the driver state: if both st->conf.gyro.mode
>    and st->conf.accel.mode are INV_ICM42600_SENSOR_MODE_OFF, return
>    -EBUSY without reading the register. Small, and maintains the document=
ed
>    behavior.
>
> 2. Have the temperature read turn on the accel (for example in low
>    power mode), wait for its startup time, read the temperature, and let
>    runtime PM turn it off again. A current value is then always
>    returned, at the cost of a delay on that read.
>
> Which one would you prefer? I'm happy to implement either in the patch.
>
> Thanks,
> Joe
>
>
> On Tue, Nov 10, 2026 at 2:28=E2=80=AFPM Joe LeVeque <joe.l@reflexrobotics=
.com> wrote:
> >
> > Hi Jean-Baptiste,
> >
> > Thank you for the quick reply and the explanation!
> >
> > > I think the best solution would be to completely delete the temperatu=
re
> > > enable/disable feature. [...]
> > > Deleting all core temperature enable/disable and make temperature sen=
sor
> > > always working. And we keep enabling/disabling of temperature reporti=
ng in
> > > the FIFO.
> > >
> > > Is that something you could work on?
> >
> > Yes, I'm happy to work on it. My plan is to remove `temp_en` from the s=
ensor
> > configuration and the suspend state, drop the `temp` argument and the `=
TEMP_DIS`
> > handling from `inv_icm42600_set_pwr_mgmt0()`, remove
> > `inv_icm42600_set_temp_conf()` and its callers in the temperature read =
and
> > buffer paths, and leave the FIFO temperature reporting as it is.
> >
> > Two questions before I begin:
> >
> > 1. Temperature read with both gyro and accel off: since the chip turns =
the
> >    temperature sensor off by itself in that case, I would keep the curr=
ent
> >    behavior (invalid data reported as -EBUSY). Or would you prefer a
> >    temperature read to turn on one of the sensors itself?
> >
> > 2. Should this go in as a fix, with a "Fixes:" tag for stable backports=
, or
> >    as a regular change? It is larger than a typical stable fix. I'm pla=
nning
> >    to base it on the IIO "togreg" branch unless you or Jonathan prefer
> >    otherwise.
> >
> > I'll test it on my ICM-42688-P board (on a 6.6 kernel with the driver
> > backported) and mention that in the patch.
> >
> > Thanks again,
> > Joe
> >
> > On Tue, Nov 10, 2026 at 6:57=E2=80=AFAM Jean-Baptiste Maneyrol
> > <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> > >
> > > Hello Joe,
> > >
> > > it seems to be a good catch. With temperature sensor disabled, gyro v=
alues
> > > are likely to not be temperature compensated internally.
> > >
> > > I think the best solution would be to completely delete the temperatu=
re
> > > enable/disable feature. There is really no interest in disabling the
> > > temperature sensor since it is really bad for the gyro values. And it
> > > would simplify the driver that is already quite complex.
> > >
> > > Deleting all core temperature enable/disable and make temperature sen=
sor
> > > always working. And we keep enabling/disabling of temperature reporti=
ng in
> > > the FIFO.
> > >
> > > Is that something you could work on?
> > >
> > > Thanks for your reporting,
> > > JB
> > >
> > > >Hello Jean-Baptiste,
> > > >
> > > >I'm bringing up an ICM-42688-P (WHOAMI/ID 0x0007c1f2, on SPI) on a
> > > >custom i.MX8M-Plus carrier board, and I'm seeing a gyro behavior I'd
> > > >like to check with you before sending a patch.
> > > >
> > > >Setup: kernel 6.6 (NXP/CompuLab BSP) with the inv_icm42600 driver pl=
us
> > > >the upstream "add support of ICM-42688-P" commit backported. I've
> > > >compared the relevant code paths with current mainline and they are
> > > >unchanged there, so I believe mainline behaves the same way.
> > > >
> > > >Observation: right after boot, reading the gyro through sysfs
> > > >(in_anglvel_*_raw, default +-2000 dps range) gives a large, very
> > > >stable offset at rest:
> > > >
> > > >- Temperature sensor off (after boot):   x =3D -139, y =3D 379, z =
=3D -229
> > > >LSB  (about 8 to 23 dps)
> > > >- After one read of in_temp_raw:         x =3D    9, y =3D  -7, z =
=3D   -3
> > > >LSB  (under 0.5 dps)
> > > >
> > > >The large offset does not decay with time or with spaced-out reads. =
A
> > > >single in_temp_raw read removes it, and it stays away as long as the
> > > >temperature sensor remains enabled. Buffered capture with the
> > > >temperature channel enabled also gives the small values. The pattern
> > > >is reproducible across boots and power cycles.
> > > >
> > > >Looking at the driver, the default configuration has .temp_en =3D fa=
lse,
> > > >inv_icm42600_set_pwr_mgmt0() sets PWR_MGMT0.TEMP_DIS whenever temp i=
s
> > > >false, and inv_icm42600_gyro_read_sensor() enables the gyro through
> > > >inv_icm42600_set_gyro_conf(), which passes the current
> > > >st->conf.temp_en through unchanged. So after boot (or runtime
> > > >suspend), the gyro runs with the temperature sensor disabled, which
> > > >matches what I see.
> > > >
> > > >As a fix, I'm currently keeping the temperature sensor on whenever t=
he
> > > >gyro or accel is on, in inv_icm42600_set_pwr_mgmt0(), just before th=
e
> > > >"if nothing changed" check:
> > > >
> > > >if (gyro !=3D INV_ICM42600_SENSOR_MODE_OFF ||
> > > >   accel !=3D INV_ICM42600_SENSOR_MODE_OFF)
> > > >temp =3D true;
> > > >
> > > >With this, the gyro reads correctly from the first read after boot.
> > > >
> > > >My questions:
> > > >
> > > >1. Is this expected behavior for the ICM-42688-P (gyro offset
> > > >compensation depending on the temperature sensor), and does it also
> > > >apply to the other chips supported by this driver?
> > > >2. Would you accept a fix along these lines, or would you prefer it
> > > >handled differently, for example only for some chips, or in the gyro
> > > >read path instead of inv_icm42600_set_pwr_mgmt0()?
> > > >
> > > >If this approach is acceptable, I'm happy to send a proper patch
> > > >against the IIO tree. I can only test on 6.6 with the backported
> > > >driver, and I would state that in the patch.
> > > >
> > > >Thank you for your time.
> > > >
> > > >Best regards,
> > > >Joe LeVeque
> > > >
>
