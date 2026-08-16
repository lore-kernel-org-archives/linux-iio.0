Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE083C1D41;
	Sun, 16 Aug 2026 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845545; cv=none; b=Ff8S9WXW3Ni07/6z+Ss3GI27+0Rh2D7BVNmr2GvDum5swj40HplCPtHZJ0iRpZtSIMiG0STpq2IRwfQ0dXWMNeHmMkKWeJsGEiyIdQ3I48frNKSoCYN97tMN8+9WGAoDL4FY36Sz53i8lAAUBriK7WIKTgR8MUqme5y72Xzi6WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845545; c=relaxed/simple;
	bh=pn6Kw8f16aCv6CgIRxnePEA58GnRmCsdvwedlyjn1fY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8jOobEhzjUs6YDorshcZFVih0ce751EsnVlF4tlh4CKQolNRG7PJmhbs1Zuc10559EeoCxFUqnwRuqBpzbTl2z88Gt3N6KE3Go4NuMoRnJsS25ugRHNHzrevXZTYS222mrUy7pPB0R+EOOjhNGFT6+OvSIpclc1K9WpAfpS6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYEPowNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYEPowNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0451F000E9;
	Sun, 16 Aug 2026 01:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786845543;
	bh=S7KyiuS5k0LrYHX8ZHtUNeqmnF6nkYmCoawuM0PQUFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZYEPowNikbDFoFcwGhKQAJl9gDe8JpNXzmHM2ztyMZ6Iyk9YFS0oZ/D7oSwE5FPBI
	 PAP55bYeeLG9wmTw8kHCV6as4aP3nzkqX95G36z/U/ugrC6/sfIY5v4GEJfrJVVOU8
	 55/xQ0+RqeiqXgrCqvxD8UBkKi3n5ImEzqtBy3S4faKOVH9TlyrLlEXpswyLDwGR7I
	 L8n+e5PrjWHba3h+Kur95hnkPe/NSXICHcig3PFwNCF1JUTY9TB4ngD9Fl94mtEB6v
	 ecP2OV96oWWKQaWyuZXCmYSTgZ+URgSZnBIfzlo9uT/lnHyqkVGBz1TeXsfD+SfU5z
	 xhN79W4SQ6xIw==
Date: Sun, 16 Aug 2026 02:58:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Kanak Shilledar <kanak.shilledar@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Henrik
 Grimler <henrik.grimler@axis.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH 2/3] iio: accel: Add support for ICM42370P
Message-ID: <20260816025858.451dbbcb@jic23-huawei>
In-Reply-To: <andT6r0ZIR1DuZWg@debian-BULLSEYE-live-builder-AMD64>
References: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
	<20260806-b4-inv_icm42370p-v1-2-670837f5842f@axis.com>
	<andT6r0ZIR1DuZWg@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > +/**
> > + * struct inv_icm42370_data - driver state variables
> > + * @lock:		lock for serializing multiple register access.
> > + * @name:		chip name.
> > + * @map:		regmap pointer.
> > + * @vdd_supply:		VDD voltage regulator for the chip.
> > + * @vddio_supply:	I/O voltage regulator for the chip.
> > + * @indio_accel:	accelerometer IIO device.
> > + * @sensor_state:	per-sensor state tracking (e.g. power, ODR).
> > + * @buffer:		buffer for reading data registers, aligned for DMA.
> > + * @accel_calibbias:	accelerometer calibration bias for X, Y, and Z axes.
> > + * @fifo:		FIFO state and configuration.
> > + * @timestamp:		interrupt timestamp.
> > + * @chip:		chip identifier.
> > + * @conf:		chip sensors configurations.
> > + */
> > +struct inv_icm42370_data {  
> There is another 'state' struct declared below which leaves us with two types of
> state structs for icm42370? Would it make sense to have them merged?
> 
> > +	struct mutex lock;
> > +	const char *name;
> > +	struct regmap *map;
> > +	struct regulator *vdd_supply;
> > +	struct regulator *vddio_supply;  
> I'm not seeing the regulators being used after probe. For these power supplies,
> devm_regulator_get_enable() is usually enough to get them running. If that
> applies to icm42370, then there will be no need for vdd fields in the state struct.
> 
> > +	struct iio_dev *indio_accel;
> > +	struct inv_icm42370_sensor_state *sensor_state;
> > +	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);  
> The __aligned() pragma forces cache line alignment on the field it annotates.
> IIO device drivers often have annotations like that to make data buffers use
> separate cache lines and thus avoid data mishandling when doing DMA.
> Though, if the alignment is forced closer to the beginning of the struct, we
> may end up with holes in memory. This is not a subject I specialize in, though,
> you may find this LWN article better than my poor explanation.
> https://lwn.net/Articles/335942/
> 
> Besides avoiding holes in data structures, running pahole may also help you
> better understand the alignment issue.

Marcelo, you indeed highlighted a problem but not quite the reason it is
a problem.  __aligned(IIO_DMA_MINALIGN) forces the alignment of the beginning
of the buffer to be on a cacheline.  It doesn't do anything about the next
element.  The aim here is to ensure that any data accesses by DMA doesn't
share a cacheline with data that may be accessed concurrently by the CPU.
It seems very likely some of the stuff that follows might be accessed
at that time and hence potentially corrupted by stale values coming back
from the DMA engine which thinks it has exclusive control of the cacheline.

Hence put them at the end of the structure not in the middle ensures there
is nothing in that space.  Structures are padded to a multiple of the
highest aligned element.

I just took a quick glance at existing comments to see where things
stood before looking at v2 and this jumped out at me

Jonathan

> 
> > +	s16 accel_calibbias[3];
> > +	struct inv_icm42370_fifo fifo;
> > +	s64 timestamp;
> > +	enum inv_icm42370_chip chip;
> > +	struct inv_icm42370_conf conf;
> > +};
