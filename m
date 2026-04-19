Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05651244661
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606607; cv=none; b=lvLofn2cHIVtu1bBqHVTZ0ahnMaur9I3Cvz3JVZjy8XRm2f3uBQGgN6KSOgA+bm1gKV6Ow7FWjlyVDEkfVuszsZ4q+EdAI0P61GVSnMKuosFxRkCBD0JdDiXGqobK/BDo/MduB40ofRUZPX+mFIrSRlK8T/eJziybbwTLKzXAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606607; c=relaxed/simple;
	bh=Ue5Oti8K+bVFW1+70ezv+sUmk1gAER2q3C5QNqVv8f0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHQLBE9e1fpbeRyvi+u2FGySMy85Tb+e8thaNeA3o45igHeRfOwvGxJ39Zpg/lzFmW3CzE7PNhWzIA40yCjaMAFahjJpeDwMNVzFS2TKR7U9AH6YV6RRCv6inAJORE1UGY1TAeo6BebZo3l1xq6mtwSuMwn75yw5a014TJfAZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPjGtsxh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPjGtsxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D0FC2BCB5;
	Sun, 19 Apr 2026 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776606606;
	bh=Ue5Oti8K+bVFW1+70ezv+sUmk1gAER2q3C5QNqVv8f0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oPjGtsxhVWs2L2KaVPZ5JBAlTopdr4QuoQJsBu16ScNB/nMY65U9i9XLPF61SEa59
	 NBb/g3AaRlRt21hzi4mVDUKagUo3NExGsGV9CzjKlNl7M9uNghghRLkcK+clUCry+p
	 auSNAwmvWgqUHG+9MX/nJKV0aIF02BOAvyklajoLNSeeZKCtDoz+l/pQT475KaKe3W
	 s1Bt206BfuNhz50qEkWjY5IU0Qglyj9durMQXGr9ako43x+Zi6weZqBSG/jQzdyYRl
	 6K7d/z98vQ+GWxIxJ+57GDW+XHApCgGIFWQa4sSlxT7npA8p5+A1RHHGa/CrFZNbRT
	 gLl1rQ3ig4uog==
Date: Sun, 19 Apr 2026 14:49:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 andriy.shevchenko@intel.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: dac: m62332: Use guard(mutex) for locking
Message-ID: <20260419144958.03394ed5@jic23-huawei>
In-Reply-To: <20260418130322.106769-3-erick.henrique.rodrigues@usp.br>
References: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
	<20260418130322.106769-1-erick.henrique.rodrigues@usp.br>
	<20260418130322.106769-3-erick.henrique.rodrigues@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Apr 2026 10:03:22 -0300
Erick Henrique <erick.henrique.rodrigues@usp.br> wrote:

> Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
> simplify locking and make cleanup automatic when the lock goes out
> of scope. Also simplify the i2c_master_send() error handling by
> using sequential early returns instead of a combined condition.
> 
> Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
> ---
>  drivers/iio/dac/m62332.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
> index 4b139904e818..a9bb6c307431 100644
> --- a/drivers/iio/dac/m62332.c
> +++ b/drivers/iio/dac/m62332.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/array_size.h>
>  #include <linux/bits.h>
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> @@ -46,33 +47,26 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
>  	outbuf[0] = channel;
>  	outbuf[1] = val;
>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
>  
>  	if (val) {
>  		res = regulator_enable(data->vcc);
>  		if (res)
> -			goto out;
> +			return res;
>  	}
>  
>  	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
> -	if (res >= 0 && res != ARRAY_SIZE(outbuf))
> -		res = -EIO;
>  	if (res < 0)
> -		goto out;
> +		return res;
> +	if (res != ARRAY_SIZE(outbuf))
> +		return -EIO;
>  
>  	data->raw[channel] = val;
>  
>  	if (!val)
>  		regulator_disable(data->vcc);
Not related to this patch, but sashiko is raising what looks to me
to be a valid point about this regulator handling.
https://sashiko.dev/#/patchset/20260418130322.106769-1-erick.henrique.rodrigues%40usp.br
(note some of the other 'bugs' reported' aren't bugs, but this one looks like it is
real to me)

The point is that a transition from val = 1, to val = 2 will enable
the regulator twice and then a transition to val = 0 will disable it only once
leaving the regulator (which is reference counted) turned on

J
>  
> -	mutex_unlock(&data->mutex);
> -
>  	return 0;
> -
> -out:
> -	mutex_unlock(&data->mutex);
> -
> -	return res;
>  }
>  
>  static int m62332_read_raw(struct iio_dev *indio_dev,

