Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1B3FE359
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422892; cv=none; b=IxoBXWI3+xiUTeyjhn0OQZ3Bm5Ic4VC3CV2oM+N4Fr4OZU8wlNtFqZmRRcJqa5ftJqPNCNOlLN9WbxWbgbv/tGBdEW1lM9vVr6bGWhwh3owGqiw++1PdaNm9pvXpvqEj6sXoF/dTWCZngI4ZkuuO5DGzhrJrwSYHOiDILtQ+sYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422892; c=relaxed/simple;
	bh=1cRWuA7CYRnjUrDrA88KiIVqyalvj7E0eefInPFai4g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=QjGH03T5RAS8cwUXZjHevhGUjz+EpWmtb/IJWHLsAy8ze04SUKUfLG7WByHEl4gtDU1UfYE6tM7/LEMYP/04fFyW80q6kbycQXQK9p3rWd2JTjFYtu4HIZKyhlyWS0nAWZk3Od8Md91mQ3y9QbSNyt7Lav5AP+zdsZ78KppOsOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEKctNh6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEKctNh6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49068493267so68132225e9.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780422889; x=1781027689; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/y3VfIHXupfD9Wrr+gIYVpG9u9vvvf2stdsP3kfUmSU=;
        b=HEKctNh6kxRzP6fnuggwJ15RB9GZwWfirEIgWZL7UEPQ9UJPz9SJREr0VAU+i/MHcX
         QcdV7QuzSwmjxiSZ2DD0D3kuFWRIvl4/nLXJx2uRntlTOPRZDARLK2hT02QM7JoqDbnW
         bkGyeJ4wvDPIxOnF0Xi+DMcU8A+EXMHSueyUSWbVZyvpUIyaPimwGgurM7jdLFDpyEPO
         1R3PsILsqrb28J96ZCR2Gr84xDt+DbwAUh/XzT1XJfAS1138U7Sk5kGEuEWus94/M5bH
         xptgOueG80DFR40y4wbmeHbKaPYjzUfe+VI2PIw8uXipcsK7379AlTdaP4731Rk2bxWB
         +ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422889; x=1781027689;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/y3VfIHXupfD9Wrr+gIYVpG9u9vvvf2stdsP3kfUmSU=;
        b=lFh1HcTwzL5c9C8FpdjKefBtyFfY/e6I/088k0Uvqf2reK3wnkGXIXMXhIvhEHqOJF
         fgIZX2PsEDf9tDbHt0IwsLcBmoWjqDoW5yqcTjR0q6pXTeFc7SUjcNYppwhwSbKEKhMu
         i5LduI5txC457TEPQgsVra5gIlrSMHbQl0UdN/NokynbbsghS+tDEPVV+xqBPpdlG55R
         ggraE3LVPhTpKsFDJyPG1/qelb1dsmIU45Qxi+8f349pPJ1vrSKEqeY7xfuyc8Nguaxa
         S6LnDm1DRUkVzbQfrKrN9rmxULZu4BLnNIlTsFCX1P7kCcj+9SK9VW1jmn9SukbLSR4N
         Q9uw==
X-Forwarded-Encrypted: i=1; AFNElJ8HidLDcPAfWh2mn6yrKUdp+ZIggh3HdCTLyb/91WcSW74iOPaJl84MZZp4J1ydO6nwTotsrBiIkFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrPrkNe78u8Y6WW7NlqA4K8T55u5tOusAp/gXnWY4tgg4Ut7Ti
	8UiLszucZfYGeUtEuqZNgt5h0feaO4vveUVwtPjML8ew7QrvNTBI7NJ9
X-Gm-Gg: Acq92OHXop7WARBNZ8WKrMLxbuMJbY8Rmjk7T7bRFVi7hVT3MzX+88bi+Q96EfFcV8R
	ddQNezm6b18zes17Rl66vt6sTKmr0F3ejcy6hl048edIgDcJvaz7mmBleOZsNpH9nVDeaK2gVVi
	ka06HDDNrhaP3NRfKb0qLtkopzM56v/vUJQvlZr502+niaxb2QxZILk6asEsh3T6GhmhXTtiPLJ
	T75WhfbFMk5jkJOoKyPy4v1ElJCNN5ohiRcza47j3Mw2cVaFef5DVWkxoGPbzYAlMssYHr/mizC
	7WBw4/B38C9RFhyaLRwjcA9wjhnmx7v0WTJv+aOccG0LZD7+OzsP5rrB0gw97TY5oyBR4T9wkXm
	GnF6s0iGpO8T7wonSGAVH3rSRXWUOBx3Z4BCtg89Jx1g3hgv28P4e9gKQxs5rSITfBeAjbCJQTV
	Rfya3A3DZwTAsGcv6K4Pm6om/Cr2J3r+rx7LfPS2MO97562+Y=
X-Received: by 2002:a05:600c:a41:b0:490:a964:14f8 with SMTP id 5b1f17b1804b1-490b505560dmr14093255e9.8.1780422888581;
        Tue, 02 Jun 2026 10:54:48 -0700 (PDT)
Received: from localhost ([2001:4bb8:152:df59:3b69:56ea:a39b:adb4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344541sm788685f8f.22.2026.06.02.10.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 10:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 19:54:45 +0200
Message-Id: <DIYR8LZ64A9E.3JQG25Z0TJ06@gmail.com>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS
 series
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Rishi Gupta" <gupt21@gmail.com>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Matti Vaittinen"
 <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Jonathan Cameron" <jic23@kernel.org>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
 <20260601112103.281387ee@jic23-huawei>
 <DIXZFV822HRI.2SBIT7ADW9LUK@gmail.com>
 <20260602133313.1d5afc51@jic23-huawei>
In-Reply-To: <20260602133313.1d5afc51@jic23-huawei>

On Tue Jun 2, 2026 at 2:33 PM CEST, Jonathan Cameron wrote:
>> >> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml=
6031x00.c
>> >> new file mode 100644
>> >> index 000000000000..6f9a7bad44d4
>> >> --- /dev/null
>> >> +++ b/drivers/iio/light/veml6031x00.c
>> >
>> >> +
>> >> +static const struct iio_chan_spec veml6031x00_channels[] =3D {
>> >> +	{
>> >> +		.type =3D IIO_LIGHT,
>> >> +		.address =3D VEML6031X00_REG_ALS_L,
>> >> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>> >> +				      BIT(IIO_CHAN_INFO_SCALE),
>> >> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME),
>> >> +		.info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_INT_TIME)=
,
>> >> +		.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),
>> >> +	},
>> >> +	{
>> >> +		.type =3D IIO_INTENSITY,
>> >> +		.address =3D VEML6031X00_REG_IR_L,
>> >> +		.modified =3D 1,
>> >> +		.channel2 =3D IIO_MOD_LIGHT_IR,
>> >> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>> >> +				      BIT(IIO_CHAN_INFO_SCALE),
>> >
>> > Can we move scale to shared_by_type?
>> >
>> > Thinking on some of the others, they should probably be shared_by_type=
 as well
>> > rather than shared_by_all. If we ever add buffered support and a times=
tamp
>> > the integration_time doesn't apply to that.
>> >
>> > shared_by_all tends to only include things that are truely universal l=
ike
>> > sampling_frequency.
>> >
>>
>> I am not sure if I get this point. This device has a single IIO_LIGHT
>> channel, and the scale only applies to it. Are info_mask_separate and
>> info_mask_shared_by_type not the same in that case? I have seen that
>> some drivers use both info_mask_separate for INFO_RAW, and
>> info_mask_shared_by_type for INFO_INT_TIME and/or INFO_SCALE, but that
>> could make more sense if there were multiple channels of the same type.
>> What am I missing here?
>
> Ah. I've been reading too many drivers. For some reason I thought this
> had more intensity channels. My comment clearly garbage as you point out.
> I maybe got thrown by how ALS sensors used to work.  They used IR only
> and a clear window that covered both IR and the frequencies we need for
> illumiance measurement. The light channel was then some combination of
> the two. I guess they've figured out how to filter that IR out of that
> these days.  That leaves me a little curious as to what applications actu=
ally
> use the IR channel.
>

According to the application note:

It can be helpful for an application to be able to differentiate between li=
ght
sources and react accordingly. The additional IR channel offers the
possibilities to do a light source differentiation based on the IR content
measured with the IR channel. A ratio between the IR and ALS channel can
be calculated to determine the amount of IR light within the light source=
=E2=80=99s
spectrum. This easily allows, for example halogen bulb to be kept apart fro=
m
an LED light.

Probably not the most useful IR channel out there, but there's still
something you could do with it :D

>>
>> >> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME),
>> >> +		.info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_INT_TIME)=
,
>> >> +	},
>> >> +};
>
>>
>> >> +
>> >> +	ret =3D veml6031x00_hw_init(iio);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	pm_runtime_put_autosuspend(dev);
>> >
>> > As sashiko shouts, this looks like runtime pm will underflow on remove=
.
>> > Check it by removing your driver.  It doesn't actually result in any
>> > problem, as the runtime pm subsystem just saturates at 0 on decrement.
>> > Given that's tear down anyway maybe we don't care.  However, it's easy
>> > enough to fix by using pm_runtime_get_no_resume() and a couple of
>> > explicit calls to put it in error paths.
>> >
>>
>> I took some time to audit this in detail, because although my
>> expectations are that atomic_add_unless(usage_count, -1, 0) should make
>> this shout a false positive. Expectations don't always meet reality. My
>> expectations were based on the code, so I have added tracepoints to know
>> exactly what's going on.
>>
>> Scenario 1: Successful probe -> unbind driver.
>>
>> devm_pm_runtime_get_noresume() increases usage_count, and the call to
>> pm_runtime_put_autosuspend() decreases it. That is balanced, giving us
>> usage_count =3D 0 and putting the device in power down mode as desired. =
If
>> the device is then unbound, the devres action (a call to
>> pm_runtime_put_noidle_action, which only calls pm_runtime_put_noidle)
>> triggers a call to atomic_add_unless(&dev->power.usage_count, -1, 0).
>> Given that the usage count is 0, nothing happens and there is no
>> underflow. In fact, the underflow is not possible this way, and adding a
>> remove function to check if usage_count is 0 and calling
>> pm_runtime_put() is basically repeating what the devres action already
>> offers for free.
>
> Agreed on this analysis. From a readability point of view it is nice
> to have balanced calls but as long as we only underflow / get clamped
> in a path where we never increment again that's fine.  I'd add a comment
> somewhere to say that's intentional.
>
>>
>> Scenario 2: write_event_config -> unbind driver.
>>
>> Sashiko says that pm_runtime_resume_and_get() increases usage_count, and
>> there is no devres action associated to it. That is only partially
>> correct, because the devres action from devm_pm_runtime_get_noresume()
>> will be triggered when the driver is unbound. Actually, this is great
>> because then pm_runtime_resume_and_get() gets balanced, and there is no
>> need for a remove function to check again if usage_count is 0 or not. In
>> this case, usage_count =3D 1 before unbinding the driver, and then the
>> devres action is triggered when it gets unbound. Exactly what we want to
>> have usage_count =3D 0.
>
> This one I'm more dubious on.  Basically you are saying on remove we happ=
en
> to have an extra decrement for largely unrelated reasons so we are fine.
> That to me smells fragile even if it works.  For instance someone tidying
> up the imbalance in scenario 1 (which would seem reasonable to do from
> a code understandability point of view) would break scenario 2.
> I'd rather we had something explicit for this. Probably an devm action
> that just checks for events being enabled at exit and disables them as pa=
rt of
> the tear down.
>
> So not bugs as such, but fragile which is not good from maintainability
> point of view.
>
> Jonathan

I will add a devm action for the events to decrement the usage count if
events are enabled i.e. the usage count was incremented.

Best regards,
Javier
