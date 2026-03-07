Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72011F4634;
	Sat,  7 Mar 2026 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772879515; cv=none; b=q0k1wYN6sO3ORocaWNWpfVNwirl1kgVTVJU8b5VklNthJqE76uysZ4Q/bq2PE+6LrgoUJGctuTDq9DXFcGy1ubMEhJvoQicq3Kc6kLb3PoFzmsOArKMb8zku/ax2lv/DpwP+XPzOgMe9ajvaJen0Uu/Xr12vt3vTIPG8zgxMe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772879515; c=relaxed/simple;
	bh=ETU5jx2bPsdZnXysAsbZWqwhOLS6/jT06udarzgUytM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jzefw0llLWZSq+VZTre5cH16//zrE8olS4woQbf95kZ5NpXO5E+CUqRKEfcK7fjLBBIm9pns+jDuzZZfphRI8mMKW9jvWnNRM4s8JCFpiGGnWrJliMXp3/K+UOyD1/0BsogNoQDEsVCMIEoz1+llaozdY9+lcBJyHnH/vpp84Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJAJua5u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJAJua5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB37C19422;
	Sat,  7 Mar 2026 10:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772879515;
	bh=ETU5jx2bPsdZnXysAsbZWqwhOLS6/jT06udarzgUytM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZJAJua5uzs0p/kIWfTQ36xOud44nzRtni1z0DsQBI1LZx84WmTi8J+ZpvUk05llCM
	 iMjcZ1pnCbGzQoLYDikH4OJdk/hwlGfDkjUR13fvsyraCRMJID7CDTmcTpYnH0XXgd
	 ixlFxMnCWsrMGNFD2wY//1WZRrGhp1WC8pPiKm9OFS2UIej1phQXgU1z6hh1lFEeH7
	 utbg+xwXytEsMAI3YDg+i51ug1VJc3HI33ZDHKzWz8QdWxzvSnm8ZAK2zvcU7IZETO
	 M84UjhLE0SPHIBNbs/2cMBdn/Ne5vxWDBmKmvMeAhwK5GPQ9d8y1h9xvmA/JRb/enX
	 4GRrNhk7ioSsg==
Date: Sat, 7 Mar 2026 10:31:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 puranjay@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: accel: adxl313: convert to guard(mutex)
Message-ID: <20260307103146.5e79767d@jic23-huawei>
In-Reply-To: <20260307101758.50091-2-rajveer.chaudhari.linux@gmail.com>
References: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
	<20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com>
	<20260307101758.50091-2-rajveer.chaudhari.linux@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Mar 2026 15:47:56 +0530
Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:

> Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
> adxl313_read_axis(). This ensures the mutex is released on all
> return paths and allows returning directly without a goto label.
> 
> v3: Return directly from regmap_bulk_read error path.
> v2: Split into separate patch per driver.
This change log belongs..
> 
> Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
> ---
.. here so that it doesn't get picked up when the patch is applied.
The history of how a patch was modified isn't normally something we want
in the git log.

One minor comment inline.

>  drivers/iio/accel/adxl313_core.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 9f5d4d2cb325..40f62c6f89b4 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/overflow.h>
> @@ -354,21 +355,15 @@ static int adxl313_set_odr(struct adxl313_data *data,
>  static int adxl313_read_axis(struct adxl313_data *data,
>  			     struct iio_chan_spec const *chan)
>  {
> -	int ret;
> -
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
> -	ret = regmap_bulk_read(data->regmap,
> +	int ret = regmap_bulk_read(data->regmap,
This is not a style used in the kernel.  There are exceptions where we declare
variables inline, but those are mainly about __free() so where a destructor and
constructor want to be visible together.   That doesn't apply here so please
leave the declaration of ret at the top.

Thanks,

Jonathan


>  			       ADXL313_REG_DATA_AXIS(chan->address),
>  			       &data->transf_buf, sizeof(data->transf_buf));
>  	if (ret)
> -		goto unlock_ret;
> -
> -	ret = le16_to_cpu(data->transf_buf);
> +		return ret;
>  
> -unlock_ret:
> -	mutex_unlock(&data->lock);
> -	return ret;
> +	return le16_to_cpu(data->transf_buf);
>  }
>  
>  static int adxl313_read_freq_avail(struct iio_dev *indio_dev,

