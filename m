Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ABC20DD51;
	Fri, 25 Sep 2026 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790305508; cv=none; b=ekEOWN9epdj03MI+Rd/+9qaS3U1T4kmB47UQrAhj8ZMNLY9+8djYQ/IryOONWr14hGjZA5clhbMesJ/+EEQxIbDsUZoK4IDmSR+t/nuCXPA56CN0q/OhiZDhK7CB4myDxoO6CYbF8GvFA4DUU/uLUbMQWcGR9yWUd//EOQlTD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790305508; c=relaxed/simple;
	bh=2A8vo2SuH6b7YVnhQt79UkvODW+AXcGxLv/gEtfkqP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhdHmSfC1A+5f5Ted7i2AOnIA023/TrpiP8VjY8dNU4AjZ5rkQuYwz6aIZ80Igl83mUTBvl5Q/ng5i9piIAIcCK3f6UjaKrsywLOtisVLvV817RAfeSLTuQ6uGrGiugl+t1KlB4ZkGGrz7RXq0xbThVqpPS/ewgjhxem8UUq84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNViKnWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNViKnWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC27B1F000FF;
	Fri, 25 Sep 2026 03:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790305507;
	bh=pDXMhPHA2gHjXcVjTuL1ZM+tJpMVc3m3oAFbbntrwRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aNViKnWzHTMKl13Gmi7ToI8DPgS9miZ911vIvRMdCciGgnarMtljmq3v4LqNCkvDF
	 ZAEP0wJ+rfBII2g2Fwzbc9JfZTY4oPw1ZvQhpOrA3ZK5SnZphaR8rNbb7l01embAgr
	 4KMZnWSI7aZfuocI2eG07so+FaP1x+NdDpndw/4l7qAy0Uk3WIkjbh2OcyZUK3nqkE
	 zwzKj4u85j+Nz3wSmR7FatkSnTeUjuXYCxXTeUJAvJTZH+4Fl5+BNcfh8euvZQSN0Q
	 TufB+KMcrLJZUC92P57vk03Red9xl+9B5h0s1yAuzIjVZIoih17cacP1DIbXCyRPJt
	 hIJR9LIriLzNg==
Date: Fri, 25 Sep 2026 04:05:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Carlos Casadiego via B4 Relay <devnull+cdcp206.gmail.com@kernel.org>
Cc: cdcp206@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Olof Johansson
 <olof@lixom.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bmc150: check reset write error
Message-ID: <20260925040500.0f637249@jic23-hlaptop>
In-Reply-To: <20260924-iio-bmc150-check-reset-error-v2-1-b6dc74d7aaf4@gmail.com>
References: <20260924-iio-bmc150-check-reset-error-v2-1-b6dc74d7aaf4@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 09:48:45 -0500
Carlos Casadiego via B4 Relay <devnull+cdcp206.gmail.com@kernel.org> wrote:

> From: Carlos Casadiego <cdcp206@gmail.com>
> 
> The software reset is required to bring the device into a known
> state before reading the chip ID.
> 
> Check the return value of regmap_write() and abort initialization if
> the reset command cannot be written.
> 
> Fixes: 1c500840934a ("iio: accel: bmc150: reset chip at init time")
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Carlos Casadiego <cdcp206@gmail.com>

Just to check: Was this verified against actual hardware?

Quite a few devices get going on their resets before sending
acks on i2c which means you get an error on that particular
write.  That is often why you don't see an error check on this
particular operation.




> ---
> Changes in v2:
> - Remove the blank line in the tag block.
> - Add Srinivas Pandruvada's Acked-by.
> - Link to v1: https://patch.msgid.link/20260923-iio-bmc150-check-reset-error-v1-1-b8c1ebc4c947@gmail.com
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 46bb36d9366e..43a39e1ccce5 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1561,8 +1561,12 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>  	 * Reset chip to get it in a known good state. A delay of 1.8ms after
>  	 * reset is required according to the data sheets of supported chips.
>  	 */
> -	regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
> -		     BMC150_ACCEL_RESET_VAL);
> +	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
> +			   BMC150_ACCEL_RESET_VAL);
> +	if (ret < 0) {
> +		dev_err(dev, "Error writing reset register\n");
> +		return ret;
> +	}
>  	usleep_range(1800, 2500);
>  
>  	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val);
> 
> ---
> base-commit: d8c0f48f0b1583308a98401c0c7b1a65d1d43a6c
> change-id: 20260923-iio-bmc150-check-reset-error-389b096b0ad4
> 
> Best regards,
> --  
> Carlos Casadiego <cdcp206@gmail.com>
> 
> 

