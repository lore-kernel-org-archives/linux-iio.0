Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5339FCDD;
	Mon, 11 May 2026 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505166; cv=none; b=EeYYucUdrzt/lzMQ9pj5vh2TNNPUbAOJgjUB7JLrE2546hqZ8yeT61QmPypj+qpns/0X4nUmBDMyIv2bY99Jwr/5SHqOdRd6o392k6Ug2eVUTQeotW69u3gmdS9yqb5g0Zrzitu6t0gI17zD7Sm6NlwzX0srBhqp/fNvbM+D4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505166; c=relaxed/simple;
	bh=azhEcK3CzLIBI/xHlHKXiniGfzjwNcNM8oLqK+NOX8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwdWbEiduVksxbqadw3XeU9Doo6cdVLn5wdt/BlONHVeFNU8dN8f3Bf25eWyWZ/AqEBvWDKQwggXEeghoIayrmjO+5YGgVE0iKQAqTI2rRkk6y+r4qLhQ0br9gppcw0ITDsrfJoRUPMnifyLXVod/WVYk4j6z2ixAEortdtQQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZb+u+EZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZb+u+EZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0F1C2BCB0;
	Mon, 11 May 2026 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778505166;
	bh=azhEcK3CzLIBI/xHlHKXiniGfzjwNcNM8oLqK+NOX8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aZb+u+EZVPcZVdOBGTSGj0T5Xr84Ntjx25BWKE/Qzl1DbUYReDq4V2MwCn3wKEeuc
	 7UCht0xULs64bP3TTnATBrWuvuXW4H6xnYhGwEKG30N9eh0fDRlpryoyFZLbgPqEDW
	 jcz/FThLx1M5UcU/e1WhXFa3NpR9h4m/ggoFJu3Xrgb5qGwIgRcQ3XbRk2V2iRqyDA
	 6uMpJ8pRcYaJV3yHaFiR7C7SLSNb0Uz32d7uUv3xS1gsmTQZLsY0nvYkoLHNKLbVHm
	 GRcjUSjXuxHDesArHGQUNctuFSvAyq1jP/DL0uBCKrhm8QbIFx2LQ+EGyRpnfyj51k
	 RmCbed/OVVKXA==
Date: Mon, 11 May 2026 14:12:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Nuno
 =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed
 resources
Message-ID: <20260511141237.344a387e@jic23-huawei>
In-Reply-To: <CALoEA-wqzLknSsj-ijzn3LsX7euiJTHcqsVbA7y7LoYiWoT34A@mail.gmail.com>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
	<20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
	<0a3e455c86cef14fe3481019031ebf04f98470f7.camel@gmail.com>
	<af9rpWwL-rdwmQYJ@ashevche-desk.local>
	<CALoEA-wqzLknSsj-ijzn3LsX7euiJTHcqsVbA7y7LoYiWoT34A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 09:04:43 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sat, 9 May 2026 at 19:15, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Sat, May 09, 2026 at 10:03:38AM +0100, Nuno S=C3=A1 wrote: =20
> > > On Thu, 2026-05-07 at 16:35 +0200, Joshua Crofts via B4 Relay wrote: =
=20
> > =20
> > > > Switch the driver to use managed resources (devm_*) which simplifier
> > > > error handling and allows removing ak8975_remove() method from
> > > > the driver.
> > > >
> > > > Note, on error path we now also set mode to POWER_DOWN state which =
is
> > > > fine. Even if the device is in that mode, there is no problem to set
> > > > that mode again, it should be no-op.
> > > >
> > > > Additionally, remove any pm_runtime_get/put*() function calls that
> > > > dummy cycled the counter to autosuspend the device. =20
> >
> > ...
> > =20
> > > Maybe it would make sense to move this before devm_iio_device_registe=
r(). At the
> > > point we register the device, userspace can start to interact with th=
e device where
> > > we have pm calls? Not that it is a problem (I think) but makes sense =
to me to enable
> > > PM before exposing the device. =20
> >
> > When you called devm_iio_device_register(), it's already user space int=
eraction
> > there, so device has to be prepared for that. Do we guarantee that devi=
ce is
> > power enabled at that point? =20

We should guarantee a couple of things.

1) If runtime PM is not turned on at all  - maybe not even built into kerne=
l.
   The power should be on.  Note that has nothing to with devm_pm_runtime_e=
nable()
2) Any calls that do need the power on and occur after or or in parallel wi=
th
   runtime PM being enabled ensure they have asked for the power to be on. =
 =20

Should all be race free if that combination is true.

Jonathan

>=20
> Okay, I'm all for moving devm_pm_runtime_enable() before
> devm_iio_device_register(),
> it makes sense to set up pm_runtime before opening the driver to
> userspace. I'll push
> out a (hopefully final) fix today so we can wrap up this series.
>=20

