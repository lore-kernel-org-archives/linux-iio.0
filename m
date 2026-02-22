Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2BAEACD
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771767493; cv=none; b=jg9SheaS8CEi7ugYI+Za7grDLYXk/DGtTxqIHhyN4x0oqt7IXVGgIFbCm7pKXOXay8evTQNsE0iTal2rYEjKrrEM2PR6Bm+QC1GkhE/V9Zj74usISmuYwhwA2P2JUik/roeKDcdKhaz5lvmY+Uujwzmx+QE9iI39JnY3PRu6SSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771767493; c=relaxed/simple;
	bh=WtPEKWxxVyrzB/nKv4QrB7HW5R0t7wf60ooZnI+9O6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1m+vFc9Hcp+QFUeXbksBkBjbz9jUwLY9LQwF0oxSnaEcAVnuvT1WZWhZkOuqgne7kyadcTqEzCyFZxbUT9HT2ZDUTinWx7wcDj7gXEYmC8HdkSFflacXkGPg+LVhaD0SV7Rs7ao5Brlem4jriZyR2qsRsYOc9IWqwZns0NDBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSMiiK+1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSMiiK+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C53C116D0;
	Sun, 22 Feb 2026 13:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771767492;
	bh=WtPEKWxxVyrzB/nKv4QrB7HW5R0t7wf60ooZnI+9O6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aSMiiK+1v6zrT5tDg+ajBO0TwScZzkGdlduan2kKluq7QEtFr+RKbDZJFHaj5W0JT
	 q8bz1zYf0Xt0yYYUrdExaQkl7wxvVNQ1cfBc4h81qiilYCXE6A3KB+RY8q30WvrD91
	 xPJSSy7ISqNUHWgdmUAFDpLOfPUOuWz00Vi5ADOFJmCoCJ3/EElN8iA6IGyXizhI7I
	 RTIYDBA1RNFKFBIrWASf6v7Fa1yQWZb/tRGqWTGUnoGYa+OZDLvjWacD+4IhZ1Js2K
	 RKXKJ/LPS6Vv4PCmrNBBDKKkx45+mPv9FM5MVQ4ak1MN4OejghVbsM+u46Re/mSeNr
	 mVu13KNeCfkFQ==
Date: Sun, 22 Feb 2026 13:38:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Almeida <gabrielsousa230@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: zopt2201: use lock guards
Message-ID: <20260222133804.0465612b@jic23-huawei>
In-Reply-To: <20260217143157.132799-3-gabrielsousa230@gmail.com>
References: <20260217143157.132799-1-gabrielsousa230@gmail.com>
	<20260217143157.132799-3-gabrielsousa230@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 11:31:57 -0300
Gabriel Almeida <gabrielsousa230@gmail.com> wrote:

> Use guard() and scoped_guard() to handle the mutex lock instead of
> manually locking and unlocking it.
> 
> Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
Applied with this tweak

diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
index 01d01c6669ec..c2777b27bf6c 100644
--- a/drivers/iio/light/zopt2201.c
+++ b/drivers/iio/light/zopt2201.c
@@ -10,6 +10,7 @@
  * TODO: interrupt support, ALS/UVB raw mode
  */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -318,10 +319,8 @@ static int zopt2201_write_resolution(struct zopt2201_data *data,
 
        for (i = 0; i < ARRAY_SIZE(zopt2201_resolution); i++)
                if (val2 == zopt2201_resolution[i].us) {
-                       scoped_guard(mutex, &data->lock) {
-                               ret = zopt2201_set_resolution(data, i);
-                       }
-                       return ret;
+                       guard(mutex)(&data->lock);
+                       return zopt2201_set_resolution(data, i);
                }
 
        return -EINVAL;


> ---
>  drivers/iio/light/zopt2201.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
> index 3192aa72a0fb..05a79ee1752a 100644
> --- a/drivers/iio/light/zopt2201.c
> +++ b/drivers/iio/light/zopt2201.c
> @@ -185,10 +185,10 @@ static int zopt2201_read(struct zopt2201_data *data, u8 reg)
>  	u8 buf[3];
>  	int ret;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  	ret = zopt2201_enable_mode(data, reg == ZOPT2201_UVB_DATA);
>  	if (ret < 0)
> -		goto fail;
> +		return ret;
>  
>  	while (tries--) {
>  		unsigned long t = zopt2201_resolution[data->res].us;
> @@ -199,30 +199,25 @@ static int zopt2201_read(struct zopt2201_data *data, u8 reg)
>  			msleep(t / 1000);
>  		ret = i2c_smbus_read_byte_data(client, ZOPT2201_MAIN_STATUS);
>  		if (ret < 0)
> -			goto fail;
> +			return ret;
>  		if (ret & ZOPT2201_MAIN_STATUS_DRDY)
>  			break;
>  	}
>  
>  	if (tries < 0) {
>  		ret = -ETIMEDOUT;
> -		goto fail;
> +		return ret;
>  	}
>  
>  	ret = i2c_smbus_read_i2c_block_data(client, reg, sizeof(buf), buf);
>  	if (ret < 0)
> -		goto fail;
> +		return ret;
>  
>  	ret = i2c_smbus_write_byte_data(client, ZOPT2201_MAIN_CTRL, 0x00);
>  	if (ret < 0)
> -		goto fail;
> -	mutex_unlock(&data->lock);
> +		return ret;
>  
>  	return get_unaligned_le24(&buf[0]);
> -
> -fail:
> -	mutex_unlock(&data->lock);
> -	return ret;
>  }
>  
>  static const struct iio_chan_spec zopt2201_channels[] = {
> @@ -323,9 +318,9 @@ static int zopt2201_write_resolution(struct zopt2201_data *data,
>  
>  	for (i = 0; i < ARRAY_SIZE(zopt2201_resolution); i++)
>  		if (val2 == zopt2201_resolution[i].us) {
> -			mutex_lock(&data->lock);
> -			ret = zopt2201_set_resolution(data, i);
> -			mutex_unlock(&data->lock);
> +			scoped_guard(mutex, &data->lock) {
This is not a good use for scoped_guard() as it makes the code more
confusing.  We are exiting scope anyway with the return so
			guard(mutex)(&data->lock);
			return zopt2201_set_resolution(data, i);
is both easier to read and more compact.

Thanks,

Jonathan


> +				ret = zopt2201_set_resolution(data, i);
> +			}
>  			return ret;
>  		}
>  
> @@ -350,16 +345,12 @@ static int zopt2201_write_scale_by_idx(struct zopt2201_data *data, int idx,
>  {
>  	int ret;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  	ret = zopt2201_set_resolution(data, zopt2201_scale_array[idx].res);
>  	if (ret < 0)
> -		goto unlock;
> -
> -	ret = zopt2201_set_gain(data, zopt2201_scale_array[idx].gain);
> +		return ret;
>  
> -unlock:
> -	mutex_unlock(&data->lock);
> -	return ret;
> +	return zopt2201_set_gain(data, zopt2201_scale_array[idx].gain);
>  }
>  
>  static int zopt2201_write_scale_als(struct zopt2201_data *data,

