Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809399;
	b=ZF2Sn35pJ+JtzWno8TrVfS2WkBRpsDTwBGgWc56DVZ4SRhaJHAsjkd9P73ST4FMVHwPx
	 W69XyOLBy2KeiD8yzT/mIShNoYUT8wxpVZubopBqpEge5tWsz/7Cz/+0rKTH2UTKh+sb+
	 Hh8REzaAmbovfXKJRmejlljkSeqK7aH2W5ofhu4A/JDJJiUWGQVWp1dUrPqt78IPzYb15
	 bf+12AePnsN30JZ/dmK1+igb/IELKTiiBkM5Is8VyzYC8g3e6E/abduC7JaDC+eVaWnzI
	 igBMxuuFcnouJQ78oR6rSywBQF/z/tGYFP5qMMtgHukoCMssIt9WK+YoQqnEhqwve9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809399;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=p8y+ApMqVZOXxJ2K2EJRI4adLyFlM0rJYm1p3LBR06A=;
	b=VvtR+aTckRmWH9ubFKvGwwKFVEXXaxA1g1o2vhqYcHmZE7VsJcfurDZHXBMw+ehXoHIw
	 nYaq49VSW6qlsCea6MXOcdN+OD7xB0ABhqgPwOWfVKPlOyZtUmZk6KAhWKF52emQSBdih
	 TGlcFvZ4ogy6QoI9GjtyevOlVdgRHy93y6bmNJ49JYCO6H4Aux9VvADdQQgXmM2C56KJZ
	 s0J4dJMgehl2+4V6EFc9Rhs01BrqTQJl71eRe2eCUzjiXBlnh9uepUWWIugDxUil6Numi
	 7uEPHCvy4YIJnwf22boeq9KwPfPIgA2JMAd25KLf4FEPcAAC4wCDvNrxxmpjMfdvhKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EP9iokq2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C02606A31A;
	Sat, 24 Oct 2026 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EP9iokq2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8BD1F01825;
	Sat, 24 Oct 2026 02:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792809398;
	bh=p8y+ApMqVZOXxJ2K2EJRI4adLyFlM0rJYm1p3LBR06A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EP9iokq2DlRqzuWGTlHFj73R5lNVjoeG4TTpdrxgzX7bauv0JWaIL/hssYV2cvE7K
	 E5MmgiWIF88KTgvYG+QVrC074mKlTIczI5ICr05yg0HNyAdwF/tr3fxL2IUpNt0Ouk
	 +QhMdt5JS/YP5RSQ5AlbqdTBQah/Uh9AdDphRdxPwb0wufCPd4ib3pay+vGeDhEWwu
	 jkeMsCT2tOk6VZ1HXdmMGZxi29+erNQ5hqXKDe4MqbbQCjOeHtmk45Y2B91hQQ9FRC
	 SKp9tCr+cPd3sXDhDR2+ZOH9FldZpTZsdnrQWhXMaw9xFLG3K9m9XQWPcElvIO+Bas
	 KecJqM4wGoMRw==
Date: Sat, 24 Oct 2026 03:36:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: osf: keep the RAW cache current when the buffer is
 full
Message-ID: <20261024033633.4d769023@jic23-hlaptop>
In-Reply-To: <36f5bc0a26aadf8f2208e6423c8a9847568ccd3d.1792315003.git.kimjinseob88@gmail.com>
References: <36f5bc0a26aadf8f2208e6423c8a9847568ccd3d.1792315003.git.kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 18:27:05 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> A full IIO software kfifo returns -EBUSY from the buffer push. The
> sample handler currently treats that as an application rejection and
> returns before publishing the valid sample to the direct-read cache.
> Consequently RAW values and the last accepted sequence remain stale
> while a consumer is not draining the buffer.
> 
> Continue cache admission for this normal saturation condition. Keep
> other push failures as errors, and retain all sample, scale and session
> validation before publication. The buffered sample is still dropped
> when the kfifo is full; subsequent samples can be queued after it drains.
> 
> Fixes: 2da37c28edc6 ("iio: osf: add IIO devices from capability reports")
Not a useful tag as I'll be rebasing.

Given this will go upstream with the driver anyway I've just dropped it.

Applied without that or the LLM tag (change of kernel policy).

Thanks,

Jonathan

> Assisted-by: LLM
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---
>  drivers/iio/sensorhubs/osf/osf_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/sensorhubs/osf/osf_core.c b/drivers/iio/sensorhubs/osf/osf_core.c
> index 4f73ff5e9572b95e1cd237671f01e149784b92b5..377645e7a8a31c60bb719b7c98e3230f04725f1c 100644
> --- a/drivers/iio/sensorhubs/osf/osf_core.c
> +++ b/drivers/iio/sensorhubs/osf/osf_core.c
> @@ -231,7 +231,8 @@ static int osf_core_handle_sensor_sample(struct osf_device *osf,
>  		return -EPROTO;
>  
>  	ret = osf_iio_push_sample(indio_dev, values, sample.channel_count);
> -	if (ret) {
> +	/* A full software buffer must not prevent the direct-read cache update. */
> +	if (ret && ret != -EBUSY) {
>  		dev_err_ratelimited(osf->dev,
>  				    "failed to push sensor %#x:%u sample: %d\n",
>  				    sample.sensor_type, sample.sensor_index, ret);
> 
> base-commit: 6a27f3a7d1063aec5aa3d9370161e850fc3a85dd

