Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795837436;
	b=DlxdKaHutQ7TotsyBOUnVg4yq7dvEJMbp2Gc6c20bBVz3obLfa1grLCp7RRv2ksJErPj
	 KyIB7q+JDEw7Pc0tT8E+Dvo6ZU5E4b1UNwGSEqvAfBS6Zw2luoWPdJXoQ9bEYxqGELM4G
	 ccuhiJsHV/TOfOQp31qzxerntpV7az3XouXbNzBSJ17Aws2X5ivg3tpnNgL72keEbaKVH
	 y0XCXKEX6aQtIQ/XINV/OBD7VWDfns8ymoRtJSGJ8Qrzss94+z+ArLVgDiEj5zKd0lk4m
	 ZZl3VNKqWu8UGvm1aPxvx6W3+C3YfqTatp11CkrNDvSbAQC12EUlIGfpGEvpPpaiRRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795837436;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IUVVTSSRDvHW+dadB9mxf31NZUgYyPwE8M8dk6TMfQ4=;
	b=dDQmvGIvyORe5fhXViDvJPaxaUnshxJScjDXPM3OvBGKAfer5v2sAXjpCuOter8Zj1g5
	 xBoznu08YA5dnT9oGJ1rGaQ71WsujjWJSRU8LQnNbivfiK9lesD9nLQCy2STdAgg6hvZW
	 G0lAW0By4z4KnXO/j4HrlKQO6SyZaX//azDpmGUlFQHT9Ca6Bn9fjMcA70KZ1Jsy6tnJe
	 ICbIwUpHNWAdw8lvb9Ds9w2qXq/iawGtZv2wy+D5CRXnxoQvjwoJQ99IyhUkAfbuuqahM
	 2fGLHhsctXV8seU27I08dCrGCwRPE66kUOe/686s9893XRrQj9tliVYZW0q6czN4pHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRUuQzl1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507AC606A31C;
	Sat, 28 Nov 2026 03:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRUuQzl1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995011F00893;
	Sat, 28 Nov 2026 03:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795837436;
	bh=IUVVTSSRDvHW+dadB9mxf31NZUgYyPwE8M8dk6TMfQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SRUuQzl1KwdmCWirAR//bj9sUjg6VhscWcf6KKnFHgULFb4ITiYIsnmZcKZxSq7GG
	 TwWBGsKrD+VXWNBZVAlForwmRlJT07NNVOa4MtfcvOYwk+2HDDZXcHgGJuYcIuLHPD
	 ejtr3nH5Ef9B8ah6mu5C4eVdpMnjG7OPghbxNbj9jXPrzG/pQ9MOEFSy4YNQMS1SvE
	 Zbhed5pyBov3hs0QSHyFx199oMHKba/KW8cpLmhmHiNRmf780MzMLh5gTqAnwE8PeF
	 3ZLHbXgtd1bCAiCt7libLw7kE/GDqAhETSfld70698/JiFyID1r2yCP5wBRwCHk5K6
	 qUMSgvSYaRUYw==
Date: Sat, 28 Nov 2026 03:43:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Biju Das <biju.das.au@gmail.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add fwnode_xlate() callback
Message-ID: <20261128034348.5e1de2c7@jic23-hlaptop>
In-Reply-To: <20261126134826.46044-1-biju.das.au@gmail.com>
References: <20261126134826.46044-1-biju.das.au@gmail.com>
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

On Thu, 26 Nov 2026 13:48:19 +0000
Biju Das <biju.das.au@gmail.com> wrote:

> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> On RZ/G3L ADC1, IIO channel indices don't map 1:1 to hardware channel
> numbers. Add a fwnode_xlate() callback that finds the registered channel
> whose number matches the specifier argument and returns its index.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Sounds like a fix.  So why no fixes tag?  If it needs one then reply
directly to this email with one and the tools will pick it up when I apply.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/rzg2l_adc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 340813f6f890..f00cfb897124 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -286,9 +286,23 @@ static int rzg2l_adc_read_label(struct iio_dev *iio_dev,
>  	return sysfs_emit(label, "%s\n", rzg2l_adc_channels[chan->channel].name);
>  }
>  
> +static int rzg2l_adc_fwnode_xlate(struct iio_dev *indio_dev,
> +				  const struct fwnode_reference_args *iiospec)
> +{
> +	if (iiospec->nargs != 1)
> +		return -EINVAL;
> +
> +	for (unsigned int i = 0; i < indio_dev->num_channels; i++)
> +		if (indio_dev->channels[i].channel == iiospec->args[0])
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
>  static const struct iio_info rzg2l_adc_iio_info = {
>  	.read_raw = rzg2l_adc_read_raw,
>  	.read_label = rzg2l_adc_read_label,
> +	.fwnode_xlate = rzg2l_adc_fwnode_xlate,
>  };
>  
>  static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)

