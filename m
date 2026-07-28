Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65223FA5C4;
	Tue, 28 Jul 2026 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272752; cv=none; b=K0HvTJ7/dN/4o2tXqtbK2H0oRKTbRVZHUFwZ/KKe8M/eBWg9R2ZtxaPMPAypxh0QX+qV4SyDzh6OjH5ehWqMDxnRiF2ui8AfJZJpsBMY6j4lkOkYI/QPkWtAPf6/k7UBgRd3Dx2sVX9je6U6OQygJQoA1NidqtxDj7ciJrrcn6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272752; c=relaxed/simple;
	bh=m6n5vAreXCDKFOQa6zSy4E1hiA+8A+6OJlztcrMf5vk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOhCAqalihsyFz6HI/p32ps7t0kJ1C0LOMwGSVOOPwiq5BYbM6DZ3kksiLt2hx5T/flOVp/iXozc21AgjBhc8Q7ZokzfP6LE6kSNCbnQ0brjDdIBEFPfT98JzcjIysEVrBYNrpiGPU998oajW2JSSp+fpVrltQ5LjL1UH/IvOK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxSb0mZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxSb0mZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711231F000E9;
	Tue, 28 Jul 2026 21:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785272750;
	bh=9feuxqLDiG1PwEdri6Yv9wRiS/yR6ZSPSzPscFQayKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GxSb0mZw+yJg5FajRcRjtiD3soctny8v7X6X/Qm6yYzk0YQC1ox6J9CjP5QZJKcTd
	 Q4OWzWYivQS6Zy+qPKzsTFGjwsiV870PoxkFEj5OZYCoM+W5n3h7zuMSmnD3egk707
	 iijPhV17KYPw9VTQrHGKKCKRi0h9yA45XLSZGsHWo3g1IP5XKsjnI8ZxwBVGeCALZW
	 3+iHBmkc4bSrX1VItei24mo1k3b2jGa0O4Ae0SZZxOdZz+0RkGyCO8sndIEZyHfoXD
	 9aSvqnwfDPsaq2w/ABwSNL4O4t1k85lZ1/zOGp4abataB2AkysFur6ABfPIDq3kGGf
	 SrPT0+bZAbVYg==
Date: Tue, 28 Jul 2026 22:05:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Conor Dooley <conor@kernel.org>, Janani Sunil <janani.sunil@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Marius
 Cristea <marius.cristea@microchip.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil
 <jan.sun97@gmail.com>, linux-spi@vger.kernel.org, Kent Gustavsson
 <nedo80@gmail.com>
Subject: Re: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <20260728220544.5c65bc50@jic23-huawei>
In-Reply-To: <e1f977a8-ab38-4dc6-a82b-b955545550a0@baylibre.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
	<20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
	<e2118cfc-feef-4843-917f-844834ef4e60@baylibre.com>
	<20260725230445.60a445a0@jic23-huawei>
	<20260728-barrette-rickety-788b47da503c@spud>
	<e1f977a8-ab38-4dc6-a82b-b955545550a0@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 13:39:20 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/28/26 11:10 AM, Conor Dooley wrote:
> > On Sat, Jul 25, 2026 at 11:04:45PM +0100, Jonathan Cameron wrote:  
> >> On Sat, 25 Jul 2026 15:55:01 -0500
> >> David Lechner <dlechner@baylibre.com> wrote:
> >>  
> >>> On 7/22/26 2:54 AM, Janani Sunil wrote:  
> >>>> Some SPI devices support sharing a single chip select across multiple
> >>>> physical chips by encoding a device address in the SPI frame itself.
> >>>> Add the generic spi-device-addr property for describing these hardware
> >>>> addresses. The property is placed on the SPI peripheral node and may
> >>>> contain multiple addresses.
> >>>>
> >>>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 +++++++
> >>>>  1 file changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> >>>> index 880a9f624566..b59d047cf117 100644
> >>>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> >>>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> >>>> @@ -142,6 +142,13 @@ properties:
> >>>>      minItems: 2
> >>>>      maxItems: 4
> >>>>  
> >>>> +  spi-device-addr:
> >>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >>>> +    description:
> >>>> +      Device addresses used when multiple peripherals share a single chip
> >>>> +      select. The array allows one logical peripheral to comprise multiple
> >>>> +      physical devices, with one address per device.    
> >>>
> >>> "per physical device" for clarity.
> >>>  
> >>
> >> We may end up relaxing that again if multichip packages start doing this.
> >> Fine to add that clarification for now. We can revisit when / if it ever
> >> needs that relaxing.
> >>  
> >>>> +
> >>>>    st,spi-midi-ns:
> >>>>      deprecated: true
> >>>>      description: |
> >>>>     
> >>>
> >>> If there is nothing useful the SPI core code can do with this information,
> >>> I'm not entirely convinced that this needs to be a common property.  
> >>
> >> I think being common does make some sense from a standarization point of
> >> view and it isn't obvious where to put it other than under spi.
> >>  
> >>>
> >>> And this only allows for one logical device. If we wanted to treat each
> >>> address as a logical device (all with same CS), we would need #address-cells = <2>;
> >>> instead where the DT "address" is two values, the CS and the device address.  
> >>
> >> Ah.  Good point for the adc@address or similar needing to match a combination
> >> of CS and spi-device-addr.  Conor any thoughts on how this would be done?  
> > 
> > I'm sorry, I don't quite understand. Why do you want to support both of
> > these representations? Hardware wise both of these things would be
> > describing the same setup, so allowing this alternate "multiple logical
> > device" typically is not permitted. What even is the use case of it?

The microchip parts.  They are entirely independent. The device address is
just a way to save pins.  That is contrasting those with the one in this
series where the design assumes you want to treat them as a large logical
device in a similar way to spi device chaining.


> > Does it matter at all if you have one or more logical devices from a
> > consumer perspective?
> > 
> > I do have an idea of how to solve the adc@address problem (you can do
> > adc@address,spi-device-address like some other devices) but as I said I
> > don't get why it would be needed.  

I think we should often do this because there are some confusing cases
otherwise. See below.

> 
> I would expect that if such a device was intended to be used as individual
> logical devices that they would just be wired up each with their own chip
> select rather than sharing one.
> 
> The only reason I can think of actually needing adc@address,spi-device-address
> would be on a system that was really short on pins on the MCU.
> 
> So not saying that we need it right now. Just wanted to make sure we were
> intentional about saying we don't need it if we don't.

To enumerate the cases:

1. One CS has multiple spi-device-address and needs to be a combined device.
	Given this ADC does some fun stuff to include messages with no
        spi-device-address that are meant to be received by all such
	devices we pretty much have to map any that share a CS to one
	logical device - we have to bind one driver.  This is kind of
	similar to SPI device chaining.
	address == cs.  spi-device-address property not used for that.
	- This one can be normal SPI style.

2. One CS has multiple spi-device-address but logically separate otherwise.
	This is the microchip devices I think.  For those the device-address
	is just a pin saving exercise.
	address == spi-device-address. CS not needed as there is only one.

2b.  Same as 2, but there is another normal ADC with a chip select.
	How do we know adc@spi-device-address vs adc@cs given they could
	easily take same address value by coincidence?

2c. Basically Case as 2 but * N CS all on same SPI bus.
	As David calls out this is the pin count minimization case.
	E.g. I want 8 devices each of which has 2 pin straps to set the
	device address.  So I have to use at least 2 CS.
	For this I need both cs and device-address and Conor's suggestion works.

There is a case of 1 + 2 with different device types but result is same
as 2c.

Now, to me the question is whether we say that if spi-device-address is
present you always do adc@cs,spi-device-address or do we allow for not
doing so for the composite devices where nothing else is sharing the CS
(like this driver).

My inclination is standardize on always doing it for these devices.

Jonathan

> 
> 

