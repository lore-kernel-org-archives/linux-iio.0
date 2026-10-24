Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792807124;
	b=Dc71xhhlfHN4V0O0fa0D/uvnnG1KhsFJE98x5wz7osOpJ5eTNTdia24AriaiFD8IDOPP
	 pjfAqhhRhnYloalpBSaQoZGc93NUYyudDdcWRClisiwzUdcPpgaxZOq35G1NaIH+7+NZx
	 jX33Ac4uUzNX4k1TqLBUP5KGw0C847/gzaqDK/AoY6kCbt28atcLO6RNYf5GLYgmeHb7m
	 oVa2cnnxyCIeu6ZuQmID+pdnJ/OmnAHjCdrQJmrZ5HvSuJQAmVlovz2y/y4WpLgffCSrl
	 CrIY8MiGEuhMYh8jQBMat6Q6O8C6iwVmkI01UIBIxJUx7Nfq9oWYbkaqpRa3GWjURjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792807124;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wYmeRUTPN83/bvXZhX+dUyfHAGnw95r5UdroTmqqt+k=;
	b=4cYLY2C1svNbBcnTG4SLObhrwOK9IXaSUyRYJ0qJQZXAXpHAcmbXojU+XvDTny8bfyQN
	 KdKMoPrarMz4Qr3ca75PbX50IwvQ6N8+8egPVr8LSL4lBW/SD/TP8um076eq9m/WFF1r+
	 8wR2/1fwdgcLsZdH2Iyh/JI5gsxY33SM+2mlNmb5q1eEtVQyOJ3GxjwfbGEogHY+Bp1kA
	 KG9frMji4fHfeDjEimqhZ1Iy8gqxhEgqP6avUhJlBxuxgxUlo1rnBuZxChv74nCGQy/Mh
	 DDYFKOqjQb/bZFCRznHJgmbkv/RDz23emTh+I8rtR53dQI/nGg+i31rHTa37LhGzANw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rbx+um0T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E9606A31B;
	Sat, 24 Oct 2026 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rbx+um0T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFAE1F01825;
	Sat, 24 Oct 2026 01:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792807123;
	bh=wYmeRUTPN83/bvXZhX+dUyfHAGnw95r5UdroTmqqt+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rbx+um0TLH6TiEwf3gi85+eW2qloHWKH0bVUEQRDHpzTcPh3JBqkEMz1fap2R9/8I
	 5W7jNw57vuKUEJBZET5g3P/WsFH9U6qbYk9Bb5NBeZT5vZ/8Ht/RDfBAoKPrQDZVe6
	 LevOEL53AGt+8x3ok3WTbtU/yJu0wKMBrmLcFYZkfpxVk3RSDN79eQxVxgiwUj1suu
	 KmocIMReIcKBysGYFGC/210chx8lIJNbsxLWUf/l4+yxfpJ+ECmcthPMlIgG26Nj7f
	 1r+CwruRgW3AGzyLyCFGoNgg3qXtdjID748hTPh8Us8EIn7D3NY+eKfDM+8v69qjKM
	 +3vNzR9nQ3ZUg==
Date: Sat, 24 Oct 2026 02:58:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Marius Cristea <marius.cristea@microchip.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: mcp3564: reject devices without match data
Message-ID: <20261024025840.65257ab7@jic23-hlaptop>
In-Reply-To: <20261023185837.195943-1-kapoorarnav43@gmail.com>
References: <20261023185837.195943-1-kapoorarnav43@gmail.com>
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

On Sat, 24 Oct 2026 00:28:34 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> When the chip can't be identified from its ID registers, the driver
> falls back to spi_get_device_match_data() and dereferences the result
> unconditionally. That returns NULL for a device bound through
> driver_override whose name isn't in the id table, causing an oops.
> 
> Return -ENODATA in that case.
> 
> Fixes: 33ec3e5fc1ea ("iio: adc: adding support for MCP3564 ADC")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Applied

> ---
> Changes in v2:
> - Shorten the commit message (Andy)
> - Add Fixes tag
> - Collect Andy's Reviewed-by
> - Rebase on fixes-togreg
> 
> v1: https://lore.kernel.org/all/20261021225431.627718-1-kapoorarnav43@gmail.com/
> 
> Compile-tested only (W=1); I don't have MCP3564 hardware.
> 
>  drivers/iio/adc/mcp3564.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> index 259ac4ebdedf..91796a47e412 100644
> --- a/drivers/iio/adc/mcp3564.c
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -1204,6 +1204,9 @@ static int mcp3564_config(struct iio_dev *indio_dev, bool *use_internal_vref_att
>  		 * try using fallback compatible in device tree to deal with some newer part number.
>  		 */
>  		adc->chip_info = spi_get_device_match_data(adc->spi);
> +		if (!adc->chip_info)
> +			return -ENODATA;
> +
>  		adc->have_vref = adc->chip_info->have_vref;
>  	} else {
>  		adc->chip_info = &mcp3564_chip_infos_tbl[ids];
> 
> base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9

