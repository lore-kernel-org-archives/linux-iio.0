Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794016086;
	b=dqKDuf8R3YmtkwLfC6R4jsvqkHpdlartOyWQQ7oat9XXCYmxMoKkXDdS1f4aNYpwtb1/
	 1JeVY0PGEo7qScXY/TPaXizP2R/EhNATpqmpf0hQfeNhGFqgMImGvHxgaupyvEe5K/dJt
	 YE1DhuhE4VrHjYdQFwTbvSLHvq6eHny6j42GTGXqgM757sdc/UjBU9ZET/ENS1+hXJizR
	 iRrzyy0ZzcTsfMeWi+DnDyNliebPEWEo0v5E+FwqE6zP9nvscnJC4mUtPRWHIM+TI4UBL
	 lALbWiqRvvrnin1AifTE+BIWtAMJIkbRjZKKBUlhCITtwZBmLdr4j2jAMR8GuCPlDAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794016086;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bD3Vm+c/OJP0FLaNU6L9t/i7FMpI2HSwp/rbnkDRItg=;
	b=KnwSidOgXo/0LhZErBE6XSFICq7fEGfWoI5pazRmbzv+pHF/oMRtnGD2dZ5UIsSZLa2k
	 T2vz2ehQgmdMMlk7QgKmyBMO6RFGZGwY+C9VI/6N4u4oc9ItlJBI3C4lJN6iZY7sa4X+o
	 WE8g8Cv1CZ3uzHfjFL1sh5OvbrAGol7ofIgg+dLU6yYejVxCeeqdh0PUAfhKV9O+1xbYn
	 9BZVfAh4viH2vVgZs2Xn+axtv5mtaJ2S6E6I2R7vY47jYi19RnXESRqxzVRPvQ0jNpcTq
	 3i/XXZvwUBSGFUR9SKaJl3UkbhBYl06Am61s17YkDLA1FR/d4rtwM35r6H3ctrNRcDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIDOLCq3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE9606A32C;
	Sat,  7 Nov 2026 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIDOLCq3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759B71F008A1;
	Sat,  7 Nov 2026 01:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794016086;
	bh=bD3Vm+c/OJP0FLaNU6L9t/i7FMpI2HSwp/rbnkDRItg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VIDOLCq3aXWcqToLyPXzSeAVHaSsngvx9ioaHCy3du4Atjy+P0G/dct5c+1YGucDA
	 NkZHMh8RSKFxZw7zxWFN2gH1H1tzWvUJza2BzZRnX0jFeb6Ua4IWg8jIEWbteTc0cH
	 pWNmQJX9z9IrSVCHNbaRtETU2BbaHSvb5/pjOxTiLmHD7c5zp4BUm2+F/Ng+l24tM0
	 1Jbqqb9eXYlGdxUuSib8Iab0oDCsH33NdXhdaOJKYNiFNVKwmORLioLh6fHd+4ZcH4
	 ddoVgurzXTpdi6jlTk0v/zYZhjm+y1uOPk0WtWyZK3ZCLeg9EPP3RaUU41U7ah7EmV
	 w7Lr+B8wkDeCQ==
Date: Sat, 7 Nov 2026 01:47:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, "Trevor Gamblin"
 <tgamblin@baylibre.com>, Joshua Crofts <crofts@kernel.org>, "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] pwm: axi-pwmgen: report the waveform step
Message-ID: <20261107014755.364d4729@jic23-hlaptop>
In-Reply-To: <20261106160529.876251-3-Nicolae-daniel.Deaconescu@analog.com>
References: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
	<20261106160529.876251-3-Nicolae-daniel.Deaconescu@analog.com>
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

On Fri, 6 Nov 2026 18:05:14 +0200
Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com> wrote:

> The period, duty and offset counters of the AXI PWM generator count cycles
> of its external clock, without a divider. Report that clock rate and one
> cycle per step.
> 
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> ---
>  drivers/pwm/pwm-axi-pwmgen.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index b40522f01002..6b15244efabf 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -136,6 +136,18 @@ static int axi_pwmgen_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_de
>  	return 0;
>  }
>  
> +static int axi_pwmgen_get_waveform_step(struct pwm_chip *chip,
> +					struct pwm_device *pwm,
> +					struct pwm_waveform_step *step)
> +{
> +	struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
> +
> +	step->clk_rate_Hz = ddata->clk_rate_hz;
> +	step->clk_cycles_per_step = 1;

Given the only known user sets cycles_per_step to 1, what evidence
do we have that part of the interface is actually useful?

I can theorise that some device might need a couple of clocks
but can also theorise someone might use both edges of the clock as possible
state transition points for a PWM.

Note my PWM knowledge is minimal so this may be entirely garbage!

Jonathan
