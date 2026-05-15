Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CC82DEA93;
	Fri, 15 May 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858344; cv=none; b=fKi+mVgYmLjhSj/xlZQGmzTcjW9lsXGsnd9xCs2jRZ45rcOBBIwg/CqRiOgZQMMe29hL+FdVr9jkTLwVx45k23zZwLukfwi9Rf+rBW13izJmtxJGomPjsUGERm2gOtGU9y6ry/JQ55GOWv3bJX/IvDXMt3duEmszcQ2hYAs/gYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858344; c=relaxed/simple;
	bh=PR75wMFIfyrKU27lzjMMgYGI+4Fn6WYPM9OsJcqHvkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ujwz4Fb5jhyWHug7Tp55Bpjdbk3MWY5FCGofkSTXKJw3ieST838YLbC3WcH3MBVew4NLTp25fyHfySJh1OS2UsoBk1ET7nrX5g3zBUJk4RV4updYcBfV1Y8PUwIegpk2Y3SbQT9onvSkQPxr4OBQRYGwYohRIpq2b9sxSAMsFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLVTuxOH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLVTuxOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2135EC2BCB0;
	Fri, 15 May 2026 15:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778858344;
	bh=PR75wMFIfyrKU27lzjMMgYGI+4Fn6WYPM9OsJcqHvkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pLVTuxOH5CVNr+UEmhkDQsQZdtfcQFPNLlYM1LvTDTvcLcYrwKk8uXDQUPOLvVu54
	 GLuiUC9fLKYJ/fLhc+m3KoCvEh/JrizYRjcOe62zloR1sz+lsglAb/TKGNjMGWbuHu
	 nqiUDysfBqBnSpnV/NDsw3KjgpfqZ+GNNsnwyK+YmQFkfOc7ZceSfV4eS/DHq0BM6/
	 qLsR/MXzPvszVqPLGWySMyEXfIzkfDmyEerzYmfZsDeX2dPQbO/jhcBOeI9aHACwzD
	 Fw8kaMF7+XGURk9m+TsJg8O0WjzQXT6YJ6hk1mG9js/60SbNQ0Kx2OllXhCRGSMbX2
	 sTjmTr4Z8hvfg==
Date: Fri, 15 May 2026 16:18:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 2/5] iio: light: tcs3472: convert remaining locking
 to guard(mutex)
Message-ID: <20260515161854.6b9ad78e@jic23-huawei>
In-Reply-To: <20260512223215.25596-3-aldocontelk@gmail.com>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
	<20260512223215.25596-3-aldocontelk@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 00:32:12 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

> Convert the locking in tcs3472_read_event(), tcs3472_write_event(),
> tcs3472_read_event_config(), tcs3472_write_event_config(),
> tcs3472_powerdown() and tcs3472_resume() to use guard(mutex)
> instead of explicit mutex_lock()/mutex_unlock() pairs.
I'd skip the list.  If anyone cares which functions are changed then
they can read the code!

Convert several functions to use guard(mutex)()

> 
> This avoids manual unlock calls on each return path, drops the goto
> in tcs3472_write_event(), and removes 'ret' variables only needed to
> return after the unlock.
> 
> No functional change.
> 
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
A couple of places where the use of guard() enables some nice cleanup.
Given it's the guard() that let's us do it I consider it part of the same
change.

Also one stray change in here that has nothing to do with the rest.

> ---
> v2:
> (Suggested by Andy)
> - Moved earlier in the series to avoid introducing manual locking in the devm
>   patch that would then be converted here.
> - Dropped "found by code inspection" (this is a cleanup, not a bug)
> - Test details moved to cover letter
> 
>  drivers/iio/light/tcs3472.c | 59 +++++++++++++------------------------
>  1 file changed, 21 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index 9b0f64cd9c50..4fd4fd74d0d6 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c

>  
>  static int tcs3472_read_event_config(struct iio_dev *indio_dev,
> @@ -310,13 +300,10 @@ static int tcs3472_read_event_config(struct iio_dev *indio_dev,
>  	enum iio_event_direction dir)
>  {
>  	struct tcs3472_data *data = iio_priv(indio_dev);
> -	int ret;
>  
> -	mutex_lock(&data->lock);
> -	ret = !!(data->enable & TCS3472_ENABLE_AIEN);
> -	mutex_unlock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
> -	return ret;
> +	return !!(data->enable & TCS3472_ENABLE_AIEN);

Hmm. Kind of unrelated, but given the code is changing can we make this a FIELD_GET()
Linus got quite grumpy a few years ago about readability of !!.
Alternative would ? 1 : 0;

>  }
>  
>  static int tcs3472_write_event_config(struct iio_dev *indio_dev,
> @@ -327,7 +314,7 @@ static int tcs3472_write_event_config(struct iio_dev *indio_dev,
>  	int ret = 0;
>  	u8 enable_old;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	enable_old = data->enable;
>  
> @@ -342,7 +329,6 @@ static int tcs3472_write_event_config(struct iio_dev *indio_dev,
>  		if (ret)
>  			data->enable = enable_old;
		if (ret) {
			data->enable = enable_old;
			return ret;
		}
>  	}
> -	mutex_unlock(&data->lock);
>  
>  	return ret;

	return 0;

This one is a case of reducing how far we have to look to see what happens
in each code path. Fine in this patch as it's the guard() enabling it.

>  }
> @@ -379,6 +365,7 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
>  	} scan = { };
>  
>  	int ret = tcs3472_req_data(data);
> +
Unrelated change so doesn't belong in a patch doing guard() stuff.

>  	if (ret < 0)
>  		goto done;
>  
> @@ -544,15 +531,13 @@ static int tcs3472_powerdown(struct tcs3472_data *data)
>  	int ret;
>  	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
>  		data->enable & ~enable_mask);
>  	if (!ret)

As below.

>  		data->enable &= ~enable_mask;
>  
> -	mutex_unlock(&data->lock);
> -
>  	return ret;
>  }
>  
> @@ -581,15 +566,13 @@ static int tcs3472_resume(struct device *dev)
>  	int ret;
>  	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
>  		data->enable | enable_mask);
>  	if (!ret)
>  		data->enable |= enable_mask;
	
	if (ret)
		return ret;

	data->enable |= enable_mask;

	return 0;

One of the nicest things about cleanup.h magic is avoids us needing
to do handling of good paths 'out of line'.  Thus we can switch to
more ideomatic code that is easier to read. That can be done as
part of this change as it's the guard() stuff that made it possible.

Jonathan

>  
> -	mutex_unlock(&data->lock);
> -
>  	return ret;
>  }
>  

