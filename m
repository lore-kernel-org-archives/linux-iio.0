Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794701386;
	b=civ3F3RtdY5KmicTzEDHVMSlgh2INwpJSmP6cmHIfQucm3XMmfaFhxJ6CsWBGiJ8L7/r
	 jh14pWkVnuIpx4Igrv5eTXUPkwmKFPx7jzLg+loEHA6I7b1skHPCK0yj4iOgC1a9Klk4O
	 l+35dX/RPSArXnX3AS7TFPYOXAz4ghBLstuUUcTnH195A/mo2HquIwxADwDhdg/QPXroy
	 ShmMJ/FOnG96vFgI7+i/4hCaPJEG/kmx7ZbIfzz5e0r9ED7DhPlVOLu+PPvgnSA3NqaPw
	 +OT8TmVHjCwmjgsSZAc9ObQ0tfSsawAdbjYdRJfOky3fIkjoWJl0H55Hw0nazM2YeNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794701386;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=izQ3LTcjPztPSrKh9NSj6gH6qw/V5paTXQ/68o2St7Q=;
	b=aG6CEOL1t+AZpDxCH0a4ID9HWUpuE/DYHGagJbYTsLSGDe3PW6uEukICy1cTHXzsJo+e
	 mYgIsqmNma7SJAIM701QunjsIV1DeijbDBnPGSIMGzDw2dfcMWmwuUCCPOtxo7UKjxfRL
	 9FbKrYpnniHPrZvcjp0aJQ6S1FFpiP6FdtmtTxoQRzUlKPZz9/4v6uBowEgHP621AdSjT
	 +d42sLVNN2+XqKWrnR3HezWLl5yn6k+QS/a20K2S8TamLxYDqUXC4n3Saa4ekpAbtYdPi
	 upV/yAlWQxMJM3weXM2qG9bKUPpmdYilMzJHD2odrtpIQK0HFfsuDCTI6+JyhOwyTnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1o3sOxc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6A606A329
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1o3sOxc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59631F000C4;
	Sun, 15 Nov 2026 00:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794701385;
	bh=izQ3LTcjPztPSrKh9NSj6gH6qw/V5paTXQ/68o2St7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e1o3sOxc3EUAho3mJ+0poUUfGiSmNvTdfRjwMgATnCVubZ/ov4+ej0wCyfJNZZvKh
	 9+ywJ/6oEA3bBAJTQq9d3L718qJ/j23US2kA2QPtEavRAb3GBtajy1FhNvRCq2/oNK
	 ldHwCCXbk6vpIEGZGofqLJfkf+NTe4wDEXlRCiFfyD1X10NJnpLLYaKfElFdB0suJx
	 TL8SfhPuj1HSZHrL4Ra9mkZmnLlMjQ2SOdHm/j/09ODdZRY4nO5wQi2tEBUpQMSE1J
	 U467RZ+9Dq+lUKSTJ12rklamQiAd5t+etfAGtS3DgPesN254QQtEb1i+aIFPggU/S+
	 DF9TQsevDf2HQ==
Date: Sun, 15 Nov 2026 00:09:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Phil Williams <phil.williams@advisoft.co.nz>
Cc: mario.tesi@st.com, linux-iio@vger.kernel.org, Francesco Lavra
 <flavra@baylibre.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [BUG] iio: st_lsm6dsx: hw timestamp gain is 0 on ISM330DLC /
 LSM6DSL
Message-ID: <20261115000940.24215eb0@jic23-hlaptop>
In-Reply-To: <a3a00c75-c830-4d1a-9a89-dd55641a422f@advisoft.co.nz>
References: <a3a00c75-c830-4d1a-9a89-dd55641a422f@advisoft.co.nz>
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

On Tue, 10 Nov 2026 02:38:14 +1300
Phil Williams <phil.williams@advisoft.co.nz> wrote:

> Hey Guys,
>=20
> I ran into an issue where every FIFO sample from an ISM330DLC came out=20
> with the same timestamp, so our attitude math froze the pitch. The=20
> accelerometer and gyroscope values were fine. I've patched it locally,=20
> so this is just an FYI.
>=20
> Make what you want of it, but here is an AI generated description of the=
=20
> issue:
>=20
> Commit 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp=20
> calculation") drops the timestamp scale for the older parts in this=20
> driver. Stable backport 981f3da383ce is what we hit, in 6.6.142.
>=20
> st_lsm6dsx_init_hw_timer() used to do:
>=20
>  =C2=A0 =C2=A0 hw->ts_gain =3D ST_LSM6DSX_TS_SENSITIVITY; /* 25000 ns/tic=
k */
>=20
> That commit deletes the constant and reads the gain from the per-chip tab=
le:
>=20
>  =C2=A0 =C2=A0 hw->ts_gain =3D ts_settings->ts_sensitivity;
>=20
> ts_sensitivity is only filled in on the entries that already had=20
> freq_fine (LSM6DSO / LSM6DSR / LSM6DSV and that generation). The=20
> untagged-FIFO entries have no freq_fine register, so they were left at 0:
>=20
>  =C2=A0 =C2=A0 LSM6DS3
>  =C2=A0 =C2=A0 LSM6DS3H
>  =C2=A0 =C2=A0 LSM6DSL, LSM6DSM, ISM330DLC, LSM6DS3TR-C
>=20
> st_lsm6dsx_read_fifo() still does:
>=20
>  =C2=A0 =C2=A0 ts =3D data[1] << 16 | data[0] << 8 | data[3];
>  =C2=A0 =C2=A0 ts *=3D hw->ts_gain;
>  =C2=A0 =C2=A0 iio_push_to_buffers_with_timestamp(..., sensor->ts_ref + t=
s);
>=20
> With ts_gain =3D=3D 0 every sample is published as ts_ref, the=20
> CLOCK_REALTIME value taken when the buffer was enabled. The accel and=20
> gyro values are fine. Only the timestamp is stuck. The raw count is=20
> still checked against 0xff0000 before the multiply, so ts_ref is=20
> refreshed when the counter gets there. At 25 =C2=B5s/tick that is about 7=
=20
> minutes. The driver comment says 1.638 s, which is 2^16 ticks, but the=20
> test is 0xff0000.
>=20
> How we found it: an ISM330DLC on SPI (whoami 0x6a), on a Toradex Verdin=20
> i.MX8M Plus, after moving onto 6.6.142. Userspace integrates attitude=20
> from the delta of the IIO buffer timestamp and treats a non-increasing=20
> timestamp as dt =3D 0, so pitch, roll and yaw froze at the first sample. =
A=20
> strace of the process reading /dev/iio:deviceX showed the xyz int16s=20
> changing and the 8 timestamp bytes identical across samples. The same=20
> binary against the previous kernel, which still used the 25000 constant,=
=20
> did not do this.
>=20
> Setting the old scale on those three entries fixes it. freq_fine stays=20
> unset, so the trim register is not read and the gain stays exactly=20
> 25000, which is what those parts had before:
>=20
>  =C2=A0 =C2=A0 .ts_sensitivity =3D 25000,
>  =C2=A0 =C2=A0 .ts_trim_coeff =3D 37500,
>=20
> After booting that kernel the timestamp bytes increment and pitch tracks=
=20
> the unit again. The entries that already had ts_sensitivity (25000, or=20
> 21701 on the freq_fine 0x4f part) were left alone.
>=20
> Fixes: 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp=20
> calculation")

Hi Phil,

Thanks for the analysis. Looks correct to me.

I've added Francesco (who was most recently active with this driver in a non
trivial way) and Lorenzo who is the listed maintainer.

If you are happy to spin a patch making the change you propose that might
be the quickest way to get this fixed upstream and the fix on its
way to a new stable release.

Thanks,

Jonathan

>=20
> Regards,
> Phil Williams
> Principal Software Engineer
> Advisoft Ltd
>=20

