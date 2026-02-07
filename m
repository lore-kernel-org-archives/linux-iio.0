Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB9F17C211;
	Sat,  7 Feb 2026 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770479207; cv=none; b=ebcGyG8m3XZGOD8gh9REWPd7OrPhiNSo9mVxvdnG3PCvP3mKmWLr/7GOno36h9sfMH6FxfcjuuRYRXITDYxiiUaFrgal3+P3HraXe4+BFqjH0Rb1lJEDd0ZuMfA1X94wzK99k2xEPoSj1cU39cFN77sa5g6S9Y39BFJTuVy5JC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770479207; c=relaxed/simple;
	bh=pxc8YER/A/L2WU4clcfC6MjujovOaGiumZyF4oAJW34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0CcV2R02lD2U92exFYrghQvlQ/J4VforG3JX+G7fFn+2hRO85Ryi8oLkF80IFhhMMayiCcg15EV1jLsuSZfJiti2esKt965m0FyR7xxJHSTmheuO0/Wwa1ot5IrGWQZQP+QYkojvL/BnluSNELqvWKvB3zbC46o8oYa42Q64/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6yPRpXQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6yPRpXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D30C116D0;
	Sat,  7 Feb 2026 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770479207;
	bh=pxc8YER/A/L2WU4clcfC6MjujovOaGiumZyF4oAJW34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X6yPRpXQfJHIeKGBQqNINZsWL8v6NaLW9FU08q4zDQ0z/9dn5wCxMIR3l6zis6tTj
	 VfrgN01L2rxVNTNBgGWzEEcIf0rgsKQ/CdMM+aSyKih5iYZJfsfJ2HqPzu0cNisTFf
	 i9aFBBkcNoIzEtvar54TvW1OLWwLAHg8ijeTFT5Z06bS6OeykDNk4MpDoqby9oN6w6
	 rNG9q1xdy2LWeOd14VIAZ8zqTjHoeaO7slmwdxDoC2fP/i4EIY03cs/wE/JuyqOuzW
	 D45R/j0hn1x2PvQbHF6dwW8PhizUD/m7pxB7oKvrZxYyKiQ088fzzKLKHY5ieYEVMV
	 fqzBRKGau5oNw==
Date: Sat, 7 Feb 2026 15:46:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, Thomas Gleixner
 <tglx@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
Message-ID: <20260207154638.30f3b47b@jic23-huawei>
In-Reply-To: <20260203145856.Rc52LIS5@linutronix.de>
References: <20260113120541.YVf2vRA3@linutronix.de>
	<20260202232741.13380-1-spasswolf@web.de>
	<20260203083826.1gOzxrwt@linutronix.de>
	<476cf5e072259332676c431c19ca3188705a86f1.camel@web.de>
	<20260203145856.Rc52LIS5@linutronix.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Feb 2026 15:58:56 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2026-02-03 11:43:53 [+0100], Bert Karwatzki wrote:
> > Yes, this should call warn_no_thread() when the interrupt is triggered,=
 but
> > I don't know if these sensors are actually functional on my laptop (I'v=
e never
> > tried to use them).
> >=20
> > So I installed libiio-utils from debian and this is the output from
> > iio_info: =20
> =E2=80=A6
> >=20
> > The iio:device* sensors all report 0 for the "offset value", so these
> > sensors are maybe non-fuctional.
> >=20
> >  =20
> > > What did I miss? =20
> >=20
> > I don't think you missed something, but the thread function being NULL =
here
> > could a problem on devices where these sensors actually work. (Or perha=
ps these sensors
> > need to be polled and the interrupts never trigger (?)) =20
>=20
> I only found one handler where the thread handler was NULL and it
> returned WAKE_THREAD. So this _is_ broken.
> Was it one of the driver I mentioned? If so I suggest to fix those
> first. I have no idea how this should work=E2=80=A6
Both the drivers that are called out in this discussion look to
be registering a triggered buffer, but are not using a trigger to fill
it. So they should not be doing that in the first place.

The right fix is either to not use those helpers at all and register
the kfifo directly (so none of the problem infrastructure is used) or
implement a proper trigger / buffer separation by having their interrupt
handlers as the trigger then moving the data reading into the pollfuncs.
At that point there would be a thread here to do that read and we'd
not have the bug.

Jonathan

>=20
> > Bert Karwatzki =20
>=20
> Sebastian

