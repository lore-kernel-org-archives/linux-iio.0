Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8417426F2BF;
	Sun, 23 Aug 2026 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787448982; cv=none; b=gQxh5AUc5s/E78LWowK3zxO8hMdZVk56iL4KcsJ65+e1+xRpoxDCRUjlWJW6WjiIhur1Vcw7qjfZ7BPkiHW3EVyHdERC0Eor6losraV5O6G3slDmEr8/mPPq/h8/v8ayFCYGw6fkl10vGkFeLTsJ6fhdzEo9tU4+hvxxgxlBE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787448982; c=relaxed/simple;
	bh=rGy1C5KTGmpezarM35jPwARJEsjZ/lcCaKEJ0PglKRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvPJPh79/iXhcawhV6n1a72m+iplMDmJswH04njHzxZn2hYh6l6ecv9UNLikMxzQVq/D/YXtLnVDn/TmqKFTrGGmTJK459C8GvZX95Bwo61duHXjdESNdRBzguuwU++jVEzIFlMtrScvnAo8EuVEIA+UJE3lt5cebVBnpSAPFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTlq7o8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTlq7o8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626E71F000E9;
	Sun, 23 Aug 2026 01:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787448981;
	bh=ZMyHtFrQUE8eFUZwUf19+PrFwGzliaDJUM4zDSpNMvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fTlq7o8Wz+pa5H/3X4aaFELD32YVuO/MJHtZmPre8cQlQGAhm7hgh0PSzXJRfBH7S
	 dllZ3QbJTWARGBcd1sZQxRuAzqZxq1WLz9o3iFDHHiv4RnNgb/Ai/K/daCYTjg5v6t
	 rswbErNTDXltrA7Sq8MS+1S6nrouJAXyDgcKXK5jHJEhEaaKBj+zuA9kbxlaiaLexp
	 L6DKmw2smSGX1xXWXHC4rNE6zcIQsH0RUkyWLENxXA0zoqFeyQdztZshzLpU+o5Xnl
	 5vfP1PWlV2b/YuNhWFTxJGrzDVHzBGGijlvEYRx/1vVCpuXujVpnZD9XtVvTOAIV/I
	 Xz3XdNTU3FU+A==
Date: Sun, 23 Aug 2026 02:36:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Taha Ed-Dafili <0rayn.dev@gmail.com>, Michael.Hennerich@analog.com,
 andy@kernel.org, conor+dt@kernel.org, conor.dooley@microchip.com,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
 nuno.sa@analog.com, robh@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: dac: ad5504: add output-range
 and missing gpios
Message-ID: <20260823023613.077ea05d@jic23-huawei>
In-Reply-To: <c34ed727-9ece-48f4-a7b7-45b0f5f558e3@baylibre.com>
References: <f35aea7d-0844-426e-ac81-d5b156b60e4a@baylibre.com>
	<20260822193621.18800-1-0rayn.dev@gmail.com>
	<c34ed727-9ece-48f4-a7b7-45b0f5f558e3@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 17:37:22 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/22/26 2:36 PM, Taha Ed-Dafili wrote:
> >> This is one that is starting to emerging as a common name, so I would
> >> call it clear-gpios instead to match the same name on chips with a
> >> similar function.  
> > 
> > Worth noting Nuno asked for the opposite in v2 review, specifically
> > to match the datasheet's /CLR pin name:  
> 
> Normally I advocate for matching the pin name too. But there are some common
> things like reset-gpios where we try to always use the same name. This clear
> input seems to be one of those common things.
> 
> > 
> > https://lore.kernel.org/linux-iio/a79296dc96215a579c29c5c9eda464f818f050d6.camel@gmail.com/
> > 
> > Let me know which name you'd prefer given that context, and I'll
> > update it in v7.
> > 
> > Best Regards,
> > Taha Ed-Dafili  
> 
> 
> There is only one binding currently with clr-gpios (adi,ltc2688).

That one is a reset I think. Includes "The control registers are cleared
to default values".  It sort of clears the DAC as the default is 0V
So probably like 3 below.

> 
> And only one with clear-gpios (adi,ad5791). Plus at least two more coming
> soon [1] [2].
ad5701 clr sets it to a user defined value..  If that's left as default it
sets to 0. That does overwrite the dac register (table 9)

ad5529r actually calls it clear on the datasheet. And just sets DAC outputs
to 0 (including the registers)

dac8163 is 0 scale, or mid scale depending on part. Registers written.
> 
> In [3], there is a /CLR pin, but we called it reset-gpios because it also
> resets the control registers.
> 
> I didn't re-check the datasheets on all of these, but hopefully we are being
> consistent.
Other than the one that maybe should have been a reset and isn't :(

They aren't quite the same across parts but close enough perhaps to generalize
the binding with some flexibility in the description.

Jonathan

> 
> [1]: https://lore.kernel.org/linux-iio/20260820-ad5529r-driver-v9-2-ba62e0b2a816@analog.com/
> [2]: https://lore.kernel.org/linux-iio/20260802-dac8163-work-v3-1-3ecc7bc66d0d@gmx.net/
> [3]: https://lore.kernel.org/linux-iio/20240714133000.5866-5-kimseer.paller@analog.com/
> 
> 
> 
> 

