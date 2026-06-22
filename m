Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168D926980F;
	Mon, 22 Jun 2026 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122555; cv=none; b=HCiDGFcmXULIi3h5dUpqCXH75s8M2pjuPtav7xdCLfhc7TEC+JGZIqKzTvfUqwpeIdbHX6WrkEJIhLVK74/e032lgf58F2C/FQJ8MHz8r5AJvPljKgYS/yErR9gGi5Go16byib/NpQ7FL4Pbi1W1IPSUDj4PcSKSruCJvaJnWCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122555; c=relaxed/simple;
	bh=uJ6xfrthPRo4iAVkc3LYOHjfMuL1yu3hgBF/D3qS6AM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unPoLhQ5xiN7UR7Mg4JZOjgNH4rqrzS/I+PGSYVtWNUQGI8HNlFQY7jXmLJRtB2WEF1How8qw+C1SxBszV1LbDcodnmofghOQySq4xgOre9v8rSm8AGPpiMsEHonxaIHwyiIHqa28voa4596ROLEm8iH9jaxu2VKHZtrevhmm7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+Rwzdkc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+Rwzdkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00091F00A3A;
	Mon, 22 Jun 2026 10:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122553;
	bh=sgnV9b33LJlANpB3dzslfoDuod+2n+fH4n9BXQl4avc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W+RwzdkcOHkhlclqrzghh8dPQWmINSnGQisn1uLQHUPgYqQIw7LaAvB8NqhH9ce9t
	 0Ukqj/+m1lg9Vkun/MXuadCLr3eLS7AwJzHmggoPgdUj6zOZl4XmCD3g621Y7DoLS8
	 gAgZ0UkF3gpIFG32Y7PEqlEcLG6oTsKVrN52Mydvc0o/IhTNZMfYK1ydDI7ks7aGrO
	 qk0iSCfuOXDH6NpuU9Lipcn+WsbQfFXWy1An15doEjdxxQ+FV/mw1ar2oeeiK9fESP
	 bS/jeCJOTKR3d3sd64R9iHcICAjIga5UldVg2+8Mie4wOPpysRT0JFIbsy1EKdFnSW
	 I0XmURej5fXXQ==
Date: Mon, 22 Jun 2026 11:02:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Kurt Borja" <kuurtb@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Nguyen Minh Tien" <zizuzacker@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] iio: adc: new ti-ads112c14 driver
Message-ID: <20260622110223.7e854dde@jic23-huawei>
In-Reply-To: <DJF5LHOE6368.2QCY5LIPT8098@gmail.com>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
	<DJA1J8D91ESA.2XU7OCVKN7LXU@gmail.com>
	<d3270250-ae18-4c0f-a0fe-e0fdabfce046@baylibre.com>
	<DJANEYYA4QTA.1JBN2L78PNXDD@gmail.com>
	<9b8d5cfc-e392-45aa-9adc-867c364dd36e@baylibre.com>
	<20260621201412.0ce54fa8@jic23-huawei>
	<DJF5LHOE6368.2QCY5LIPT8098@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jun 2026 19:32:29 -0500
"Kurt Borja" <kuurtb@gmail.com> wrote:

> On Sun Jun 21, 2026 at 2:14 PM -05, Jonathan Cameron wrote:
> > On Tue, 16 Jun 2026 13:16:46 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >  
> >> On 6/16/26 12:26 PM, Kurt Borja wrote:  
> >> > On Tue Jun 16, 2026 at 10:21 AM -05, David Lechner wrote:    
> >> >> On 6/15/26 7:18 PM, Kurt Borja wrote:    
> >> >>> On Mon Jun 15, 2026 at 4:59 PM -05, David Lechner (TI) wrote:    
> >> 
> >> ...
> >>   
> >> >>>> All of these chips have in common that they are designed for use with
> >> >>>> RTDs and thermocouples and so they look very similar to each other in
> >> >>>> terms of wiring and feature set, even if the register maps are
> >> >>>> different. They are in the gray area where we could either keep them
> >> >>>> separate because they are just different enough, or we could do like
> >> >>>> we've done before with ad_sigma_delta and have a bit of an abstraction
> >> >>>> layer for the register differences and otherwise try to share as much
> >> >>>> code as possible. Normally, I would lean towards keeping them separate,
> >> >>>> but in this case, I'm considering trying to share code because the
> >> >>>> devicetree bindings for the inputs is complex and is going to be mostly
> >> >>>> the same across all of these chips.    
> >> >>>
> >> >>> The channel configuration is indeed very similar for the three chips.
> >> >>> All three have IDAC, BOC and VREF configurations.    
> >> >>
> >> >> Hmm... I forgot to include the burnout current in the DT bindings. Following
> >> >> the channel = "conditions for measurement" pattern that I have set out here
> >> >> I guess that would mean that we would need to have the same inputs twice
> >> >> when using the burnout. One "channel" would be the one used to do a "precision"
> >> >> measurement and the other would be the one to do open/short circuit detection.
> >> >>
> >> >>
> >> >>     i2c {
> >> >>         #address-cells = <1>;
> >> >>         #size-cells = <0>;
> >> >>
> >> >>         adc@40 {
> >> >>             compatible = "ti,ads112c14";
> >> >>             reg = <0x40>;
> >> >>
> >> >>             avdd-supply = <&avdd>;
> >> >>             dvdd-supply = <&dvdd>;
> >> >>
> >> >>             refp-supply = <&avdd>;
> >> >>
> >> >>             #address-cells = <1>;
> >> >>             #size-cells = <0>;
> >> >>
> >> >>             channel@0 {
> >> >>                 reg = <0>;
> >> >>                 diff-channels = <1>, <2>;
> >> >>                 excitation-channels = <0>, <3>;
> >> >>                 excitation-current-microamp = <500>;
> >> >>                 current-chopping;
> >> >>                 ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
> >> >>                 label = "rtd-precision";
> >> >>             };
> >> >>
> >> >>             channel@1 {
> >> >>                 reg = <0>;
> >> >>                 diff-channels = <1>, <2>;
> >> >>                 excitation-channels = <0>, <3>;
> >> >>                 excitation-current-microamp = <500>;  
> > Maybe use an example with more stuff changing? Do we want same excitation
> > for burn out? I've no idea.
> >  
> >> >>                 burnout-current-nanoamp = <1000>;
> >> >>                 ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
> >> >>                 label = "rtd-diagnostic";
> >> >>             };    
> >> > 
> >> > This would mean we wouldn't be able to use iio_chan_spec .channel and
> >> > .channel2 to describe inputs because of duplicate sysfs attributes, no?
> >> >     
> >> 
> >> Yes, that is a bit unfortunate. At least there the labels to tell them
> >> apart. I guess we would just need to use consecutive channel and channel2
> >> when dynamically allocating the channels to avoid conflict.   
> >
> > From a very initial look, maybe do something similar to the folk have
> > been looking at for the more complex DDS devices where we have lots
> > of channels that are on the same 'wires'.  Basically add a numbering
> > scheme to keep them reasonably separate - channel numbers are cheap.
> > Maybe first channel is 10->1f, second 20-2f etc.  They are differential
> > so it will get ugly.  Perhaps have a play around and see if there is
> > a reasonable channel naming scheme for this 'same inputs, different thing
> > being measured case'  
> 
> May I also suggest having some sort of IIO_VOLTAGE_DIAGNOSTIC channel
> type? Would that be worth the trouble?

Nope. That would get messy fast as any channel type could have a diagnostic
variant.   If we only ever want to poll it from sysfs we could use
an info_mask element so in_voltageX_burnoutraw or something like that.

> 
> We could also maybe just drop burn-out current completely from
> dt-bindings and add IIO_CHAN_INFO_BURNOUT_CURRENT. Given that this
> feature is only used ocasionally for diagnostic purposes (I assume...).

I did wonder if we just push this either into debugfs, or into an
events type interface.  So poll it every now and then or on demand.

> 

