Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7D35C685
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743601; cv=none; b=ilEtoubNVH9fxl9W0ZeADa9HWnkcwC2EASQU6WTI9xizF9DFPijOjSaQGU5BRWxt/lBSzj4iNsc9+SNsQW6qsUGiNvYWlonRPN1S5occ9RDCkFme4O5317DQ4CZ9wy2rSXjcIb5e7TL/RhbRJ9L+W64sMk5F5j+9YT0xhZZfZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743601; c=relaxed/simple;
	bh=KtTprRU7XIUZdYx9ZjW0dJMuO4bbCKQiA4GIAAuTyT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r5xOtCj1MsF6J2CVWzcpy3t8cMRv0M9c0WYik4tR+7Q9qBSIZDhxDhOnEYqFu44ocS5is6MRtwKX8CZp7218MPCU57uZp8Mn4CtwXeVOeGOkJMDbd+Z3/P22qOrNzueDMV0TQz/uZAe3VYsvvmcbawCqS3+KL8jmi84q9XklHzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=SDpt/Z6L; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="SDpt/Z6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785743586; x=1786002786;
	bh=xDbxnHEz4eNauYSycQwwlngVIilUgbo8t6kf0UFuNQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SDpt/Z6LGYyMqnVdm+R4GJq0E5J5ARtm1t8nOX9zWzercV5phUpahPAmkecxyHUnh
	 6QkwIoWnkA2P1XKmFER1XZff+qNuoOGnHyJPlppnCkVD4OS0kwIug9nkqSsqtSDWB+
	 upa1+lWU8HqgsXDSqazRe/pgmgwObyrmkWXCW2Lw9xJtlyhcI/fKcdUdaokWXiou8T
	 hIQLZwz0sIgkxuak6AwyydlYJGpKTQA8NKtMhyXjIttx6eLrAfV/KYqfvT4VOi14H7
	 iB6PBDdFKwJ9wiQ9YVPTNr/S0mSGLfhMdV7t0/mFezR6Bi49JAUpQ66iqfU5/Udi2j
	 G5ikMcnyQSfnQ==
X-Pm-Submission-Id: 4hD86k58xxz2ScNC
From: Esben Haabendal <esben@geanix.com>
To: "Jonathan Cameron" <jonathan.cameron@oss.qualcomm.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>,  "Lars-Peter Clausen"
 <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Martin Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer"
 <sean@geanix.com>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
In-Reply-To: <20260719023035.2380e8df@jic23-huawei> (Jonathan Cameron's
	message of "Sun, 19 Jul 2026 02:30:47 +0100")
References: <aldH3vtk_eKh6oCC@ashevche-desk.local> <87ldbco582.fsf@geanix.com>
	<Tu8Mavh-mfl8Vv75Oab3vrghtEbTXiYPZ4qhj6RZv8xe5nWKP4lG1KSuJXEQfyKeio7zv9myLbmifMjFTl8juA==@protonmail.internalid>
	<aleQVYrK9YBoLqGl@ashevche-desk.local> <874ii0misv.fsf@geanix.com>
	<alefh86sqW-XvLHl@ashevche-desk.local>
	<J2apVLUJhrI3AOweGpouqGGB0XhxbcqLiWasDpOdm4d2YGgNv8PuE-udUGJZcH0z-V9yyqbjIwMKDdtuam0mp6ya5F6GHUzf6OjRCo0GdaA=@geanix.com>
	<nnp75d8J8In8paKGfojb_WdiRMfnz84lOlzz_LBKVsxDzR3fG7Y5Mn91q6P4BF2LetfZS7da2SeqGhpiLUOE-A==@protonmail.internalid>
	<alkgZTnHyvEasMCk@ashevche-desk.local> <877bmtsu1h.fsf@geanix.com>
	<alpqq3zhSS_iYGJq@ashevche-desk.local>
	<nlzE8HA1b2C6D9P6L63VNtKUWaXbUTxoJB5c3K4eFLIrEkoV_2CDQNp50cj2ILfMni0Rjz94guWdLadq2ewdHw==@protonmail.internalid>
	<20260719023035.2380e8df@jic23-huawei>
Date: Mon, 03 Aug 2026 09:53:01 +0200
Message-ID: <87tspb63oi.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jonathan.cameron@oss.qualcomm.com> writes:

> On Fri, 17 Jul 2026 20:47:23 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
>> On Fri, Jul 17, 2026 at 02:02:50PM +0200, Esben Haabendal wrote:
>> > "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
>> > > On Thu, Jul 16, 2026 at 04:51:34PM +0000, Esben Haabendal wrote:
>> > >> On Wednesday, 15 July 2026 at 16:56, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>> > >> > On Wed, Jul 15, 2026 at 04:25:20PM +0200, Esben Haabendal wrote:
>> > >> > > "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
>> > >> > > > On Wed, Jul 15, 2026 at 01:35:41PM +0200, Esben Haabendal wrote:
>> > >> > > >> "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
>> > >> > > >> > On Wed, Jul 15, 2026 at 10:07:39AM +0200, Esben Haabendal wrote:
>>
>> ...
>>
>> > >> > > >> >>  	if (client->irq) {
>> > >> > > >> >>  		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
>> > >> > > >> >> -					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> > >> > > >> >> +					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
>> > >> > > >> >> +					   data->open_drain ? IRQF_SHARED : 0,
>> > >> > > >> >>  					   client->name, indio_dev);
>> > >> > > >> >
>> > >> > > >> > Why do we care?
>> > >> > > >>
>> > >> > > >> Care about what exactly?
>> > >> > > >
>> > >> > > > About exclusivity of the interrupt.
>> > >> > >
>> > >> > > Ok.
>> > >> > >
>> > >> > > >> We need to add IRQF_SHARED flag in order to allow shared interrupt, and
>> > >> > > >> we should not add it when using (the default) push-pull mode.
>> > >> > > >
>> > >> > > > Why not? How would it make any difference from SW perspective?
>> > >> > >
>> > >> > > Not adding the IRQF_SHARED flag prevents use with shared interrupts. I
>> > >> > > think we are on the same page on that.
>> > >> > >
>> > >> > > Unconditional adding IRQF_SHARED flag would allow configurations where
>> > >> > > other devices share interrupt line with mma8452 compatible chip
>> > >> > > configured with push-pull, resulting in broken or unpredictable results.
>> > >> > > I don't see why we should not care about that.
>> > >> >
>> > >> > But it's not their problem! If it's this device that prevents this
>> > >> > configuration, it should have a check. With this code it just hides
>> > >> > and changing a DT property will lead to kernel warning.
>> > >>
>> > >> The chip such does not prevent the configuration, and does not prevent
>> > >> sharing the interrupt. The irq pin in the device can be configured in either
>> > >> push-pull mode or open-drain mode.
>> > >> In order to allow sharing interrupt line with other chips, the chip
>> > >> must be configured with irq pin in open-drain mode, which is what the
>> > >> drive-open-drain device-tree property I am adding in this series enables
>> > >> developers to do.
>> > >> If/when you add this property to the device-tree, the irq pin will be
>> > >> in open-drain mode, and the IRQF_SHARED flag can (and should IMHO) be set
>> > >> as the interrupt line can be shared.
>> > >> If/when the drive-open-drain property is not set (existing device-trees
>> > >> and current only supported behavior), the chip cannot support sharing the
>> > >> interrupt line, and adding the IRQF_SHARED flag would be a bug, as the
>> > >> chip irq pin requires an exclusive interrupt input.
>> > >>
>> > >> Maybe the confusion is caused by the fact that the drive-open-drain
>> > >> does not describe how the irq pin IS behaving, but rather how it SHOULD
>> > >> behave, and possibly required because of the HW designed having tied the
>> > >> irq pin to an irq input together with other irq sources.
>> > >
>> > > Why do we care of push-pull then? Can't we always make it open-drain?
>> >
>> > No. Open-drain requires an external pull-up resistor. If there are no
>> > external pull-up resistor, open-drain will not work, and interrupt
>> > sharing is not possible.
>>
>> Right. My question was basically to understand if we have the HW (platforms to
>> which this sensor is attached) that relies on this pin to be PP (in current
>> configuration)?
>
> I'd met plenty of boards where the resistor wasn't there for other sensors
> (including one that 'shared' the interrupt - worked much better once we'd
> patched a resistor on) so I'd say it is very likely those exist.
>
> Anyhow it is also trivial to put an interrupt multiplexer in the path for
> the push pull case (I've seen this on a real design). In this case an
> AND gate will do the job Sure you'd not bother if both sensors were
> capable of open-drain, but maybe only one of them is?  We could of course
> make that an explicit component and give it a driver, but meh, why
> bother - just allow the combination argued against here of push-pull
> and IRQF_SHARED.

Ok. Makes sense.

> So I'd just set IRQF_SHARED unconditionally.

Will do.

>> > >> > > > Yes, I understand the HW case.
>> > >> > > >
>> > >> > > >> > The (hidden) problem this will have in the future is that the IRQ core
>> > >> > > >> > will splat a warning in case that other shared IRQs might be
>> > >> > > >> > configured with different flags. Putting that flag conditionally makes
>> > >> > > >> > it a mine field for the users. Instead just unconditionally add that
>> > >> > > >> > flag and we will get reports as soon as there will be a user that
>> > >> > > >> > shares the same interrupt pin with some other devices which drivers do
>> > >> > > >> > not use the same settings.
>> > >> > > >>
>> > >> > > >> If we add the IRQF_SHARED flag unconditionally, it will be set also when
>> > >> > > >> push-pull mode is enabled. I don't see how the kernel will be able to
>> > >> > > >> notice that that is not going to work. If you have another device that
>> > >> > > >> uses IRQF_TRIGGER_LOW|IRF_ONESHOT|IRQF_SHARED, it will not work with the
>> > >> > > >> MMA8452 device when configured as push-pull.
>> > >> > > >
>> > >> > > > Right, and why do we care (again)?
>> > >> > >
>> > >> > > Why we care that the system as a whole (SW on top of HW) will not work?
>> > >> > >
>> > >> > > If we don't care about that, why do we even have this IRQF_SHARED flag?
>> > >> > > The only purpose of that is to tell the kernel that this particular
>> > >> > > device / interrupt will work with shared interrupt or not.
>> > >> > >
>> > >> > > Isn't that exactly what I do with this change? Nothing more, nothing less.
>> > >> > >
>> > >> > > > It's pure DT/FW/HW issue, not an SW issue.
>> > >> > > > Otherwise it will become a carefully placed mine for the poor user who will
>> > >> > > > use these flags and try to share an interrupt with the mma8452 device which
>> > >> > > > has no set property and uses push-pull mode.
>> > >> > >
>> > >> > > I don't get how you see it like that. Adding IRQF_SHARED unconditionally
>> > >> > > would create exactly the mine field you are talking about. Poor users
>> > >> > > can specify a system configuration (DT) that tries to use a shared
>> > >> > > interrupt line, but configures the mma8452 compatible chip in push-pull.
>> > >> > > The poor user will not only be poor, but also unhappy.
>> > >> >
>> > >> > > By applying the IRQF_SHARED dynamically, the kernel will be able to fail
>> > >> > > in a controlled manner instead, making it much less painful to create a
>> > >> > > working system configuration (DT)
>> > >> >
>> > >> > And my point that we need to make less painful runtime experience.
>> > >>
>> > >> Yes. We agree on that.
>> > >>
>> > >> But I do believe that my patch is that painful runtime experience.
>> > >>
>> > >> Adding IRQF_SHARED flag when irq pin is configured in push-pull mode
>> > >> will be painful. I know, that was my initial approach. Does really not
>> > >> work, and can lead to wasting time on debugging the HW.
>> > >>
>> > >> > > Going back to your poor user story above, if the poor user tries to
>> > >> > > share the interrupt pin with the mma8452 device, it will get an error
>> > >> > > (just as it is with the kernel today). The device does not support
>> > >> > > shared interrupts. Reading the DT bindings documentation, the user
>> > >> > > should be able to find the drive-open-drain property, and add that to
>> > >> > > the device-tree to make things work. Maybe even consider if that is
>> > >> > > compatible with the hardware being used.
>> > >> > >
>> > >> > > If IRQF_SHARED was set unconditionally, the user would not get an error,
>> > >> > > but most likely would get a system where no irq's were raised for the
>> > >> > > other chips. I sincerely believe that debugging this is much more
>> > >> > > painful than reading device-tree bindings.
>> > >> > >
>> > >> > > > Did I miss anything?
>> > >> > >
>> > >> > > I don't know. Maybe I am missing the obvious here.
>> > >> >
>> > >> > I consider the case when shared interrupt is enabled on both devices, but
>> > >> > second one (driver) missed the same IRQ flags. This becomes a warning in
>> > >> > IRQ core.
>> > >>
>> > >> Missed which IRQ flags?
>> > >
>> > > _LOW, for instance.
>> >
>> > All devices sharing an interrupt really do need to agree on these
>> > flags. Do you known any drivers that does not specify the trigger type
>> > when requesting an irq?.
>>
>> Huh?! Majority of the device drivers! And that's how it should have been from
>> day 1, that's why I call this a pre-existing bug in this driver which we may
>> not address :-(. But we may address it when use SHARED interrupts.
>>
>> > You cannot share an interrupt line if not all devices have the
>> > same trigger mode. So if one device on a shared interrupt has _LOW, all
>> > the other devices need to have that. Not just the flags, but the actual
>> > triggering mode of the device. Some chips might support more than one
>> > mode, others only one specific mode.
>>
>> Yes.
>>
>> > >> > Shared interrupts it's also a contract with all stakeholders on keeping
>> > >> > the same flags for all devices.
>> > >>
>> > >> Of-course.
>> > >>
>> > >> And adding IRQF_SHARED is a contract that says that the interrupt can be
>> > >> shared. I can only see that it would be a bug to add that flag in cases
>> > >> where we know that the interrupt really cannot be shared.
>> > >>
>> > >> As for the IRQF_TRIGGER_LOW flag being set, I think that looks correct
>> > >> as long as we do not support switching to active high irq polarity.
>> > >
>> > > No, it's not. It overrides whatever platform wants to have.
>> >
>> > The trigger type is not just a platform thing. It describes how the
>> > device behaves.
>>
>> No, it describes how this certain device is connected to the certain platform.
>> It's a combination of what device is capable of and how platform design makes
>> use of it.
>>
>> > Device that only support one triggering mode must set
>> > the flag that describes that. Devices that can be configured for
>> > different triggering modes can implement that, and should then configure
>> > the device for the chosen mode and set the flags accordingly.
>>
>> Yes, but not in the device drivers!
>
> Absolutely agree on this point.  Setting interrupt sense / type in a driver
> was something I used to miss in reviews and is effectively impossible to
> fix without regressions.  This should be coming from firmware.  The mention
> elsewhere of a not gate in the path is annoyingly common as it is a really
> cheap way to solve voltage level mismatches.
>
> So I think Andy made a good point that, given until now shared interrupts
> weren't possible, we can't regress any board if we remove the _LOW bit
> for at least those.
>
> With the above thing (the AND gate interrupt combiner)
> arguing for IRQF_SHARED always this gets a bit less obvious though.
>
> We have had some 'novel' solutions in the past where we needed to enable
> the opposite sense from firmware in which we check if firmware made a choice
> to be _HIGH.  If it did we override the _LOW in the driver.
> Could that work here to avoid that _LOW forcing in all but a fallback
> case to avoid regressions?

I am not sure I understand what you want. Something like this:

    irq_flags = irq_get_trigger_type(client->irq);
    if (irq_flags == 0)
        irq_flags = IRQ_TYPE_LEVEL_LOW;
    irq_flags |= IRQF_ONESHOT | IRQF_SHARED;
    request_threaded_irq(client->irq, NULL, mma8452_interrupt,
                         irqf_flags, client->name, indio_dev);

Or can this still cause regressions, if there are cases where firmware
configured _HIGH and the override to _LOW needs to be kept?
If so, I don't see how to differ between the two different situations.
I don't see how we at this point in time can know if the interrupt is
shared.

Another approach could be to keep the _LOW override, and only drop it
for cases where open_drain is enabled. This should safe for regressions.
Something like this:

    request_threaded_irq(client->irq, NULL, mma8452_interrupt,
                         (data->open_drain ? 0 : IRQF_TRIGGER_LOW)
                         | IRQF_ONESHOT | IRQF_SHARED,
                         client->name, indio_dev);

What do you think?

>> > > It prevents PCB level designs from anything else.
>> >
>> > Yes. In this case, the current driver does not support designs that
>> > requires the mma8452 compatible chip to be configured for active high
>> > irq trigger. We could and probably should address that.
>>
>> Exactly!
>>
>> > But that is a different issue than what I am doing here. And I don't
>> > have hardware readily available where this can be tested, so I would
>> > prefer to let somebody else do that.
>>
>> No objection on the specific issue, but...
>>
>> > I am adding support for designs that require the mma8452 compatible chip
>> > to be configured for open-drain, while staying backwards compatible and
>> > allowing support for designs without external pull-up.
>>
>> ...the shared case *is* different. And I do not want the disaster (a bug)
>> to spread.
>>
>> > In all cases, the driver should register the interrupt handle with the
>> > IRQF_TRIGGER_* flag that matches what the chip is configured for.
>> > I believe leaving it out is invalid.
>>
>> Again, this chip is not a single party in the equation. Nobody prevents
>> to put a NOT gate on PCB to support this device and say other that wants
>> inverted polarity while sharing the same interrupt line.
>>
>> > >> But on that topic, the chip actually supports selecting between active
>> > >> low and high irq polarity. Should we implement something along the lines
>> > >> of what is done in smi330_setup_irq() in iio/imu/smi330/smi330_core.c?
>> > >> And thereby allow using the device with active high irq?
>>
> I've always been really nervous about that approach because we might get
> one of those with a not gate. If we do then we do have to an explicit
> device to do the interrupt inversion.
>
> I did let myself get talked into that handling a long time back but
> in conflates the interrupt description at the two ends of a path with
> possible logic on it.

Ok. Let's not dig a new hole like that then :)

If someone needs to use the configure this chip for active-high irq,
maybe a new device-tree property would be a better approach.

>> > >> > After looking into genirq code I don't see other way how to handle this.
>> > >> > It looks like we need to address the TRIGGER_LOW first, in other words
>> > >> > we need drop that flag when IRQF_SHARED is set, and leave it to users
>> > >> > to setup IRQ trigger properly on all sides.
>> > >>
>> > >> Why do we need to drop the IRQF_TRIGGER_LOW flag because IRQF_SHARED is
>> > >> set?
>> > >>
>> > >> Users as in those specifying the system device-tree?
>> > >
>> > > No, because like I said, the SHARED is a *contract*, it's not just a setting.
>> >
>> > Absolutely. That is the key here.
>> >
>> > IQRF_SHARED is a contract, where the driver promises to return IRQ_NONE
>> > if the interrupt is not for that device. This is already implemented
>> > by mma8452_interrupt().
>> >
>> > > And that contract includes the similarities on the IRQ flags. One may not
>> > > have two devices with different trigger level, it's a common sense,
>> > > right?
>> >
>> > Right.
>> >
>> > And that is exactly why we have to specify the IRQF_TRIGGER_* flag that
>> > the irq output is configured for.
>>
>> No, definitely the opposite. We may *not* specify this flag in the driver,
>> we have to rely on the _platform_ configuration. PCB level.
>>
>> > The driver will not switch to the
>> > desired trigger level based on what other devices on the same interrupt
>> > uses. You have to configure/specify the trigger mode and leve and set
>> > the IRQF_TRIGGER_* flag accordingly.
>>
>> Yes, but not in the driver!
>>
>> > > So, SHARED must exclude anything that comes from the platform description or
>> > > IRQ chip controller (limitations).
>> >
>> > Now you got me confused again. The IRQF_TRIGGER_LOW flag given to
>> > request_threaded_irq() is not coming from platform description or IRQ
>> > chip controller. It describes the trigger mode that the chip is
>> > excercising in the current implementation.
>>
>> And this is wrong. It's not device driver business to define this. More
>> accurate it's not only of the device in question and how it works.
>>
>> > The kernel would not know how to configure the IRQ chip controller, and
>> > in case of shared interrupts, would not be able to check that the
>> > devices sharing the interrupt is configured correctly.
>>
>> Huh?! The kernel is responsible to program IRQ chip and the respective
>> device drivers in accordance with the platform design (and protocol to
>> supply it to the OS is called DT or ACPI or ...).
>>
>> There are several limitations for this:
>> - IRQ chip that might not support certain trigger configurations
>> - device that can only take subset of trigger configurations
>> - in shared line case all of the devices need to agree on that
>>   on a _platform_ level
>>
>> > > So, without addressing that, it makes a little sense to add SHARED.
>> >
>> > Not true.
>>
>> True. Obviously we have a disagreement here and I tried hard to explain
>> my point above.
>>
>> > Let me take my system here. I have multiple chips / irq sources
>> > connected to the same interrupt input on the CPU. They are all using
>> > level low triggering (which hardware and system engineers have ofcourse
>> > been observant enough to ensure).
>>
>> And if not? Isn't it possible to make them share an interrupt line?
>> Of course it's very much possible, but in the platform description
>> the both devices will need to have the same one, so for the second
>> one it will be a bit of a lie (due to an external NOT gate or a latch
>> or any other PCB level tricks).
>>
>> > Without my change, the mma8452 driver does not support configuring the
>> > chip to use open-drain, so it will be pulling the interrupt line high,
>> > interrupting irq for all interrupt sources.
>>
>> I even don't consider this, this is obvious. And you are correct here.
>>
>> > With my change, I can now configure the device to use open-drain,
>> > register the interrupt, and everything works nicely.
>>
>> Nope, it depends on the other stakeholders.
>>
>> > And the change is backwards compatible, as you have to specify
>> > drive-open-drain to switch from PP to OD.
>> >
>> > How does that not make sense?
>>
>> Please, read again what I wrote.
>>
>> > > I would accept this patch without adding SHARED, perhaps.
>> >
>> > Without IRQF_SHARED, I cannot use it with the hardware I have which are
>> > sharing the interrupt.
>>
>> True, but with _LOW it makes a little sense to use SHARED.
>>
>> > > But still question why we can't use the OD instead of PP for the pin
>> > > to begin with?
>> >
>> > Because HW needs to be designed for OD. It is perfectly valid to design
>> > hardware that relies on the default mode of mma8452 and compatible chips
>> > to use PP. Switching to OD will not work for such systems without
>> > external pull-up.
>> >
>> > > Do we have real HW that uses IRQ input without a pull-up?
>> >
>> > I certainly have had such designs many times in the past.
>>
>> Okay.
>>
>> > Why should we implement the driver so that we cannot support such valid
>> > HW designs?
>>
>> This is exactly my question as your patch limits this to _LOW.
>> And this is a big issue with it.
>>
>> ...
>>
>> P.S.
>> I'm on vacation, but I disagree on the approach taken in this patch.
>> I leave it to you and Jonathan and others to settle down.
>>
>> Here is my formal NAK (to this form of the patch, as I said, w/o shared
>> support it might be okay to go).

I would like to find a way to agree on a solution with shared support.

/Esben
