Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7EB17A31C;
	Sat, 14 Feb 2026 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771096116; cv=none; b=oGq40ggNbvrRhq4eOVnGkUHvn+EHngPa09lehaFnjo+1Ui7gv1Aw/jmoHuo14OXhV6lepNU3kvp92Tn34Eh3iqjxyCPe6Ccd08iW3XYnQjNdcbiafXf7tCPCRKhRn65dVCVjtqK33hI9G2NWoUVgUoX3fhXtwFEqbdqxI68y92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771096116; c=relaxed/simple;
	bh=uWJLb3mgJkqAmoFC50FX4e4j7tmQL321HNT/JG4ZjlU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGulqFRVEsi0/3vK2v1MQE0gn8WxWwG4GgfiiN4GpOxJXLfntjHM4kSW/40/yQz0GVRp9hkYp4mmQiiEOyj2LregXHy3RZ50ms/+T4Ph3cbNOlqH1oi0fNRhxwIhaz+8fgWd1jKLqm9f1AZ0u78dzFWcL3sJdS4gA7MRSn4VctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqipVavD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqipVavD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C628C16AAE;
	Sat, 14 Feb 2026 19:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771096115;
	bh=uWJLb3mgJkqAmoFC50FX4e4j7tmQL321HNT/JG4ZjlU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aqipVavDtvTzWTWySf/Ikm8iDMavSYDTiO7BDd4jczUgviuPkTLgs6lYxJZF1iYXu
	 dQ2vgK5qfrAOl0QcILJ35vlhqmxKtoFgR2bEujay63/LJCAyydJvDXyvgu8Yu8xk6m
	 ElZiZhfgtp60H45LqjQ1iHjhH4V6dFcmfI9oH2rZmCUwBK6PWW4pq0IFmNDTse14GE
	 EyDOrDzGKZ/AxhHIWIWH7xKhnO/SZhti0cmlMX8FUdTbcs5fqvZdW09uKthBACOst0
	 6xpr45xcSyT0LLsQsrkeXHFnn9RqPe+KxDGgOakVbIflwjLkJyeyMkzChsJ55sXbA1
	 pRoxIWGwh/nZw==
Date: Sat, 14 Feb 2026 19:08:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap020a00f: Correct return type to int
Message-ID: <20260214190829.018b057e@jic23-huawei>
In-Reply-To: <20260211004819.854169-1-ethantidmore06@gmail.com>
References: <20260211004819.854169-1-ethantidmore06@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 18:48:19 -0600
Ethan Tidmore <ethantidmore06@gmail.com> wrote:

> The function gp2ap020a00f_get_thresh_reg() can return type -EINVAL in
> its error path. Yet, the function has return type of u8. Added error
> checking for gp2ap020a00f_get_thresh_reg() return's value.
Hi Ethan,

Did you find a path via which it can actually return an error? char
and dir are tightly constrained inputs.

I think the error return is probably just defensive coding against future bugs
and compiler warning supression.

If so it's still a good thing to clean up but Fixes tag and backports
probably not appropriate.

And best of all, once it's not a fix we can use some guard()
magic to make these functions and your new checks cleaner.
guard() usage would be a precursor patch with this one on top to minimize
churn.

Thanks,

Jonathan



> 
> Fixes: 5d6a25bad035 ("iio:gp2ap020a00f: Switch to new event config interface")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>  drivers/iio/light/gp2ap020a00f.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index c7df4b258e2c..492d1a029f77 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -992,7 +992,7 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static u8 gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
> +static int gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
>  					     enum iio_event_direction event_dir)
>  {
>  	switch (chan->type) {
> @@ -1023,12 +1023,18 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>  	bool event_en = false;
>  	u8 thresh_val_id;
> -	u8 thresh_reg_l;
> +	int thresh_reg_l;
>  	int err = 0;
>  
>  	mutex_lock(&data->lock);
>  
>  	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
> +
> +	if (thresh_reg_l < 0) {
> +		err = thresh_reg_l;
> +		goto error_unlock;
> +	}
> +
>  	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
>  
>  	if (thresh_val_id > GP2AP020A00F_THRESH_PH) {
> @@ -1080,13 +1086,18 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
>  				       int *val, int *val2)
>  {
>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> -	u8 thresh_reg_l;
> +	int thresh_reg_l;
>  	int err = IIO_VAL_INT;
>  
>  	mutex_lock(&data->lock);
>  
>  	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
>  
> +	if (thresh_reg_l < 0) {
> +		err = thresh_reg_l;
> +		goto error_unlock;
> +	}
> +
>  	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
>  		err = -EINVAL;
>  		goto error_unlock;

