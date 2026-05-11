Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C040C2F8E81;
	Mon, 11 May 2026 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516632; cv=none; b=qwbu5TK9lz64NTfmZK/fVFQRp5kgzfFkodgoxUrBPf3qAlyejeX3D/UWm8J2wQQwSxTXdyXUL14hqWrsFXcuXiO9EVm1+baBoab8xhxku4c+mTfFRhlD5dOCJ5X+JLXnHAPlE69AxDc5os+tbbE7hr6Wjxfeq+2ls+/R96bUPPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516632; c=relaxed/simple;
	bh=GOXh8eKA5B3R+6lj2uF+NvChEcSvaGrHXWkTQPG2zKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuQ2LBRTKmRiaqLnXFnMCt1g45dAvd8oCzxV83b7GhUaznXL1LtxhHnekf9TIsYjkVAnzmccMPJHDdR8KKLIBJPrnmmlsK3YK6r6XK2CT+X8uOD/TuvozFf1nzrPVZZc/xUuaioPGXtGrpQAYofGy9m2MtU6UbmI9GUTgkYaDNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4exGtwS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4exGtwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AD3C2BCB0;
	Mon, 11 May 2026 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516632;
	bh=GOXh8eKA5B3R+6lj2uF+NvChEcSvaGrHXWkTQPG2zKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d4exGtwS1J/5aRdKLubxhUf0EaDcb4UYqCW2V+Msc/rZ4RhiiMElBptp6p3bqzqlD
	 qO8WSWVSryvsaINUe4afKXu+GA8Zr6rtAX5ixgvyd05Bvqlktc3qFLQjYc5SV4DVf2
	 TxrZTGgcU3XY8yy6rjXWXrFHDNg50U2B/pZxloRKOT5pVVJb6Thv+S1DqaAktSga7V
	 uHOaJ7/L4c5d2Uk0384VmWC9LXnO7505tC5r/XmJOIySWfT7iFjwFVwVMVYQRw6FfS
	 kYBhHE5o6cuMla3qqOg3UeYWpf+XwhVcsUA1bROGcDGXe7u8ZT5M77gQgYIK8Fijxp
	 M6vR8qXmiUUwg==
Date: Mon, 11 May 2026 17:23:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 gregkh@linuxfoundation.org, hcazarim@yahoo.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160: bail out when bandwidth/filter is
 not in table
Message-ID: <20260511172343.6480f0d0@jic23-huawei>
In-Reply-To: <20260510023500.61036-1-sozdayvek@gmail.com>
References: <20260510023500.61036-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 May 2026 07:35:00 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> bmg160_get_filter() walks bmg160_samp_freq_table[] looking for the
> entry matching the bw_bits value read from the chip:
> 
> 	for (i = 0; i < ARRAY_SIZE(bmg160_samp_freq_table); ++i) {
> 		if (bmg160_samp_freq_table[i].bw_bits == bw_bits)
> 			break;
> 	}
> 	*val = bmg160_samp_freq_table[i].filter;
> 
> If no entry matches, i ends up equal to the array size and the next
> line reads one slot past the end. bmg160_set_filter() has the same
> shape, driven by 'val' instead of bw_bits.
> 
> smatch flags both:
> 
>   drivers/iio/gyro/bmg160_core.c:204 bmg160_get_filter() error:
>   buffer overflow 'bmg160_samp_freq_table' 7 <= 7
>   drivers/iio/gyro/bmg160_core.c:222 bmg160_set_filter() error:
>   buffer overflow 'bmg160_samp_freq_table' 7 <= 7
> 
> Return -EINVAL when no entry matches.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
For the get case it would be a hardware bug to return wrong value.
That's good to harden against but not something I'd consider an urgent bug.

The set case is a different matter. Looks to me like userspace can trivally cause
an overflow.  As such this needs a fixes tag.  Please can you send one in reply
to this email so I can pick it up when taking the patch.

Thanks and good fix!

Jonathan

> ---
>  drivers/iio/gyro/bmg160_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 38394b5f3..58963f3ea 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -201,6 +201,9 @@ static int bmg160_get_filter(struct bmg160_data *data, int *val)
>  			break;
>  	}
>  
> +	if (i == ARRAY_SIZE(bmg160_samp_freq_table))
> +		return -EINVAL;
> +
>  	*val = bmg160_samp_freq_table[i].filter;
>  
>  	return ret ? ret : IIO_VAL_INT;
> @@ -218,6 +221,9 @@ static int bmg160_set_filter(struct bmg160_data *data, int val)
>  			break;
>  	}
>  
> +	if (i == ARRAY_SIZE(bmg160_samp_freq_table))
> +		return -EINVAL;
> +
>  	ret = regmap_write(data->regmap, BMG160_REG_PMU_BW,
>  			   bmg160_samp_freq_table[i].bw_bits);
>  	if (ret < 0) {

