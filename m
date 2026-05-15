Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A74248A2AC;
	Fri, 15 May 2026 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857482; cv=none; b=CG2gT7D5ZNriMvy0GJgpJZSV58YU0pYBmaluD3uEcF36vBWp0h321F9ezmiBxbKP4Lfaj4YbEYIQ4TLnlT76M9x6GNVf+akoHZrqwgUuMw2OiCsxYl2YqqRA7XcRQ/c301wZzNRnETvKqkMLhLhXEShnKRSoyhXXN/0zDv5IAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857482; c=relaxed/simple;
	bh=yAcXoUaaXvfRLm97deQe+k4PPsWmVPYoe++1z/JQTCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h17oI4/3NuYSdrbgEJ5pCIwi6yH/kQ1+rV5ApwvP8UOkMpCaHqg4m5kdJVYjoqd6GHmZAa8qUJK5QIOBpUp9gArxD7r24jT6+dbUjTpVKKENgCuQo49i8HoCR3/fSajtGssMHCRNqOdZB77j798XahU8h3ipuEzNFzHAIrrzv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOCvyb1u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOCvyb1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2ADC2BCB0;
	Fri, 15 May 2026 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778857481;
	bh=yAcXoUaaXvfRLm97deQe+k4PPsWmVPYoe++1z/JQTCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SOCvyb1uib/y0nRZmQMaF96569U2WH4ghGDujFf9v9LOvrSE5yYqIxEt2+PP+Y9KT
	 2pvuz1/oOZsOYQ18l5T3KcHkLwS1G0Mf/ha7svbrPPbIFWfiwp8Iz5jVjHiLu7k19A
	 AnTERzOCKqvz7Qke7F/F+J9FOgForfQkhs3rS56JSHbtJIb1JbfR30tYIPCdBQNHJL
	 YuI2AHk10qOWmAN9jqwoO8wKf5m2qCHH56TPlahz5yJMR72TxnoiLbXYDK8qXaFvWO
	 YoaKmbMOKePgnSo48rhR8gaO9fvfq1yg0rEsDy3xVZt2+ZmzbURhvaXiHnDXCHBTtk
	 gv7PHQZReJFBw==
Date: Fri, 15 May 2026 16:04:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: health: max30102: Add timestamp to FIFO data
Message-ID: <20260515160434.7749e240@jic23-huawei>
In-Reply-To: <20260514200309.1597-1-shofiqtest@gmail.com>
References: <20260514200309.1597-1-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 23:03:09 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

There are various things going on here - that patch title
isn't enough.


> The I2C DMA read buffer was not aligned to IIO_DMA_MINALIGN, which
> can cause issues on platforms with strict DMA alignment requirements.
> Fix this by annotating the buffer field with __aligned(IIO_DMA_MINALIGN).

Nope. Look into the requirements of i2c (basically it doesn't have
any as it always bounces the data unless you go to considerable effort
to tell it to not do so!)

I've kind of lost track but didn't I explain why timestamps and fifos
are an awful lot more complex than this!  This is an absolute non starter.
Also the max30102 is a serious weird device that runs with a custom
userspace. You can't get pulse readings without some nasty (not particularly
public) maths.

Generally don't add features to a driver you aren't using - they
end up as dead code.

Jonathan


> 
> Replace the plain processed_buffer[] array with a packed scan struct
> containing the channel data and an aligned_s64 timestamp field. This
> satisfies the alignment requirement for iio_push_to_buffers_with_timestamp()
> and ensures correct layout when the IIO core appends the timestamp.
> 
> Add IIO_CHAN_SOFT_TIMESTAMP entries to both max30102_channels[] and
> max30105_channels[] so the IIO core knows to expect a timestamp slot in
> the scan buffer.
> 
> Capture iio_get_time_ns() per FIFO sample read and pass it to
> iio_push_to_buffers_with_timestamp() so userspace consumers receive
> timing information alongside the intensity data.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  drivers/iio/health/max30102.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index 47da44efd68b..447c4de8ff4b 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -24,6 +24,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/trigger_consumer.h>
>  
>  #define MAX30102_DRV_NAME	"max30102"
>  #define MAX30102_PART_NUMBER	0x15
> @@ -106,8 +107,11 @@ struct max30102_data {
>  	struct regmap *regmap;
>  	enum max30102_chip_id chip_id;
>  
> -	u8 buffer[12];
> -	__be32 processed_buffer[3]; /* 3 x 18-bit (padded to 32-bits) */
> +	u8 buffer[12] __aligned(IIO_DMA_MINALIGN);
> +	struct {
> +		__be32 channels[3]; /* 3 x 18-bit (padded to 32-bits) */
> +		aligned_s64 ts;

Where does the timestamp end up if only 1 or 2 channels are enabled?
(or indeed the device only has 2 channels).
The answer to that question will tell you why (if we were doing this)
it should be an array.


> +	} scan;
>  };

> @@ -298,11 +304,13 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
>  	mutex_lock(&data->lock);
>  
>  	while (cnt || (cnt = max30102_fifo_count(data)) > 0) {
> +		s64 ts = iio_get_time_ns(indio_dev);

So all the samples get timestamps near each other. Nope. They should
have the timestamps that reflect when they enter the fifo. That's hard.

> +
>  		ret = max30102_read_measurement(data, measurements);
>  		if (ret)
>  			break;
>  
> -		iio_push_to_buffers(data->indio_dev, data->processed_buffer);
> +		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, ts);
>  		cnt--;
>  	}
>  

