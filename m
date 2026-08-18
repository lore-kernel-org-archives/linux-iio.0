Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0A187346;
	Tue, 18 Aug 2026 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069825; cv=none; b=iEP+KHpu/7RmJ5Dsx5pw/9xwHBy5L9HIoJVQjVS5BmScMxeYsvJblpWbiQYPLvUjNsSec39ctB9ZYCfqWl/C4LTuEmoLkyK5+GJAafWlmbGdvU3z67pZNuqKD8AwlN47VXXyCIdbnnu4NLBu+J77mWiMGwdQ/br6+8lKosqYj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069825; c=relaxed/simple;
	bh=R/EBpE6C3VGG83uDxZbPXPGnOkd1L5BrcUy/U/lhtHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+Fy2sDDQr0kfXEy5JL6k8EcJ1X2BlNWn3SLsWWcvjlHaP5nuLWempWjsjYv31fh6i9FCu0Iyv1RJLwHjDv+6pXlKGW/wz/kBjOfnZlcOfjATXBqgP0m91MJUKmThsSyxpunHWQFEM5s9KX17A4tahG2C4R1s473pr7/pzP4l70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9fQlS4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9fQlS4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134211F000E9;
	Tue, 18 Aug 2026 16:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787069823;
	bh=go6X9S0WzYxkKHIsbqzYc3Lq7x1IPYrXxuvyNnNt+L8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e9fQlS4gWsISeKBCMk9Na7TZ1QnLXFpVdpW3Fg66WWgqGo0lp/yQpxPUJbC7Nj6W1
	 jLilv9LK7BRK4LuazvrXBCJr+pQQHppCH1/myoRGDt/KP8QtOnDCS/59KqI+mALUIA
	 F8s+bdynuzCCoPaqQr0nBy8ChicnpJCd5OlnTtrNZsS7VuwMfTIyYH91SV1kG2odaS
	 DS4Zi2TGMVajydnJRrJY6ggw7lsP2pS2uUB84lo6ZrfctMRhNIfG/WdialywD6iYvA
	 Gv4vNEBeFiO8c3xHOuXP09H+bvpnvbdRTxw54W9mUemiUi/l4j8QCIXmRAycIU1kLU
	 iTpetknDnjxSw==
Date: Tue, 18 Aug 2026 17:16:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Rondon <grondon@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kionix-kx022a: use
 iio_push_to_buffers_with_ts()
Message-ID: <20260818171657.7c1af7b3@jic23-huawei>
In-Reply-To: <20260818155635.8367-1-grondon@gmail.com>
References: <20260818155635.8367-1-grondon@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 16:56:35 +0100
Gabriel Rondon <grondon@gmail.com> wrote:

> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), which takes the destination buffer size
> and checks it against scan_bytes at runtime.
> 
> Both push sites already use suitably sized and aligned storage: the FIFO
> flush path pushes data->scan ({ __le16 channels[3]; aligned_s64 ts; }),
> and the trigger handler pushes data->buffer (__le16[8], aligned to
> IIO_DMA_MINALIGN). Both are 16 bytes, which matches scan_bytes for the
> 3-axis plus s64 timestamp layout used by all supported variants, so pass
> sizeof() for each.

As is quite common with this sort of cleanup, it got me looking at
code that has evolved in an odd direction. In this case it was
you pointing out both buffers are same size and have same content!

Why do we have both scan and buffer?  The kx022a_trigger_handler()
could just as easily use scan (which is the cleaner solution here)

That leaves get_axis which uses st->buffer as well. Whilst it is a little
ugly, that can just use the first channel of scan as well.

If you are happy to do so could you make that change as a precursor
to this set?  I don't particularly want to leave that mess in place
now I've noticed it.

Thanks,

Jonathan

 
> 
> Signed-off-by: Gabriel Rondon <grondon@gmail.com>
> ---
>  drivers/iio/accel/kionix-kx022a.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 02dd1db7a646..ed0fffd83d3f 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -864,7 +864,8 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>  		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
>  			chs[bit] = sam[bit];
>  
> -		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
> +		iio_push_to_buffers_with_ts(idev, &data->scan,
> +					    sizeof(data->scan), tstamp);
>  
>  		tstamp += sample_period;
>  	}
> @@ -1034,7 +1035,8 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
>  	if (ret < 0)
>  		goto err_read;
>  
> -	iio_push_to_buffers_with_timestamp(idev, data->buffer, data->timestamp);
> +	iio_push_to_buffers_with_ts(idev, data->buffer, sizeof(data->buffer),
> +				    data->timestamp);
>  err_read:
>  	iio_trigger_notify_done(idev->trig);
>  

