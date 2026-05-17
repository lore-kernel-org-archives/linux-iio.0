Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4916405C4B;
	Sun, 17 May 2026 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029935; cv=none; b=dILhEEgMhSuRVpbcXjhNfygh+13/2HBAS6gM+6WvDw4V+UCUpOiV+NEzkOVcVDhaf8cND9wkWNz4IAiyhZZo+iaOjYpe8TL2dEn68xiu2BJTQp1DNz0pGaCVUb7B1Y05Pp5IvguU1sRmy9oFBx9nad0PYKyEPFfGeEaiyOB/6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029935; c=relaxed/simple;
	bh=1/XxmtYLtJTXXPC9jwFGV3orfIZ2dD7+cPrHHIv2AGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcW4p2Bq3qId3AF7HU5bex0t4C5QkKbQ1ZVQAt9srHlUyqpmiy/tz5fX06LavlwTqfMReGj5JJ1j2UvEDXBLdy20NqrY8rb6ANmYOSRuLdxKKsTppb+FsNKo4F4WtdhCLFa5pLdoFPXy5gCIXxU84aomMhE/LO8MDXq6Fg1ujo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKgtW2vO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKgtW2vO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC57CC2BCB0;
	Sun, 17 May 2026 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779029935;
	bh=1/XxmtYLtJTXXPC9jwFGV3orfIZ2dD7+cPrHHIv2AGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IKgtW2vOic/gfcG5O3ydGgB+7FKV7JGIgLahQHzmy/KreAhEd1SsOI4gDDibKqKAw
	 bVnubh7QiZs73Z91V8UuJ2kdtMDOZ6MkAKXNg+veC9PGX/IXh5Tj6Mef2pAO6LNUTw
	 cz3PG6ya0zRR3fUp4amccfMVDwajsnMAZgC2DDDDDyjhaBoyApu11bDffkFxhD8xGX
	 oFelShe4CUcIVgi70wVGqeEjOR/bU157HUnBZJrb205zAGxjA8f22JOZ9n3ZjDqz5H
	 Wi3lyHg8VNjhIiXhTOF13HfUN3S0tNsgGhwBeKqXTNd0iBHvnP8tzuo7AZR5RlFrwh
	 gGdQTbP0XH/EA==
Date: Sun, 17 May 2026 15:58:43 +0100
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
Message-ID: <20260517155843.7f833658@jic23-huawei>
In-Reply-To: <20260508-ad9910-iio-driver-v4-9-d26bfd20ee3d@analog.com>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
	<20260508-ad9910-iio-driver-v4-9-d26bfd20ee3d@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 May 2026 18:00:25 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add custom ABI documentation file for the DDS AD9910 with sysfs entries to
> control Parallel Port, Digital Ramp Generator and OSK parameters.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
I'm fine with phase and frequency as defined, but for the scaling it made me wonder.
For outvoltage0 channels the assumption the value is the peak voltage so if
we know what input to be modulated by the ramp generator can we express them
in volts (well milivolts) rather than as a scaling multiplier?

That seems to me like it fits better with the overall ABI.

> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_offset
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For a channel that allows amplitude control through buffers, this
> +		represents the value for a base amplitude scale. The actual output
> +		amplitude scale is a result with the sum of this value.
> +

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_roc

Silly question perhaps but can work out how this related to millivolts/sec
That might make a more intuitive interface than scaling multiplier per sec
Perhaps the combination with offset makes this impossible though maybe that
could be a expressed as a voltage offset?  Afterall if the amplitude being
scaled is 5V then 5 * (offset + scale) = 5 * offset + 5 * scale
 
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Amplitude scale rate of change in 1/s for channels that ramp
> +		amplitude. This value may be influenced by the channel's
> +		sampling_frequency setting.


