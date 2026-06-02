Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6224248F72;
	Tue,  2 Jun 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403608; cv=none; b=M64sZf8q7f7rBNByq8D0UBc6enOYMc6RPfXP5YMMGuwxBsVGujZGVKNZtKexXHKButEUp1GxYwYUVrMfzE0ATUINKksyGom8VvOuJ4eh5Kj+WSdShTAAYjFavw8ClITqkRVKnhMTt1vezTrb+xSPAYPkAtHEwV/2CqwqHSiIXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403608; c=relaxed/simple;
	bh=oorn8PkbrCMs690TgzP0GowgTilR3Pg76BHFiYB6wag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ai9UOBjQS8eMDZwHT51n5ko4dJX6Qei9Xeezqqt2J2b1JepoXtNRhzmWVtyArSnO12ljHkJe21FvEisbvjsVAd1AzXSDGBCpQ2LPj87oOdDUNChCZis//dO/k04931D8FptqKMlC2Tg0H3P/6bQoW5fZAIlJOl4QaB2jBOKsvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULxW9rbl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULxW9rbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2801F00893;
	Tue,  2 Jun 2026 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780403604;
	bh=ZHQsese53YCkfqHYmt+s9OJNTsAb5+eEU5kgQzjsnTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ULxW9rblXpGd5J5f/7GxN1SxeaEitL9/opl5v4wAllH6ATcw6Rckc36K6EQURm7RY
	 Vp9FUfZeYpBN76qyb0t88STqs3U/UZ18wyo+6KnNN7iN255oUb5MDojXUrmfzrFl+G
	 nkIgyx2pgN6yjshTXmNMIjm6m59Gewj081Vk83DmEmc1TMGJAIaGEzoMiHCx4Vycuw
	 QUZ152NA8oOQkXwpO3sOTTch/ZwJv0LWCYeCWsSaIT3LZH1QLlrYMlEF0KPupvq7r1
	 uinxPwEGJuLyrB67YVwDsZvAED7qY+qa6AyuHOpOJK4/H0385HEVrY/M/Cy6OqJhP6
	 fQX7AtI8t8XDw==
Date: Tue, 2 Jun 2026 13:33:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Rishi Gupta" <gupt21@gmail.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Matti Vaittinen"
 <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260602133313.1d5afc51@jic23-huawei>
In-Reply-To: <DIXZFV822HRI.2SBIT7ADW9LUK@gmail.com>
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
	<20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
	<20260601112103.281387ee@jic23-huawei>
	<DIXZFV822HRI.2SBIT7ADW9LUK@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Jun 2026 22:07:42 +0200
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> Hi Jonathan, thanks again for your review.
> 
> On Mon Jun 1, 2026 at 12:21 PM CEST, Jonathan Cameron wrote:
> > On Sun, 31 May 2026 21:58:22 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >  
> >> These sensors provide two light channels (ALS and IR), I2C communication
> >> and a multiplexed interrupt line to signal data ready and configurable
> >> threshold alarms.
> >>
> >> This first implementation provides basic functionality (measurement
> >> configuration, raw reads and ID validation) and defines the different
> >> register regions in preparation for extended features in the subsequent
> >> patches of the series.
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> > A few comments from sashiko and a couple from me based on a fresh read.
> >
> >  
> >> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> >> new file mode 100644
> >> index 000000000000..6f9a7bad44d4
> >> --- /dev/null
> >> +++ b/drivers/iio/light/veml6031x00.c  
> >  
> >> +
> >> +static const struct iio_chan_spec veml6031x00_channels[] = {
> >> +	{
> >> +		.type = IIO_LIGHT,
> >> +		.address = VEML6031X00_REG_ALS_L,
> >> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >> +				      BIT(IIO_CHAN_INFO_SCALE),
> >> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> >> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
> >> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> >> +	},
> >> +	{
> >> +		.type = IIO_INTENSITY,
> >> +		.address = VEML6031X00_REG_IR_L,
> >> +		.modified = 1,
> >> +		.channel2 = IIO_MOD_LIGHT_IR,
> >> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >> +				      BIT(IIO_CHAN_INFO_SCALE),  
> >
> > Can we move scale to shared_by_type?
> >
> > Thinking on some of the others, they should probably be shared_by_type as well
> > rather than shared_by_all. If we ever add buffered support and a timestamp
> > the integration_time doesn't apply to that.
> >
> > shared_by_all tends to only include things that are truely universal like
> > sampling_frequency.
> >  
> 
> I am not sure if I get this point. This device has a single IIO_LIGHT
> channel, and the scale only applies to it. Are info_mask_separate and
> info_mask_shared_by_type not the same in that case? I have seen that
> some drivers use both info_mask_separate for INFO_RAW, and
> info_mask_shared_by_type for INFO_INT_TIME and/or INFO_SCALE, but that
> could make more sense if there were multiple channels of the same type.
> What am I missing here?

Ah. I've been reading too many drivers. For some reason I thought this
had more intensity channels. My comment clearly garbage as you point out.
I maybe got thrown by how ALS sensors used to work.  They used IR only
and a clear window that covered both IR and the frequencies we need for
illumiance measurement. The light channel was then some combination of
the two. I guess they've figured out how to filter that IR out of that
these days.  That leaves me a little curious as to what applications actually
use the IR channel.

> 
> On the other hand, the integration time applies to both the IIO_LIGHT
> and IIO_INTENSITY channels, so I guess you are suggesting to add it
> to both channels as info_mask_shared_by_type because the timestamp
> is a channel itself. Moving it form shared_by_all to shared_by_type is
> alright, and I will add it to V5.

Yes, that one was correct.

> 
> >> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> >> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
> >> +	},
> >> +};  

> 
> >> +
> >> +	ret = veml6031x00_hw_init(iio);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	pm_runtime_put_autosuspend(dev);  
> >
> > As sashiko shouts, this looks like runtime pm will underflow on remove.
> > Check it by removing your driver.  It doesn't actually result in any
> > problem, as the runtime pm subsystem just saturates at 0 on decrement.
> > Given that's tear down anyway maybe we don't care.  However, it's easy
> > enough to fix by using pm_runtime_get_no_resume() and a couple of
> > explicit calls to put it in error paths.
> >  
> 
> I took some time to audit this in detail, because although my
> expectations are that atomic_add_unless(usage_count, -1, 0) should make
> this shout a false positive. Expectations don't always meet reality. My
> expectations were based on the code, so I have added tracepoints to know
> exactly what's going on.
> 
> Scenario 1: Successful probe -> unbind driver.
> 
> devm_pm_runtime_get_noresume() increases usage_count, and the call to
> pm_runtime_put_autosuspend() decreases it. That is balanced, giving us
> usage_count = 0 and putting the device in power down mode as desired. If
> the device is then unbound, the devres action (a call to
> pm_runtime_put_noidle_action, which only calls pm_runtime_put_noidle)
> triggers a call to atomic_add_unless(&dev->power.usage_count, -1, 0).
> Given that the usage count is 0, nothing happens and there is no
> underflow. In fact, the underflow is not possible this way, and adding a
> remove function to check if usage_count is 0 and calling
> pm_runtime_put() is basically repeating what the devres action already
> offers for free.

Agreed on this analysis. From a readability point of view it is nice
to have balanced calls but as long as we only underflow / get clamped
in a path where we never increment again that's fine.  I'd add a comment
somewhere to say that's intentional.

> 
> Scenario 2: write_event_config -> unbind driver.
> 
> Sashiko says that pm_runtime_resume_and_get() increases usage_count, and
> there is no devres action associated to it. That is only partially
> correct, because the devres action from devm_pm_runtime_get_noresume()
> will be triggered when the driver is unbound. Actually, this is great
> because then pm_runtime_resume_and_get() gets balanced, and there is no
> need for a remove function to check again if usage_count is 0 or not. In
> this case, usage_count = 1 before unbinding the driver, and then the
> devres action is triggered when it gets unbound. Exactly what we want to
> have usage_count = 0.

This one I'm more dubious on.  Basically you are saying on remove we happen
to have an extra decrement for largely unrelated reasons so we are fine.
That to me smells fragile even if it works.  For instance someone tidying
up the imbalance in scenario 1 (which would seem reasonable to do from
a code understandability point of view) would break scenario 2.
I'd rather we had something explicit for this. Probably an devm action
that just checks for events being enabled at exit and disables them as part of
the tear down.

So not bugs as such, but fragile which is not good from maintainability
point of view.

Jonathan


> 
> >> +
> >> +	ret = devm_iio_device_register(dev, iio);
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "Failed to register iio device\n");
> >> +
> >> +	return 0;
> >> +}  
> >  
> >>  
> 
> Best regards,
> Javier

