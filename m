Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795226508;
	b=dxXWQ29fqM5efuTiPclwJI0bsaM5r/L5BW20h9T3hw/h99a7V9fqpmCXIpwVL86hzkPr
	 qrPS6VbGvR5dfjmP/JgwtmemWWNIZLi/VKOhT+iwP/ED3ZCSrOJYbpSgUWeaZMwkl6Os2
	 4U9d5/RI2FIlnozNslUEyAu6F3SvHP1LzEPWofKPGdLIjjHrpLq824oF5wue8Sqe2tpQc
	 xytJPzm5xiAqQTSD8GYz+v0jlFVjwFVb13BkXHm0xnnPBqkDJ46wex4nD7WVrjwREu7tK
	 oIrkLPvdprcB3n7y8yB5y6Cja6uDbADFSXv4E+qFXqy52EN1xcbOcbNknF4+hyLzROg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795226508;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kmMOA/JqT3+zTDvjZdA8gReRHgHGh2MTpTCnYqFH+JE=;
	b=BLAUtR6qrk6PU0PA6/OlLvjq5pHLOOmFnCY2lsHnyFP/JDWL3P/+IBZ1Uo8pWhs6zSDr
	 6lfbyg4zaI3SPHq2jHCAr5hXVathy98JKAMTm6wOYvJg3QLbMvvO6JFW7t0vaKRVKbcN5
	 ojKI1Ao48C6wIxUKCm5jU6QnFV+nEUSdDPNN+Tw3lEyUMHXChGdVtMKS+Bd+WKhvm7Eup
	 HBXeQVRURW6GhLDRJCZ0Syld2ooiTEdCKXkyfdyfweNaMJFIzbUVNyBRIZ4XTh1zGD1Mx
	 6BkI6Bg2Z5HuGhAEGc0u7v079YTiTVp40PJuj3nYSyBIi2z2v0BiGR+UdkgFfJvN/nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A41pkW2b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B069606A6A9;
	Sat, 21 Nov 2026 02:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A41pkW2b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08F91F000C4;
	Sat, 21 Nov 2026 02:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795226507;
	bh=kmMOA/JqT3+zTDvjZdA8gReRHgHGh2MTpTCnYqFH+JE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A41pkW2bWhSmi1hlpL2vzaJ0GGHTCNRR3mLQFcNGurTDhldf5Sh3Znnhatl2dlhPO
	 rwL09/86rVqS3J9ScjQzbjoY7sU+CfNTbItL0zL5KzQVqkuIURLvQ34dPviNzW0h16
	 SBxJ6jm3dvRf1+Qnt2trukxDSThDPWF7ECHtNC4erfXzh2dlxHQsVi/4FZmUWS6klB
	 72adyelnlFJW3PXsyUfOrQ9z64W/6qeisT3GKMi7Th973AY7yDg7GrgHZ19jt9CA6C
	 ehZ+c/AdEu4NkFRqAVOZseItsp8WAfeWRV4pPnrGMZDyK8q1J7KPRYHOuPejyW3Z8D
	 Rpvg+GxXANJVw==
Date: Sat, 21 Nov 2026 02:01:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Matti Vaittinen
 <matti.vaittinen@linux.dev>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Joshua Crofts <joshua.crofts1@gmail.com>,
 Radu Sabau <radu.sabau@analog.com>, Janani Sunil <janani.sunil@analog.com>,
 Salih Erim <salih.erim@amd.com>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Jakub Szczudlo <jakubszczudlo40@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: rohm-bd79112: Support ROHM BD79111
Message-ID: <20261121020136.16f48636@jic23-hlaptop>
In-Reply-To: <awBc1qFMhydEXo69@ashevche-desk.local>
References: <cover.1795176984.git.mazziesaccount@gmail.com>
	<4be17e339f768da93db2f42abd3cc5a21fea01ad.1795176984.git.mazziesaccount@gmail.com>
	<awBc1qFMhydEXo69@ashevche-desk.local>
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

On Fri, 20 Nov 2026 16:44:38 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Nov 20, 2026 at 02:28:28PM +0200, Matti Vaittinen wrote:
> > 
> > ROHM BD79111 is very similar to the BD79112. Both are ADC/GPIO devices,
> > where pins can be configured to be either used as GPIO or ADC inputs.
> > ADCs are 12-bit SAR ADCs and GPIOs support input/output but not being IRQ
> > sources.
> > 
> > The main difference is amount of channels/GPIOs. The BD79112 has 32 pins
> > for this use, the BD79111 has 16. Furthermore, the BD79111 data-sheet
> > promises 0.5 MSPS sample rate with maximum of 10 MHz SPI clock,  whereas
> > the BD79112 data-sheet mentioned 1MSPS rate with maximum of 20 MHz SPI
> > clock.  
> 
> ...
> 
> >  - Return -ENODATA instead of -ENODEV when SPI match data is not
> >    available.  
> 
> I guess you were distracted by something, the error code is now introduced in
> the very previous patch, fix it there.
> 
> ...
> 
> > -	tristate "Rohm BD79112 ADC driver"
> > +	tristate "ADC/GPIO Driver for ROHM BD79112 et al."  
> 
> > - * ROHM ADC driver for BD79112 signal monitoring hub.
> > + * ROHM ADC/GPIO driver for BD79112 and similar signal monitoring hubs.  
> 
> Can this text be modified to be closer to the other two?
> Something like:
> 
>  * ADC/GPIO Driver for ROHM BD79112 and similar signal monitoring hubs.

I had nothing to add and nearly picked it up with tweaks. Given
this is something you may well want to feedback on (or adopt as
is!) I decided to ask for a v3.

Given this is small and in a clean state, send it whenever you are
ready - no need to wait a week in this case.

Thanks,

Jonathan

> 
> > -MODULE_DESCRIPTION("Driver for ROHM BD79112 ADC/GPIO");
> > +MODULE_DESCRIPTION("ADC/GPIO Driver for ROHM BD79112 et al.");  
> 
> ...
> 
> Otherwise LGTM,
> Reviewed-by; Andy Shevchenko <andriy.shevchenko@intel.com>
> 

