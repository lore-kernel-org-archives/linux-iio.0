Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649857;
	b=WQZAg95tSECsntutiQL6OlXqPNn885URwePiTR6Th+yxNl9+0kiGfhhUhDZgImRHd8Nh
	 JpZnN/kobvhgBk4mLhOw1d+5IEtON1WLqGBbz+CiVXI67K38boIbOr7IKm5y3Sc3zoW+Y
	 6g28KC9wlQOG8FfGUVDwAjLVu2uvcUjsLYIROBjTfD4B7Aopvd0QnCQDzfnylOehiuZXa
	 F1w6W3qMm/e2O8MMw29a3FHt1LwptqU9fBX7WLBk/2d0gR7I5odbBSo2x6d6+1g8tDqGY
	 mgM71B/xQPdl8SEp19CGrR7EvdXpTHb3T+SDb0ScMsx8Qu0yVsglyuQUMCgwTO5eT4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649857;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3kLEugfQfn8NVt9VAXAf6YXDkgAIN7iKcN9pwbkyzcg=;
	b=Kd9Cb5mV75WX7DFa3GDdvX4xwUEeoOWyOIL6g4o7HfiOJknJ+AzQY1YOXmz2zsiiKtfH
	 WGIgZQah2zaZzyQV7uGJl+/mc7yeRNmEBqpnThAQcUJeJosqHpVPq6i+r0inTyhl56rKI
	 6c9T58mIkwZ9OmxTi11dIE9dTwO0Y107zJQOUfS58lFnV0pfbLZ3PbOPKG/aAe1aOFo0B
	 5joxAUZo3MsF3QvjMl/jf7QHC+ikzf++EpsWnIxdTHCqtxL4qkdN31X4okVK4va5PQTbR
	 54zBbIiX8SA/iwTPq6VaeqKJyDrM1s7BSwk2/jpOFMsz+KG9WESxaEYuBnkjP9dUNgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeCjZQNo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F1606A321;
	Wed, 25 Nov 2026 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeCjZQNo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F281F000C4;
	Wed, 25 Nov 2026 23:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795649857;
	bh=3kLEugfQfn8NVt9VAXAf6YXDkgAIN7iKcN9pwbkyzcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VeCjZQNoLN9PTEmKwZ7EkWiC0YZoUToH+rm470p90gtziK9NAzQmIFzEfMFl8rc/7
	 81YSZx8zlv2j5aCPPCBft6MxzJtJhPWOJCakrHNsOkfbwnKZizS0hMNzIVh2QvB3en
	 TAROg6FYw3zBeTseIYDG4mFHThscXqQWNuq/ZvcKhaLZt0kg2yNGjTFI6A5zvks944
	 cZMwzO4GsDLRggmUnPlGwElgmdXg1COQFDy64aXJH+oGo5NRpXqV8HTgYgyKVZV8tG
	 T+M9hDq8T0aq937q4scpbVoYw07BAnONkmkHFhPh6dh/f+T6MdFtNhdPuqRUZDBtXb
	 s2LsFkebv4eDQ==
Date: Wed, 25 Nov 2026 23:37:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joseph Telaak <joseph@telaak.dev>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Peter Rosin
 <peda@lysator.liu.se>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iio: ABI: Move out_resistance_raw_available to
 sysfs-bus-iio
Message-ID: <20261125233727.5b5c68f0@jic23-hlaptop>
In-Reply-To: <20261125-iio-ad5246-v2-1-8feeb630f0b6@telaak.dev>
References: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
	<20261125-iio-ad5246-v2-1-8feeb630f0b6@telaak.dev>
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

On Wed, 25 Nov 2026 15:22:28 -0500
Joseph Telaak <joseph@telaak.dev> wrote:

> The available raw values of a resistance output were documented only
> for the mcp4531, without the channel index. ds1803, mcp4531, tpl0102
> and x9250 all report them, and indexed channels name the attribute
> out_resistanceY_raw_available. Document both forms with the other
> generic resistance attributes and drop the driver-specific file.
> 
> Signed-off-by: Joseph Telaak <joseph@telaak.dev>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio                       | 10 ++++++++++
>  Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531 |  8 --------
>  MAINTAINERS                                                   |  1 -
>  3 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 54800847f2ca..83eb616862ea 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2034,6 +2034,16 @@ Description:
>  		Raw (unscaled no offset etc.) resistance reading.
>  		Units after application of scale and offset are ohms.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/out_resistance_raw_available
> +What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceY_raw_available
> +Date:		October 2016
> +KernelVersion:	4.9
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The range of available raw values, as the minimum value, the
> +		step and the maximum value, all enclosed in square brackets.
> +		Example: [0 1 256]

Not suggesting we do it in this series but in general the ABI docs could do with
a cleanup for _available attributes.  Their form is generic and what the values
mean simply comes from what we are describing as taking those values.

Ah well, a move is fine for now as this doesn't make things any worse.

Right now there is too much else going on to worry about tidying up ABI docs.

Jonathan

> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_coverageY_raw
>  KernelVersion:	7.2
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531 b/Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
> deleted file mode 100644
> index 2a91fbe394fc..000000000000
> --- a/Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/out_resistance_raw_available
> -Date:		October 2016
> -KernelVersion:	4.9
> -Contact:	Peter Rosin <peda@axentia.se>
> -Description:
> -		The range of available values represented as the minimum value,
> -		the step and the maximum value, all enclosed in square brackets.
> -		Example: [0 1 256]
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c74dadb6cea9..ef6033c5edf3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16691,7 +16691,6 @@ MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
>  M:	Peter Rosin <peda@lysator.liu.se>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
>  F:	drivers/iio/potentiometer/mcp4018.c
>  F:	drivers/iio/potentiometer/mcp4531.c
>  
> 

