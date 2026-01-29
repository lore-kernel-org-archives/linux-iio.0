Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FA13959D
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711566; cv=none; b=CXZ1Fpvd7RK7i8a7kWmiQZHS44ySyo0AZilnogx8us4F69hCvnOy8MVbiskpF/nk2GM17H7RVrFe57vl6dJvhzsbshBpBCtAXphSQszmznHTAYxY9B6pFeikR8yZvFjBqlEkHuxqBpUD9NMBEOXgtt0a+6OgV5uHgXqsZGK/6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711566; c=relaxed/simple;
	bh=qajjDrvN56vecV2QL0TGC80RoHHSeinuf8UmG96v3Og=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkMCJIecHKNDADfaKc6ZjKd109i3dOL7UZukwwq9aUd2sFx/zARidK3LOjwLb93bcRvoyQ8TeecA68dTB3y7U3a4dHTf3DSTRkxuO/3/f9hmoSlihYn+1Xqay5Mb3LB7ccLG7B2PgqHpraPeE7GLKxsBhxyDPkaoaUcI35Dx3fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukPo0rkn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukPo0rkn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6FFC4CEF7;
	Thu, 29 Jan 2026 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769711566;
	bh=qajjDrvN56vecV2QL0TGC80RoHHSeinuf8UmG96v3Og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ukPo0rknMZUUKN85qTxCJLF4OuMPz6HE07jsmoUJX1HkSjmtALyFJjK4cB4GWZlH8
	 u1G+uztHQi+9GwtmWwiFNwJYs3rN+MbUnaIoBU/g7e5sesjmunW60H7MNIQ0Mh7Q6M
	 AdyiaYML04QIfJSoRgqmVxy0GeqTLFRAdTqwiEC/aY9lY1289/LKDFxdD6PJgrlS4P
	 FOjQfjTv2sCTCY5/FR8eo2VQL8kbyf9zdqgbCdrUlfHt9VtTrR8Gwf2emoY0ek3fxH
	 gCwSw4yrUMU0jG5K5vpqxO0qP22g1HrtHV2fR0Nv53h+LLALYZrgBIn9vNaQyjoex3
	 kftlrsefg95vQ==
Date: Thu, 29 Jan 2026 18:32:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Almeida <gabrielsousa230@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: zopt2201: use lock guards
Message-ID: <20260129183241.0fbe74b2@jic23-huawei>
In-Reply-To: <20260125230518.112027-1-gabrielsousa230@gmail.com>
References: <20260125230518.112027-1-gabrielsousa230@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Jan 2026 20:05:18 -0300
Gabriel Almeida <gabrielsousa230@gmail.com> wrote:

> Use guard() to handle the mutex lock instead of manually
> locking and unlocking it.
> 
> Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> ---
> v2:
> - Reorder headers
Hi Gabriel,

That's an unrelated change. Please do it in a separate patch before
the lock guard change.

> - Add required linux/cleanup.h include
> - Use lock guards in zopt2201_read()
> - Use scoped_guard() in zopt2201_write_resolution()
>  drivers/iio/light/zopt2201.c | 40 +++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
> index 1dba1b949cc3..c73c604170b3 100644
> --- a/drivers/iio/light/zopt2201.c
> +++ b/drivers/iio/light/zopt2201.c
> @@ -10,15 +10,14 @@
>   * TODO: interrupt support, ALS/UVB raw mode
>   */
>  
> -#include <linux/module.h>
> -#include <linux/i2c.h>
> -#include <linux/mutex.h>
> -#include <linux/err.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
> -
> +#include <linux/err.h>
> +#include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -
> +#include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/unaligned.h>

>  
>  static const struct iio_chan_spec zopt2201_channels[] = {
> @@ -324,9 +318,9 @@ static int zopt2201_write_resolution(struct zopt2201_data *data,
>  
>  	for (i = 0; i < ARRAY_SIZE(zopt2201_resolution); i++)
>  		if (val2 == zopt2201_resolution[i].us) {
> -			mutex_lock(&data->lock);
> -			ret = zopt2201_set_resolution(data, i);
> -			mutex_unlock(&data->lock);
> +			scoped_guard(mutex, &data->lock) {
> +				ret = zopt2201_set_resolution(data, i);
> +			}
>  			return ret;

You can return from within the scoped_guard().  However that does trip
up compilers to maybe this is the best approach if you want to use
guards. 

>  		}
>  
> @@ -351,15 +345,13 @@ static int zopt2201_write_scale_by_idx(struct zopt2201_data *data, int idx,
>  {
>  	int ret;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  	ret = zopt2201_set_resolution(data, zopt2201_scale_array[idx].res);
>  	if (ret < 0)
> -		goto unlock;
> +		return ret;
>  
>  	ret = zopt2201_set_gain(data, zopt2201_scale_array[idx].gain);
>  
> -unlock:
> -	mutex_unlock(&data->lock);
>  	return ret;
Look again at this one and consider if the code that is left after this
patch is as neat and tidy as it can be.


>  }
>  

