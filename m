Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEF937B407;
	Sun, 13 Sep 2026 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789337949; cv=none; b=i9tOlUyjBXvdPfnrT3BwoGLW9FBbYQjQCENXriuhi87XdyLomb/oqBKopWsfgiYZWqupyA6P94hKdIf/1LEqrdHUwt4HO9rc4bHGRUPL8FLjiMbFPdBe1yVANfwVWYICIFBDhJw7+nMCduBGHUiH7utdU9Ua25DQ4xqVAtiXtpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789337949; c=relaxed/simple;
	bh=9h7waPu3gIXu9ur1V8f/z2/l/b7N5vAdaPWMvOEwbTA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqXMcULQALvYsALUI1vhvugATtzP/b63SfvSkm+kXXPCbnsJMTVuLQA9GdTFW5doXPcBq0RKtJjZ67uyn7SBj3wfknkweK88I7YLNytTquChEdVU7ZI9s9gVE98XUOELI23KcQw/HLdqxdpURPYy3Z+JGEfDacizDgafA7Ta+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOCfBdJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOCfBdJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007041F000FF;
	Sun, 13 Sep 2026 22:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789337946;
	bh=7a/JZ0iT8+k5e8UbON52DAMFH7IysCze2tHoanwgWr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JOCfBdJPB3eWuCM0m6KqSlaxi69UdTyfN1ip0LC5bjbgOcYHocSTp2G2tVdZTas4Q
	 0Ap+LZXiAg5Y0bnztDoGM/7vb4o2ekjZExn9EbP1kZ2Rh+BHAaYmclDmxkwkWs/Vbe
	 tKP3L1M/qJIvZQSBVB+PuqTdcrS/i+kKjEz3yZfp+Cg0CFIjPiYjQQC3lK1Bm/Z9n0
	 203PhOjuuCBrikY1DLkABOazO1FHbBHaqHUBN1+ekhhdIo/p+mF6h6DTVkr3C2i5jG
	 gVNvXiFKlocjwDwMJvaoWRvy1MsF0gbnRnuzE00HvzWOopOqL/3rmfEP6rNnI/PG8F
	 2InkZW9AbzoeA==
Date: Sun, 13 Sep 2026 23:19:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Radu Sabau <radu.sabau@analog.com>, Salih Erim
 <salih.erim@amd.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 "Jakub Szczudlo" <jakubszczudlo40@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 3/4] iio: adc: ade9000: add support for ADE9430
Message-ID: <20260913231904.6ba87d79@jic23-hlaptop>
In-Reply-To: <20260907101623.8730-4-antoniu.miclaus@analog.com>
References: <20260907101623.8730-1-antoniu.miclaus@analog.com>
	<20260907101623.8730-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2026 13:16:20 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADE9430 is a polyphase energy metering device that is register
> compatible with the ADE9000. The differences relevant to the driver are
> the absence of the on-chip dip/swell detection, the absence of an on-chip
> digital integrator (the ADE9430 uses an external analog integrator for
> Rogowski coils, so the DICOEFF register does not exist) and slightly
> different full-scale ADC codes.
> 
> Reuse the dip/swell-less channel table introduced for the ADE9078 and add
> a matching chip_info describing the ADE9430 full-scale codes. Add a
> has_digital_integrator flag to the chip_info so the DICOEFF write is only
> issued on parts that implement the register, and skip it for the ADE9430.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

I guess it is simple enough that I'm not that bothered, but my
normal preference would be to introduce the 'has_digital_integrator'
as a precursor where all device set that to true, then follow up with
the new part.

> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> index 0f64bfb221da..2f5fe016a82f 100644
> --- a/drivers/iio/adc/ade9000.c
> +++ b/drivers/iio/adc/ade9000.c

>  };
>  
>  struct ade9000_state {
> @@ -668,6 +670,7 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
>  
>  ADE9000_DECLARE_CHANNELS(ade9000_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL);
>  ADE9000_DECLARE_CHANNELS(ade9078_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS);
> +ADE9000_DECLARE_CHANNELS(ade9430_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS);

It it is identical. Just use the ade9078_channels.  This sort of reuse
of exiting chan_spec arrays on new devices is very common in drivers
that support a lot of parts.  Don't worry about the name. They should
be named after the first device that needed that particular chan_spec
array.


