Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B142EE262;
	Mon,  2 Feb 2026 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064169; cv=none; b=BBKudmUxAVTxAI1zGw0u/hWcrW/+HqJgoUZjYqtnCNH+o5vRPsNJ9+G1B/Z2iMdrqjhCQ4teA8dN1Yi8VOLgKCciJfXzZLBluu0qbUND++8ijcKVqpFJgG+XxiAeTcsvilv7C+2+zLW6dD+7mZz8CfQnYH1Zwi/lEkHquOcoI48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064169; c=relaxed/simple;
	bh=TI9lMJqRP4258IigelzMVRlw/r7SAYG4DeKuBlrEyAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbDauA8wiM2KW5Jg3udtOOyT7jR5kGaF4VrvkWSnoCtBfoNqRLjL5vM4AJAFQlLn68/c2rO3nIbqovBqll9uAfc87LeIoEvyXGz6jHlluFFzvunyxHa9gFkkTshsqTEZMrlrkcLwyv3HqUfDJhbTt7Q6s8K0hzndfRlhEq8ioeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsoLv4Zw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsoLv4Zw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E59CC116C6;
	Mon,  2 Feb 2026 20:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770064168;
	bh=TI9lMJqRP4258IigelzMVRlw/r7SAYG4DeKuBlrEyAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CsoLv4Zwdxa9603UfHdmbv9hdjRyxGUnzZhcBe5qqoUqTa4MTndXGg4MbIQxYccKg
	 2V+wLU8104ytGucdil4Tj1Np4nBIGM1ciOD/gpyvlMpjV/S6XEEW43b5XFLamOqgwe
	 jWMX+vZljJAVDtBxkR/RAf9v0S/4wpAJuJLMMtzS9hgqRmwYyZB4hKRZ4ifm61yV2v
	 dzhB4759pE8GYz5x7DASlc9A2KqLNT26V+wZl/+C0kZhRP1FEohb6j3NItDWV2ALLM
	 01Oja3tKp+K8kJF+zQR0PZ0+ZZxsALDrVbl3k4VxdQrVq1orCLgR4guNyogsQ2gVri
	 U/YSNdqh+Jqnw==
Date: Mon, 2 Feb 2026 20:29:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Schmid <lukas.schmid@netcube.li>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RESEND [PATCH v1] iio: potentiometer: mcp4131: fix double
 application of wiper shift
Message-ID: <20260202202920.1d45fa8a@jic23-huawei>
In-Reply-To: <20260202201537.2194476-1-lukas.schmid@netcube.li>
References: <20260202201537.2194476-1-lukas.schmid@netcube.li>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Feb 2026 21:15:35 +0100
Lukas Schmid <lukas.schmid@netcube.li> wrote:

> The MCP4131 wiper address is shifted twice when preparing the SPI
> command in mcp4131_write_raw().
> 
> The address is already shifted when assigned to the local variable
> "address", but is then shifted again when written to data->buf[0].
> This results in an incorrect command being sent to the device and
> breaks wiper writes to the second channel.
> 
> Remove the second shift and use the pre-shifted address directly
> when composing the SPI transfer.
> 
> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
Hi Lukas,

Good find.  
Needs a fixes tag though so that we can know how far to backport it.
looks like this one goes all the way, so I'll just reply here and
pick this up in a minute once my email reaches lore.

Fixes: 22d199a53910 ("iio: potentiometer: add driver for Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X")


Thanks,

Jonathan

> ---
>  drivers/iio/potentiometer/mcp4131.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4131.c b/drivers/iio/potentiometer/mcp4131.c
> index ad082827aad5..56c9111ef5e8 100644
> --- a/drivers/iio/potentiometer/mcp4131.c
> +++ b/drivers/iio/potentiometer/mcp4131.c
> @@ -221,7 +221,7 @@ static int mcp4131_write_raw(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&data->lock);
>  
> -	data->buf[0] = address << MCP4131_WIPER_SHIFT;
> +	data->buf[0] = address;
>  	data->buf[0] |= MCP4131_WRITE | (val >> 8);
>  	data->buf[1] = val & 0xFF; /* 8 bits here */
>  

