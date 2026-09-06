Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802933C0619;
	Sun,  6 Sep 2026 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788731076; cv=none; b=cTtwk7hiW5NL1noP5+4VG90yvwNJqpfOD2HYZqv/9fdLP2k+gnYZht2ucol6iEzV2XTO6QoaclO0rLcgF1DqWVJhoIe0d5Fe97RhkZk7WblYXsgsOn09W8ZdBaUFK7dxxKc+epvDA5G2V2FrRpcAQJXvjRa1fKsCTSURcqQ5+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788731076; c=relaxed/simple;
	bh=p9IMSs4cUrwyhC59HnLu7FWGqJKYqf+L1eqzvY5S3XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgWirFCWRdGhL+m/wk8ETDmw3fy+f6Nm96RY5pPyUHxNuu1LdVUHVFibT2CO++JQ4z7A3QzEORO5n1HNhrjXdN2fVruNu0qDI/NZXAKd9S4mgDhkpi1h2xRO0pW/IowD0uHERgb5bofqJyoOBQE8epMouhLubeqXHoHA1xGon8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw8Z7Vpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw8Z7Vpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7246C1F00A3A;
	Sun,  6 Sep 2026 21:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788731074;
	bh=EspTMV3Op18o1x9uExv6wM29oNHslhzis7xhIg1ANss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dw8Z7Vpnny8BH+mjOcevwEOzvM3CIBV0cf66FTqNUCJIdZH4iI4ZOfqiNyQVcDJ9F
	 wvQv8g9JKezsM7jYs/XzcquhEZLJd+GIOupO/j3qlh8lnTYtICT26dOcCO4KDFI87H
	 IQY6NHpbq5boqTUFay+sv8afTeSxe40DRE0Y6D6XcUnOwik7BvL9YkOWtAgK23YzeL
	 DVxiOh/4tq+1+/eAJewv8FkBu15TLGT1kKHNWCDNCyi6v0tn1OAua2ThQevYXa7g4t
	 LIbVsGFqghRoxIuRTzwUI8QL++rFQaAGHMnOd9YPZ+/Qnj+AXYFp3nPrOfiSmqy9hn
	 UobQk0danu2VQ==
Date: Sun, 6 Sep 2026 22:44:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iio: ad_sigma_delta: support four byte register
 writes
Message-ID: <20260906224428.2e0b07fe@jic23-huawei>
In-Reply-To: <20260902-ad-sigma-delta-4byte-v1-1-af43e4e045f0@vaisala.com>
References: <20260902-ad-sigma-delta-4byte-v1-1-af43e4e045f0@vaisala.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Sep 2026 04:11:43 +0000
Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:

> ad_sd_write_reg() writes at most three bytes of data after the command
> byte. Devices that protect register writes with a checksum need one more
> byte on the wire: a three byte register plus its CRC is four bytes of
> data, which the switch currently rejects with -EINVAL.
> 
> Add the four byte case, and grow tx_buf from four to five bytes so that
> the command byte and four data bytes fit. The layout of the structure
> does not change, since rx_buf is aligned to eight bytes and only the
> amount of padding before it shrinks.
> 
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
> There is no in-tree user of a four byte write yet, so I am sending this
> as an RFC to ask how you would like it handled.
> 
> We drive an ad_sigma_delta part with CRC protected register writes
> downstream. A three byte register plus its CRC byte is four bytes of
> data after the command byte, which ad_sd_write_reg() currently rejects
> with -EINVAL. No mainline sigma-delta driver implements the protocol
> CRC these parts support, so the four byte case has no caller in tree
> today.
> 
> Two questions:
> 
> - Is the core change welcome ahead of a driver that uses it, or would
>   you rather see it together with CRC support for one of the AD7xxx
>   parts?

Needs to come with a patch that uses it.

> - If the latter, is CRC support for ad7173 or ad7124 something you would
>   want at all?

Hmm.  Retrofitting something like CRC onto a driver is an interesting corner.
For a fresh driver I'd normally very much encourage it but for an existing
driver maybe there would be a noticeable perf drop?  If it is pretty small
then I think we should enable it anyway and hope no one needed that last
little bit of perf.  I don't see crc as something that userspace generally
has a say in enabling - though I'm open to suggestions for why it might
usefully be given that control.

Do we currently support any CRC using parts via this library?  I'm not keen
on using put_unaligned_be32 when it is really a put_unaligned_be24 + a byte
of crc, so I was wondering if there is precedence?

> 
> Note that the buffer growth is not optional if the four byte case is
> added: put_unaligned_be32() writes data[1] through data[4] and the
> transfer length becomes five, so tx_buf has to be five bytes. Adding the
> case without growing the buffer writes one byte out of bounds, into the
> padding that alignment happens to leave before rx_buf.

That bit is obviously so drop this paragraph if you do a v2!

> ---
>  drivers/iio/adc/ad_sigma_delta.c       | 3 +++
>  include/linux/iio/adc/ad_sigma_delta.h | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 1b410291da5378584347231fcdb328fa5633a68e..bfdf28348e226a3b2311a8fc707aa4f41ed7e848 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -84,6 +84,9 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
>  	data[0] = (reg << sigma_delta->info->addr_shift) | sigma_delta->comm;
>  
>  	switch (size) {
> +	case 4:
> +		put_unaligned_be32(val, &data[1]);
> +		break;
>  	case 3:
>  		put_unaligned_be24(val, &data[1]);
>  		break;
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 6e70a412e218d54bbf9bb6861b1a4cc89be868e8..866355789ef0923c28fe8b61cfecb8b29fa9fb42 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -121,11 +121,11 @@ struct ad_sigma_delta {
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> -	 * 'tx_buf' is up to 32 bits.
> +	 * 'tx_buf' is an 8 bit command plus up to 32 bits of data.
>  	 * 'rx_buf' is up to 32 bits per sample + 64 bit timestamp,
>  	 * rounded to 16 bytes to take into account padding.
>  	 */
> -	u8				tx_buf[4] __aligned(IIO_DMA_MINALIGN);
> +	u8				tx_buf[5] __aligned(IIO_DMA_MINALIGN);
>  	u8				rx_buf[16] __aligned(8);
>  	u8				sample_addr;
>  };
> 
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260831-ad-sigma-delta-4byte-82f465fd2d48
> 
> Best regards,

