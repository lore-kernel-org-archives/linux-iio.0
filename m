Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80136403B;
	Sun,  9 Aug 2026 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786317593; cv=none; b=KKkav4svhJo1aqe6/2HJb0Ru3W5G89+xVB4Sw6o3w20A+cl+r2maqKi0q5HWU408JU6oLPlVk+j476Xgw5vR5Q65B/Eki2SGRWapcTNXWjm8Uc4RxHHTSoXLAYe1wn2a3FM4VIqQ18oEWqrI0y53ZkL3ya7ohXW33DFSOZhVV0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786317593; c=relaxed/simple;
	bh=G9DNuLMch4ONlK/zIz5hHPtlrDhG+X0LJ8OoFtRxgpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8DeNfyvhGEb5KIPLWFWXdOA8mY/BEdeD2ZVDMA8f2PuZIJpGDIbThdQ+Le1zHRpAOt6AlBI0Mu4okpEM/U5lxopK8Fyn2ge2G98h34oWds7FQK0JRzGteh9qsHIP4QEPtgswg9v55ui6rQTMk3YlC+pY3SHOhNPJR6Z/0OMz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjtRtVZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjtRtVZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E271F00A3D;
	Sun,  9 Aug 2026 23:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786317591;
	bh=s32b7eZO6HKkPNrsjJvULZ7193813c7PyQ6Njhfuu94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mjtRtVZTsSEeaskCTvYsZVLpDriuLONzbYDSVcYS7Bj1LFwJurvXNJPRj3n7HMP8o
	 wLXpPnmAT2hJsf7sPoV0gPsbB46ULJ/yLM1x/ijM9QZCrNuBpijRTFjrsK6vEifeKm
	 Bs+OF2bjEdqtGOGEv4nH7AwP5Fw4hAudDyB61ufPGVvwLY8A5riZPJLtRQj+U3dFce
	 +qd5Rst3flZz8iAM+Y6oSynB4PtVJ470Gn7R5CC862usbRI69O/ePemH1zedy+lMIJ
	 2BEnbb1/Cc36rWKL/gDySxLr26W6tKyIeryZsUL6Oh8+yxXPUxlhgxtv/y2vR0QL0d
	 LJZNOKN/C9Gjg==
Date: Mon, 10 Aug 2026 00:19:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bmc150: use
 iio_push_to_buffers_with_ts()
Message-ID: <20260810001946.2f5b3a55@jic23-huawei>
In-Reply-To: <20260809174928.565911-1-yashsuthar983@gmail.com>
References: <20260809111303.496393-1-yashsuthar983@gmail.com>
	<20260809174928.565911-1-yashsuthar983@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Aug 2026 23:19:28 +0530
Yash Suthar <yashsuthar983@gmail.com> wrote:

> Replace deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts() to allow source size runtime checks.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
See the other thread.  Given there will be dependencies between
the patches, for v3, send them as a thread with an appropriate cover
letter.

Thanks,

Jonathan

> ---
> v2:
> - Add Suggested-by tag
> 
>  drivers/iio/accel/bmc150-accel-core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index dc8a6285cf3d..d904136720d5 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1011,8 +1011,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
>  			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
>  			       sizeof(data->scan.channels[0]));
>  
> -		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> -						   tstamp);
> +		iio_push_to_buffers_with_ts(indio_dev, &data->scan,
> +					    sizeof(data->scan), tstamp);
>  
>  		tstamp += sample_period;
>  	}
> @@ -1196,8 +1196,8 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
>  	if (ret < 0)
>  		goto err_read;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -					   pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, data->buffer,
> +				    sizeof(data->buffer), pf->timestamp);
>  err_read:
>  	iio_trigger_notify_done(indio_dev->trig);
>  

