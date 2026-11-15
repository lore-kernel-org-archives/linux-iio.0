Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794701610;
	b=B+7Ii4ItrvqeSUWPpmNI71jerqLAmVjII527lpuEUWtsE+iSXB83O7pdTFA66hpT0EYC
	 KWRAD4mS3HQnUl+g3c9TJ3WpSxliyKfoMAbFUnJN8f4kVDyk2v+VKGXgeZY6oa3Z61K4l
	 9SMWSSy3//d3T1lY6jdSHRsN2xDFKYbCxQYtgkIZ9tjIDgCwY/y80FXcO0wU/HU1w/0DJ
	 rK9BgsSuI/mux2tF1cQtnpB5+ATaCn+Hc/Jf88LnGECxVliaSqXZmbpi/hKqMlKO9jWfL
	 RD/PeNisk5CW3d6dEmyCdSd89+QF356Q+n7fQPp/yi9/A8FL7axD1VwgjU+xaBcgpIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794701610;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dOoV3qoWRT5vJA3d6X527WzddUn03UNPNwr/wQkk5us=;
	b=BlI+ncmb+xCdRkQzXLCM+cucOkd/dOMKz8Q9gllyoiwiTiHu7q0bD9b1J0wD04cBXpfZ
	 1kaiJaiiL7d4+edaFVk77k13oxOORCq0FWfHi93n0yBZpZaBHiXv93FXsUsUiv8zN0psZ
	 mXi5XB+KtXqQaWxBkKOM4Qaz5s5HTNcaYmLR/2pEkomLrkDhi9gPEIXoUPxC2bCnHnzJ5
	 1WXRgJ0NH96IcWf8O7xLz2ETVMdcp6iNeMkaKc6hVJyAGV2DNy98+ci2XJCIw2wwqtIiJ
	 2oLDT9/b4x5tWJefCvZ/9dgMDK5f9KKCKJzdIORgituC47IodR3CxNcUjFx+VMupLCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mbf7wAyn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A2606A327;
	Sun, 15 Nov 2026 00:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mbf7wAyn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33DD1F000C4;
	Sun, 15 Nov 2026 00:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794701610;
	bh=dOoV3qoWRT5vJA3d6X527WzddUn03UNPNwr/wQkk5us=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mbf7wAyn6LU77icvDXowXB5uY1uHJC9Jus86aynnSQ/Tj0LSN+GjE6edc4CQ1Z5g2
	 n2PwocPKXXjye8DrJRhyszQK8Scl3wJ/SZFpLp25CHKbf3vyWI9o3wsZdng2G78pHu
	 cZ2y0WYtc1YQrXc5vZ1H0rnX3qFfuktFxeU7xfSdzunTvRKn1nqcof3GABmFw9GIG3
	 fKxvZdeW0rBbBwLoBW2IxJylGq65qQXmK4hRAHuxI1kjR7jlaVOqACPhIHRHbFrofZ
	 R/ctO/3p8ym9w1xgFiwj3ocmvXdkpvsOyohi5vRxxONHJqA262YHpcQhb77vMmLLVO
	 JtwNhEV2IZpVw==
Date: Sun, 15 Nov 2026 00:13:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Archit Anant <architanant5@gmail.com>
Cc: dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com
Subject: Re: [PATCH v6 06/11] iio: adc: ti-ads1015: Remove
 ads1015_set_power_state()
Message-ID: <20261115001322.0cc599be@jic23-hlaptop>
In-Reply-To: <20261109165805.31160-1-architanant5@gmail.com>
References: <20261109165805.31160-1-architanant5@gmail.com>
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

On Mon,  9 Nov 2026 22:28:00 +0530
Archit Anant <architanant5@gmail.com> wrote:

> Remove the unnecessary ads1015_set_power_state() helper and
> use runtime PM helpers directly at the call sites.
> 
> Use PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND() to manage the
> runtime PM reference in __ads1015_read_info_raw(), ensuring
> it is automatically released on function exit, including
> error paths.
> 
> For event configuration and buffer operations, retain
> explicit reference management as the runtime PM reference
> must remain held beyond the lifetime of the respective
> function.
> 
> Mark the device as last busy before putting it into
> autosuspend.

Glad you called this out as otherwise I might have not noticed.
See comment below.  How this works changed a while back.

> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Archit Anant <architanant5@gmail.com>

>  static int ads1015_buffer_postdisable(struct iio_dev *indio_dev)
>  {
> -	return ads1015_set_power_state(iio_priv(indio_dev), false);
> +	struct ads1015_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +
> +	pm_runtime_mark_last_busy(dev);

Take a look at what upstream pm_runtime_put_autosuspend() does.

> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
>  }
>  
>  static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {

