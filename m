Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F0F405C32;
	Sun, 17 May 2026 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032754; cv=none; b=fwFa8n+txeKH1KkNTmrxR3JCuSWejndEH1AnSQM2j6DmOurYkBiZGrgemf00TYyuZJ0jQQn/r4IKeCdD0RqiHMnN0i6yG8iTMQ4E1RocF5qBq6XEqVu+2f7pIpN8c56wBDSckUp8UgdFrcHIShCEQitzkykKhM5DyFDLSuDZ0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032754; c=relaxed/simple;
	bh=ItD4S9x0mFpUzIadUXek7CMnVOMmle1JXqnbR7Ej58g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/0v2itPlwZOk/K7Os/pluUjqALG7c+ajwQR8VqNbgo71Wd3GiUqP4x2TLC7UGH5nMNx41VqPKBlmXZfB/oX1zzkegnWgJl+9b/pyCUxHYP8XY+KlKtLu4Fwoez1FG7wdrM/KkvIsxg+udm2pjE1LOVhjDZRKCGXmzrrfxAWvYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfYRzgM+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfYRzgM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C353AC2BCB0;
	Sun, 17 May 2026 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779032754;
	bh=ItD4S9x0mFpUzIadUXek7CMnVOMmle1JXqnbR7Ej58g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IfYRzgM+DtGlBgcpGCMVW9sJTrzrixPXuJyw0fhPxM2ihHniQBzBNs1hdgapnL5zc
	 8z/WLxtVND1yu8Ykr0+gIpC6SbhlOW9BY3zMMLmA2RG/0AnHATz3E6ofMe95ac2JJB
	 TANEW4BpLOVEdaxXontvxyIx1xnQe246wa8YD2bTBJo9BkfHBrcSX1GENL23+/JMtA
	 GIVMkpAaH77UpQfA790chUZBuuDp/+JsJioX1uDnOUF9DemFLk8F4yoyo4OgC/8PLO
	 SFmtpFoc93xWXY57QZ1P9fehEbbs3wkZQhWNt99PRFDg/bpM0cTc1VbJSLWYuGeXl6
	 zUYzGZvyllbbg==
Date: Sun, 17 May 2026 16:45:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
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
Message-ID: <20260517164543.0d9a12fd@jic23-huawei>
In-Reply-To: <20260517155843.7f833658@jic23-huawei>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
	<20260508-ad9910-iio-driver-v4-9-d26bfd20ee3d@analog.com>
	<20260517155843.7f833658@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 15:58:43 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 08 May 2026 18:00:25 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add custom ABI documentation file for the DDS AD9910 with sysfs entries to
> > control Parallel Port, Digital Ramp Generator and OSK parameters.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> I'm fine with phase and frequency as defined, but for the scaling it made me wonder.
> For outvoltage0 channels the assumption the value is the peak voltage so if
> we know what input to be modulated by the ramp generator can we express them
> in volts (well milivolts) rather than as a scaling multiplier?
> 
> That seems to me like it fits better with the overall ABI.
> 
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_offset
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		For a channel that allows amplitude control through buffers, this
> > +		represents the value for a base amplitude scale. The actual output
> > +		amplitude scale is a result with the sum of this value.
> > +  
> 
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_roc  
> 
> Silly question perhaps but can work out how this related to millivolts/sec
> That might make a more intuitive interface than scaling multiplier per sec
> Perhaps the combination with offset makes this impossible though maybe that
> could be a expressed as a voltage offset?  Afterall if the amplitude being
> scaled is 5V then 5 * (offset + scale) = 5 * offset + 5 * scale
>  
See thread on next patch. I think I argued myself out of this.  

> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Amplitude scale rate of change in 1/s for channels that ramp
> > +		amplitude. This value may be influenced by the channel's
> > +		sampling_frequency setting.  
> 
> 
> 

