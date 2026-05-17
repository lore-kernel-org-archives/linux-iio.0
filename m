Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B530C372;
	Sun, 17 May 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032671; cv=none; b=F2TXd4w2iqZvvc6aSCNGauaZhJVq8uUFpxDsq91vE+1X80ePsGuLzyzdLb6TvcjnCa6pm3IcXBdF9G035ce4sXtHR3JbZYHPeGoTxkD3Wo9GkpnaMaujrszDf18dJ5/GXdmXfSi1UXIjcaCG1nrzjSBwmasim343xnC3Rld+vwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032671; c=relaxed/simple;
	bh=tB9sbw1/VK3EnV8KCRP73ZtAmQEachDtTVRP9aAlBUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSH40t53iOyGeCxID7Vit20BoFET9hZpKkC6GBAW7WdtlSkzLT88O1S1hZExLWVdipM1QPsND5XG3xbsZGXYHAIDznVHT1d3JNzfm9G7Y9c5gdu9gSeFwsVOpK46PBFrv2SoWIUQghKPFUKWHya53raSOKFyoxpyncqj0OdVTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYv98OUv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYv98OUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EF2C2BCB0;
	Sun, 17 May 2026 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779032671;
	bh=tB9sbw1/VK3EnV8KCRP73ZtAmQEachDtTVRP9aAlBUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aYv98OUvZaiwwFibT65Y5SLCGoH9um/RsSzDKJ+gTQFemKtP64XaZ36VNP0gdWake
	 acEZiWVfTlCmOCnUvBV9aWtjX1DeSmPjbG7FYPJmYlYLog47+Yezw3qFFBBaBYxZgY
	 BAcE2aN3GtiXDTzQd+uAIkEp29DTiXCHyCXk6dlHAXEYdgeXeR5Ak4bW5Xtc1S5q8H
	 c3fd6gBcvr+na95zWhP+7da8KXJ+90PPRIOGfQ1nGzM5ZeVxy8lC/5BUWwpL8chLRS
	 kaDHbUI7HUCQz8vMHP7rvdsm9zfUCNilK9IjBPpWE+xxi/5Uv57nwGbE3TTp0Ug/xE
	 oODaW7MVA5mZw==
Date: Sun, 17 May 2026 16:44:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 10/10] docs: iio: add documentation for ad9910
 driver
Message-ID: <20260517164418.37f13914@jic23-huawei>
In-Reply-To: <5bce7868-feca-4c54-a14d-ad4bf4072c29@baylibre.com>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
	<20260508-ad9910-iio-driver-v4-10-d26bfd20ee3d@analog.com>
	<b8f9a174-f3d0-4cb8-a571-605be79165d6@baylibre.com>
	<zvulxrrvg4sf7m5pjfpfucg7yssgallfu6zi6mcyblu2qy24hn@wdzs7h77vkoz>
	<18c2eab9-c0c7-4e93-b4e8-73b18531e784@baylibre.com>
	<uphcx5zr4lmukuom75g66hp4agurty7yq6mo6ri6otrsscqfek@tn3u5jjszaoy>
	<5bce7868-feca-4c54-a14d-ad4bf4072c29@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 10:23:35 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/11/26 10:02 AM, Rodrigo Alencar wrote:
> > On 26/05/11 09:46AM, David Lechner wrote:  
> >> On 5/10/26 4:30 AM, Rodrigo Alencar wrote:  
> >>> On 26/05/09 06:42PM, David Lechner wrote:  
> >>>> On 5/8/26 12:00 PM, Rodrigo Alencar via B4 Relay wrote:  
> >>>>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >>>>>
> >>>>> Add documentation for the AD9910 DDS IIO driver, which describes channels,
> >>>>> DDS modes, attributes and ABI usage examples.  
> >>>
> >>> ...
> >>>  
> >>>>> +       must be a power of 2.
> >>>>> +
> >>>>> +   * - ``frequency_offset``
> >>>>> +     - Hz
> >>>>> +     - Base FTW to which scaled parallel data is added. Range :math:`[0, f_{SYSCLK}/2)`.
> >>>>> +
> >>>>> +   * - ``phase_offset``
> >>>>> +     - rad
> >>>>> +     - Base phase for polar modulation. Lower 8 bits of POW register.
> >>>>> +       Range :math:`[0, 2\pi/256)`.
> >>>>> +
> >>>>> +   * - ``scale_offset``
> >>>>> +     - fractional
> >>>>> +     - Base amplitude for polar modulation. Lower 6 bits of ASF register.
> >>>>> +       Range :math:`[0, 1/256)`.
> >>>>> +  
> >>>>
> >>>> I guess there was some discussion on these attributes. I see some of these in the
> >>>> ad9832 driver in staging, but I'm guessing they are new ABI. It isn't clear to
> >>>> me from the documentation here what they actually do though. I guess they are
> >>>> just basic transformations on the input signal?  
> >>>
> >>> Not sure how the ABI is not clear:
> >>>
> >>> 	For a channel that allows amplitude control through buffers, this
> >>> 	represents the value for a base amplitude scale. The actual output
> >>> 	amplitude scale is a result with the sum of this value.
> >>>
> >>> So yes, it is a basic transformation.  
> >>
> >> I didn't have time to read the ABI docs yet. For scale_offset though,
> >> how is that different from the existing offset attribute?  
> > 
> > I suppose that existing offset ABI is applied to (raw * scale), mostly for
> > voltage channels, here the scale_offset is an offset to the scale itself.  
> 
> 
> Ah, so a very general case would be (raw * (scale + scale_offset)) + offset
> 
> when the scale can change as a function of time and comes from an external
> source.
Ah. Similar question to what I was commenting on.  Though maths is currently wrong
for normal offset application as it is pre scale.


	(raw + offset) * scale is normal case.
This is proposing (I think)

	(raw + offset) * (scale_offset + scale)

Altvoltages are a little odd though in that we are really always kind of dealing
in scales as it's the peak voltage that is the base unit. So they are kind
of always about scale - hence for such a single offset would be shifting the
mid voltage point which I guess is different form scale_offset.

Hmm. Not sure I can draw this but i'll give it a go...

So with no modulation going on and scale = 2.0, Raw 1000. 
(imagine these are sign waves)

  _         _       _ 2V
 / \       / \
/___\_____/___\___  _ 0V
     \   /     \
      \_/       \__ _ -2V

That is sine wave -2/2V swing.

Now if scale or voltage double it get twice as big.

If offset + 100

  _         _       _ 3V
 / \       / \
/   \     /   \   
_____\___/_____\___ _ 0v
      \_/       \__ _ -1V

Scale offset at this point seems straight forward.. Gets more fun when it's modulated.

For now apply a scale offset of -1 and scale becomes 2 - 1 == 1. 
  _         _       _ 1.5V
 / \       / \
/   \     /   \   
_____\___/_____\___ _ 0v
      \_/       \__ _ -0.5V

So for simple case we could just role it into scale. However the fun here
I believe is that _scale is controlled by say a ramp generator.. 

Ok. I can't really draw this.. Lets try with xs

Initial scale 1, ramping to 2 over a couple 1ish cycles, offset 1.  That is
computed sale is going from 2 to 3.
                   Peak 3
____________________________ 3V
    Peak 2.33         xx
______x_______________xx____ 2V 
     xxx             x  x
   xx   x            x
 xx      x          x
x_________x_________x_______ 0V   
           x       x 
            x      x
             x    x
______________x__x__________ -2V            
_______________xx___________ -2.5
                Peak 2.67

Key being really where this starts which is scale_offset = 1 rather than starting
ramp from scale of 0.

Having drawn these I'm even less clear in my head on whether we can move from
expressing that scale_offset and scale_roc in volts  - i.e. not as scales
or not.

Given need for separate control for overall mid point of waveform and the
starting point of scaling I think not.  Ah well.  The challenge will be
how to makes sure folk looking at the ABI can understand the complex
interactions of all these parameters. We may need some extra docs with
better diagrams than above.
              
Jonathan


