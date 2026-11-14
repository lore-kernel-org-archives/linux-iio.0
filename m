Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697338;
	b=ZZkHoitr0FHlNvrmZyLfdJFZfnOF6yPmrcoQM72g3YoCKP524CnUGKoW4YXNpViCqdRz
	 H2+ddo/BFOQpZfJiDjJjpf4djcs/8N8nrNSjuLrlIHGH7JkonIkJPJT2D23wq1yxRKvEc
	 RDo+qxpQYUJW5GNwB6/XoZ1abWqqv6g/s6tRGtSnKrMZvFCiqiVi9HUsU9o+rKjKuqldl
	 03CN/6qPhRuIdSnzp/qLZ2i5K0oNrzpEgxv8NTAGOPC052uxLrDU2SpStrnQJaTcizA63
	 iNCV0k16wBeShEP5G7s1ToZCOh5mBY4RLFteFFCicgxB7JKce2aNCLk5X51tebwbCIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697338;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=E+c6urLa23eP640Q2vfarHT1qxBNlCLeaHxHasRT0Qs=;
	b=VqIbDryPSFa4Os/1ekW08Vtj5kx3AAj4g4VIO+01aAnkkc+h0bKXGp57P/E+vU2gXQG6
	 F5R9hU49+nIZ3g69sZcwiIuPII7zS2/Pe8kuQ6YgeqT2eIrs+Xppp1i9LiqgUoarDCZHK
	 YJnlU34BkCnGRWdIhCpf+21uUV60hKMGMxfyI+l1h8HXc34iNSVd0z8TvPX/uKby4s7W9
	 klIFoSErJm+DmIK3FdAxOPlv9YGuBeLXSZHfVnBrCcVme2PRzjEJnrg8aCqjrtRgnfJt6
	 h3kRgmk2Mz08bkOKyq7Y9/4Z8yvvSgJMoxdEHaF5ZK1v1W87VmSQFJbCV1mXrTNXuHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2628vlL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E5606A33F;
	Sat, 14 Nov 2026 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2628vlL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF071F000C4;
	Sat, 14 Nov 2026 23:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794697338;
	bh=E+c6urLa23eP640Q2vfarHT1qxBNlCLeaHxHasRT0Qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T2628vlLSIX57XLkLM9tFnjgFDv3qSjioBl2xHn5oX4Cisv/4yf9k09J19zvSuE9o
	 pOYcA2UNFj/LaHThfqN34fbiCAmHjolzAZ2qoc1J82K7jHS81ulyRQ7Zd0wXFoUtdO
	 lk3H+v4DwTD7/xKGglzy1JJPU2oMMH9gmXUCJX8bUGyK2vWulrw4U8BZjZLFlPRmk9
	 ihPGOvTgATyu8yFYJUdyOpdAaCIv979hIWHzKEsHW0KjHYNf423t9HWCKHJKBnLMt8
	 /hnxAiQNtRjk0bSBc3FzP94IG4HNACJKXUZsOYg/FlbsK5R0LHW4sfhmi/ciST2Qji
	 YElkorXkGGgDw==
Date: Sat, 14 Nov 2026 23:02:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Pan Chuang <panchuang@vivo.com>, Hemanth
 Selam <hemanth.selam@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nikita Travkin <nikita@trvn.ru>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: light: ltr501: Add support for the
 LTR-659PS-01 proximity sensor
Message-ID: <20261114230210.4b2c4cb1@jic23-hlaptop>
In-Reply-To: <20261108094253.83899-5-clamor95@gmail.com>
References: <20261108094253.83899-1-clamor95@gmail.com>
	<20261108094253.83899-5-clamor95@gmail.com>
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

On Sun,  8 Nov 2026 11:42:53 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Add support for the Lite-On LTR-659PS-01 proximity sensor. This device is
> nearly identical to the LTR-559ALS-01, but omits all elements related to
> ambient light sensing.
> 
> Add a no_als_support flag, similar to how no_irq_support is used, to
> isolate ALS register access for the LTR-659PS-01, since ALS registers are
> marked as reserved and interactions with them are discouraged.
> 
> The ltr501_trigger_handler relied on the scan index to identify channels.
> This approach is fragile regarding channel status flags and can break if
> the index is not strictly set. Switch to checking the channel type
> instead.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Just trivial stuff inline.

Thanks,

Jonathan

> @@ -1260,16 +1295,21 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
>  		aligned_s64 ts;
>  	} scan = { };
>  	__le16 als_buf[2];
> +	unsigned int i;
>  	u8 mask = 0;
>  	int j = 0;
>  	int ret, psdata;
>  
>  	/* figure out which data needs to be ready */
> -	if (test_bit(0, indio_dev->active_scan_mask) ||
> -	    test_bit(1, indio_dev->active_scan_mask))
> -		mask |= LTR501_STATUS_ALS_RDY;
> -	if (test_bit(2, indio_dev->active_scan_mask))
> -		mask |= LTR501_STATUS_PS_RDY;
> +	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->num_channels) {

iio_for_each_active_channel() should work here.  The longer term plan is
to make some of this stuff opaque so I have a series that I haven't posted
yet converting most users over to this macro.

> +		const struct iio_chan_spec *chan = iio_find_channel_from_si(indio_dev, i);
Fine exporting that helper.

Thanks,

Jonathan

> +
> +		if (chan->type == IIO_INTENSITY)
> +			mask |= LTR501_STATUS_ALS_RDY;
> +
> +		if (chan->type == IIO_PROXIMITY)
> +			mask |= LTR501_STATUS_PS_RDY;
> +	}


