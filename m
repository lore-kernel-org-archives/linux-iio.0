Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722701FBEA8;
	Mon, 18 May 2026 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111948; cv=none; b=oIIgYVCm+8NCYf8SeHiNNgkGe+lcRKCw1aJuefqV4cRxfGc701HL2ezuOszI6eDXphRYESnJGNAvJLoMeuJuk50MR05fu38DtWkrsjsxcnR2WpvKSw37pLlL3wYgtofGV22EGrALR193JdxxUbTacUl6f3jCaT0uyHCQwfRd7eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111948; c=relaxed/simple;
	bh=tDAoFGFvkYgyrEHwppvlh3HDSU8G12IrZS59be5EKkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFkOhEd08F2f/0vrQee9KaXCG5kFbegYY0SRkDSOwFQSUSvrvxEOUCIkqWxQHA8M6NXhNTg87IZH5gg8ke9ku/yXzrjcdg/kKx0ffbiYctOJ6WEruzQCUZTw0gE00lQvrzPssufJtkL4bbz6xYMkqNKhPMsexO1cyEC/umheLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heX+I03Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heX+I03Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB59C2BCB7;
	Mon, 18 May 2026 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111948;
	bh=tDAoFGFvkYgyrEHwppvlh3HDSU8G12IrZS59be5EKkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=heX+I03QVitiX4hw+zKWoFscXe7oBjinLU0dWj9eY1K6sRjGPJ+NSu+rnvQX7hBE8
	 cxcTT3gb0Pk+0bB26m8pSI1Uy6cBNpxREtEcEXZ70wIg2LtnmXLOoUyCeVBqn8qiJu
	 05wpvokNiQMg6+AWzX5jj3hmbDfyyFK/i8I5AJ+S2VLXoxCMiiiym1/8MsIDSFIpfF
	 5isotSAgu5EEi9gPc2Mka4g2BBQMm7bBvWYnFXOIc2LTORXypRLTUVoctQplHLqze9
	 ZZootCwkbYou8Sj0ftL9nXVhyabwMsKnEKRQxdisCOLqc1o18i0BqSMnBM6MTMu3pn
	 KQK7K+upptsng==
Date: Mon, 18 May 2026 14:45:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 09/10] Documentation: ABI: testing: add docs for
 ad9910 sysfs entries
Message-ID: <20260518144537.7c998308@jic23-huawei>
In-Reply-To: <yrabhhhdkzmiuxlqzrrj6a47ftlzwvva7r2korzeszdy4yqrin@xl6obhhnnas4>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
	<20260508-ad9910-iio-driver-v4-9-d26bfd20ee3d@analog.com>
	<20260517155843.7f833658@jic23-huawei>
	<yrabhhhdkzmiuxlqzrrj6a47ftlzwvva7r2korzeszdy4yqrin@xl6obhhnnas4>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 18:30:27 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/05/17 03:58PM, Jonathan Cameron wrote:
> > On Fri, 08 May 2026 18:00:25 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add custom ABI documentation file for the DDS AD9910 with sysfs entries to
> > > control Parallel Port, Digital Ramp Generator and OSK parameters.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> > I'm fine with phase and frequency as defined, but for the scaling it made me wonder.
> > For outvoltage0 channels the assumption the value is the peak voltage so if
> > we know what input to be modulated by the ramp generator can we express them
> > in volts (well milivolts) rather than as a scaling multiplier?  
> 
> The DAC output is current-based and differential. Voltage conversion would happen
> outside the device...

Why aren't we representing this as out_altcurrentX-Y_xxxx?


> using a resistor load or an op-amp transimpedance stage,
> and I am no expert on that, but that often requires impedance matching so voltage
> levels may depend on the frequency. Then, I suppose that voltage is not the right
> unit to use.

Understood that it can get complex!
> 
> The scale here controls the amplitude of the varying signal. Assuming the peak voltage
> (amplitude) is constant means we have a constant envelope, but that should not mean
> we can't control it or it should not mean that the hardware can have other ways to
> control it. That said, scale behaves as a "gain multiplier".
Understood. Given it's the envelope then if scale happened to be 1 always it would
be presented as _processed. So this is consistent with other channel types.

> 
> > 
> > That seems to me like it fits better with the overall ABI.
> >   
> > > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_offset
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		For a channel that allows amplitude control through buffers, this
> > > +		represents the value for a base amplitude scale. The actual output
> > > +		amplitude scale is a result with the sum of this value.
> > > +  
> >   
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_roc  
> > 
> > Silly question perhaps but can work out how this related to millivolts/sec
> > That might make a more intuitive interface than scaling multiplier per sec
> > Perhaps the combination with offset makes this impossible though maybe that
> > could be a expressed as a voltage offset?  Afterall if the amplitude being
> > scaled is 5V then 5 * (offset + scale) = 5 * offset + 5 * scale
> >    
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Amplitude scale rate of change in 1/s for channels that ramp
> > > +		amplitude. This value may be influenced by the channel's
> > > +		sampling_frequency setting.  
> > 
> >   
> 

