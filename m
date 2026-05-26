Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778633DF00D;
	Tue, 26 May 2026 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799184; cv=none; b=o0in5e6DBM+gJmKqqpFxmoq8h5t1F5rEhPvXN/38btYrMdj6vDcSktTK0gIbfSWB6gGgddgFAtlVvXv8wVqZQ79GlcvEiEPNP8Krqfhg0/OrLfrfJpaFT1cyVhaINkF/b6fNHdQVTXcmNtnZx0607e+FIxK41sqaVMF4lrEn/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799184; c=relaxed/simple;
	bh=1oXwAzM9Y0vH1Ewkzh+zMBqoD+1npCAqc08WWtwA1U4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQWtB0zBvnS86AxKaWjiokxNOOrylpY81ym4mhxABDdzYltHEAqfehvjsrAI5c3E2eHKUvDo2w4e/ABG3ARcBA4wHkHeF9abYFDrhDBianrPcMtH0qEETkMALsOJEh6XKKFxIsp0gW0+/QpXLxeTH63ga41Pa79qAMzd7nQLDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0wjnMtJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0wjnMtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58051F000E9;
	Tue, 26 May 2026 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779799182;
	bh=X2r6Wv50WlPdf2q1g4zKdjGk1hO0rxsfMykQFrXTUtA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a0wjnMtJEDCcm2QR88T7keLtA+cNxZcBixWYBQAbQ55gBzj7eWNoHk12zkduFVWur
	 gB71Xtw7ibx4/ANSjmnO8sf3mjim3sp1hlrryqjyQj1zooTne79KQ709r2VoI2/noR
	 ZsK0GOen6Wt4sYA6kvLMYsBZtIzEN5rh+ADVZ5RL/pJae2oxOeQfYvhzy7kCHfLZmj
	 GF7rzA8CrOT23da/r+Nm07PiI/lFcO3vxVINmy4royNC9KKDrXW9TGZ+umLhAZIKD7
	 JxTz90GDapu9YSsi9Owe//ZnVTVx7NXr+OTpwp80sKhfkBRofj/uly81kUgU2Rxk4r
	 ltIeCngd2xK1Q==
Date: Tue, 26 May 2026 13:39:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Uwe Kleine =?UTF-8?B?S8O2bmln?= <u.kleine-koenig@baylibre.com>, Radu
 Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 2/2] iio: adc: ad_sigma_delta: fix
 clear_pending_event for registerless devices
Message-ID: <20260526133933.61c7444f@jic23-huawei>
In-Reply-To: <SA5PR03MB84250008796EE6F3B5A124DAF70A2@SA5PR03MB8425.namprd03.prod.outlook.com>
References: <20260521-ad_sigma_delta-fix-v4-0-bfb3df3e36da@analog.com>
	<20260521-ad_sigma_delta-fix-v4-2-bfb3df3e36da@analog.com>
	<20260522145143.1e651c12@jic23-huawei>
	<ahBwbklQh9VKkfKZ@monoceros>
	<SA5PR03MB84250008796EE6F3B5A124DAF70A2@SA5PR03MB8425.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 May 2026 12:16:14 +0000
"Sabau, Radu bogdan" <Radu.Sabau@analog.com> wrote:

> > -----Original Message-----
> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > Sent: Friday, May 22, 2026 6:21 PM =20
>=20
> ...
>=20
> > > David raised this on v2.
> > >
> > > This sounds suspiciously like we are in implementation defined territ=
ory.
> > > IIRC if an irq is disabled, whether the interrupt is latched is down
> > > to whether the irq controller happens to do so. There is no hard rule=
 on this
> > > or way to detect whether it will or not.
> > >
> > > =20
> > https://lore.kernel.org/all/io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfr
> > s3rz2a2@orquwgflrtyc/ =20
> > > Was I think the most recent detailed thread on this.
> > >
> > > Uwe - you were driving that discussion can you sanity check what we h=
ave
> > > here if you have a moment?  Thanks! =20
> >=20
> > Without having looked at the code but skimmed through the old discussion
> > again, the result back then was that you won't get reliable behaviour
> > without rdy-gpio.
> >=20
> > I didn't try to understand what's different fro "registerless devices",
> > but I doubt this implements a robust solution.
> >  =20
>=20
> Hi everyone,
>=20
> Thank you so much for looking into this. The concern about IRQ latching i=
s valid,
> and after looking more carefully at this I can see the commit message exp=
lanation
> is simply wrong.
>=20
> IRQ_DISABLE_UNLAZY I think actually does the opposite... it causes immedi=
ate hw
> masking when disable_irq_nosync() is called, precisely to prevent spuriou=
s interrupts
> from MISO.
I'd modify this a tiny bit.
Perhaps read that thread above again.  The understanding I took away at the=
 time is that
IRQ_DISABLE_UNLAZY is just a performance trick to get into a useful state i=
f you
think something is likely to happen - it's not a tool to use to make functi=
onal
changes or constrain the handling.

> So the claim that it "keeps the hardware IRQ line unmasked while
> software-disabled" was backwards. However, as Jonathan says this is imple=
mentation
> defined territory, but perhaps the comment and commit message could still=
 be corrected.
>=20
> But, I think return 0 could still be safe, devices with rdy-gpios use tha=
t, the ones without
> but with registers use the status register and the others which have neit=
her (in our case
> ad7191, ad7780 and max11205 as far as I can tell) could safely use return=
 0 branch from
> here and this is why I think its safe:
>=20
> - ad7191: CS is the PDOWN pin - deasserting it powers down and resets the=
 device. By the
> time clear_pending_event() is called at the start of a new conversion, th=
e device has been
> reset and there should not be any stale result to clear.
> - ad7780 (with powrdown GPIO): same - device is powered down between conv=
ersions.
> - ad7780 (without powerdown GPIO) and max11205: both are continuously-con=
verting ADCs
> that cycle ~DRDY at their output data rate regardless of whether the prev=
ious result was read.
> The next conversion's falling edge fires naturally.
>=20
> One limitation still remains (beside the risk of missing a sample for the=
 last case): a future
> registerless device (has_registers =3D false) that holds ~RDY asserted un=
til data is read would
> need either num_resetclks set or a rdy-gpio. Perhaps a comment would be u=
seful here.

Agreed.  There is a pitfall here that we should definitely label!  I'm fine=
 with the change
I think as long as it's backed by some extra 'breadcrumbs' for anyone wonde=
ring how this
all works in future.

Thanks

Jonathan
>=20
> With Best Regards,
> Radu

