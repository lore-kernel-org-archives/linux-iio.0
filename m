Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8739F292B44;
	Mon,  9 Mar 2026 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083638; cv=none; b=PthsE4Uw2oGFMVMR/Xq5lJ2OzUxe/adsDA8Lg36maIB3BH7lYo5Ht77Bhdv1T6ByqMsSK9oDVyklcyimTmKJgCxMj97rgbSsorjXaurNhPesU9tEJuKmvz7/X1iXa8ngcOVcdh0kKYWPyOLWW8sSHN6SVi0LROx/SY59IFggQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083638; c=relaxed/simple;
	bh=qxON14QbK68rpuBRPlvz8peoX0bwI8oMy+kf16fH2cE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeMEiEEnen1yaROYKTwbPtQO3nlXc1Ks9jP8ptriYzkqpcVT+j4fq5q6lyQmNxOSOgwqR5pV9T5d7tfDQGDnocfaE1aObNs08tyq2LMhfstZMjwKWT2oq5IKrdsVGNIRDTdyC1FtH7qxqnj82zyrNrjc0iUEDPza+9iOm/R0G74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFahkrnL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFahkrnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F62EC4CEF7;
	Mon,  9 Mar 2026 19:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773083638;
	bh=qxON14QbK68rpuBRPlvz8peoX0bwI8oMy+kf16fH2cE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kFahkrnLSDB39KcvU32K78QuW0T4KODkGpaM6Swka8g76/jrnGwai8rXJMSFa7HX4
	 O+CwuVfJccrXU6JPXzZzKmuOfwplDcFrTjy1q8JWx0vl436A75U2WVAnBR18V6IXjw
	 5Gfs1Lkj6FYsmRdk7mBL7vMpOpSv4x1Zix1rA1ehxz689vnGpq3IKG+WY15/x6y6Jh
	 SYungXzBwD4+AITp+jyLE7/rOeBnp6c2AILIpV81MgjFk5gGeSVIUJcfu1QuQ8t5kb
	 NawGnY1tzwnU9fe8sHlgDvA5fYtIA6sSmbh2cbiANn1vpLJvLYOWfSFwWB5QNGKB3B
	 LCfTNmFPIIcvw==
Date: Mon, 9 Mar 2026 19:13:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 waqar.hameed@axis.com, linusw@kernel.org, sakari.ailus@linux.intel.com,
 harshit.m.mogalapalli@oracle.com, antoniu.miclaus@analog.com,
 andrew.ijano@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: accel: bmc150: convert to guard(mutex)
Message-ID: <20260309191348.0cb0b8f0@jic23-huawei>
In-Reply-To: <20260309153408.71512-2-rajveer.chaudhari.linux@gmail.com>
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
	<20260309153408.71512-2-rajveer.chaudhari.linux@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Mar 2026 21:04:05 +0530
Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:

> Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
Wrap commit messages up to 75 chars.
 mutex_lock()/mutex_unlock() pair with guard(mutex)()

> bmc150_accel_buffer_predisable() and
> bmc150_accel_buffer_postenable(). This ensures the mutex is
> released on all return paths and allows returning directly
> without a goto label.
> 
> Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
> ---
> v2: Cleaned mutex_unlock and goto in bmc150_accel_buffer_postenable(),
> Dropped Header alignment change.
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 42ccf0316ce5..bd9791c9fcf7 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -7,6 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> @@ -1485,15 +1486,15 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
>  	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
>  		return 0;
>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
>  
>  	if (!data->watermark)
> -		goto out;
> +		return ret;

return 0; and stop initializing ret to 0 at the start of the function.
That will make it clear that this is a 'good' exit path not an error one.
Its the path where we don't turn on the fifo.

>  
>  	ret = bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_WATERMARK,
>  					 true);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	data->fifo_mode = BMC150_ACCEL_FIFO_MODE_FIFO;
>  
> @@ -1504,9 +1505,6 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
>  					   false);
>  	}
>  
> -out:
> -	mutex_unlock(&data->mutex);
> -
>  	return ret;
I'd slightly prefer return ret moves up into the if (ret) {} block above and
we return 0 here.  Again to make it easier to spot where the good and bad paths are.

>  }
>  
> @@ -1517,19 +1515,16 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
>  	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
>  		return 0;
>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
>  
>  	if (!data->fifo_mode)
> -		goto out;
> +		return 0;
>  
>  	bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_WATERMARK, false);
>  	__bmc150_accel_fifo_flush(indio_dev, BMC150_ACCEL_FIFO_LENGTH, false);
>  	data->fifo_mode = 0;
>  	bmc150_accel_fifo_set_mode(data);
>  
> -out:
> -	mutex_unlock(&data->mutex);
> -
>  	return 0;
>  }
>  

