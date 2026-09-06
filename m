Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698533B42C0;
	Sun,  6 Sep 2026 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717406; cv=none; b=OazDJPcFNYFljockqP8MieXrRqHZ3z4LU9n7+4vAQ0U1G6K9dNuXBvozFtw9PCwWgO/v0MP1Xutv2hOLotaAqX2dqDRMQnjLe7oqnX8Z4xEGFHIv6AuPJjSC/rYedlCENlcSkRng6fpVyYpc7lm9JQlmYp4gnuZ0wtSNpSww2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717406; c=relaxed/simple;
	bh=T2p251zp5FhPoCifnmVlqxpg9Ql9ifdAGXbL7HH+9nE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3YsG7yCuex+zZECq5HfFCzHhtvVOdSOzArg8izzfg00djVU5a8gv6wSwc2tMP7fSQM3dWvfkDzp1sc+B8LQJ1QisjBshs+UGRA4nWXxEDcGW8oR8Pycz1jHc3OyGtV1yORP3rSgKANjisT2t31e2I9exumDrJqFtWVM+qLpQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko5FTGbb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko5FTGbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF191F00A3A;
	Sun,  6 Sep 2026 17:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788717403;
	bh=9+2M6E7sgzvIjfqdHE3Y7EFLYYax73rduYrlsljSOGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ko5FTGbbQnl6qtGmFm5Q14KESBBMaAEfSu4buCMXs9+IiHU2NbRgUWDFq5skXwKxT
	 4eaM5HqGYFqdX1ffjBuWinPYN2EKY6zeivYJtwjY9Om3LOhH+ERt+ni9t38B59lXGN
	 CrsrF7B8YdVf10EDdHvFGHG8c4nLYQCbUULB1Z4eJjx2ag63Dp+cVtJbpiZ8cFMfwm
	 1brbBrOCHid1q0cF9dvuXtcg1UjWdrYacxy6cnInJhrortpbpxM8lbBwfJcz3mdkhp
	 ExkG5pd2shqvGUN6pfthBhZOnSJpBMvC5xmuZdUNNbZAGwtR63jeJjPpvSH4i3rufw
	 7QFL4LzAV/udg==
Date: Sun, 6 Sep 2026 18:56:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Manush Prajwal" <manushprajwal555@gmail.com>
Cc: sai.krishna.potthuri@amd.com, conall.ogriofa@amd.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: adc: xilinx-ams: fix OOB read in
 ams_get_ext_chan()
Message-ID: <20260906185637.2046ca1d@jic23-huawei>
In-Reply-To: <6a9d48ef.4987c784.3608f9.714a@mx.google.com>
References: <6a9d48ef.4987c784.3608f9.714a@mx.google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 6 Sep 2026 16:35:18 +0530
"Manush Prajwal" <manushprajwal555@gmail.com> wrote:

> The PL external-channel "reg" property is only checked against its
> upper bound (AMS_PL_MAX_EXT_CHANNEL + 30 == 50), matching the
> 'maximum: 50' constraint in the devicetree binding
> (Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml), but
> the binding also documents 'minimum: 20' which the driver never
> enforces at runtime.
> 
> ext_chan is computed as 'reg + AMS_PL_MAX_FIXED_CHANNEL - 30' in
> unsigned arithmetic. For any reg < 20 (e.g. a hand-written or
> malformed devicetree overlay with reg = <0>), this underflows to a
> huge unsigned value, and the following
> 
> 	memcpy(chan, &ams_pl_channels[ext_chan], sizeof(*channels));
> 
> reads far outside the 31-entry ams_pl_channels[] array.
> 
> Reject any reg value that would produce an out-of-range ext_chan
> before it is used to index ams_pl_channels[], instead of relying only
> on the upper-bound check.
> 
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>

Explanation seems valid. I'll wait for the AMD folk to have
time to take a look though before considering picking this up.

One comment inline.
> ---
>  drivers/iio/adc/xilinx-ams.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index 158e6133a..cd778d053 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -1154,8 +1154,11 @@ static int ams_get_ext_chan(struct fwnode_handle *chan_node,
>  		if (ret || reg > AMS_PL_MAX_EXT_CHANNEL + 30)
>  			continue;
>  
> -		chan = &channels[num_channels];
>  		ext_chan = reg + AMS_PL_MAX_FIXED_CHANNEL - 30;
> +		if (ext_chan >= ARRAY_SIZE(ams_pl_channels))
> +			continue;
I haven't looked closely but is it ever fine to go off the top of this?
If not, error out and fail probe.
I'd also prefer to have more direct handling of the wrap around case
rather than relying on it being a big value and so failing this.

Thanks,

Jonathan

> +
> +		chan = &channels[num_channels];
>  		memcpy(chan, &ams_pl_channels[ext_chan], sizeof(*channels));
>  
>  		if (fwnode_property_read_bool(child, "xlnx,bipolar"))

