Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A5377A81;
	Thu, 16 Jul 2026 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220714; cv=none; b=g0jEsUbP7seYs35CeR5Nwhtwc4evV3ikZ3O6guBsL6aoVXcoJ6Z02dyWtNTVHw5daBo80mq8X+1qhQZ1ED20H4mjubPzB+cQq5XGdPLjADnInZlERVlhcnIJ/Rhc1k+ImdxHXNAM6p/gAtTbFCt85vX0XpaLqnrUfJ1EsyffIfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220714; c=relaxed/simple;
	bh=++4fSZ1b0TlFbEN6k2dLgetUrAGI7Nl1H5eauj/9Sow=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G37DmHC8WircChC/Mhr6YeIvCyJHq/5HMXNYdaBrO8TdGXKUUKQV2iPjOJ5R/sz83pr6cOHmq3cxCJcepstef/Rcc6HX+07nt7YTZKoBm3UwJkj9cuqPU1+vWtv9sqyc511IfgUfmAVfZHxjgnuWMdc5qp3kPqmjd9Qw79xeS8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=xyFoVDBH; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="xyFoVDBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784220699; x=1784479899;
	bh=qrb8hC/Y3Qak286c4lrbAZTCd38DaMdKc9tpip4M5II=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=xyFoVDBHNJjyrxn4RzxLEp59uo97V2wc5fzOFStV2tu0n9jlO5rabRzlYlk78KVvT
	 7jtRWKcvywAfZ0xkPbXWEMyWqYla5mDv4obQEAi0bADP90alGovaudJPnYeyLrA9fo
	 +Xdv0VfnYGRMOzZ6GM8630wE/HJfIHx1+D6oIjfkJFFKNOpefNb2gsElbi1FOvQRL1
	 EsLLqpIY/c9RgifYaZmxFliC2HF+CpzXqTefU4FoPG2bbs4AZsW9m0X8X8XoCBMVQ+
	 7VLo2FiLttwE6/jZjQ5ZuwL46udaSsAy52MtpNeTD/+HfCbNrAXczOc6uXrxui42Rl
	 SvZdf2/SeV/Mw==
Date: Thu, 16 Jul 2026 16:51:34 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>
From: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: mma8452: Allow open drain interrupt pin configuration
Message-ID: <J2apVLUJhrI3AOweGpouqGGB0XhxbcqLiWasDpOdm4d2YGgNv8PuE-udUGJZcH0z-V9yyqbjIwMKDdtuam0mp6ya5F6GHUzf6OjRCo0GdaA=@geanix.com>
In-Reply-To: <alefh86sqW-XvLHl@ashevche-desk.local>
References: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com> <20260715-mma8452-open-drain-v1-2-b1dd2a440c60@geanix.com> <cA7m1VgJxkr39GAxpnMPw9PVIKX2TR8Ju4Q0m6L2SxS_jJNITfZ6AA5LOeMIK0jGFXaUptY1_vPhDd_imWw5FQ==@protonmail.internalid> <aldH3vtk_eKh6oCC@ashevche-desk.local> <87ldbco582.fsf@geanix.com> <Tu8Mavh-mfl8Vv75Oab3vrghtEbTXiYPZ4qhj6RZv8xe5nWKP4lG1KSuJXEQfyKeio7zv9myLbmifMjFTl8juA==@protonmail.internalid> <aleQVYrK9YBoLqGl@ashevche-desk.local> <874ii0misv.fsf@geanix.com> <alefh86sqW-XvLHl@ashevche-desk.local>
Feedback-ID: 133791852:user:proton
X-Pm-Message-ID: ecf190f24607daa5641d0f141b74fa32cb0368f8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, 15 July 2026 at 16:56, Andy Shevchenko <andriy.shevchenko@int=
el.com> wrote:

> On Wed, Jul 15, 2026 at 04:25:20PM +0200, Esben Haabendal wrote:
> > "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
> > > On Wed, Jul 15, 2026 at 01:35:41PM +0200, Esben Haabendal wrote:
> > >> "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
> > >> > On Wed, Jul 15, 2026 at 10:07:39AM +0200, Esben Haabendal wrote:
>=20
> ...
>=20
> > >> >>  =09if (client->irq) {
> > >> >>  =09=09ret =3D request_threaded_irq(client->irq, NULL, mma8452_in=
terrupt,
> > >> >> -=09=09=09=09=09   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > >> >> +=09=09=09=09=09   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> > >> >> +=09=09=09=09=09   data->open_drain ? IRQF_SHARED : 0,
> > >> >>  =09=09=09=09=09   client->name, indio_dev);
> > >> >
> > >> > Why do we care?
> > >>
> > >> Care about what exactly?
> > >
> > > About exclusivity of the interrupt.
> >
> > Ok.
> >
> > >> We need to add IRQF_SHARED flag in order to allow shared interrupt, =
and
> > >> we should not add it when using (the default) push-pull mode.
> > >
> > > Why not? How would it make any difference from SW perspective?
> >
> > Not adding the IRQF_SHARED flag prevents use with shared interrupts. I
> > think we are on the same page on that.
> >
> > Unconditional adding IRQF_SHARED flag would allow configurations where
> > other devices share interrupt line with mma8452 compatible chip
> > configured with push-pull, resulting in broken or unpredictable results=
.
> > I don't see why we should not care about that.
>=20
> But it's not their problem! If it's this device that prevents this
> configuration, it should have a check. With this code it just hides
> and changing a DT property will lead to kernel warning.

The chip such does not prevent the configuration, and does not prevent
sharing the interrupt. The irq pin in the device can be configured in eithe=
r
push-pull mode or open-drain mode.
In order to allow sharing interrupt line with other chips, the chip
must be configured with irq pin in open-drain mode, which is what the
drive-open-drain device-tree property I am adding in this series enables
developers to do.
If/when you add this property to the device-tree, the irq pin will be
in open-drain mode, and the IRQF_SHARED flag can (and should IMHO) be set
as the interrupt line can be shared.
If/when the drive-open-drain property is not set (existing device-trees
and current only supported behavior), the chip cannot support sharing the
interrupt line, and adding the IRQF_SHARED flag would be a bug, as the
chip irq pin requires an exclusive interrupt input.

Maybe the confusion is caused by the fact that the drive-open-drain
does not describe how the irq pin IS behaving, but rather how it SHOULD
behave, and possibly required because of the HW designed having tied the
irq pin to an irq input together with other irq sources.

> > > Yes, I understand the HW case.
> > >
> > >> > The (hidden) problem this will have in the future is that the IRQ =
core
> > >> > will splat a warning in case that other shared IRQs might be
> > >> > configured with different flags. Putting that flag conditionally m=
akes
> > >> > it a mine field for the users. Instead just unconditionally add th=
at
> > >> > flag and we will get reports as soon as there will be a user that
> > >> > shares the same interrupt pin with some other devices which driver=
s do
> > >> > not use the same settings.
> > >>
> > >> If we add the IRQF_SHARED flag unconditionally, it will be set also =
when
> > >> push-pull mode is enabled. I don't see how the kernel will be able t=
o
> > >> notice that that is not going to work. If you have another device th=
at
> > >> uses IRQF_TRIGGER_LOW|IRF_ONESHOT|IRQF_SHARED, it will not work with=
 the
> > >> MMA8452 device when configured as push-pull.
> > >
> > > Right, and why do we care (again)?
> >
> > Why we care that the system as a whole (SW on top of HW) will not work?
> >
> > If we don't care about that, why do we even have this IRQF_SHARED flag?
> > The only purpose of that is to tell the kernel that this particular
> > device / interrupt will work with shared interrupt or not.
> >
> > Isn't that exactly what I do with this change? Nothing more, nothing le=
ss.
> >
> > > It's pure DT/FW/HW issue, not an SW issue.
> > > Otherwise it will become a carefully placed mine for the poor user wh=
o will
> > > use these flags and try to share an interrupt with the mma8452 device=
 which
> > > has no set property and uses push-pull mode.
> >
> > I don't get how you see it like that. Adding IRQF_SHARED unconditionall=
y
> > would create exactly the mine field you are talking about. Poor users
> > can specify a system configuration (DT) that tries to use a shared
> > interrupt line, but configures the mma8452 compatible chip in push-pull=
.
> > The poor user will not only be poor, but also unhappy.
>=20
> > By applying the IRQF_SHARED dynamically, the kernel will be able to fai=
l
> > in a controlled manner instead, making it much less painful to create a
> > working system configuration (DT)
>=20
> And my point that we need to make less painful runtime experience.

Yes. We agree on that.

But I do believe that my patch is that painful runtime experience.

Adding IRQF_SHARED flag when irq pin is configured in push-pull mode
will be painful. I know, that was my initial approach. Does really not
work, and can lead to wasting time on debugging the HW.
=20
> > Going back to your poor user story above, if the poor user tries to
> > share the interrupt pin with the mma8452 device, it will get an error
> > (just as it is with the kernel today). The device does not support
> > shared interrupts. Reading the DT bindings documentation, the user
> > should be able to find the drive-open-drain property, and add that to
> > the device-tree to make things work. Maybe even consider if that is
> > compatible with the hardware being used.
> >
> > If IRQF_SHARED was set unconditionally, the user would not get an error=
,
> > but most likely would get a system where no irq's were raised for the
> > other chips. I sincerely believe that debugging this is much more
> > painful than reading device-tree bindings.
> >
> > > Did I miss anything?
> >
> > I don't know. Maybe I am missing the obvious here.
>=20
> I consider the case when shared interrupt is enabled on both devices, but
> second one (driver) missed the same IRQ flags. This becomes a warning in
> IRQ core.

Missed which IRQ flags?

> Shared interrupts it's also a contract with all stakeholders on keeping
> the same flags for all devices.

Of-course.

And adding IRQF_SHARED is a contract that says that the interrupt can be
shared. I can only see that it would be a bug to add that flag in cases
where we know that the interrupt really cannot be shared.

As for the IRQF_TRIGGER_LOW flag being set, I think that looks correct
as long as we do not support switching to active high irq polarity.

But on that topic, the chip actually supports selecting between active
low and high irq polarity. Should we implement something along the lines
of what is done in smi330_setup_irq() in iio/imu/smi330/smi330_core.c?
And thereby allow using the device with active high irq?

> ...
>=20
> After looking into genirq code I don't see other way how to handle this.
> It looks like we need to address the TRIGGER_LOW first, in other words
> we need drop that flag when IRQF_SHARED is set, and leave it to users
> to setup IRQ trigger properly on all sides.

Why do we need to drop the IRQF_TRIGGER_LOW flag because IRQF_SHARED is
set?

Users as in those specifying the system device-tree?

/Esben
