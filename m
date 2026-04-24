Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1F314D05;
	Fri, 24 Apr 2026 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051846; cv=none; b=tDI9gTIil0g+vNHA8ebvYgnZ8vkY1KzolNCfc/ztsXK6IA1uZLPLigptQLpbLXsGfWs4Kj6HbKbqEvSZkv/Jkeub7i8IZL3yRT8QuLzrMvi3DcHLqObi/FfoniDbCZqd2MfjFAU3g28r1GkyAtBhNdVlLbHIpAMidqhM9dr+8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051846; c=relaxed/simple;
	bh=f7AlSyIz9DU2WG9FHbX4NMEpSMPuvyXziuxNR8y3R7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AO1xWopvtcw1bMYaQCihc1+1XJUFBKQ0YljfptsxyJugax90iqHGyd1x2GUsvmI9yvkpYQP0Rg/h1yvLZxR53YPWLr0AmL+7TAw5mEq2e/x7hihlgQsil0+Wf3rPDeIJMU0IoL14gByAtgRZvIAOJ40umcCiGCZUg0e4swsZwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq0bNhwj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq0bNhwj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062FEC19425;
	Fri, 24 Apr 2026 17:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051845;
	bh=f7AlSyIz9DU2WG9FHbX4NMEpSMPuvyXziuxNR8y3R7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sq0bNhwjtErZxTJ98KI0x/SQ1vrWl1gndUvMWviIE5URuEp8F/pD0TTONxCEo0V8G
	 FsGjc4jOdUxFlucFQm505dc23WSOMz3FHtlKvp9uUDIIZ+WkOlwHZq3ctZfGqC8Iur
	 VNxr1Hwv7FKNWX1jWB3M2EMnXPJxfirkEqaApCmbzUu1gdzjzAIyHA3KzwCDroMQNB
	 3f/qNVI9pYvPi9H+6mtuYVCpMQ9ojbsOviONHmmzOW6K1Od/KLnH0PRnTt4MfqNta6
	 5zeN4JhYP9MbTp3itfRtvtCOAyKtV5WArXEaNX9rc+lTBhyfWT9Yw+Sgw0+I1ANtBz
	 PbtGHxO0e8Udw==
Date: Fri, 24 Apr 2026 18:30:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: accel: mma8452: use guard() to release
 mutexes
Message-ID: <20260424183037.7057821c@jic23-huawei>
In-Reply-To: <20260422165643.2148195-7-sanjayembedded@gmail.com>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
	<20260422165643.2148195-7-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 22:26:43 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Replace explicit mutex_lock() and mutex_unlock() with the guard() and
> scoped_guard() macro for cleaner and safer mutex handling.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Hi Sanjay,

This can be taken a step further and give less churn + a cleaner end result.

> ---
>  drivers/iio/accel/mma8452.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 9983f76a8bcd..1c284bdcc44a 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -18,6 +18,7 @@
>   * TODO: orientation events
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/mod_devicetable.h>
> @@ -500,9 +501,8 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>  		if (!iio_device_claim_direct(indio_dev))
>  			return -EBUSY;
>  
> -		mutex_lock(&data->lock);
> -		ret = mma8452_read(data, buffer);
> -		mutex_unlock(&data->lock);
> +		scoped_guard(mutex, &data->lock)
rest of the maths after this point is trivial an safe to do under locks,
so even better than this change might be to go directly to using
the ACQUIRE magic to handle the direct mode control claiming as well.

	case IIO_CHAN_INFO_RAW: {
		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 		if (IIO_DEV_ACQUIRE_FAILED(claim))
			return -EBUSY;
		guard(mutex)(&data->lock);

		ret = mma8452_read(data, buffer);
		if (ret < 0)
			return ret;

		*val = sign_extend32(be16_to_cpu(
			buffer[chan->scan_index]) >> chan->scan_type.shift,
			chan->scan_type.realbits - 1);

		return IIO_VAL_INT;
	}

There is one other place where it maybe worth using IIO_DEV_ACQUIRE_DIRECT_MODE()
In that location the advantage is tiny but then we'd have all the code in here
using that approach and I think that is worth doing.

+			ret = mma8452_read(data, buffer);
>  		iio_device_release_direct(indio_dev);
>  		if (ret < 0)
>  			return ret;
