Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7625F99F;
	Tue, 23 Jun 2026 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227324; cv=none; b=HmAmxmGrG9xu50gXSCGwjIOegBE+8x8Q31yeOeVkm4iCA/fXLIoe0qg5ehAkw6f2PecaQ/Gtu7KD/a9fU3FWupv2a0sxh/S1OKEH/Nd51TW4vRdrCkTpYCG6Wa7bz+XdfBrCjF3cawrxuIiNSeaYQ+9sUGpnhQffT9d95RTcTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227324; c=relaxed/simple;
	bh=swxMVi2/5GBeOkGZeUcQqpnIRK2v0l4JWY5Im7sAicQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VucKX12fKTECra7jHksFVc0UbLRmRwAjKSg5vJWcPux7o1ZWQ+jEAhscHc8sgK31f5Qmq69I9yBn9N9deHOpKgdegc/QrAbMzfPZgKnwMb2G6Q+maTOH3hFTnLr/NG3MR9A1VqsJna9tiDCDJvLTat9wWT2FpWafZRzq72v2szI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDRHYHKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDRHYHKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EDD1F000E9;
	Tue, 23 Jun 2026 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782227323;
	bh=lgxErHiAsUx2zyUgJpjq3vm+qoyUS3A23oDYQHZoGvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lDRHYHKw2S+xore/XuR0msYqrpqVZttTY/ssE+cnEcpCB88RupjnmQe0+xgBQc81O
	 TISPJ363pHWDuvzAfFhVOqlYBiCMf/HelXPrGk8IcbKqsE2aNHRBi3j3FnX/+kyzNI
	 Owb/7XlfB1dBhmSkEEBhqfvDl0Stjpx5nwDFtHwVRajtMDN0PhGU6iH/JPcxEW5Y/x
	 LXgsQOkdShXslTv9OCivzytOJhM2WU46XuZurg4m4ypcTgrpJhGyfB2K/BWZTsUHjj
	 Sk+g3O4WXXOzqdu4My9ag9DDlO3E9uDzjuTNNTv5dXGFiULb2rmGaW+fhJE2YP8zRy
	 vRT/1/jVzmr5g==
Date: Tue, 23 Jun 2026 16:08:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Rodrigo Alencar
 <455.rodrigo.alencar@gmail.com>, Janani Sunil <jan.sun97@gmail.com>, Janani
 Sunil <janani.sunil@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260623160830.42833ba9@jic23-huawei>
In-Reply-To: <20260622-captive-tux-067efd31ceac@spud>
References: <076d7d2d-81a0-49c2-af94-bd65ead66c09@gmail.com>
	<20260619-obstinate-polo-a230bef97fda@spud>
	<20260619-bunch-diocese-dd7805cc17ff@spud>
	<ajU73_TkKrSbqD4f@nsa>
	<20260619-concierge-doozy-9c161533c369@spud>
	<ajVlD-j0nIGrRVow@nsa>
	<20260621153330.79b6600c@jic23-huawei>
	<5u4dnsgxwcwie45f24cacyzf3dko4srhyyyhcpom6tsvhqtmpc@y7d7gmex6n7k>
	<ajkMBh-R_7pYaoAn@nsa>
	<20260622172911.48259a0c@jic23-huawei>
	<20260622-captive-tux-067efd31ceac@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 19:39:43 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Jun 22, 2026 at 05:29:11PM +0100, Jonathan Cameron wrote:
> > > > > Yeah. It's not clear to me how that works for the microchip devices
> > > > > (I suspect it doesn't!)
> > > > > 
> > > > > Just thinking as I type, but could we do something a bit nasty with
> > > > > a gpio mux that doesn't actually switch but represents the GPIO being
> > > > > shared?  Given this is all tied to the spi bus that should all happen
> > > > > under serializing locks. 
> > > > > 
> > > > > Agreed though that this would be nicer as an SPI thing that let
> > > > > us specify that a single CS is share by multiple devices and their
> > > > > is some other signal acting to select which one we are talking to.
> > > > >     
> > > > 
> > > > If the device-addressing on the same chip-select is to be handled
> > > > by the spi framework, wouldn't we lose device-specific features?
> > > > 
> > > > I understand that this multi-device feature is there mostly to extend the
> > > > channel count from 16 to 32, 48 or 64. I suppose the command:
> > > > 
> > > > 	"MULTI DEVICE SW LDAC MODE"
> > > > 
> > > > exists so that software can update channel values accross multiple devices.    
> > > 
> > > Right! You do have a point! I agree the main driver for a feature like
> > > this is likely to extend the channel count and effectively "aggregate"
> > > devices.
> > > 
> > > But I would say that even with the spi solution the MULTI DEVICE stuff
> > > should be doable (as we still need a sort of adi,pin-id property). 
> > > 
> > > But yes, I do feel that the whole feature is for aggregation so seeing
> > > one device with 32 channels is the expectation here? Rather than seeing
> > > two devices with 16 channels.  
> > 
> > Agreed - if we have messages that address both devices at once that needs
> > to be a unified driver and given they are about triggering simultaneous
> > update of all channels it needs to look like one big device.
> > This ends up similar to how we handle daisy chain devices.
> > 
> > The question of what to do on devices that don't have this feature
> > is rather different. Good thing you read the datasheet :)  
> 
> I'm not sure it really is, the intent for the microchip devices I think
> is pretty similar. The mcp3911 datasheet cites three-phase power
> metering using three devices as a typical use-case, for example.
> Probably creating an amalgamated device is a good fit there too?
> 
> I assume an amalgamated device for this ADI product means per-channel ID
> properties?

Per device as they are 8 channel each, but effectively the same.
(microchip devices are 2 channels each I think)

> If so, I think they should be made generic and the Microchip
> products retrofitted to use them, with a fallback to the proprietary
> property. Not going to ask for the support for multiple devices in those
> drivers, since the current way doesn't work and there'd be no loss of
> support. Someone from Microchip can do that. The proprietary property
> to generic conversion should be straightforward and provides weight to
> an argument for this being generic, since that'd be three devices that
> can all share?

I think the practical difference is that for the ADI part we have to support
it as a single device as some commands effectively don't use the address
bits in the message.  For the microchip ones we could register multiple
separate SPI devices and just provide one address for each.

Equally we could treat the microchip ones as a unified device in which case
the binding will be the same and there will be a property with a bunch
of addresses (one for each device present). I'm fine with this option given
as you say the datasheet calls out using this for channel expansion.

Jonathan



