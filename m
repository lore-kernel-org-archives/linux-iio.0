Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F2146A66;
	Sun, 26 Apr 2026 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777211239; cv=none; b=kJGSrVR3p2Zi7Rt/FzM1xj+5A6bg8rV/xZQ/l5izuitLpEmi1IrHAWG1XBjFycKAFl6uGZxJE27bBqip0LTq5WCINHYjByB/JWX+rYWMfXTILfmJNVDx5x1rxQxLZG88x5Pp2X0ss1IivrLjy5QY8gqZ1c77S9b5WE0U8FIzzwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777211239; c=relaxed/simple;
	bh=oy35uwFF9NRvDYki/vBf5b/lwDYhyuNP/7QkKUBnyjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ttf8Kij/Ct6g7D0IBe65zMTtApNITVs/N1w1cl76RLUIQ1wBrSvaGxT7hJTAR29S683DGs0SztVSRuVmnyo6vBKuKbbabGffTkbGp3QhVpGqJW+sE6hIyIrlBCTIIS1qe+oki0KXyuS0R2I2AvvRgb1XZ0xaxy6lSLq8qhT9tlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPgibppM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPgibppM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BB9C2BCAF;
	Sun, 26 Apr 2026 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777211239;
	bh=oy35uwFF9NRvDYki/vBf5b/lwDYhyuNP/7QkKUBnyjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gPgibppMth6717g4I3JJ9sdgUXL8l0FXu4m3EQM5mWnqwNQ0hClOn5jvyQt3yr6CE
	 dR1pYLUSw12bkoVa6SEUHWShEklafGIi6ze9l4old68f6l7h1uAdHieIbEqJQPGbwc
	 cEhu5VzCPTuMzIrU6lXmbKJibJlu4gJyyp4UlKdKSnXA+Becw/EP/++P2DwYZYbX0Z
	 eh06Yol5p22vPxlqfQrGSOjQ/7TfYk3hwwYCk8zS/wOv2yYSAoeDC3poS4+5dDHDHW
	 oRFkpCIpt74hEMAUVMQKTHt7wFBINNucRyvYjcMYXTs8POx2wgMkjZzNlHcJkVlhLD
	 xDU1jbxMMfkUQ==
Date: Sun, 26 Apr 2026 14:47:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 06/10] iio: dac: ad5686: acquire lock when doing
 powerdown control
Message-ID: <20260426144709.5d1201f1@jic23-huawei>
In-Reply-To: <20260426-ad5686-fixes-v1-6-7c946a77794e@analog.com>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
	<20260426-ad5686-fixes-v1-6-7c946a77794e@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 09:38:07 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Protect access of pwr_down_mode and pwr_down_mask fields with existing
> mutex lock. This issue exists since the ad5686 driver was first
> introduced.

This doesn't say what the issue is.  You definitely need to mention
why those two elements need protecting.

> Acquire mutex with guard(mutex)() throughout for consistency,
> which allows for early returns, facilitating the review of further
> changes.
> 
> Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")

Again, fixes at start of patch set.  Or given there are a few here, as
a set on their own.

> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 843e425f656f..c7d5ee344a6f 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c

> @@ -163,25 +170,19 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
> -	int ret;
> +
> +	guard(mutex)(&st->lock);

Guard changes don't appear related to the thing being fixed so
do that in a separate patch.  Fine to have an intermediate state
where the fix includes guard() only in the new places the lock
is taken then a follow up patch that brings everything else in line
with that.

>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		if (val > (1 << chan->scan_type.realbits) || val < 0)
>  			return -EINVAL;
>  
> -		mutex_lock(&st->lock);
> -		ret = st->write(st,
> -				AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> -				chan->address,
> -				val << chan->scan_type.shift);
> -		mutex_unlock(&st->lock);
> -		break;
> +		return st->write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> +				 chan->address, val << chan->scan_type.shift);
>  	default:
> -		ret = -EINVAL;
> +		return -EINVAL;
>  	}
> -
> -	return ret;
>  }
>  
>  static const struct iio_info ad5686_info = {
> 

