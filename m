Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7D1E5B9A;
	Sat,  6 Jun 2026 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780754989; cv=none; b=oUBE1OCp483CjgeOKEQQlF4J4nCbF8Kps+rZ0HDwsAV7DK+M9IEiEhNVsNdw7GEGWkllw/Knc6roPGxLtPwnUEXz1i4E4aWocCMkemeWWDYhVYwM/wCG9Vv8TWUbn4Ao9sLu6FXXjHlESARzyMke5fk9vsXeXVgNH1StwV/qukQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780754989; c=relaxed/simple;
	bh=mn2d46eRNCvD8lBaGB3kHS/0Ea4JwBG9jj0Fx3W+Wzs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZulWfa/xYMAR/gfrsjbfNc+BBNq/Fsve04q/GDFYj+hMXgVLYLI5Zha3BzB4fPyCFUYBrsgkZ23pAKocNAqaF3vHHCbbMWNit+Nl+V0TPhweGlY5EnvLtR+0wvFbWCX4lJzRF5lsuUB/F/k4+BZskebqhlSIncx+L6PMOf/5L2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFZ8B7kj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFZ8B7kj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537461F00893;
	Sat,  6 Jun 2026 14:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780754987;
	bh=2hPouMqkZK7bjDzEDxYsjG/pLKOpQKgeThW8vausu58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eFZ8B7kjd7PxQZ634ZzIwe07qYxkM0NXAOeuTCHeyfbHgddTZhdy0ek5NDSdRWWoV
	 /1uow3/8xmOtiK6WkUaXJIXOoA5bI2+e43MUM4iD+RzSnVhRkooxVPVBdLwAbDLzGj
	 TmPGi1eyZZorWfN2TpT4hImNoAsjhJ6xvwD0HZCNCXk0HotKTBP+CfqofH5+yI5lsr
	 /7Ouy/rU+1F2XJj/cdqDrEnn+JFMz36kbwn2oxog4pBhTG0qTGBm9RQqco8bCz+atT
	 jEVnw58LmmskLWuOdgh00b9ncgOadteqWMAGTBmz2VNlvBta9F0qMMefrF1ZL3ysNs
	 EN+ipty3noCpg==
Date: Sat, 6 Jun 2026 15:09:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 8/8] iio: tcs3472: implement wait time and sampling
 frequency
Message-ID: <20260606150939.72974703@jic23-huawei>
In-Reply-To: <8392f8a6-719e-43d9-813a-0a163f450ed8@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
	<20260522123420.45495-9-aldocontelk@gmail.com>
	<9c0bec93-e102-4655-8074-fd544b16d912@gmail.com>
	<8392f8a6-719e-43d9-813a-0a163f450ed8@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 6 Jun 2026 11:27:16 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

> On 04/06/26 11:23, Aldo Conte wrote:
> > On 22/05/26 14:34, Aldo Conte wrote:
> >  =20
> >> =C2=A0 static int tcs3472_req_data(struct tcs3472_data *data)
> >> =C2=A0 {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int tries =3D 50;
> >> @@ -166,16 +214,131 @@ static int tcs3472_read_raw(struct iio_dev *ind=
io_dev,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D 0;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val2 =3D (256 =
- data->atime) * 2400;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IIO_VAL_=
INT_PLUS_MICRO;
> >> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SAMP_FREQ: {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int cycle_us =3D =
tcs3472_cycle_time_us(data);
> >> +
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcs3472_cycle_to_freq(cycl=
e_us, val, val2);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IIO_VAL_INT_PLUS_MI=
CRO;
> >> +=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0 }Hi Jonathan, =20
> >=20
> > One more thing on v4 before I send it.
> >=20
> > For Sashiko's "tries too short" finding, I made the timeout dynamic
> > based on the actual cycle time:
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0cycle_us =3D tcs3472_cycle_time_us(data);
> >  =C2=A0=C2=A0=C2=A0=C2=A0timeout_ms =3D max(1000U, (cycle_us * 2) / USE=
C_PER_MSEC);
> >  =C2=A0=C2=A0=C2=A0=C2=A0tries =3D DIV_ROUND_UP(timeout_ms, 20);
> >=20
> > 2 * cycle_us gives some safety margin, and the 1-second floor keeps
> > the original behavior on default configurations.
> >=20
> > This solves the timeout issue but introduces a new concern:
> > tcs3472_cycle_time_us() reads data->{enable,wlong,wtime,atime}
> > without holding the lock, both here and in the SAMP_FREQ case of
> > read_raw() (also flagged by Sashiko).
> >=20
> > For the SAMP_FREQ case I'll just add guard(mutex)(&data->lock)
> > before the call:
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0case IIO_CHAN_INFO_SAMP_FREQ: {
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int cycle_us;
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard(mutex)(&data->lock);
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cycle_us =3D tcs3472_cycle_=
time_us(data);
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcs3472_cycle_to_freq(cycle=
_us, val, val2);
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IIO_VAL_INT_PLUS_MIC=
RO;
> >  =C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > For tcs3472_req_data() I plan to use scoped_guard() only around the
> > cycle_us computation:
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0scoped_guard(mutex, &data->lock)
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cycle_us =3D tcs3472_cycle_=
time_us(data);
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0timeout_ms =3D max(1000U, (cycle_us * 2) / USE=
C_PER_MSEC);
> >  =C2=A0=C2=A0=C2=A0=C2=A0tries =3D DIV_ROUND_UP(timeout_ms, 20);
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0while (tries--) {
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> >  =C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > Could this be ok?

If this races with an update can we end up with too short a dynamic timeout?
I.e. what happens if that time changes - is the current read cycle completed
with old timing and it only affect the next one, or is it super simple and
the affect is immediate - maybe changing some threshold on a counter that
is used to trigger / stop the acquisition?

I would not expect us to either be able to rely on particular behaviour or
find it documented anywhere.  So two options.
1) Lock around the retry loop
2) Set the retry max to the worse possible case if that's not insanely long.
   Give the polling should exist early anyway it shouldn't make a practical
   difference and is always long enough.   I think the max is about 7 secon=
ds? That's
   rather long to hold a lock for, but should never apply if real timing is=
 a
   microseconds.  This would be my preference as it's simple.

Only remaining thing to check is there is nothing in the datasheet to imply=
 it
is unsafe to change the timings during a capture - as if that were the case
stronger locking would be needed.

> >=20
> > Thanks,
> > Aldo =20
> Hi Jonathan,
> do you have any updates on this idea?
>=20
> I have already implemented it and it seems to work.
>=20
> If you agree, I am ready to submit the v4 of the patch.
>=20
> thanks,
> -- Aldo

