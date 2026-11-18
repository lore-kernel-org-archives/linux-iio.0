Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044263;
	b=y/eIueXKTPZbGyYsfX/8MuR48C0SkG5VfiNPEeC9FkETlhw2XmyiwU021zZmEbagkovt
	 8rbQU9WrqBDEpMU3JAFEi0h98qwHkYHUz9Z1mvtLANWlEf3ysrGsLtP87OA8mxBunJIqb
	 bwcPkER2FWgX7LNkr6W4sVYfMZ4NfAa8Snov0xm1I8N7sm9EjXaExmlP6dUsfI/xj2uDv
	 FGzwQspUC9hjtGCJmJAjmzMGcb7shZxuOBzjCk8pAnMOKeZ2odJ/11to38B+6BZlDBqmr
	 qwfcyoOvE0K/9VV2OG2JSmkVZ9xRcZDqPAvNhURmHPIhe/S19fZB+Gj9Nk8iFBlm+JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044263;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pIQ5Ix94t0jSQmA8pB2c+O3uEnE02Nox27idZsmudT4=;
	b=xyxsPIoTA19a8/Ck2womEtTx+hmSqvCk7euu8rtlS34j6GZfdNyYkH0li+aBciRGW1/B
	 DNr6D3/NVBpyISO5d/kFofnVQofmH/WCdcNqou+meo/YGcaLPv9P+DzG4spKmG3WBSnjF
	 XXybDsoShaqX3Bj0Qjwoe4MhRvHBRlDUbTMPp70L4zf/qpA17wQAjyNlkDr2343jhmgiK
	 YsSexIAIPV+jD+vyBLGdv4CUcCb/V5Q3fx8YbQovqt11OpA6qcF3UVmkwBN33Qxis6Tcc
	 35n2TWNCnP8lO+w+6Zhmd58s3iShm3hPaF72gAmow9xo0OigRL3ott1XH4UvHrt9BDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxMkt25G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B2606A32A
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxMkt25G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298071F000C4;
	Wed, 18 Nov 2026 23:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795044263;
	bh=pIQ5Ix94t0jSQmA8pB2c+O3uEnE02Nox27idZsmudT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FxMkt25GoMRtIXnUElfnkTBX5AEcqeKb5JkUK1ShpLdxRb/2GpRL13KAc88u9i9jz
	 5AaQ/wYYO/1fpzWC933rziiKipWs4Jwz05mhGq/JboMeFcvB7aO6A4KIi2GGSTv9jU
	 votIrVq4Xrw9Re1u9bbPNB1/KxpceuwX/mt+CNv25k8TqoI4HRukjZtlCz5eq7sXU2
	 oqlqFJ+XtfGrtEV4Kp0z8SZXs/j9uzXXUb/m2Xp46lHhOAh9Bchx6S2IV4NR/KmyUR
	 pUqlW7kIGaORH7ePhchbet/foogzpmzu1vWzIHqP1PNvt5vSbYQcGAp2LD/77uxIJT
	 StU1Mju8Eocqw==
Date: Wed, 18 Nov 2026 23:24:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joe LeVeque <joe.l@reflexrobotics.com>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio: imu: inv_icm42600: large gyro offset with temperature
 sensor disabled (ICM-42688-P)
Message-ID: <20261118232418.7fc702a8@jic23-hlaptop>
In-Reply-To: <CAJLMkXYYXjFwAZN9TwyD3vez1XCpCxuEtmye1vi=jdLSLt36xg@mail.gmail.com>
References: <CAJLMkXY6wS7ErVT5YUyp=c0TJDPmGePJiDua4MPw47V83JQ0Fw@mail.gmail.com>
	<FR2P281MB310391F1880DC67B2FC446DBCE722@FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM>
	<CAJLMkXYB9NjwN1ZxfkGPE=y2NESRc=ir7B80cVpVk=d-tyPoVw@mail.gmail.com>
	<CAJLMkXYNpRWWqNbUn72J8p7Fqi1jCy4FC2fdAtjkzJ4eW_9r2Q@mail.gmail.com>
	<FR2P281MB31032ED88B4637350921FB4CCE7A2@FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM>
	<CAJLMkXYYXjFwAZN9TwyD3vez1XCpCxuEtmye1vi=jdLSLt36xg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Nov 2026 11:33:17 -0800
Joe LeVeque <joe.l@reflexrobotics.com> wrote:

> Thank you both! Since the two of you lean different ways: Jean-Baptiste's=
 point
> fits the case Jonathan mentioned, where the temperature is dominated by t=
he
> sensor itself rather than the environment. Here it=E2=80=99s the die temp=
erature, used
> for gyro/accel compensation. So I=E2=80=99d propose option 1 (return -EBU=
SY when both
> gyro and accel are off), unless Jonathan prefers otherwise. I=E2=80=99ll =
prepare it that
> way and send it once you=E2=80=99ve both confirmed.

That's fine.


>=20
> Thanks again,
> Joe
>=20
> On Wed, Nov 18, 2026 at 10:00=E2=80=AFAM Jean-Baptiste Maneyrol
> <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> > =20
> > >Hi Jean-Baptiste,
> > >
> > >I've implemented the change as you suggested (temperature sensor always
> > >on, temp_en, set_temp_conf() and the TEMP_DIS handling removed, FIFO
> > >temperature reporting unchanged) and tested it on my ICM-42688-P (SPI,
> > >i.MX8M Plus, 6.6 kernel with the driver backported).
> > >
> > >The gyro reads correctly from the first read after boot (about 3, -6, 0
> > >LSB at rest at +-2000 dps), including after runtime suspend, and the
> > >accel is unchanged.
> > >
> > >Regarding my question about temperature reads with both gyro and accel
> > >off, testing shows the data is not marked invalid. The temperature
> > >register retains the last measurement:
> > >
> > >  gyro and accel off (runtime suspended), 10 reads 1 s apart:
> > >    3598 3598 3598 3598 3598 3598 3598 3598 3598 3598  (about 52.2 C)
> > >
> > >  gyro running (sysfs gyro read before each temp read), 10 reads:
> > >    4934 4956 4950 4958 4956 4958 4956 4958 4962 4958  (about 62.4 C)
> > >
> > >  gyro started fresh each time (reads 3 s apart, autosuspend 2 s):
> > >    4952 4960 4964 4960 4956
> > >
> > >So with both sensors off, a temperature read returns a stale value, he=
re
> > >about 10 C out of date, instead of INV_ICM42600_DATA_INVALID. The inva=
lid
> > >value only seems to appear before the very first measurement after
> > >power-up. The fresh-start results show the first sample after a sensor
> > >starts is current, so it appears the separate temperature startup dela=
y is not
> > >needed.
> > >
> > >With the patch as it stands, inv_icm42600_temp_read() would therefore
> > >silently return stale data when both sensors are off. I see two option=
s:
> > >
> > >1. Return -EBUSY based on the driver state: if both st->conf.gyro.mode
> > >   and st->conf.accel.mode are INV_ICM42600_SENSOR_MODE_OFF, return
> > >   -EBUSY without reading the register. Small, and maintains the docum=
ented
> > >   behavior.
> > >
> > >2. Have the temperature read turn on the accel (for example in low
> > >   power mode), wait for its startup time, read the temperature, and l=
et
> > >   runtime PM turn it off again. A current value is then always
> > >   returned, at the cost of a delay on that read.
> > >
> > >Which one would you prefer? I'm happy to implement either in the patch.
> > >
> > >Thanks,
> > >Joe
> > > =20
> >
> > Hello Joe,
> >
> > I prefer #1, since it is consistent with actual behavior and it makes s=
ense.
> > Returning temperature when all sensors are off doesn't have any sense, =
since
> > the only usage is temperature compensation of accel/gyro data.
> >
> > This is the reason why the implementation was done like this. And #2 is=
 quite
> > complex for something that is completely useless.
> >
> > Thanks,
> > JB
> >
> > ________________________________________
> > From: Joe LeVeque <joe.l@reflexrobotics.com>
> > Sent: Friday, November 13, 2026 23:27
> > To: Jean-Baptiste Maneyrol
> > Cc: linux-iio@vger.kernel.org
> > Subject: Re: iio: imu: inv_icm42600: large gyro offset with temperature=
 sensor disabled (ICM-42688-P)
> >
> > Hi Jean-Baptiste, I've implemented the change as you suggested (tempera=
ture sensor always on, temp_en, set_temp_conf() and the TEMP_DIS handling r=
emoved, FIFO temperature reporting unchanged) and tested it on my ICM-42688=
-P (SPI, i.=E2=80=8AMX8M Plus,
> > ZjQcmQRYFpfptBannerStart
> > This Message Is From an External Sender
> > This message came from outside your organization.
> >
> > ZjQcmQRYFpfptBannerEnd
> >
> > Hi Jean-Baptiste,
> >
> > I've implemented the change as you suggested (temperature sensor always
> > on, temp_en, set_temp_conf() and the TEMP_DIS handling removed, FIFO
> > temperature reporting unchanged) and tested it on my ICM-42688-P (SPI,
> > i.MX8M Plus, 6.6 kernel with the driver backported).
> >
> > The gyro reads correctly from the first read after boot (about 3, -6, 0
> > LSB at rest at +-2000 dps), including after runtime suspend, and the
> > accel is unchanged.
> >
> > Regarding my question about temperature reads with both gyro and accel
> > off, testing shows the data is not marked invalid. The temperature
> > register retains the last measurement:
> >
> >   gyro and accel off (runtime suspended), 10 reads 1 s apart:
> >     3598 3598 3598 3598 3598 3598 3598 3598 3598 3598  (about 52.2 C)
> >
> >   gyro running (sysfs gyro read before each temp read), 10 reads:
> >     4934 4956 4950 4958 4956 4958 4956 4958 4962 4958  (about 62.4 C)
> >
> >   gyro started fresh each time (reads 3 s apart, autosuspend 2 s):
> >     4952 4960 4964 4960 4956
> >
> > So with both sensors off, a temperature read returns a stale value, here
> > about 10 C out of date, instead of INV_ICM42600_DATA_INVALID. The inval=
id
> > value only seems to appear before the very first measurement after
> > power-up. The fresh-start results show the first sample after a sensor
> > starts is current, so it appears the separate temperature startup delay=
 is not
> > needed.
> >
> > With the patch as it stands, inv_icm42600_temp_read() would therefore
> > silently return stale data when both sensors are off. I see two options:
> >
> > 1. Return -EBUSY based on the driver state: if both st->conf.gyro.mode
> >    and st->conf.accel.mode are INV_ICM42600_SENSOR_MODE_OFF, return
> >    -EBUSY without reading the register. Small, and maintains the docume=
nted
> >    behavior.
> >
> > 2. Have the temperature read turn on the accel (for example in low
> >    power mode), wait for its startup time, read the temperature, and let
> >    runtime PM turn it off again. A current value is then always
> >    returned, at the cost of a delay on that read.
> >
> > Which one would you prefer? I'm happy to implement either in the patch.
> >
> > Thanks,
> > Joe
> >
> >
> > On Tue, Nov 10, 2026 at 2:28=E2=80=AFPM Joe LeVeque <joe.l@reflexroboti=
cs.com> wrote: =20
> > >
> > > Hi Jean-Baptiste,
> > >
> > > Thank you for the quick reply and the explanation!
> > > =20
> > > > I think the best solution would be to completely delete the tempera=
ture
> > > > enable/disable feature. [...]
> > > > Deleting all core temperature enable/disable and make temperature s=
ensor
> > > > always working. And we keep enabling/disabling of temperature repor=
ting in
> > > > the FIFO.
> > > >
> > > > Is that something you could work on? =20
> > >
> > > Yes, I'm happy to work on it. My plan is to remove `temp_en` from the=
 sensor
> > > configuration and the suspend state, drop the `temp` argument and the=
 `TEMP_DIS`
> > > handling from `inv_icm42600_set_pwr_mgmt0()`, remove
> > > `inv_icm42600_set_temp_conf()` and its callers in the temperature rea=
d and
> > > buffer paths, and leave the FIFO temperature reporting as it is.
> > >
> > > Two questions before I begin:
> > >
> > > 1. Temperature read with both gyro and accel off: since the chip turn=
s the
> > >    temperature sensor off by itself in that case, I would keep the cu=
rrent
> > >    behavior (invalid data reported as -EBUSY). Or would you prefer a
> > >    temperature read to turn on one of the sensors itself?
> > >
> > > 2. Should this go in as a fix, with a "Fixes:" tag for stable backpor=
ts, or
> > >    as a regular change? It is larger than a typical stable fix. I'm p=
lanning
> > >    to base it on the IIO "togreg" branch unless you or Jonathan prefer
> > >    otherwise.
> > >
> > > I'll test it on my ICM-42688-P board (on a 6.6 kernel with the driver
> > > backported) and mention that in the patch.
> > >
> > > Thanks again,
> > > Joe
> > >
> > > On Tue, Nov 10, 2026 at 6:57=E2=80=AFAM Jean-Baptiste Maneyrol
> > > <Jean-Baptiste.Maneyrol@tdk.com> wrote: =20
> > > >
> > > > Hello Joe,
> > > >
> > > > it seems to be a good catch. With temperature sensor disabled, gyro=
 values
> > > > are likely to not be temperature compensated internally.
> > > >
> > > > I think the best solution would be to completely delete the tempera=
ture
> > > > enable/disable feature. There is really no interest in disabling the
> > > > temperature sensor since it is really bad for the gyro values. And =
it
> > > > would simplify the driver that is already quite complex.
> > > >
> > > > Deleting all core temperature enable/disable and make temperature s=
ensor
> > > > always working. And we keep enabling/disabling of temperature repor=
ting in
> > > > the FIFO.
> > > >
> > > > Is that something you could work on?
> > > >
> > > > Thanks for your reporting,
> > > > JB
> > > > =20
> > > > >Hello Jean-Baptiste,
> > > > >
> > > > >I'm bringing up an ICM-42688-P (WHOAMI/ID 0x0007c1f2, on SPI) on a
> > > > >custom i.MX8M-Plus carrier board, and I'm seeing a gyro behavior I=
'd
> > > > >like to check with you before sending a patch.
> > > > >
> > > > >Setup: kernel 6.6 (NXP/CompuLab BSP) with the inv_icm42600 driver =
plus
> > > > >the upstream "add support of ICM-42688-P" commit backported. I've
> > > > >compared the relevant code paths with current mainline and they are
> > > > >unchanged there, so I believe mainline behaves the same way.
> > > > >
> > > > >Observation: right after boot, reading the gyro through sysfs
> > > > >(in_anglvel_*_raw, default +-2000 dps range) gives a large, very
> > > > >stable offset at rest:
> > > > >
> > > > >- Temperature sensor off (after boot):   x =3D -139, y =3D 379, z =
=3D -229
> > > > >LSB  (about 8 to 23 dps)
> > > > >- After one read of in_temp_raw:         x =3D    9, y =3D  -7, z =
=3D   -3
> > > > >LSB  (under 0.5 dps)
> > > > >
> > > > >The large offset does not decay with time or with spaced-out reads=
. A
> > > > >single in_temp_raw read removes it, and it stays away as long as t=
he
> > > > >temperature sensor remains enabled. Buffered capture with the
> > > > >temperature channel enabled also gives the small values. The patte=
rn
> > > > >is reproducible across boots and power cycles.
> > > > >
> > > > >Looking at the driver, the default configuration has .temp_en =3D =
false,
> > > > >inv_icm42600_set_pwr_mgmt0() sets PWR_MGMT0.TEMP_DIS whenever temp=
 is
> > > > >false, and inv_icm42600_gyro_read_sensor() enables the gyro through
> > > > >inv_icm42600_set_gyro_conf(), which passes the current
> > > > >st->conf.temp_en through unchanged. So after boot (or runtime
> > > > >suspend), the gyro runs with the temperature sensor disabled, which
> > > > >matches what I see.
> > > > >
> > > > >As a fix, I'm currently keeping the temperature sensor on whenever=
 the
> > > > >gyro or accel is on, in inv_icm42600_set_pwr_mgmt0(), just before =
the
> > > > >"if nothing changed" check:
> > > > >
> > > > >if (gyro !=3D INV_ICM42600_SENSOR_MODE_OFF ||
> > > > >   accel !=3D INV_ICM42600_SENSOR_MODE_OFF)
> > > > >temp =3D true;
> > > > >
> > > > >With this, the gyro reads correctly from the first read after boot.
> > > > >
> > > > >My questions:
> > > > >
> > > > >1. Is this expected behavior for the ICM-42688-P (gyro offset
> > > > >compensation depending on the temperature sensor), and does it also
> > > > >apply to the other chips supported by this driver?
> > > > >2. Would you accept a fix along these lines, or would you prefer it
> > > > >handled differently, for example only for some chips, or in the gy=
ro
> > > > >read path instead of inv_icm42600_set_pwr_mgmt0()?
> > > > >
> > > > >If this approach is acceptable, I'm happy to send a proper patch
> > > > >against the IIO tree. I can only test on 6.6 with the backported
> > > > >driver, and I would state that in the patch.
> > > > >
> > > > >Thank you for your time.
> > > > >
> > > > >Best regards,
> > > > >Joe LeVeque
> > > > > =20
> > =20
>=20

