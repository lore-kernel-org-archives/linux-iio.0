Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FC2246781
	for <linux-iio@vger.kernel.org>; Sun,  4 Oct 2026 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131915; cv=none; b=cQ2JQUsW/xa3Mt5lNYzhnvnsnzftvDfH/Np9AFuKQQhOpoLWzA25LZ0YxL+V3fdLc1iQMPR31Jz2iBtK6jISMlRVgbE8gKXqFGknDZXDBg6yLKBnay3KKqw29YkXVkxf3K83s0esXCrL67tXLzYS6OkKkNwyiKRLvFbvFU9OAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131915; c=relaxed/simple;
	bh=0cLBqD4xE7YB+10m8rJevo8PJVZv7MDOy4pr97X1s34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/MuDmV1cP81WZdTzCuYAUaUbFoHG7jkSAf8HH8vry2oOOJhAM7ocVDeuxSrTu+eZyfwRdl2w+Qi75XLHrDLBebUFT/Eudh7S5zFZ/0cqqsbcGIpSTUn9avr9IlM9E3D7U6O61SFjtLeuvQAiY458UFpt+zaJirKIbJKcMlFla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw08F5Su; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw08F5Su"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8174A1F000FF;
	Sun,  4 Oct 2026 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131914;
	bh=IbD+Z86Nl9zAGhX1HsDFE4ScvNBB55H4BWfft/wpwHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Lw08F5Sun9Il2ky1H8ZoynADtAyRXQ2fzh1pyHdHl1GvgKH5y9KjmnqNoeCsTZc1/
	 3DvSm2N2QDqLmUBT/9z5QUmgs8LWM0OtPP5QGc7Se36ZMxtZ8UUDRSS8BdYVHYus4b
	 Hn8j/+vvemuQoM6hRWN4l0kIOc/d8qCkJO9gd34EyvPuz8ilhptS6/TmPQ7QVhQIY8
	 xBP6Oa/LS07dsv9NMmJZGZSKLdwyqgzhKcq+B4C0QMrUU0Py53Fs3RxZ7PG0Z0qtAK
	 b7DV+vYpAr3ahXW07TBjh9Yj7ZVaQrq5Ki0AY34F9jtyqoRe83p2Aw4pB7N8RmR7ev
	 XroYEqP8l6RAw==
Date: Sun, 4 Oct 2026 17:38:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yuval Saar <thefireking@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, maxwell@maxwelld.cc
Subject: Re: [PATCH v3 1/2] iio: adc: mcp3422: describe parts with chip_info
Message-ID: <20261004173828.60eff19e@jic23-hlaptop>
In-Reply-To: <20261003001647.1975549-2-thefireking@gmail.com>
References: <20260919195507.94130-1-thefireking@gmail.com>
	<20261003001647.1975549-1-thefireking@gmail.com>
	<20261003001647.1975549-2-thefireking@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Oct 2026 03:16:46 +0300
Yuval Saar <thefireking@gmail.com> wrote:

> The driver encodes MCP3421-8 differences as integer ids and switches
> on them in probe. Point i2c_device_id.driver_data at a per-chip
> structure instead, and keep the channel list and 3 SPS support there.
> 
> Compile tested. No hardware.

Ok. This is a little marginal for a patch to do without any form
of test.  You could look at the various ways this sort of patch
can be tested.  Personally I'd probably hack just the DT into qemu
but that's because it is the tool I am familiar with.  

Otherwise the below is preexisting issues but ones that your code
is touching on so I'd like them fixed as part of this.

Thanks,

Jonathan


> 
> Assisted-by: LLM
> Signed-off-by: Yuval Saar <thefireking@gmail.com>

> ---
>  drivers/iio/adc/mcp3422.c | 103 ++++++++++++++++++++++++++------------
>  1 file changed, 70 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 36ba00edf..92825aaf2 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -320,7 +374,6 @@ static const struct iio_info mcp3422_info = {
>  
>  static int mcp3422_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct iio_dev *indio_dev;
>  	struct mcp3422 *adc;
>  	int err;
> @@ -335,33 +388,17 @@ static int mcp3422_probe(struct i2c_client *client)
>  
>  	adc = iio_priv(indio_dev);
>  	adc->i2c = client;
> -	adc->id = (u8)(id->driver_data);
> +	adc->chip_info = i2c_get_match_data(client);

For the one ID that is currently in the of_match_table, this will return NULL
so it's not a bug as that will then fallback to doing of_device_id matching
but is not how this stuff is intended to work.  See below.

> +	if (!adc->chip_info)
> +		return -ENODEV;
>  
>  	mutex_init(&adc->lock);

>  
>  	/* meaningful default configuration */
>  	config = MCP3422_CONT_SAMPLING |
> @@ -382,14 +419,14 @@ static int mcp3422_probe(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id mcp3422_id[] = {
> -	{ .name = "mcp3421", .driver_data = 1 },
> -	{ .name = "mcp3422", .driver_data = 2 },
> -	{ .name = "mcp3423", .driver_data = 3 },
> -	{ .name = "mcp3424", .driver_data = 4 },
> -	{ .name = "mcp3425", .driver_data = 5 },
> -	{ .name = "mcp3426", .driver_data = 6 },
> -	{ .name = "mcp3427", .driver_data = 7 },
> -	{ .name = "mcp3428", .driver_data = 8 },
> +	{ .name = "mcp3421", .driver_data = (kernel_ulong_t)&mcp3421_chip_info },
> +	{ .name = "mcp3422", .driver_data = (kernel_ulong_t)&mcp3422_chip_info },
> +	{ .name = "mcp3423", .driver_data = (kernel_ulong_t)&mcp3423_chip_info },
> +	{ .name = "mcp3424", .driver_data = (kernel_ulong_t)&mcp3424_chip_info },
> +	{ .name = "mcp3425", .driver_data = (kernel_ulong_t)&mcp3425_chip_info },
> +	{ .name = "mcp3426", .driver_data = (kernel_ulong_t)&mcp3426_chip_info },
> +	{ .name = "mcp3427", .driver_data = (kernel_ulong_t)&mcp3427_chip_info },
> +	{ .name = "mcp3428", .driver_data = (kernel_ulong_t)&mcp3428_chip_info },

Any idea why this driver has only one of_table_id entry?  I'd generally expect
that to mirror what we have here.  The issue goes all the way back but let us
clean it up as part of this series.  Then use i2c_get_match_data() which will
check for matches in each type of firmware table, starting here with the of
one.


>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mcp3422_id);

