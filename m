Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517D255E43;
	Sat, 17 Oct 2026 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264246; cv=none; b=VyO4Wh0CflJbcKUwA8+gaZqI1bror1vs1p2W9C1HtFinlEL1uvlQFwvdVa1+Vy/ADMq/sYs2o5PF2jol/m0nkimJ12v+cUhsjmTQ6VAzIxqM7UFytFxk0eAJsFOPKTcEIWKR1ggFpBAHzDH0jHYkcLADYHvVCh9W+Q6i5H96+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264246; c=relaxed/simple;
	bh=orzydwwQvH+4TFpY2dG3asuXR+qpItNnlOB4/yGcQDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUrqHkq9I8MWmY83mO70eIzkblV0Ay6bhZQv6ZJiH2bb3Bim/ENmcik4hzVw3wSaGgPH8A4c7h1kii4Jk2h/mpXaCyDvVrt8yFH5uzM79k/ktkc7p2S/oSX+woKPSEOYwvfpqH0SRFMHCLUXXdnJZCCYrCQVTOrN6Tripa1Bw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieogcHsz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieogcHsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C081F000C4;
	Sat, 17 Oct 2026 19:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792264245;
	bh=1t/2jUGkxv5LyP1PvSsusnqIWBP2jrYAkzX+eKb0a9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ieogcHszQGt88CGu7RgJtcmPIP32ORtD+NMO16miZFs1OJMAEV31BQtiFXrE/APQu
	 2m1YP2yfSihxpPP264tH/nt/zvDHw/EMjcXMYBpxx3Wbzi85itl6UahDRcDIdpFsSc
	 P/3oXs2DQ7FY4IvlJ2Grrrd2skN6A6gEZzRqnVNxCMJ+K/aYfI0c/x1nMpRL0RMYrQ
	 2VAknvprqm/PaFz4Hk27DyH44EX0jqncu0q1HzAeDuwxuW+KGOjBy0AkElJBAU2Q5p
	 kprJt8bO2W+HPSSokToRsWF07m+5g51s7c8b8IWrl5HnH1dUIhKECn/CbQ4QHSzw0y
	 P++TLqey6oAJA==
Date: Sat, 17 Oct 2026 20:10:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andy@kernel.org>, <Michael.Hennerich@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v5 14/15] iio: adc: ad4134: Support high-speed data
 capture
Message-ID: <20261017201036.28a64081@jic23-hlaptop>
In-Reply-To: <44d545559aaf7cf2605aa30b5e9c9e5aa4aca879.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
	<44d545559aaf7cf2605aa30b5e9c9e5aa4aca879.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 23:00:34 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Make use of SPI transfer offloading to speed up data capture, enabling data
> acquisition at faster sample rates (up to 1.496 MSPS).
> 

I'd call out here that in this mode, you can't uses the sysfs interfaces
to read channels.  Even when offloading is involved, no access at all
is unusual. Is there a path to add that, if only for debug?

> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>


> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index 6b05e40f7aeb..21e8039b3411 100644
> --- a/drivers/iio/adc/ad4134.c
> +++ b/drivers/iio/adc/ad4134.c

>  static irqreturn_t ad4134_trigger_handler(int irq, void *p)
>  {
>  	IIO_DECLARE_BUFFER_WITH_TS(u32, channels, AD4134_NUM_CHANNELS) = { };
> @@ -520,6 +660,9 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW: {
> +		if (!IS_ERR_OR_NULL(st->offload))
> +			return -EPROTONOSUPPORT;

If direct access is not supported when offload is in play
then we shouldn't have an interface to get here (i.e. no
IIO_CHAN_INFO_RAW bit set in the info mask bitmaps.
As such is this just defensive coding?

If so add a comment to say that, or just drop it.


> +
>  		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>  		if (IIO_DEV_ACQUIRE_FAILED(claim))
>  			return -EBUSY;




