Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B66221FB6;
	Sat, 14 Feb 2026 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771081251; cv=none; b=m6wQLlvWFEArTXR41bhijYZeDIvcKB6n2MA5NL2ljAcub+DBNmjtYzeXRyJQpv6wqBgxRpMplCtuYlV35InGEloTz7Fu8W50WduJ73ByMuW8mNedTWWJMMS2ehjO7fT71zFBJKiJNEyclP3T4Wil01dGEBmX0RVlhYtL3wsy3Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771081251; c=relaxed/simple;
	bh=Qqif6tztr8r3Sltn2DQnwP37JCCOQ5d7Q2GRL5eElys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/C0ZiHbECf8Px9M9pVucbARZeCeC8+Tg1J2lMV1VGddjff5dw0i39I9W0cnlVgejSYt9jpMfVAf6AAx4ED3K2bXHT+aTjg/JclFUhunIUdg9lHt8jfG7jrFpje8VYr2rgETEUykQi/x5UvJ10ko99uOWqN8wcDlsdybIi9+Xbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obxSIQT3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obxSIQT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68FAC16AAE;
	Sat, 14 Feb 2026 15:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771081251;
	bh=Qqif6tztr8r3Sltn2DQnwP37JCCOQ5d7Q2GRL5eElys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=obxSIQT3N0ZkJNk13g945R0dJ2m1xWJJHCfgWkUWSQizkrly2QxipRJXZOcMzLYNS
	 DC/Q4JMivRFow+aJOlLtvdzz66acPhB52Ttj+8wNZ42TOGQK7i0GYRarnHAhVmtXBa
	 6b9xlovSwW7FTeNWQmXCAOCnFD1GnrlK73ElQ/VwBuNUyhxaKIdTLyig34i4Xo1/vu
	 2hTKtL9j5Serb0oegjxBftX7+V3xyy/A9fSMqmkU3pwizYN4AUOYNu6oRW3ac7ul40
	 bpXxjNyYRfYpLajLoWi/fb8fQkovrHXJabbgt9+EyqmBNYnMQmpn9PBLSwPQpFgnDx
	 iti7ErJICWjQg==
Date: Sat, 14 Feb 2026 15:00:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Sebastian Andrzej Siewior  <bigeasy@linutronix.de>, Bert Karwatzki
 <spasswolf@web.de>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Thomas Gleixner
  <tglx@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
Message-ID: <20260214150042.51a14483@jic23-huawei>
In-Reply-To: <a69abd18ea5a30fdb32478183ad16d9aaacd73a3.camel@linux.intel.com>
References: <20260113120541.YVf2vRA3@linutronix.de>
	<20260202232741.13380-1-spasswolf@web.de>
	<20260203083826.1gOzxrwt@linutronix.de>
	<476cf5e072259332676c431c19ca3188705a86f1.camel@web.de>
	<20260203145856.Rc52LIS5@linutronix.de>
	<20260207154638.30f3b47b@jic23-huawei>
	<a69abd18ea5a30fdb32478183ad16d9aaacd73a3.camel@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 08 Feb 2026 18:00:53 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Sat, 2026-02-07 at 15:46 +0000, Jonathan Cameron wrote:
> > On Tue, 3 Feb 2026 15:58:56 +0100
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >  =20
> > > On 2026-02-03 11:43:53 [+0100], Bert Karwatzki wrote: =20
> > > > Yes, this should call warn_no_thread() when the interrupt is
> > > > triggered, but
> > > > I don't know if these sensors are actually functional on my
> > > > laptop (I've never
> > > > tried to use them).
> > > >=20
> > > > So I installed libiio-utils from debian and this is the output
> > > > from
> > > > iio_info:=C2=A0  =20
> > > =E2=80=A6 =20
> > > >=20
> > > > The iio:device* sensors all report 0 for the "offset value", so
> > > > these
> > > > sensors are maybe non-fuctional.
> > > >=20
> > > > =C2=A0  =20
> > > > > What did I miss?=C2=A0  =20
> > > >=20
> > > > I don't think you missed something, but the thread function being
> > > > NULL here
> > > > could a problem on devices where these sensors actually work. (Or
> > > > perhaps these sensors
> > > > need to be polled and the interrupts never trigger (?))=C2=A0  =20
> > >=20
> > > I only found one handler where the thread handler was NULL and it
> > > returned WAKE_THREAD. So this _is_ broken.
> > > Was it one of the driver I mentioned? If so I suggest to fix those
> > > first. I have no idea how this should work=E2=80=A6 =20
> > Both the drivers that are called out in this discussion look to
> > be registering a triggered buffer, but are not using a trigger to
> > fill
> > it. So they should not be doing that in the first place. =20
>=20
> Replacing with devm_iio_kfifo_buffer_setup_ext() breaks user space on
> laptops as they expect current_trigger. This is not available for
> INDIO_BUFFER_SOFTWARE. Using INDIO_BUFFER_TRIGGERED doesn't help
> without poll function. Still breaks user space. This all works from
> Linux 3.1x in this mode.

Ah ok.  So I wouldn't have gone in this direction in the first
place. Obviously I missed it at the time ;(
Given where we are we can't remove it without breaking backwards compatibil=
ity.
I thought we'd long ago taught userspace to handle devices with untriggered
buffers but as ever with ABI we can never assume that's universal (and maybe
not even common!)  IIRC the reason untriggered buffers became common
was when device with hardware FIFOs came along and the trigger is still the=
re
but never visible to software.  Which is kind of similar to the cases you
are referring to I think.

>=20
> Sensors are powered off till user space writes to current_trigger which
> results in call to .set_trigger_state() via
> iio_trigger_attach_poll_func().=20

With hindsight I'm not sure why we'd do that rather than doing it in the
buffer enable, but we are stuck so that doesn't matter now.

>=20
> Here the hub is pushing data, not pulled to register a thread handler
> and read.
>=20
> So not sure what to add to thread handler other than dummy function.

Yes, let's do that but add a note to it saying that it should not
be copied into new drivers + can we throw a big warning print in the
dummy handler and stop proving a meaningless top half?

We have a few really annoying corner cases where a 'fake' current trigger
is used to switch between types of trigger. This is usually for wiring
up various in device signals rather than having software in the path.
Those would need a different rethink if we get a new one of those.
They aren't common.

Jonathan


> =20
>=20
> Thanks,
> Srinivas
>=20
> >=20
> > The right fix is either to not use those helpers at all and register
> > the kfifo directly (so none of the problem infrastructure is used) or
> > implement a proper trigger / buffer separation by having their
> > interrupt
> > handlers as the trigger then moving the data reading into the
> > pollfuncs.
> > At that point there would be a thread here to do that read and we'd
> > not have the bug.
> >=20
> > Jonathan
> >  =20
> > >  =20
> > > > Bert Karwatzki=C2=A0  =20
> > >=20
> > > Sebastian =20
>=20

