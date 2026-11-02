Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585794;
	b=M3H40OuqauFzpwZCKzLRgH6OcYss6XT2xqq7eqvAmyS86zpqqCq4UJRhE6xZhWlBy+xG
	 H9PfFLwh/+pRoMZjCSi/OActN6yUvO0mmRZAaeLb6WMMjUs+MHH1uqwBzVOpB9Hu7r4qM
	 hnAr6QKK0ogSLLdaDH3ikDW/JGSdIR8CpXO3K6XtDEafJvVE17i8cyktTbLc/qfeWZtwa
	 I4lf56i6o5JrbpUUVR1RvOWmV0bpcBcCwKTckV2Q2DEMdIRkrd7Qoo4k02CGhyKEpFZl6
	 M1N6YX0HQs9pBEJ1v19w6MCNx9FENdCxjGNDX0pyaEM+fZBXKyRFACByLUnbwxULNjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585794;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hyTofYu3dTL4yGt3yh5IrrMFIbzWO6XcSopjoxjIawI=;
	b=mWXF/h9pDc+CNt2mp3eapUcT3P8uuQYxwneSC3C2IvXZF3D6Cf15ByLsN86Mf15eeny9
	 ixXMxZDy3WoLPHc5bpVgp0tXXOH6p9+fr9LUH6CVL74hgIyU6pQM9I09xC8xZXjs3UgWB
	 oAOvPumv05ugLTjryq0PKZWvLVG6ToRe08R3UyWwXP8gnSvmaKgS9A0qhMnyZUo1zJTor
	 7RmMzTmBliotQL1FswP02ES+kxXV5T86QB0LwSe9rJ+cmZDTCb7LKXdZQU+b/GPlb5sFm
	 ZrHquRFXUfOk2+5I7DxAuPr7WKcckgOHdr4t6YtIMz7Wq3vmS64s5QIM1Kd5d5sBW3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuMRdA5E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E59606A324
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 02:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuMRdA5E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9B11F00919;
	Mon,  2 Nov 2026 02:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585793;
	bh=hyTofYu3dTL4yGt3yh5IrrMFIbzWO6XcSopjoxjIawI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kuMRdA5ElVKDYLJmfWaaIdYrS8qJ+orAHfBeLh+TkfV5BU480X+5DwNwLlz1Xz+6s
	 bnvcVJwD9wjE1zUssMX2GSS2amkprpbM9rCpH6nAIft087a7C6UmkqiWe+tIa+rgn2
	 5ET5aI/xYA+8qjTAuwyqo/jDgua0Jx0JFN35EDe44Q11roBXFlUYa5N88gZU19qHN+
	 uxmsG4nle7NB304eca75jifSPhumOEnHtbsMyG9fmzXwJlgy6yo70IhfQiaSV2oWqI
	 7LabTxITidOKg1BrxA4wwZio2Y0yYuq83YzvKdsa6x3D4hqHMErkW72tc6FJ5hCsQD
	 rsLHhqzXXeF+w==
Date: Mon, 2 Nov 2026 02:16:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jianping Shen
 <Jianping.Shen@de.bosch.com>, Alex Lanzano <lanzano.alex@gmail.com>, Justin
 Weiss <justin@justinweiss.com>
Subject: Re: [PATCH 15/39] iio: imu: bmi270: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261102021630.628f4b6b@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-15-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-15-8b136778eedf@oss.qualcomm.com>
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

On Mon, 26 Oct 2026 16:05:33 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Applied patches 13-15. I think I'll stop there for now as the patches
are getting more complex perhaps and should have more review time.

Also, beer o'clock ;)

J
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
> Cc: Jianping Shen <Jianping.Shen@de.bosch.com>
> Cc: Alex Lanzano <lanzano.alex@gmail.com>
> Cc: Justin Weiss <justin@justinweiss.com>
> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index fbcf6bb87acc..83a9a96c3ca9 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -851,8 +851,8 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
>  	if (ret)
>  		goto done;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> -					   pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
> +				    sizeof(data->buffer), pf->timestamp);
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  	return IRQ_HANDLED;
> 

