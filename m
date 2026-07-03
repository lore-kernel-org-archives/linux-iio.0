Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750040855;
	Fri,  3 Jul 2026 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783119550; cv=none; b=cT1ZzicT3ZhYTAJdgUFn049rWPH7Y296gfaTYCV/NXzdr6fa0zpdj1THGGJqqiDJkm5rde2sRN80HGFD66A1Nwu+UEDI/XoSSpJqrZOdrFB4IzDHS0N6rU7t1H4hO6cDHHNLMYO7OEJCUdm4evAlMNk5ZXguFHa4WBLh+22cxB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783119550; c=relaxed/simple;
	bh=060hOQfZAiGJNo+cwqms6RwssbnDbQtzuIgjL/YbGJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kp5twLomd7kI05UQG/KMma3CiZSKu/fMLkYmn+EhezJQOu9KVaxOv77yXBiWi2wh95Bdzs7vuEQCxtezu1CqmpGQZIhYMdlVqXts2NZ6jCLS8dU74oSkBhwkY7OJy9ZLek9Exz4aaBksPNdlvQ7xnCAzgOIyn1+51JC5wSz84iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8ad8i4q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8ad8i4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A692F1F000E9;
	Fri,  3 Jul 2026 22:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783119548;
	bh=5JCmJ3QQ1q4RredNY0oI4Hj5SrPJHU2l2uBVMLNbbjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M8ad8i4qa4R4YFrazeV4FOPXDTZTzL+PxWK+XDyG3VovcespIMWvYIaszkuRTfNRA
	 pEju4eyvvW9gVk5zx//SlM5TtpsD6hfo9MfJo3kCYD+7gy/uVGsGNhR1ctZcbqoUIF
	 zNsNVRi2A2Gi6qQD2fKgvNKD1s77VPPSriEcmTxqXeptVMpThy/zA7noF25/d27vUL
	 CPkqLqTYSApCOO199oVATL0XjLZdnxmZYgBIdg3qeuL8J5M2I3IJtif0cz8KrJRHAq
	 SjLY+hjaCHBkNK29P7uPqIIrPcrUzMjbm0bRyuXadlYugAZ8cHaVT6O1Ij/iI2hRHA
	 vFKZVr8HyAg3w==
Date: Fri, 3 Jul 2026 23:59:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, daniel.lezcano@linaro.org, nuno.sa@analog.com,
 andy@kernel.org, gregkh@linuxfoundation.org, hcazarim@yahoo.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: nxp-sar-adc: harden buffer ISR against
 per-channel read failure
Message-ID: <20260703235902.73c841b2@jic23-huawei>
In-Reply-To: <20260518181138.1504-1-sozdayvek@gmail.com>
References: <20260518181138.1504-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 23:11:38 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> nxp_sar_adc_isr_buffer() bails on the first channel-read failure
> without calling iio_trigger_notify_done(), so the trigger use_count
> is left incremented and iio_trigger_poll_chained() drops subsequent
> dispatches until the device is rebound.
> 
> Reaching this path means a state machine has gone wrong (driver bug
> or the SAR ADC in an unexpected state) rather than a transient bus
> issue, so this is hardening rather than a bug fix. If the underlying
> condition persists the device is wedged and needs an unbind anyway.
> 
> Call iio_trigger_notify_done() on the error exit too, matching the
> success path. The nxp_sar_adc_read_notify() duplication is intentional
> and avoids a goto label for a two-line bail-out, as suggested by David.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Huh. Seems I picked this up a while ago but neither replied to this thread
nor marked it so in patchwork.

Anyhow, long applied.

Thanks,

Jonathan

> ---
> v2:
> - Drop Fixes: and Cc: stable@; this is a state-machine hardening, not
>   a user-visible bug fix (Jonathan)
> - Reframe the commit message and explain why the failure is not a bus
>   issue
> - Inline the iio_trigger_notify_done() in the error exit instead of a
>   goto label, accepting the small nxp_sar_adc_read_notify() duplication
>   (David)
> 
> v1: https://lore.kernel.org/all/20260517162346.189-1-sozdayvek@gmail.com/
> 
>  drivers/iio/adc/nxp-sar-adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> index 9d9f2c76b..1fc839a15 100644
> --- a/drivers/iio/adc/nxp-sar-adc.c
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -341,6 +341,7 @@ static void nxp_sar_adc_isr_buffer(struct iio_dev *indio_dev)
>  		ret = nxp_sar_adc_read_data(info, info->buffered_chan[i]);
>  		if (ret < 0) {
>  			nxp_sar_adc_read_notify(info);
> +			iio_trigger_notify_done(indio_dev->trig);
>  			return;
>  		}
>  

