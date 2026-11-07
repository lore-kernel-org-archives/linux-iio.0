Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095013;
	b=ErXKGy3HW7g/nyUa3UsLXBa+mlfSGMBo1gJugSZeLZdvgOglpCGpHa1eaBUyySS3K0ij
	 /s4Gd9SXOdzV2bbhN1T9D6YRQYkAEXJqbijqCh8cJ8qgu4WO1vUB7vGVuXUeQxax0RRO6
	 zq/YUGeBhYNj8+veAz/6IWkSwsdBhN9bKQ99/qAQRNpu4CIW3H0uHeQ33ZuNITfOnFFro
	 oYNsxs3ynJ7wadDSd8l6X8LyKJwfnx7Qkj5MMb1zt21kr9wPN/uiHgLLsK+0SxSefR6BW
	 b6ppvvBGuwywinEPdn0GCSXaEIETUONVCz7cERTAcxW07q5bYKxrrVUV5719Wxprb2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095013;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9JVhoZv/kApjV5ecEB9wAeg1QHl094+ex1qsxNehnhc=;
	b=LQ5fTY2lakWV6L0qnpUnrhFBoAOPBJV9qAyHBziDyvifY6CUz8Pd3lwh6veDvWsrYZ5F
	 ED0CABDFWzGYw3sLg5a1hGgJn6gFlWnt6o1lEjPMxR/d9I2Cy0PMAqIfd4Kwgn1SIafQd
	 DoyQdvWnWPxQs5xVO0dGzMMmWKFiISPWXUEcm45dKZ7eAC+re5ubjtRnLxiTELErftmB+
	 K2YRlnwIsW3nEcv8vLgcV9BMxSDmnLGYOu18v2l9KU3ObvvsKTCmAR+Cz0/KWB/P27fKJ
	 1zC9FfBziBfE+Z2RxK0PSnLnSkcq4OYl8II2Cn3JPoSJ9ugza4KiANgIOfCJngRw1XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhhiDMTO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A19606A326;
	Sat,  7 Nov 2026 23:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhhiDMTO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAD61F0089F;
	Sat,  7 Nov 2026 23:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794095012;
	bh=9JVhoZv/kApjV5ecEB9wAeg1QHl094+ex1qsxNehnhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UhhiDMTOXiySnfYDmTQByecsNuzvdkkUYa2f2XsT9gcuhd1owatVF5gjkOY95l2pQ
	 qN7llj/K7lYPqktGk2IgIr0luMD7W21SVInSqvvKvMfuZx7GGgzDu/38wXrHchKlBI
	 mW4RhKSpgi0IBfsbiak0KnlDzajD7qO4+wYIX8wtRdTEasE/rZNtcqdkgxTdc/udfU
	 RD/1ss1OCeK4xjdco3O06oEA8eecxNZHkM5D/n28NcgNPB5Rmhe/XlHh+mRv3ZRu88
	 vvcSuYb6SEodgyl6CDvK41XJTy8moTRsIG5MYuv2nZzety/bsx17nejZhY+puwwShA
	 EHO8KKUg5MHBg==
Date: Sat, 7 Nov 2026 23:43:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: Michal Simek <michal.simek@amd.com>, Sai Krishna Potthuri
 <sai.krishna.potthuri@amd.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <amitrkcian2002@gmail.com>
Subject: Re: [PATCH 4/6] iio: adc: versal-sysmon: add over-temperature alarm
 events
Message-ID: <20261107234323.0aef5ae0@jic23-hlaptop>
In-Reply-To: <20261102122112.1723130-5-amit.kumar-mahapatra@amd.com>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
	<20261102122112.1723130-5-amit.kumar-mahapatra@amd.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Nov 2026 17:51:10 +0530
Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com> wrote:

> The SysMon has two independent temperature comparators. The driver
> exposes only DEVICE_TEMP on interrupt bit 9; the over-temperature alarm
> on bit 8, with its own threshold pair at OT_TEMP_TH_LOWER and
> OT_TEMP_TH_UPPER, is not reported to userspace at all.
> 
> The two are structurally identical: an upper threshold, a lower
> threshold acting as the hysteresis floor, and a hysteresis mode bit in
> ALARM_CONFIG, bit 0 for OT and bit 1 for DEVICE_TEMP. Per AM006 the
> over-temperature shutdown response is a PMC function configured at
> design time, so the kernel's role here is threshold configuration and
> notification rather than acting on the alarm.
> 
> IIO identifies an event by channel, type and direction, and both
> comparators are rising thresholds on the same aggregate temperature, so
> they cannot share a channel. Add an event-only channel labelled "ot"
> carrying the OT thresholds.

So the reason we don't normally do multiple threshold levels is they
have minimal use for an IIO interface - as you've discovered they've
reported the same on the events interface.

If this wasn't an existing driver, the support of this is something that
would strongly push in favour of an hwmon driver where the concept of
warn and critical thresholds exists.  That's there precisely because
the critical is often wired to a pmic or similar.

However, that isn't normally a problem even in an IIO driver
because that threshold should be a design time concern with the
limits coming from firmware.   So why is this even settable by
userspace? Feels like an interface to create the bad type of smoke.

We have a few times discussed how we would perhaps add another
layer of indexing to events, but it is hard given the the compact
event codes and I'm not sure I'm seeing a usecase that justifies
that complexity here.

I also can't work out where your new channel turns up. What does
the userspace ABI look like for this and the existing event controls?

Thanks,

Jonathan


> 
> The channel is appended after the device tree derived channels because
> io-channels phandle arguments are raw array positions, and placing it
> earlier would silently repoint existing consumers. It is created only
> when the device has an interrupt, as without one it would carry no
> events.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
>
W
> @@ -880,6 +932,9 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
>  
>  	num_static = ARRAY_SIZE(temp_channels);
>  	num_chan = size_add(num_temp, size_add(num_static, num_supply));
> +	/* The over-temperature channel exists only when events do */
> +	if (irq > 0)
> +		num_chan = size_add(num_chan, 1);
>  	sysmon_channels = devm_kcalloc(dev, num_chan, sizeof(*sysmon_channels), GFP_KERNEL);
>  	if (!sysmon_channels)
>  		return -ENOMEM;
> @@ -960,6 +1015,25 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
>  		};
>  	}
>  
> +	/*
> +	 * Over-temperature alarm. The OT comparator watches the same
> +	 * aggregate temperature as channel 0 but against its own threshold
> +	 * pair, and IIO cannot express two rising thresholds on one channel.
> +	 * It has no reading of its own, so only event attributes and a label
> +	 * are exposed. Appended last, because io-channels phandle arguments
> +	 * are raw array positions and inserting it earlier would silently
> +	 * repoint every existing consumer.
> +	 */
> +	if (irq > 0)
> +		sysmon_channels[idx++] = (struct iio_chan_spec) {
> +			.type = IIO_TEMP,
> +			.indexed = 1,

indexed without an index? I'm not even sure what this
turns up as. There are already 4 indexed temperature channels
so why isn't this just landing on the index 0 one?

> +			.address = SYSMON_OT_TH_UP,
> +			.event_spec = sysmon_temp_events,
> +			.num_event_specs = ARRAY_SIZE(sysmon_temp_events),
> +			.datasheet_name = "ot",
> +		};
> +

