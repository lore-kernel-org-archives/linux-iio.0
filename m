Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC83C6A2B
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040483; cv=none; b=iW30NLR/CbT6QZ5Bi0hjgxJbSl/CeBqQ23vCnWc3dA0e0tq1dPPQcoah6UFhgRKVkqwCF6Iea37yuiM8TgaoZS2lCxCiY1RRPUfhKoel7Y9FgJYincO6i3Tg3dKeUpCz438Yj+ktdId3ylJqgB2lyoS1iPu7gBpvecYxgPAQZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040483; c=relaxed/simple;
	bh=HV9+cXihAaH4KwSTsC1gpmYVeE6h/AHKaW49mEWHgB8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgHyTEBsbmSaiVouOpbGMfdoN87XH9QCyc5hFw69uSQKZLZbP6RFqXDEIjxs1M8sjYGzgCNfnRZnJf47R1qlaYOCYQutTq+8IONomWTJTMB1PRvYgr3W4o2s2DxLTkEQVh72zMzmczW3d95kqnBLzXh7uRDCWVHToeZqMmTg7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJDcSzUZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJDcSzUZ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44e5624c053so732890f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779040480; x=1779645280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TnFwmmTG90t0fKQgEeFLZttD4NeL9fxw8K+kX1DEzbA=;
        b=CJDcSzUZCydm54QBxUNXA+hA8oosDpavNttlf92pe5ylkavdt9zuD/uSVCsi1O9GyY
         rCpfVm7ROr+J97t7odaTaHJHhsupkmYLyj6OBshs/YaCZrjOJtUCm1lAkcFvNV4R3yto
         sVk4sUIsxl8FMdw1iQxsFdxtJpUJ8UBEDx9QVyDf4NvaSzm25xYfuVuc7en4tsUPKoNY
         /Xc1/mAqn+/kQ5oUM4CFnwOfImFl3y/Q/G2mp9sPJFvwc8zWy0rxE2VJzSUQ22Td5jWT
         kVGS502jHT+mScFwagskCd5FnVeTffQdCd/70mXdUYdo3fTaWLwB5nQBzWCWuEpIgczG
         b7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779040480; x=1779645280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnFwmmTG90t0fKQgEeFLZttD4NeL9fxw8K+kX1DEzbA=;
        b=k+mkDjPVIs9xvF/KwkxSqAVPMTJ/1/tAwUOfF0fJuv4ECTQPLaY0iGGe33C50MAvnv
         WadsyxsnfpQuxbEK5T7D3Ag1mRiCKLxbW1lEboeGaPiOpgLC2Z+Na3We9e568dYuKxCN
         Ev7Xq8TzQ0IlUvjOrzgG/JXPwzKEzipg2Dy9MTDun7vvKz5oh0AWMDUdrVYk9Qt9Jgk2
         VlInq8vU5hDMIB/ctEfvFrV2zIY+maQZEIrPc6KO0Mx/iNubhljV376DZlD2hkAw+aas
         95zNDc5BsvJXXF5WjVP6zsUZBoilJStReMCjFtebQrR3V+vPL7bOHKfE7jEpUNOCPc8M
         qjvw==
X-Forwarded-Encrypted: i=1; AFNElJ8es0haW9nf/r0yXMoZGR89v15R/pPlieY4FILt0Rq4i6iY5dWZ2DjvbMf9FkSqdhNhMIRp9fgzxFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyST2oNNhu0+jyAmcul2vGTM+AX9Vq+8LqBGP/j/Lsng99t/JHq
	1qieBNIUGqakrv0xHAVnalbPBX4YqrTNO4dgsfCRVipu2YWwETDcsY5z
X-Gm-Gg: Acq92OGwRGt3dQdpyCR3iC6zUnLk9Hy6MpaTsTGlsRg5Qj1x6JC4eMSgYbRXFSJeMqG
	MBD9PTTlR2cxAJKotdVLXYCkYPE7cwEg+Ra4nOgBodaIhrqG3jlIMFZxaLhYBqWux2TYMXh6aHg
	w9DcyI+FXo+w7wpZhssZYfalW1UDgIPUvGWyglNrXTwZMVaKxCpd/pcpMynJTF1QqmVThyaIHvH
	bdEIn8AFxPIwp+QkOaTVCnyyuEI1L9cRBCWWmT+Qlz+cfVdK+Ifq6lSMK6klmnVtDezDLbm563F
	O3sbZK27AyJr52aoFbHtw6Vv68/CiUDCi7+xuELhzTjouspNEjsuMuuAsVVf9zHvzpDgdgtG+NF
	S3aN5eBWqZFScmirM1uWddnF8apja5Lr6T8WIytt/swlpRajsSn1WM0XDvuUUgaZ3QZdoFTusfi
	I9r/8tBDRsmpTxDYa/UK137YEwgmVrJiFOoYd1P4i2QkntyfiRuBqWr1k3MDDbhNvEA4P2ndzJs
	2GIw8FMdyrmKVAcuj0Lnn+MvV3Behoa9I8X8GhAf57gyzmrow==
X-Received: by 2002:adf:f643:0:b0:45e:73b6:d107 with SMTP id ffacd0b85a97d-45e73b6d124mr3699595f8f.41.1779040480412;
        Sun, 17 May 2026 10:54:40 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768bcesm32883396f8f.4.2026.05.17.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:54:39 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 17 May 2026 18:54:34 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, 
	rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 10/10] docs: iio: add documentation for ad9910
 driver
Message-ID: <lydcfe6pxgswwysqqnn3mqjwj2b2x3ldcnvwhnbh5tukdummps@f4b3h4kpf7ff>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <20260508-ad9910-iio-driver-v4-10-d26bfd20ee3d@analog.com>
 <b8f9a174-f3d0-4cb8-a571-605be79165d6@baylibre.com>
 <zvulxrrvg4sf7m5pjfpfucg7yssgallfu6zi6mcyblu2qy24hn@wdzs7h77vkoz>
 <18c2eab9-c0c7-4e93-b4e8-73b18531e784@baylibre.com>
 <uphcx5zr4lmukuom75g66hp4agurty7yq6mo6ri6otrsscqfek@tn3u5jjszaoy>
 <5bce7868-feca-4c54-a14d-ad4bf4072c29@baylibre.com>
 <20260517164418.37f13914@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517164418.37f13914@jic23-huawei>

On 26/05/17 04:44PM, Jonathan Cameron wrote:
> On Mon, 11 May 2026 10:23:35 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 5/11/26 10:02 AM, Rodrigo Alencar wrote:
> > > On 26/05/11 09:46AM, David Lechner wrote:  
> > >> On 5/10/26 4:30 AM, Rodrigo Alencar wrote:  
> > >>> On 26/05/09 06:42PM, David Lechner wrote:  
> > >>>> On 5/8/26 12:00 PM, Rodrigo Alencar via B4 Relay wrote:  
> > >>>>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > >>>>>
> > >>>>> Add documentation for the AD9910 DDS IIO driver, which describes channels,
> > >>>>> DDS modes, attributes and ABI usage examples.  
> > >>>
> > >>> ...
> > >>>  
> > >>>>> +       must be a power of 2.
> > >>>>> +
> > >>>>> +   * - ``frequency_offset``
> > >>>>> +     - Hz
> > >>>>> +     - Base FTW to which scaled parallel data is added. Range :math:`[0, f_{SYSCLK}/2)`.
> > >>>>> +
> > >>>>> +   * - ``phase_offset``
> > >>>>> +     - rad
> > >>>>> +     - Base phase for polar modulation. Lower 8 bits of POW register.
> > >>>>> +       Range :math:`[0, 2\pi/256)`.
> > >>>>> +
> > >>>>> +   * - ``scale_offset``
> > >>>>> +     - fractional
> > >>>>> +     - Base amplitude for polar modulation. Lower 6 bits of ASF register.
> > >>>>> +       Range :math:`[0, 1/256)`.
> > >>>>> +  
> > >>>>
> > >>>> I guess there was some discussion on these attributes. I see some of these in the
> > >>>> ad9832 driver in staging, but I'm guessing they are new ABI. It isn't clear to
> > >>>> me from the documentation here what they actually do though. I guess they are
> > >>>> just basic transformations on the input signal?  
> > >>>
> > >>> Not sure how the ABI is not clear:
> > >>>
> > >>> 	For a channel that allows amplitude control through buffers, this
> > >>> 	represents the value for a base amplitude scale. The actual output
> > >>> 	amplitude scale is a result with the sum of this value.
> > >>>
> > >>> So yes, it is a basic transformation.  
> > >>
> > >> I didn't have time to read the ABI docs yet. For scale_offset though,
> > >> how is that different from the existing offset attribute?  
> > > 
> > > I suppose that existing offset ABI is applied to (raw * scale), mostly for
> > > voltage channels, here the scale_offset is an offset to the scale itself.  
> > 
> > 
> > Ah, so a very general case would be (raw * (scale + scale_offset)) + offset
> > 
> > when the scale can change as a function of time and comes from an external
> > source.
> Ah. Similar question to what I was commenting on.  Though maths is currently wrong
> for normal offset application as it is pre scale.
> 
> 
> 	(raw + offset) * scale is normal case.
> This is proposing (I think)
> 
> 	(raw + offset) * (scale_offset + scale)
> 
> Altvoltages are a little odd though in that we are really always kind of dealing
> in scales as it's the peak voltage that is the base unit. So they are kind
> of always about scale - hence for such a single offset would be shifting the
> mid voltage point which I guess is different form scale_offset.

As mentioned in the previous patch, I'd say we don't handle voltages in altvoltage
channels because voltage values depends on external circuitry and they vary with
frequency. Scale control is often achieved with hardware_gain in dB, but the
dB scale would not be good to achive the 32 bit control of the "raw" values.
Then, here it is implemented from 0 to 1.0, where 1.0 is the full scale.

> 
> Hmm. Not sure I can draw this but i'll give it a go...
> 
> So with no modulation going on and scale = 2.0, Raw 1000. 
> (imagine these are sign waves)
> 
>   _         _       _ 2V
>  / \       / \
> /___\_____/___\___  _ 0V
>      \   /     \
>       \_/       \__ _ -2V
> 
> That is sine wave -2/2V swing.
> 
> Now if scale or voltage double it get twice as big.
> 
> If offset + 100
> 
>   _         _       _ 3V
>  / \       / \
> /   \     /   \   
> _____\___/_____\___ _ 0v
>       \_/       \__ _ -1V
> 
> Scale offset at this point seems straight forward.. Gets more fun when it's modulated.
> 
> For now apply a scale offset of -1 and scale becomes 2 - 1 == 1. 
>   _         _       _ 1.5V
>  / \       / \
> /   \     /   \   
> _____\___/_____\___ _ 0v
>       \_/       \__ _ -0.5V
> 
> So for simple case we could just role it into scale. However the fun here
> I believe is that _scale is controlled by say a ramp generator.. 
> 
> Ok. I can't really draw this.. Lets try with xs

The ramp pattern would be the envelope of the actual varying signal.

> 
> Initial scale 1, ramping to 2 over a couple 1ish cycles, offset 1.  That is
> computed sale is going from 2 to 3.
>                    Peak 3
> ____________________________ 3V
>     Peak 2.33         xx
> ______x_______________xx____ 2V 
>      xxx             x  x
>    xx   x            x
>  xx      x          x
> x_________x_________x_______ 0V   
>            x       x 
>             x      x
>              x    x
> ______________x__x__________ -2V            
> _______________xx___________ -2.5
>                 Peak 2.67
> 
> Key being really where this starts which is scale_offset = 1 rather than starting
> ramp from scale of 0.

yeah... that makes sense. Note that scale_offset ABI is defined generically, but
it is proposed for the parallel port mode with polar as destination. That is needed
because the amplitude is defined by the 6-bit offset (LSB) plus 8-bit input (MSB) that
would come from the buffer.

> Having drawn these I'm even less clear in my head on whether we can move from
> expressing that scale_offset and scale_roc in volts  - i.e. not as scales
> or not.

Yes, I'd say volts is not the right unit to use here. We may have the options:
- raw values
- fractional or proportional values from 0 to 1.0 (the one I am using here)
- dBFS

> Given need for separate control for overall mid point of waveform and the
> starting point of scaling I think not.  Ah well.  The challenge will be
> how to makes sure folk looking at the ABI can understand the complex
> interactions of all these parameters. We may need some extra docs with
> better diagrams than above.
>               
> Jonathan
> 
> 

-- 
Kind regards,

Rodrigo Alencar
