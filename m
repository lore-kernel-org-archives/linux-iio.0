Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C102BB13;
	Wed, 12 Aug 2026 04:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510117; cv=none; b=Ng5fXQWmIiSrHxSX/rZobQ56PZv4if6UwH8JqK1baRARJ7KIygp2uusXsns/vvjDI5ZdtKKDWfkALeaWWWgm8Ob/WFOZPS+VSZ0eypUg//9pvF5C/w8CcvVzazVN7fb4BtlQWVWdPjgAzmJmvnIVFMjAY2Y5UXCjTVUY8PhFjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510117; c=relaxed/simple;
	bh=duxxv6G0rgLv1xlnmMUqBnsy5Pkei0zYUsQaGzJKGic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnJqlBu9y1c6D3NZqFWmIn3W241/Twfj6wXExYqxQDgVNoRCX523fH3reUl4vTedNa6Hz0/oDnCLcCJIcxgHuafvtrSumOQ+DwTpDT7ZMY6BD4gi8MNTSZerKVV9R/RePkdujIVtp0WVS5+ktDxx/mNkjeDThnK/pIM4RC1Lpx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGD46dmq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGD46dmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC77B1F000E9;
	Wed, 12 Aug 2026 04:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786510115;
	bh=dMo8lMjG8gqzkvVwytJqUgoCl4n2bz2YkCquvk/fp9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PGD46dmqQ8H6xKyEg/J96Y/hSzjPLdnyWDqji63WYR9MbKrZ8C1dyRgHxRTtTdFzo
	 bQt5M9pFG2rqlxb/qm5W1WLOqfYf6OgpXpastOtO4eFVqpybGtSTfo8YYTAQ7NJNyn
	 VEEbzl8zuiLFwq2Y25IGDP1nbH/JJX1zTuMd7LXcunv0bhJbXC/fldrEqTHcpYZkjg
	 D66KroVAWyElNADahoaNJLdm5ILgF+37MxkIWkxIqMzL5vzKLzlZa7G376z7tKg4jO
	 Vg07ziFlT1ZaOcWZPYS3MJUqdPGp9pXEtz0HlKLn5sfX+ggQb7Kc4i85XX1psan+Jj
	 xXVuWueDpbz0A==
Date: Wed, 12 Aug 2026 05:48:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, Vinod Koul
 <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 6/9] iio: buffer-dmaengine: Use dma_slave_caps bus
 width accessors
Message-ID: <20260812054827.7d97a564@jic23-huawei>
In-Reply-To: <20260810-dmaengine-support-wider-dma-masks-v2-6-1f7b798d035f@analog.com>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
	<20260810-dmaengine-support-wider-dma-masks-v2-6-1f7b798d035f@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Aug 2026 16:06:47 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Query the minimum supported source and destination bus widths through
> the new dma_slave_caps_get_{src,dst}_width_min() helpers rather than
> decoding the raw legacy u32 width masks. This keeps the buffer working
> with DMA controllers that advertise bus widths via the new bitmap
> representation.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
I'm currently assuming this will all go through a single tree
(and not mine) As such

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers=
/iio/buffer/industrialio-buffer-dmaengine.c
> index 98acce909854..855e3662cd3d 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -229,14 +229,13 @@ static struct iio_buffer *iio_dmaengine_buffer_allo=
c(struct dma_chan *chan)
>  		return ERR_PTR(-ENOMEM);
> =20
>  	/* Needs to be aligned to the maximum of the minimums */
> -	if (caps.src_addr_widths)
> -		src_width =3D __ffs(caps.src_addr_widths);
> -	else
> -		src_width =3D 1;
> -	if (caps.dst_addr_widths)
> -		dest_width =3D __ffs(caps.dst_addr_widths);
> -	else
> -		dest_width =3D 1;
> +	src_width =3D dma_slave_caps_get_src_width_min(&caps);
> +	if (src_width =3D=3D DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +		src_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +	dest_width =3D dma_slave_caps_get_dst_width_min(&caps);
> +	if (dest_width =3D=3D DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +		dest_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
> +
>  	width =3D max(src_width, dest_width);
> =20
>  	INIT_LIST_HEAD(&dmaengine_buffer->active);
>=20

