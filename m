Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7502C028F;
	Sat, 21 Mar 2026 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774120111; cv=none; b=d6OMKm2GoOtB+eKDVYVDk7K28fLjMJjxLzNSFFK+KffG8YbOcj87zZlx37/zUN6V2AetmJYugHXsVMobIaNVemtDHc1Ks0E4EVly7NGNHWwOdGm2QaLRHNJKhxgWkbqUB6dfNoMtQO8nDVYDzfNNnjDHTTh2MNDpy8NhA/CyZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774120111; c=relaxed/simple;
	bh=i+n5BYlC998eUMCDEUHIOCONz51rAsy6uCcchchBzqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1bC+eIpae8Yu+oRHIgGS84zyjGk7hq7KykB/mBDbFirirAXj4sUgVpsprAVSeNseiMoMNPfHoEONsVa3egogweiIpvrS/5UmxjaOFTwR/nocydA87eJt7JnIaAw8DPZb8i4auO5ZBiIP9gGWtZQ9/4+rvi1s6+49eH+gKyN8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQNF6eOg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQNF6eOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2235C19421;
	Sat, 21 Mar 2026 19:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774120110;
	bh=i+n5BYlC998eUMCDEUHIOCONz51rAsy6uCcchchBzqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gQNF6eOgfO/HGVHo0juagK/nurElyTfPcckbYXRXurZB7e60dh4hZ0UALB7W7Rni3
	 9+13U3C348/kWlFQanzYAfyqhH52fgEdOUeIgFrViI8WfLOwOMSkFCGLehMZ/lEheH
	 AnAnI+3lu5NkdPEGlgLNkvBZ7zQW41EX0ILIr05DX76h092XxZyBOgLeH148e5jblP
	 HLwnfHMn7SPrA+jJVqwH1CVa0QCNcOBWtjWZLLHMgX77+OQ8y5BZrys14jBO/HNcXt
	 chyL8wn4+bJVibLNQdjko6r+N/p9jUo1qwUyFxHToY2FZNhLh/uVGIm48p3dO/PtTZ
	 d/ljUBVXSUwlQ==
Date: Sat, 21 Mar 2026 19:08:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <cosmin.tanislav@analog.com>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH v2 5/5] iio: adc: ad4130: add new supported parts
Message-ID: <20260321190820.5c868cc6@jic23-huawei>
In-Reply-To: <9295ce0b3376481bf8530d1c53bb77a70e8761d1.1773311639.git.Jonathan.Santos@analog.com>
References: <cover.1773311639.git.Jonathan.Santos@analog.com>
	<9295ce0b3376481bf8530d1c53bb77a70e8761d1.1773311639.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 08:45:45 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Add support for AD4129-4/8, AD4130-4, and AD4131-4/8 variants.
> 
> The AD4129 series supports the same FIFO interface as the AD4130 but with
> reduced resolution (16-bit). The AD4131 series lacks FIFO support, so
> triggered buffer functionality is introduced.
> 
> The 4-channel variants feature fewer analog inputs, GPIOs, and sparse pin
> mappings for VBIAS, analog inputs, and excitation currents. The driver now
> handles these differences with chip-specific configurations, including pin
> mappings and GPIO counts.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Just one additional comment below.  Given it is either fifo or the other
path can we share physical storage for the two?

>  	 * DMA (thus cache coherency maintenance) requires any transfer
> @@ -324,6 +395,9 @@ struct ad4130_state {
>  	u8			fifo_tx_buf[2];
>  	u8			fifo_rx_buf[AD4130_FIFO_SIZE *
>  					    AD4130_FIFO_MAX_SAMPLE_SIZE];
> +
> +	/* Triggered buffer data with timestamp */
> +	IIO_DECLARE_DMA_BUFFER_WITH_TS(u32, scan_channels, AD4130_MAX_CHANNELS);
Could we put this in a union with some of the fifo stuff given it seems
to always be a case of using one or the other?

We are already in an area that should be safe for dma due to the aligned
marking some lines up. So to overlap you'd need to use the IIO_DECLARE_BUFFER_WITH_TS()
macro that doesn't force the alignment.

>  };

