Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795141057;
	b=JHOwQHzXC67ourkhHt6j9Vejv1edr+dIdms2+Z6jwy7PpHk1D7WwJizvLYNUJJYPo1+B
	 jS2m0Jl7ye8ZPgGuIj3e9lunLIjeMEx6RYMaIFbMx/ihbfOMXvVEdS/3mzDT5e7ydZMzi
	 67+jLo1AOEUzMy66clb7m1U8y8hRhIas+H1uNWsMwKX/bdyt/TM4uqRWaL3ZjxpC14NUN
	 i039o26/L0N6hPyjYdL6jIp944cED/JvcwBGARr/KY5u7QK4Ggom/GhSiJVlE2hU0Cikr
	 2Bh9yNu1sOYDrJU41632YQfbl164QicoLCx4UubwazpMXgo8T8LqGEidDWsv7SVWtGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LsEFk0RgZI7tbU1ifZ0Ps2UawHHHZN4oS65HUeVABNI=;
	b=YXLKgsE8JXVWa38GhcjxQuiwMAGEFtpXxVaYe++T3jzr9la3IhmZ0BYgBHPp8RQDVJee
	 9Mx038DDLeWbYL1dobh552fUS3BYFjZm97XG1jPqrUKZdTwIw6yc2xeZvcYmf07vb2F1k
	 L8wBWYLD3feCOqj18bjsp6qBRdrKtfluUCui6jGOS0iBL8ucn2ONHjMw1EJTV5cq2JdNe
	 oEYkx36Sk/LKGzUEFq6V00LZaN4gwD5ibb9KRJ1S5EE/Cy8YoqQdk8MB+213n7qD8t/AX
	 nHWhrjfzj+nqq2Wl7sKc1Zb2MMTFqR647I8/Yha72K/Ir2PZ4FsYxehsM0Tpol9uGZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=reflexrobotics.com;
	spf=pass smtp.mailfrom=reflexrobotics.com;
	dkim=pass header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pNipV384;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9879606A332
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 02:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9879606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pNipV384
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b8a52db5f9so441539a12.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 18:17:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795141055; cv=none;
        d=google.com; s=arc-20260327;
        b=bxjXNBwMEzpxG7+3YO7plXfMRdjsUIiwhaODNT/QmPqwiKfsDwKyZkHSPfjDeyXSrp
         Gd/2J36yLWoC4olOR6TuOZ/XzilR4dK8kGf8Jb1tGTZH2hgxB9INNq3/iiqJRfY45JrR
         DIIlEzAVCXQvcT/olfhqCpFumfMoMs6XZqCOWEAmplS0gLpq3M4Ux5BirhQFoFG+D9/u
         vnXFVhZ0DN8UOcBuaIlSxpBxw8BZeEjkwmMjYMpvF5vy0v5rWWhTsVNIiPaoZCk0w2wX
         Nk5aq1VvV6eR5c+HjA7ggWjLWTGMVmxA5FugvrmHF/FeRlKsk7xnO9V+mxeyuy8R7dsI
         gIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LsEFk0RgZI7tbU1ifZ0Ps2UawHHHZN4oS65HUeVABNI=;
        fh=yKpDLXwr5RJwADC4HfwqbVSsFvKxPaugRiZTQIL3JWg=;
        b=hUQ59shWTuEdH5mELvHP/6diZgdGP6wWO7Z0OkCYKMdgAEfBOx0cWP6hTQcOURe9ri
         qXnqIk1rUZgIUyC/TNpNvNdZEK8hUjrEVGwm0fQ8GHv0VXU209H+P3OD+ZcpB7rXfV7j
         WqLg2g3tcdiczIe97GT7gQD1RZyT7X9oWHN6q0S5T82+KKPoq7zX8ML0qvjk4b1F0HIX
         seU3MmNBa+AAeCp0Ygijp/ZAShGbpgwJeXdekv7fFxqO2vc7RtTTyOQlX1nEXX3Ovyd1
         KE047s/LDWoH6BGwJHPdpTUtIqovjgmP4OJDAiuE0vOEVRPGF7BKb7p1Rsq0n6Cbw33/
         bbNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reflexrobotics-com.20260707.gappssmtp.com; s=20260707; t=1795141055; x=1795745855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LsEFk0RgZI7tbU1ifZ0Ps2UawHHHZN4oS65HUeVABNI=;
        b=pNipV384oD8IF+NFdRN2OVulhES77PY8nOPbxCEAtJQz8aTKNk+NW2jtiIqu3uRxm/
         GL5vr2Bsd1QeN2Ee5+mJ1+tLQ/LEGa38auD2pEL5DCtnW91hFLy00yorEQfE4q7ntpcS
         NSuMGAhpiKYkrjeQpFnZxqTTxI50lSKy9kM8kVWcrciqwHAqfkFBeoyAjh4ie8qOwO1a
         5l1SYhubcA+fLUKExaZ02plnAxVk7afyxG20HtGP53xl8erBuEULaMBYKMf7x/yufhaT
         U9ic+ngTSX0ucOLyTgjUbRZkyhRvm3Zmxk8Ytp1qGAaW3wsWDkHiKkAkMXo3Nf/1rpQE
         1vdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795141055; x=1795745855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LsEFk0RgZI7tbU1ifZ0Ps2UawHHHZN4oS65HUeVABNI=;
        b=1UxIWlYz3s0edyLRpslqlTCVPzkh3uOfWbIOwMqcReQCDZAEHW5FpcjSYR41K8oWRP
         TpaEJNJ4H9stNMMom+Bd69ZDYOMwFhZpkicTs6QSYvrSqw3w5GlPjTz6vHtZMzAjNm0a
         o0sSmtiTMFHg59cnReworIWbt7DnHQpqOoEBFRAjCI7orNv00pRewuoBwgT3XcWr34aq
         YKTUvSEJEVR/9UFwkANoYxrAjAf31CJvNUBv0h3HYCzGhNSqp1NQFQB4EOj9tuMrU6Gf
         IXNq3nSqC+8DKgTmyoIlPbkefBKQNY2zRs6qnL2X9P5Z3M6vknkLmKUE922cyxd5D6p9
         9cig==
X-Forwarded-Encrypted: i=1; AL+hErFFao+t6dAIuOprbwNw2s8rfRPfLhbQJ3SFEAZPKS5wK/J72qMlvqRlmUNpKBnRye1QspwpQEQscgU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vIjjYsjaTWjgOG55+e3xnRLvIWA5QpzQYfzNx8Gv60M28UJ/I
	5uZWnb6204kVgPZcw/NOJnQFDnd8xwO8GMn4LutWTv+xOihi9q/Ezw5EI6LzD9eZhZri/DDmo+V
	F8Y4rp7G2gm7plj9lzUyMWQJa7tuDaVT/WBquEAPaFQ==
X-Gm-Gg: AZFdTZeedG1mUaCil0n0AmrNCfMmuwpAhHjJFro7/nOuzywxSo0ovM2CSwUn/oB7AXf
	xvQLpILxQ80bwrOyXKCRbPrzbv/fO0w4HSxM6IkfhPtmxZCit9SRQf+1L74VFZBH49u21ehT4HD
	wlDYgB/k5tFkHR9+ocxRYuzuBXr7mbQzEHJw/zq9xwXt4tS8/aYpmDgHVA9sNIB5xalDhCRTjiD
	uI0PlS3SImqG9a2T62Kv/sNm/Odv7Z95ahBvJGoNOc4zk/zaCEiuv+zx2bbH7i/gSTsqD/HM38d
	jV1914sqGr4RttPFOFfHTWRacSN/9qeInWRHdQoPQiwk0YvDgKrGKx0C62ARzgNU0sPxyVeEPvM
	7PSFElsQETrn8NMx9d6wrTIPY6zMgWx6aXoFOEYFtCmm1i07nu0H6ZiZLu7jMcrmH+Djtduo9pM
	oHTk+cdgl/U/jlI4JlvzYKyyBhbrUCuu1GuXo2MwhpVAt0YQZMow==
X-Received: by 2002:a05:6402:134e:b0:6ba:1266:cd9c with SMTP id
 4fb4d7f45d1cf-6ba37d606d5mr697868a12.8.1795141054717; Thu, 19 Nov 2026
 18:17:34 -0800 (PST)
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
 <CAJLMkXYNpRWWqNbUn72J8p7Fqi1jCy4FC2fdAtjkzJ4eW_9r2Q@mail.gmail.com>
 <FR2P281MB31032ED88B4637350921FB4CCE7A2@FR2P281MB3103.DEUP281.PROD.OUTLOOK.COM>
 <CAJLMkXYYXjFwAZN9TwyD3vez1XCpCxuEtmye1vi=jdLSLt36xg@mail.gmail.com> <20261118232418.7fc702a8@jic23-hlaptop>
In-Reply-To: <20261118232418.7fc702a8@jic23-hlaptop>
From: Joe LeVeque <joe.l@reflexrobotics.com>
Date: Thu, 19 Nov 2026 18:17:23 -0800
X-Gm-Features: AclHuK_ZqDlOi_c2YfvFMwQwllJLwSI_aal4S2CIZh6wgAG6XpLXxgKaGezo6oA
Message-ID: <CAJLMkXYfE25_Py4-JetnB6ZhhHowm8tps0WNm9pzY31Y_8duMA@mail.gmail.com>
Subject: Re: iio: imu: inv_icm42600: large gyro offset with temperature sensor
 disabled (ICM-42688-P)
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99ve sent the series implementing this (option 1, -EBUSY for idle
temperature reads):
https://lore.kernel.org/linux-iio/20261120020850.24318-1-joe.l@reflexroboti=
cs.com/T/#t

Thanks for the guidance!

On Wed, Nov 18, 2026 at 3:24=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Wed, 18 Nov 2026 11:33:17 -0800
> Joe LeVeque <joe.l@reflexrobotics.com> wrote:
>
> > Thank you both! Since the two of you lean different ways: Jean-Baptiste=
's point
> > fits the case Jonathan mentioned, where the temperature is dominated by=
 the
> > sensor itself rather than the environment. Here it=E2=80=99s the die te=
mperature, used
> > for gyro/accel compensation. So I=E2=80=99d propose option 1 (return -E=
BUSY when both
> > gyro and accel are off), unless Jonathan prefers otherwise. I=E2=80=99l=
l prepare it that
> > way and send it once you=E2=80=99ve both confirmed.
>
> That's fine.
>
>
> >
> > Thanks again,
> > Joe
> >
> > On Wed, Nov 18, 2026 at 10:00=E2=80=AFAM Jean-Baptiste Maneyrol
> > <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> > >
> > > >Hi Jean-Baptiste,
> > > >
> > > >I've implemented the change as you suggested (temperature sensor alw=
ays
> > > >on, temp_en, set_temp_conf() and the TEMP_DIS handling removed, FIFO
> > > >temperature reporting unchanged) and tested it on my ICM-42688-P (SP=
I,
> > > >i.MX8M Plus, 6.6 kernel with the driver backported).
> > > >
> > > >The gyro reads correctly from the first read after boot (about 3, -6=
, 0
> > > >LSB at rest at +-2000 dps), including after runtime suspend, and the
> > > >accel is unchanged.
> > > >
> > > >Regarding my question about temperature reads with both gyro and acc=
el
> > > >off, testing shows the data is not marked invalid. The temperature
> > > >register retains the last measurement:
> > > >
> > > >  gyro and accel off (runtime suspended), 10 reads 1 s apart:
> > > >    3598 3598 3598 3598 3598 3598 3598 3598 3598 3598  (about 52.2 C=
)
> > > >
> > > >  gyro running (sysfs gyro read before each temp read), 10 reads:
> > > >    4934 4956 4950 4958 4956 4958 4956 4958 4962 4958  (about 62.4 C=
)
> > > >
> > > >  gyro started fresh each time (reads 3 s apart, autosuspend 2 s):
> > > >    4952 4960 4964 4960 4956
> > > >
> > > >So with both sensors off, a temperature read returns a stale value, =
here
> > > >about 10 C out of date, instead of INV_ICM42600_DATA_INVALID. The in=
valid
> > > >value only seems to appear before the very first measurement after
> > > >power-up. The fresh-start results show the first sample after a sens=
or
> > > >starts is current, so it appears the separate temperature startup de=
lay is not
> > > >needed.
> > > >
> > > >With the patch as it stands, inv_icm42600_temp_read() would therefor=
e
> > > >silently return stale data when both sensors are off. I see two opti=
ons:
> > > >
> > > >1. Return -EBUSY based on the driver state: if both st->conf.gyro.mo=
de
> > > >   and st->conf.accel.mode are INV_ICM42600_SENSOR_MODE_OFF, return
> > > >   -EBUSY without reading the register. Small, and maintains the doc=
umented
> > > >   behavior.
> > > >
> > > >2. Have the temperature read turn on the accel (for example in low
> > > >   power mode), wait for its startup time, read the temperature, and=
 let
> > > >   runtime PM turn it off again. A current value is then always
> > > >   returned, at the cost of a delay on that read.
> > > >
> > > >Which one would you prefer? I'm happy to implement either in the pat=
ch.
> > > >
> > > >Thanks,
> > > >Joe
> > > >
> > >
> > > Hello Joe,
> > >
> > > I prefer #1, since it is consistent with actual behavior and it makes=
 sense.
> > > Returning temperature when all sensors are off doesn't have any sense=
, since
> > > the only usage is temperature compensation of accel/gyro data.
> > >
> > > This is the reason why the implementation was done like this. And #2 =
is quite
> > > complex for something that is completely useless.
> > >
> > > Thanks,
> > > JB
> > >
> > > ________________________________________
> > > From: Joe LeVeque <joe.l@reflexrobotics.com>
> > > Sent: Friday, November 13, 2026 23:27
> > > To: Jean-Baptiste Maneyrol
> > > Cc: linux-iio@vger.kernel.org
> > > Subject: Re: iio: imu: inv_icm42600: large gyro offset with temperatu=
re sensor disabled (ICM-42688-P)
> > >
> > > Hi Jean-Baptiste, I've implemented the change as you suggested (tempe=
rature sensor always on, temp_en, set_temp_conf() and the TEMP_DIS handling=
 removed, FIFO temperature reporting unchanged) and tested it on my ICM-426=
88-P (SPI, i.=E2=80=8AMX8M Plus,
> > > ZjQcmQRYFpfptBannerStart
> > > This Message Is From an External Sender
> > > This message came from outside your organization.
> > >
> > > ZjQcmQRYFpfptBannerEnd
> > >
> > > Hi Jean-Baptiste,
> > >
> > > I've implemented the change as you suggested (temperature sensor alwa=
ys
> > > on, temp_en, set_temp_conf() and the TEMP_DIS handling removed, FIFO
> > > temperature reporting unchanged) and tested it on my ICM-42688-P (SPI=
,
> > > i.MX8M Plus, 6.6 kernel with the driver backported).
> > >
> > > The gyro reads correctly from the first read after boot (about 3, -6,=
 0
> > > LSB at rest at +-2000 dps), including after runtime suspend, and the
> > > accel is unchanged.
> > >
> > > Regarding my question about temperature reads with both gyro and acce=
l
> > > off, testing shows the data is not marked invalid. The temperature
> > > register retains the last measurement:
> > >
> > >   gyro and accel off (runtime suspended), 10 reads 1 s apart:
> > >     3598 3598 3598 3598 3598 3598 3598 3598 3598 3598  (about 52.2 C)
> > >
> > >   gyro running (sysfs gyro read before each temp read), 10 reads:
> > >     4934 4956 4950 4958 4956 4958 4956 4958 4962 4958  (about 62.4 C)
> > >
> > >   gyro started fresh each time (reads 3 s apart, autosuspend 2 s):
> > >     4952 4960 4964 4960 4956
> > >
> > > So with both sensors off, a temperature read returns a stale value, h=
ere
> > > about 10 C out of date, instead of INV_ICM42600_DATA_INVALID. The inv=
alid
> > > value only seems to appear before the very first measurement after
> > > power-up. The fresh-start results show the first sample after a senso=
r
> > > starts is current, so it appears the separate temperature startup del=
ay is not
> > > needed.
> > >
> > > With the patch as it stands, inv_icm42600_temp_read() would therefore
> > > silently return stale data when both sensors are off. I see two optio=
ns:
> > >
> > > 1. Return -EBUSY based on the driver state: if both st->conf.gyro.mod=
e
> > >    and st->conf.accel.mode are INV_ICM42600_SENSOR_MODE_OFF, return
> > >    -EBUSY without reading the register. Small, and maintains the docu=
mented
> > >    behavior.
> > >
> > > 2. Have the temperature read turn on the accel (for example in low
> > >    power mode), wait for its startup time, read the temperature, and =
let
> > >    runtime PM turn it off again. A current value is then always
> > >    returned, at the cost of a delay on that read.
> > >
> > > Which one would you prefer? I'm happy to implement either in the patc=
h.
> > >
> > > Thanks,
> > > Joe
> > >
> > >
> > > On Tue, Nov 10, 2026 at 2:28=E2=80=AFPM Joe LeVeque <joe.l@reflexrobo=
tics.com> wrote:
> > > >
> > > > Hi Jean-Baptiste,
> > > >
> > > > Thank you for the quick reply and the explanation!
> > > >
> > > > > I think the best solution would be to completely delete the tempe=
rature
> > > > > enable/disable feature. [...]
> > > > > Deleting all core temperature enable/disable and make temperature=
 sensor
> > > > > always working. And we keep enabling/disabling of temperature rep=
orting in
> > > > > the FIFO.
> > > > >
> > > > > Is that something you could work on?
> > > >
> > > > Yes, I'm happy to work on it. My plan is to remove `temp_en` from t=
he sensor
> > > > configuration and the suspend state, drop the `temp` argument and t=
he `TEMP_DIS`
> > > > handling from `inv_icm42600_set_pwr_mgmt0()`, remove
> > > > `inv_icm42600_set_temp_conf()` and its callers in the temperature r=
ead and
> > > > buffer paths, and leave the FIFO temperature reporting as it is.
> > > >
> > > > Two questions before I begin:
> > > >
> > > > 1. Temperature read with both gyro and accel off: since the chip tu=
rns the
> > > >    temperature sensor off by itself in that case, I would keep the =
current
> > > >    behavior (invalid data reported as -EBUSY). Or would you prefer =
a
> > > >    temperature read to turn on one of the sensors itself?
> > > >
> > > > 2. Should this go in as a fix, with a "Fixes:" tag for stable backp=
orts, or
> > > >    as a regular change? It is larger than a typical stable fix. I'm=
 planning
> > > >    to base it on the IIO "togreg" branch unless you or Jonathan pre=
fer
> > > >    otherwise.
> > > >
> > > > I'll test it on my ICM-42688-P board (on a 6.6 kernel with the driv=
er
> > > > backported) and mention that in the patch.
> > > >
> > > > Thanks again,
> > > > Joe
> > > >
> > > > On Tue, Nov 10, 2026 at 6:57=E2=80=AFAM Jean-Baptiste Maneyrol
> > > > <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> > > > >
> > > > > Hello Joe,
> > > > >
> > > > > it seems to be a good catch. With temperature sensor disabled, gy=
ro values
> > > > > are likely to not be temperature compensated internally.
> > > > >
> > > > > I think the best solution would be to completely delete the tempe=
rature
> > > > > enable/disable feature. There is really no interest in disabling =
the
> > > > > temperature sensor since it is really bad for the gyro values. An=
d it
> > > > > would simplify the driver that is already quite complex.
> > > > >
> > > > > Deleting all core temperature enable/disable and make temperature=
 sensor
> > > > > always working. And we keep enabling/disabling of temperature rep=
orting in
> > > > > the FIFO.
> > > > >
> > > > > Is that something you could work on?
> > > > >
> > > > > Thanks for your reporting,
> > > > > JB
> > > > >
> > > > > >Hello Jean-Baptiste,
> > > > > >
> > > > > >I'm bringing up an ICM-42688-P (WHOAMI/ID 0x0007c1f2, on SPI) on=
 a
> > > > > >custom i.MX8M-Plus carrier board, and I'm seeing a gyro behavior=
 I'd
> > > > > >like to check with you before sending a patch.
> > > > > >
> > > > > >Setup: kernel 6.6 (NXP/CompuLab BSP) with the inv_icm42600 drive=
r plus
> > > > > >the upstream "add support of ICM-42688-P" commit backported. I'v=
e
> > > > > >compared the relevant code paths with current mainline and they =
are
> > > > > >unchanged there, so I believe mainline behaves the same way.
> > > > > >
> > > > > >Observation: right after boot, reading the gyro through sysfs
> > > > > >(in_anglvel_*_raw, default +-2000 dps range) gives a large, very
> > > > > >stable offset at rest:
> > > > > >
> > > > > >- Temperature sensor off (after boot):   x =3D -139, y =3D 379, =
z =3D -229
> > > > > >LSB  (about 8 to 23 dps)
> > > > > >- After one read of in_temp_raw:         x =3D    9, y =3D  -7, =
z =3D   -3
> > > > > >LSB  (under 0.5 dps)
> > > > > >
> > > > > >The large offset does not decay with time or with spaced-out rea=
ds. A
> > > > > >single in_temp_raw read removes it, and it stays away as long as=
 the
> > > > > >temperature sensor remains enabled. Buffered capture with the
> > > > > >temperature channel enabled also gives the small values. The pat=
tern
> > > > > >is reproducible across boots and power cycles.
> > > > > >
> > > > > >Looking at the driver, the default configuration has .temp_en =
=3D false,
> > > > > >inv_icm42600_set_pwr_mgmt0() sets PWR_MGMT0.TEMP_DIS whenever te=
mp is
> > > > > >false, and inv_icm42600_gyro_read_sensor() enables the gyro thro=
ugh
> > > > > >inv_icm42600_set_gyro_conf(), which passes the current
> > > > > >st->conf.temp_en through unchanged. So after boot (or runtime
> > > > > >suspend), the gyro runs with the temperature sensor disabled, wh=
ich
> > > > > >matches what I see.
> > > > > >
> > > > > >As a fix, I'm currently keeping the temperature sensor on whenev=
er the
> > > > > >gyro or accel is on, in inv_icm42600_set_pwr_mgmt0(), just befor=
e the
> > > > > >"if nothing changed" check:
> > > > > >
> > > > > >if (gyro !=3D INV_ICM42600_SENSOR_MODE_OFF ||
> > > > > >   accel !=3D INV_ICM42600_SENSOR_MODE_OFF)
> > > > > >temp =3D true;
> > > > > >
> > > > > >With this, the gyro reads correctly from the first read after bo=
ot.
> > > > > >
> > > > > >My questions:
> > > > > >
> > > > > >1. Is this expected behavior for the ICM-42688-P (gyro offset
> > > > > >compensation depending on the temperature sensor), and does it a=
lso
> > > > > >apply to the other chips supported by this driver?
> > > > > >2. Would you accept a fix along these lines, or would you prefer=
 it
> > > > > >handled differently, for example only for some chips, or in the =
gyro
> > > > > >read path instead of inv_icm42600_set_pwr_mgmt0()?
> > > > > >
> > > > > >If this approach is acceptable, I'm happy to send a proper patch
> > > > > >against the IIO tree. I can only test on 6.6 with the backported
> > > > > >driver, and I would state that in the patch.
> > > > > >
> > > > > >Thank you for your time.
> > > > > >
> > > > > >Best regards,
> > > > > >Joe LeVeque
> > > > > >
> > >
> >
>
