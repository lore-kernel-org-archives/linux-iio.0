Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794726701;
	b=R3KKPJmHDkgtgLVS7czB/c8xYFdQHE2FUWN2EoIdAjo6TikV9mqHWLfMZdLRI28b+9mF
	 oGGfesu96c89LPMqUE9UvJhkLaHQEiIDZRPALEuuzRdAQ6KzT2irzFZr1qSYKPV7TrgVK
	 +WbCjyamUpBLaAhh+qFct5JW0QPdacJ20V3IllVsUN535ugcOkimKM3Vw66lUt61gK8Qj
	 x6uHhBAXlBwz3HJvIaxIadLoETmu3O0gRsl/j0f6zdjh3RtUTr7BHZot+2zEFaEK6Y1Vy
	 uh1N6qkG2b/ehlr9Ut4QQDGGuQNoWxKuNRd5TvDiN19PRheautR8Rijf/G0N93rdWNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794726701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Organization:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=0XKUUkw7R9v5Z3R0hb5vCv7yEC5IZgo5hJ/JYgNvPEU=;
	b=wiYijplFmXu54JrqnHk3mzN64B5bWmQKBTvZo+KeIpaYOordVfDrpxdTVlDqkSHtL++B
	 yy+wPKSokkS+eQ6T1auriv4sP7PYc7dC9Ft0u/5U+8giihqzR9e42dFxADCcRu7yapkWr
	 2NspS7/T4xh6LgGMEmO+yi43QNJPYvCnevujgJSrQvMV84XFaig48CbCSQN/WSKSLqP0n
	 j0AHBj6SNinoUTKnMB33BqlbflV6o0z8atAbub6mxIQs/Xphu6cuVwzbmxTpgxJLqiHNV
	 sPeyF7tqeYRNGP2l0z/1i8qTCg14gPjEqedNucm+YASjAn/X/1JYV0ToC7MLVl42h8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hiBQzAxo;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C6606A327
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 07:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B50C6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hiBQzAxo
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-49134c8509fso2474007f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 23:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794726698; x=1795331498; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :organization:references:in-reply-to:date:cc:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0XKUUkw7R9v5Z3R0hb5vCv7yEC5IZgo5hJ/JYgNvPEU=;
        b=hiBQzAxo7+jpKxKkBjHkpsfYiWdzc42BZTcNLR26zYFi2xsiWl5pvI5EtUN7GaOQAf
         NH3y7SYbwYvEMNLIwsCEV8jHSyqwoakBwyPP16WvLz0HeVTvHABRM1fxbiaqPnqqhqjp
         bRxP/rIWgjYjxbczDU50EdrKfixQdqniqd3tWzrZbSVzFKgpqnCzpsvezbfUWsuPkVTg
         m4gpnD1gQkI7CObc2lqOs/CU6HK16slaffqcHHI54WlzD4V02+Tx1pnYh6eStpmXK/Jq
         HL+0dz5bBsnntx2f2sCV7mqxNaBGfcGeSkE1UOR9OsrSBroS40b/3Hq6SunCMkv3T5xE
         y+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794726698; x=1795331498;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :organization:references:in-reply-to:date:cc:to:from:subject
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0XKUUkw7R9v5Z3R0hb5vCv7yEC5IZgo5hJ/JYgNvPEU=;
        b=X9htlpxxattzna4Qdd1+T5BJi/LQtWQfMwtetqQob4QgOR7Ck42RT4HuWt0XTZDcqG
         g3T4RBbdIdNxJZLiV9Bug9CthpbLqwmxh8DJXfxLqM8GAB5iDLUJcHSwIWND452EC9ic
         K/izo8nvjw6b0gLDRNEDyf5+xtqAxXVN8WmyNnoQ07ykNng2agQGxEPGTvyuadxFuIfC
         uIlWnGl39CWGsZI1NJWTHR/vr4asNFQ6kBQrpI4MUYdPrOz6T8Zr9WJI2OzDkjVS8Abd
         fIpmOl9nWmNrtg6o1DcV2BBTHuxLgNv/9c379LjAReTMEkur4jINkmdK5s8TzH+muqrj
         o+8A==
X-Forwarded-Encrypted: i=1; AL+hErGHToSkeUsReVdXf/0qBle2OR2YcQOEtECJUmU9fA/koCkmyYWK80DxIsPpvQigGcL8yX6z69pZw6Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZA2hYkwFEf1sJbL9eGLSGNLz4jajyG5HDxPvPgBfhaK7xav3v
	cpM5911VYZToOx0f+8leNy9FwwrSEK6i6bedBg0FvrjnCCLXHRWN2Sbr3zwjXFniC4s=
X-Gm-Gg: AYBFou2OyUsnhFgOf9cKLGgUgRplN7k4Uqc/QX3GSg5o28nDgZsMwAkQbD8T+sr4GA1
	MtLZ77TNZlMquasMrQ2ovkzdLBQGL59CTakcTVll8X3m4PFs5rpWQjeeum+f6VOoMNMGAhmRX9s
	XqUaG2M4rbl6tGQBboTp4GLue/Pn7GiE3F6Wc+ccGxS8jSfVh1V1dVrxhxmM9MSpyS/DOJnFYqX
	DDyyxO/phBBU99Y5uKfovsyzq5UkkSAiYz5vwyipAfiuGGwkSTEE1N0J1iStfKZ1s33uVL1knQ4
	oS6lsDeITLIKR7lqQGvB3ii0bZtFtHvluJcd9BC6pnqoy89T0xd6C8FKcU98YxqCBxF9lUrYBwb
	6cihLfD18GYds/tFLQQ20KdVEQUMGfLGOXf+Z3nxHAd/cFRuG3SA4aQfDPvnjbrZn2Keoi2hLBO
	lS0H8zYZskkc7G5nT8a/FprAHjGnpt6X8dvaQZC1YJl2/Ma9NMUT8oKwvemvolGFtvNtQPtKw93
	4du9jbu1qQhBBdTDFh1blJirQDyMU5ZY8V4gJlTZe/O3KAp4gjfYW4c23C2NDYYfi2bnTA8Grmh
	sWpjsXdkaFVOZkFL6oZa7E8CHW9gR4Z5SbXpRi0uuVp6Zs1hTjHhlBomP3gvlsg0xEQD
X-Received: by 2002:a05:6000:1606:b0:492:820d:107e with SMTP id ffacd0b85a97d-49c72f7b036mr11142811f8f.47.1794726697760;
        Sat, 14 Nov 2026 23:11:37 -0800 (PST)
Received: from ?IPv6:2a0e:439:8da8:0:158d:3495:cbd4:81c7? ([2a0e:439:8da8:0:158d:3495:cbd4:81c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c8d286480sm26322890f8f.7.2026.11.14.23.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:11:37 -0800 (PST)
Message-ID: <2cc30a3e725639667085f3f82d453a7dfc9f853c.camel@baylibre.com>
Subject: Re: [BUG] iio: st_lsm6dsx: hw timestamp gain is 0 on ISM330DLC /
 LSM6DSL
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, Phil Williams
	 <phil.williams@advisoft.co.nz>
Cc: mario.tesi@st.com, linux-iio@vger.kernel.org, Lorenzo Bianconi
	 <lorenzo@kernel.org>
Date: Sun, 15 Nov 2026 08:11:36 +0100
In-Reply-To: <20261115000940.24215eb0@jic23-hlaptop>
References: <a3a00c75-c830-4d1a-9a89-dd55641a422f@advisoft.co.nz>
	 <20261115000940.24215eb0@jic23-hlaptop>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, 2026-11-15 at 00:09 +0000, Jonathan Cameron wrote:
> On Tue, 10 Nov 2026 02:38:14 +1300
> Phil Williams <phil.williams@advisoft.co.nz> wrote:
>=20
> > Hey Guys,
> >=20
> > I ran into an issue where every FIFO sample from an ISM330DLC came out=
=20
> > with the same timestamp, so our attitude math froze the pitch. The=20
> > accelerometer and gyroscope values were fine. I've patched it locally,=
=20
> > so this is just an FYI.
> >=20
> > Make what you want of it, but here is an AI generated description of
> > the=20
> > issue:
> >=20
> > Commit 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp=20
> > calculation") drops the timestamp scale for the older parts in this=20
> > driver. Stable backport 981f3da383ce is what we hit, in 6.6.142.
> >=20
> > st_lsm6dsx_init_hw_timer() used to do:
> >=20
> > =C2=A0=C2=A0 =C2=A0 hw->ts_gain =3D ST_LSM6DSX_TS_SENSITIVITY; /* 25000=
 ns/tick */
> >=20
> > That commit deletes the constant and reads the gain from the per-chip
> > table:
> >=20
> > =C2=A0=C2=A0 =C2=A0 hw->ts_gain =3D ts_settings->ts_sensitivity;
> >=20
> > ts_sensitivity is only filled in on the entries that already had=20
> > freq_fine (LSM6DSO / LSM6DSR / LSM6DSV and that generation). The=20
> > untagged-FIFO entries have no freq_fine register, so they were left at
> > 0:
> >=20
> > =C2=A0=C2=A0 =C2=A0 LSM6DS3
> > =C2=A0=C2=A0 =C2=A0 LSM6DS3H
> > =C2=A0=C2=A0 =C2=A0 LSM6DSL, LSM6DSM, ISM330DLC, LSM6DS3TR-C
> >=20
> > st_lsm6dsx_read_fifo() still does:
> >=20
> > =C2=A0=C2=A0 =C2=A0 ts =3D data[1] << 16 | data[0] << 8 | data[3];
> > =C2=A0=C2=A0 =C2=A0 ts *=3D hw->ts_gain;
> > =C2=A0=C2=A0 =C2=A0 iio_push_to_buffers_with_timestamp(..., sensor->ts_=
ref + ts);
> >=20
> > With ts_gain =3D=3D 0 every sample is published as ts_ref, the=20
> > CLOCK_REALTIME value taken when the buffer was enabled. The accel and=
=20
> > gyro values are fine. Only the timestamp is stuck. The raw count is=20
> > still checked against 0xff0000 before the multiply, so ts_ref is=20
> > refreshed when the counter gets there. At 25 =C2=B5s/tick that is about=
 7=20
> > minutes. The driver comment says 1.638 s, which is 2^16 ticks, but the=
=20
> > test is 0xff0000.
> >=20
> > How we found it: an ISM330DLC on SPI (whoami 0x6a), on a Toradex Verdin
> > i.MX8M Plus, after moving onto 6.6.142. Userspace integrates attitude=
=20
> > from the delta of the IIO buffer timestamp and treats a non-increasing=
=20
> > timestamp as dt =3D 0, so pitch, roll and yaw froze at the first sample=
.
> > A=20
> > strace of the process reading /dev/iio:deviceX showed the xyz int16s=
=20
> > changing and the 8 timestamp bytes identical across samples. The same=
=20
> > binary against the previous kernel, which still used the 25000
> > constant,=20
> > did not do this.
> >=20
> > Setting the old scale on those three entries fixes it. freq_fine stays=
=20
> > unset, so the trim register is not read and the gain stays exactly=20
> > 25000, which is what those parts had before:
> >=20
> > =C2=A0=C2=A0 =C2=A0 .ts_sensitivity =3D 25000,
> > =C2=A0=C2=A0 =C2=A0 .ts_trim_coeff =3D 37500,
> >=20
> > After booting that kernel the timestamp bytes increment and pitch
> > tracks=20
> > the unit again. The entries that already had ts_sensitivity (25000, or=
=20
> > 21701 on the freq_fine 0x4f part) were left alone.
> >=20
> > Fixes: 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp=20
> > calculation")

This analysis looks correct to me too.
But I wouldn't set .ts_trim_coeff for the parts where .freq_fine is 0: for
those, there is no trimming to be done.
So either set .ts_sensitivity =3D 25000 for all parts that currently don't
have it set, or maybe better use 25000 in st_lsm6dsx_init_hw_timer() as a
fallback value when .ts_sensitivity is not set.
