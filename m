Received: from outbound7.mail.transip.nl (outbound7.mail.transip.nl [136.144.136.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD053E3172;
	Mon, 15 Jun 2026 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522910; cv=none; b=mXX3yKXrCmCdbsKh4DWykOTyN9fZ8W9p0ly4otUTDIUdjCBC5CK9kZzq0mvHr423D9COYcX1Kc2QhKb6DJXJIh+8sFvE/eqNgmygqLt6wOlHKcgqD+eBhDydoCUaiO0/crupX6jVwDajJl74A92OZQdSNxssfq+Dr3mHnQaS7+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522910; c=relaxed/simple;
	bh=VyF+tEcxEs62cFwn6ieRGy2ts08RJpAiM5Fc/+TM/tM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=m7c+323DRpRKos4MUK+KLToLizMA3fOdkAS2AnRFpOcWBcvlTouCa0bDoa9K8loHt9xM3Ncsr919HhpR6adPEjsl/8nMV9gIgl2ZsHpArwb2aYtoF/FBJjFYQFOv/wTHgNhK4GX7K8G5ZDenIF2Q2VU9AwylsJrkl5ubNzoTVBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=R33EQat/; arc=none smtp.client-ip=136.144.136.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="R33EQat/"
Received: from submission9.mail.transip.nl (unknown [10.103.8.160])
	by outbound7.mail.transip.nl (Postfix) with ESMTP id 4gf72W6HgXzQvwk1;
	Mon, 15 Jun 2026 13:20:19 +0200 (CEST)
Received: from transip.email (unknown [10.100.4.34])
	by submission9.mail.transip.nl (Postfix) with ESMTPA id 4gf72W1yTrz3NZKgd;
	Mon, 15 Jun 2026 13:20:19 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jun 2026 13:20:19 +0200
From: me@herrie.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, github.com@herrie.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, tomasborquez13@gmail.com,
 masneyb@onstation.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: light: isl29018: add
 isil,cover-comp-gain
Reply-To: github.com@herrie.org
Mail-Reply-To: github.com@herrie.org
In-Reply-To: <20260614205131.7449d180@jic23-huawei>
References: <20260604100617.3486541-1-github.com@herrie.org>
 <20260604100617.3486541-3-github.com@herrie.org>
 <20260604-energy-lid-e7949164431a@spud>
 <20260605140449.1d7538ee@jic23-huawei>
 <b6919a62f06ad8e4e80232d9b2a0e706@herrie.org>
 <bb7c65095dc53dd8723c1ecd9c33796c@herrie.org>
 <20260608-raft-auction-6305f9f324cd@spud>
 <20260614205131.7449d180@jic23-huawei>
User-Agent: Webmail
Message-ID: <5ab0c054be89432db7cf6917f2528a30@herrie.org>
X-Sender: me@herrie.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission9.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1781522419; h=from:reply-to:subject:to:
 cc:references:in-reply-to:date:mime-version:content-type;
 bh=/OiORrqSOn5XJRaVbRclzkXa59IhgUb4CGdw0dXXDxQ=;
 b=R33EQat/Vj9Tkib92GCeVN5WnFcvdoqBEw6PqufPaNIJc7Rt7ZUf1ksc1S/SVmb0wrw6ZG
 tlzZCOkTODHMuG/wXEiEe6jbQroj0RNdRICWD2lZlg2KZmIvaSLeJ7eXA7s2h5Ysd02o/i
 pcE/p4GObYzjqCnTSxqzgccyZxqveAd/cwROqqwiB0k32F9ovn+5tbUVowCoTHU7z3Idx7
 bYdihawBiRLEuB+oS40ms7cw89OKczo2sA4STz7guW5GswhC8DywRe1ezhv/IftkMW3euv
 X8tWrhQfbb4NQjrAuInn3tHLFdN7AXH7G0yW/F1NY+7Mc9f8fzTbiXrDNSyXQQ==
X-Report-Abuse-To: abuse@transip.nl

On 2026-06-14 21:51, Jonathan Cameron wrote:
> On Mon, 8 Jun 2026 18:49:13 +0100
> Conor Dooley <conor@kernel.org> wrote:
> 
>> On Fri, Jun 05, 2026 at 09:28:03PM +0200, me@herrie.org wrote:
>> > On 2026-06-05 15:18, me@herrie.org wrote:
>> > > On 2026-06-05 15:04, Jonathan Cameron wrote:
>> > > > On Thu, 4 Jun 2026 18:01:08 +0100
>> > > > Conor Dooley <conor@kernel.org> wrote:
>> > > >
>> > > > > On Thu, Jun 04, 2026 at 12:06:16PM +0200, Herman van Hazendonk wrote:
>> > > > > > Document the new optional property that seeds the ISL29018 calibration
>> > > > > > scale factor at boot from firmware, allowing boards with tinted cover
>> > > > > > glass to ship with correct luminance readings without a userspace helper.
>> > > > > >
>> > > > > > The value is a positive integer (minimum 1, maximum 65535) that is
>> > > > > > multiplied with the raw lux reading.  Userspace can still override it
>> > > > > > at runtime through in_illuminance0_calibscale.
>> > > > > >
>> > > > > > Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
>> > > > > > ---
>> > > > > >  .../devicetree/bindings/iio/light/isl29018.yaml     | 13 +++++++++++++
>> > > > > >  1 file changed, 13 insertions(+)
>> > > > > >
>> > > > > > diff --git a/Documentation/devicetree/bindings/iio/light/isl29018.yaml b/Documentation/devicetree/bindings/iio/light/isl29018.yaml
>> > > > > > index 0ea278b07d1c..92ea2742bbd3 100644
>> > > > > > --- a/Documentation/devicetree/bindings/iio/light/isl29018.yaml
>> > > > > > +++ b/Documentation/devicetree/bindings/iio/light/isl29018.yaml
>> > > > > > @@ -34,6 +34,19 @@ properties:
>> > > > > >    vcc-supply:
>> > > > > >      description: Regulator that provides power to the sensor
>> > > > > >
>> > > > > > +  isil,cover-comp-gain:
>> > > > > > +    description: |
>> > > > > > +      Multiplier applied to the ambient-light reading at startup to
>> > > > > > +      compensate for optical loss in the board's cover glass. Boards
>> > > > > > +      that mount the sensor under a tinted or coated window typically
>> > > > > > +      need a value between a few and a few hundred.
>> > > >
>> > > > Is it useful to support decimal points on these values?  The
>> > > > userspace interface
>> > > > does and you mention the 'right' answer might be only a few which
>> > > > means precision
>> > > > at that range will be terrible - less of an issue if 100s!
>> > > >
>> > > > Thanks
>> > > >
>> > > > Jonathan
>> > > >
>> > > Hard to say, my old HP TouchPad needs 100 as a value here (taken from
>> > > legacy 2.6.35
>> > > kernel and binaries). So we probably don't need precision, but I have no
>> > > other
>> > > references to substantiate.
>> > >
>> > > Thanks
>> > > Herman
>> > Scratch that. Did some more research. Proof is in the legacy webOS binaries:
>> >
>> > What legacy webOS actually does here:
>> >
>> > 1. Per-device calibration via factory token reads an ALSCal token from
>> > system storage
>> > containing JSON with calibration points at lux_0, lux_50, lux_100, lux_400
>> > (measured
>> > ADC counts at known reference illuminance levels).
>> >
>> > 2. Computes a floating-point ratio AlsToLux_Ratio_WhiteLED = average of
>> > expected_lux /
>> > measured_count across the JSON calibration points. This is a real number,
>> > not an integer.
>> >
>> > 3. Adjusts for light source spectrum at runtime detects illuminant type from
>> > ALS:IR
>> > ratio, then applies a fractional spectrum correction:
>> > Fluorescent above 100 counts: ratio x 0.4652
>> > Incandescent above 700 counts: ratio x 0.4
>> > Incandescent 50-100 counts:    ratio x 0.9
>> > Fluorescent < 50 counts:       ratio x (-0.000724·N + 0.7463)
>> >
>> > 4. Final lux = ALSCount / spectrum_corrected_ratio - a true floating-point
>> > division.
>> >
>> > Implications
>> >
>> > - The "right" cover-comp value is per-device factory-measured, not
>> > per-board. Different
>> > units off the same production line have different optical transmission due
>> > to coating
>> > tolerance.
>> > - The values are fractional by nature. Examples from the legacy code:
>> > 0.4652, 0.7463,
>> > 0.8333. None are integers.
>> >
>> > The ISL29023 datasheet itself says nothing about cover compensation - it's
>> > strictly
>> > board-level optical correction. So there's no "right" answer from the chip
>> > side;
>> > it's whatever the board's cover glass + coating attenuates.
>> >
>> > ALSCal values found on the particular device:
>> >
>> > {"lux_50":{"c":31}, "lux_100":{"c":58}, "lux_400":{"c":164}}
>> >
>> > This is device specific TouchPad's factory calibration:
>> >   - At 50 lux, ADC reads 31 counts  lux/count = 1.613
>> >   - At 100 lux, ADC reads 58 counts lux/count = 1.724
>> >   - At 400 lux, ADC reads 164 counts  lux/count = 2.439
>> >
>> > Note the ratio isn't constant - the response is mildly non-linear, but per
>> > the legacy
>> > code the driver computes the average ratio as the calibration:
>> >
>> >   ratio = (1.6129 + 1.7241 + 2.4390) / 3 = 1.9253 lux/count
>> >
>> > Independent verification:
>> >   - At calibscale=34: lux = 1295
>> >   - Implied raw count: 1295 / (34 x 0.015258) = 2496 counts
>> >   - Applying legacy formula: 2496 / 1.9253 = 1296.4 = 1295
>> >
>> > The factory-calibrated value for this specific TouchPad is 34.04 (not 100).
>> > Per-point
>> > calibscale values from the ALSCal JSON:
>> >
>> > Cal point‚ lux/count ratio‚ Equivalent calibscale
>> > lux_50    ‚ 1.6129          ‚ 40.64
>> > lux_100   ‚ 1.7241          ‚ 38.01
>> > lux_400   ‚ 2.4390          ‚ 26.87
>> > average   ‚ 1.9253          ‚ 34.04
>> >
>> > What this means concretely
>> >
>> > 1. Decimal precision is necessary, not nice-to-have. Real per-device factory
>> > values
>> > span 26.9 - 40.6 across the chip's response curve. A single scalar
>> > approximation costs
>> > precision; restricting to integer compounds it.
>> >
>> > 2. Updated v5 plan: switch to two-cell <int micro> for fractional values,
>> > and change
>> > the tenderloin DTS default from <100> to <34 040000> (or close to that).
>> >
>> > Thoughts on this?
>> 
>> Instead of going 2-cell, it might be worth moving the property to be
>> based in some fractional unit to begin with. I just don't know what to
>> call that, milligain? I dunno.
>> 
>> 
>> Jonathan's call here I think
> 
> If this is varying that a lot per device, then, unless you plan to
> have a bootloader inject it into DT, are we better off making this
> a userspace problem?  There is a hybrid we've done before, which is
> to make it a firmware loading problem but that requires some way to
> generate a suitable file to load and typically a calibration sequence
> that goes with it.
> 
> If it is 'fairly constant' for a given device then fine to be in DT
> - it will just be a case of picking the average of a bunch of measured
> devices and assuming it is good enough.
> 
> If it does end up in dt, then a fractional type like Conor suggests
> is fine.
> 
> Jonathan
Hi Jonathan,

I have about 8-10 devices in slightly different configurations using 
this I guess,
so I can quickly run the numbers and see how the values look like, so we 
have more
data to go by.

Thanks,
Herman

