Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15333987E;
	Fri, 24 Apr 2026 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050166; cv=none; b=iFriZ5jqAKnZkfaUEW7PXlKsoPJNm4YSirLvOnMZMWoKg/OUVyn+XpFblu9qrXh8TbX0eGleyJzG/t+KsPWc3inCWlIPEPh8Fj7ftdeDkx9kdQeKwWrv96cGQqh0X/rNwA2Bgz28n5TfKgOfynzEswrAmO7Lv48yjVbalpn3S7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050166; c=relaxed/simple;
	bh=uqzsbccj3Dgkca8d0rOxX0X6qxKogMm1MwQifoj5s+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJDsYksAdTqX5F7oMl+m8yWWdrcInHEx9BoXqG93cr8EW35ZgFKGXKSkH7fgCOTOw8GWmW1/6iBDwBnuJTG+o0NRi3D/M9DnsrprsGjNm8CAw9ov1abxGcW2Msa7zZROB15VANsFNRxv1p6Pkg3dJm0Fy+M8yMCtRaOTZQcRRf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U91G8c1d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U91G8c1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1A3C19425;
	Fri, 24 Apr 2026 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050166;
	bh=uqzsbccj3Dgkca8d0rOxX0X6qxKogMm1MwQifoj5s+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U91G8c1dElZdqg38sSti1bxHVAUCMGBVP6aenc+n4DABi+M2jKLTMDYKLCI1RyRC9
	 mvvI3iyXIDvDPyQwA+84qbpnMFEhT1ilX13xScPgYpDAUL/KC+tAf3EKQMsVOU7pU8
	 LLWZALhMWrvBMx6QNxp8PWh/WL+T3jyutQSdN+PZ4S62zyuATLed1Kf8daqYb+V4EO
	 rvhFLXbQgpXk4rAKGl2VGpmc6msgCRSGIo1Vsu1Z2C07HldKBs3Orv67xS+p8VvMSG
	 RhozLzdNIgxyGdQCEJq/4drQYFTaVq+BwBf7XJWLIC1qq0aAlMleJsfN7962sv2YsZ
	 rgYnRp+3+uj2A==
Date: Fri, 24 Apr 2026 18:02:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Auchter
 <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees
 Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 20/22] iio: dac: ad5686: implement new sync() op for the
 spi bus
Message-ID: <20260424180235.22bdf98c@jic23-huawei>
In-Reply-To: <umhebqm7nwcg6h5y77egrh7nirtpjpin5t42oxifo5em4jmsyj@gavxnwsadyuh>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
	<20260422-ad5313r-iio-support-v1-20-ed7dca001d1b@analog.com>
	<20260423191833.0de9fb8c@jic23-huawei>
	<umhebqm7nwcg6h5y77egrh7nirtpjpin5t42oxifo5em4jmsyj@gavxnwsadyuh>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 09:58:39 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/04/23 07:18PM, Jonathan Cameron wrote:
> > On Wed, 22 Apr 2026 15:45:54 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Use of local SPI bus data to manage a collection of SPI transfers and
> > > flush them to the SPI platform driver with the sync() operation. This
> > > allows for faster handling of multiple channel DAC writes, avoiding kernel
> > > overhead per spi_sync() call, which will be helpful when enabling
> > > triggered buffer support.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> > Interesting approach to potentially optimise for SPI.  Do you have
> > perf numbers or similar to support it being worth the effort?  
> 
> Short answer is no, I can try to produce some benchmarks, but I am not sure it
> is needed. The implementation here prepares the ground for triggered buffer support,
> which adds the capability of implementing a control loop in userspace that updates
> all the enabled channels at once. That will happen in a trigger handler, then we want
> that to be as fast as possible, so it can be prepared for the next trigger event.
> It is not really about calling a function once rather than multiple times, but the
> problem happens when the device is sharing the spi bus with other devices and how busy the
> system is in general, so there may be context switches in the spi platform driver with
> one or two mutex acquire/release operations, which may add bigger delays between
> transfers, which depends on what the other devices are doing. I suppose that devices with
> high channel count like 8 or 16 can benefit with this.

Fair enough.  There is enough complexity here that maybe a perf
number would strengthen the argument.  I'm reasonably happy with
that complexity anyway so this would be if anyone else pushed back.

> 
> > Otherwise a few minor comments inline.  
> 
> ...
> 
> > > @@ -84,8 +107,18 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
> > >  				      AD5686_ADDR(addr));
> > >  	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
> > >  
> > > -	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
> > > -	if (ret < 0)
> > > +	xfer[0].tx_buf = &st->data[0].d8[1];
> > > +	xfer[0].len = 3;
> > > +	xfer[0].cs_change = 1;
> > > +	xfer[1].tx_buf = &st->data[1].d8[1];
> > > +	xfer[1].rx_buf = &st->data[2].d8[1];
> > > +	xfer[1].len = 3;
> > > +	xfer[1].cs_change = 0;
> > > +
> > > +	spi_message_init_with_transfers(&bus_data->msg, xfer, 2);  
> > 
> > Why not carry on using spi_sync_transfer() here?
> > We'll end up with an spi message the stack but I suspect that's
> > not a significant performance cost.  
> 
> True, it would be around 200 extra bytes in the stack, and read operations
> would not happen concurrently with writes, so why not reuse resources
> (message and transfer structs) that is now available in the bus data?
> To me, it allows for consistency in this implementation. 
> 
Reusing transfers makes sense.  I was a little less clear on reusing the
message because we can't then use the helper (which is all spi_sync_transfer()
really is).  Not particularly important either way.
> > > +
> > > +	ret = spi_sync(spi, &bus_data->msg);
> > > +	if (ret)
> > >  		return ret;
> > >  
> > >  	return be32_to_cpu(st->data[2].d32);  
> 

