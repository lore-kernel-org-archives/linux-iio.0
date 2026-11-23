Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447353;
	b=c2EdTS/fg32LMVm8l5+xSla73GLX3JYhTEvZH47XiPb5X9fGFLDHmCyY2j52ZFhKMeRi
	 970fctWMKFh3FF6fahncWm6nFnJGmmSEezLr6oa5BUw8R2CqjlQYR8htq5FMBpLPskpKz
	 8wE5qEm8t3zdXZ7bDxpLT4nMPPolY3/Cff6DQ+9UJLgTG8XA903BOBoiyL8wLuR//9MH1
	 Bzenw+yeCxG8fxixWTALrymoDNsc0n86VNlQVMVmjB2vRSarMl9b5olhmxF6a4fETXkj+
	 +qfP+qAJIsRAuyjGBy8p+j/3LHtePqhB7UxW89hLG1EXhFL0atlfyNSaMuv2ar4QuBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447353;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bLuFhzPDMD82jx0FB6acUSp89OVedJqWalTPyxGSkpg=;
	b=DMDa2AyhHnfwdk/6tcPfRnTQtaufDBLGgxxdhwZtrMGd0nCtm87QngpaEILzp1aCA7ak
	 keesbA+dG8fna0QiclC6OQsYqVmt3ydNzqX0Z36n8xQKi/eB4xT6eYGarTOv4H8em29VQ
	 nj5xaqVpVYy0f9RoxMHaCdo5WyWna9hUWi+WBz/xV7ItM4GYxBF7NEZ5DiKkSC5RT9+ZR
	 mdN3eIM46+KwUnT+D+H21zavZdk5gnkBgTHKnp7jPDJi8X6MXHpaAOE8vL/f3cF85pD8D
	 IAXCivrkSfIACkJ2YJquyZ8aqLakxlzG4YpqcKI1DF7wVbB9qZ2K8tXjcCxmn4Uyv5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwHiO91e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416E0606A321;
	Mon, 23 Nov 2026 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwHiO91e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524611F000C6;
	Mon, 23 Nov 2026 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795447352;
	bh=bLuFhzPDMD82jx0FB6acUSp89OVedJqWalTPyxGSkpg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KwHiO91e1Lo0aUZIvfTFNmO9FIESjNS834JSYFiVRF1yitRkLC7W46o7xZVYag3vS
	 cliZ72+FDlm7G+EyqMUv9sk3xg25+d+To5MJ6N06iDOqXroFwP06b6smiytYEbUgcy
	 wYfTabShJMAnGN7ZxG3JVE98xAzNfkED48ShJNbju/Rf5nA74DOskZ6g8hgNtcUAZk
	 QAjUCM1n3Alv6dt6GU5k8MGAgvE1jbAWMuqquPyo1YzwFnb4PnFvsHdJDTfJsc1RO9
	 BkcmxBrlvizI1OIAhYRAuS8MKWOEzYE7eCZWNYNCS7uJ4SJD7sznCfsgj4hpQclHGg
	 BP6tlt9dHo1fg==
Message-ID: <9e1b6e08-4cd9-4c0e-a009-16330843ce3c@kernel.org>
Date: Mon, 23 Nov 2026 16:22:28 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH] iio: adc: mcp3564: Use guard() and scoped_guard() to
 manage mutex
To: Vaibhav Chahar <vaibhav.chahar26@gmail.com>,
 marius.cristea@microchip.com, jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261123070802.14487-1-vaibhav.chahar26@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261123070802.14487-1-vaibhav.chahar26@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23-Nov-26 8:08, Vaibhav Chahar wrote:
> Adopting cleanup.h helper: Replaced mutex_lock() and mutex_unlock() calls with guard() and scoped_guard(). Ensures locks are automatically released, simplifying the code.
> 
> scoped_guard(){} was handled in mcp3564_read_raw switch statement (case: IIO_CHAN_INFO_SCALE)- giving it proper
> scope.

I'd reword the commit message; something along the lines of "Use guard(mutex)
instead of manual mutex_lock()/mutex_unlock() calls to modernize driver and improve
mutex handling."

> No goto statements were present inside older mutex blocks - so it was a
> 1 to 1 substitution.
> 
> Tested:
> - compiled with `make W=1` with zero warnings.
> - Verified using Sparse (`make C=1`)
> - Verified styling via 'scripts/checkpatch.pl --strict' (0 errors, 0 warnings)

Move the above paragraphs under the ---, you should mention testing only if
done on the affected hardware (one would expect a patch to be at least compile
tested before being sent to the mailing list).

> Signed-off-by: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
> ---
> Q: If i have similar cleanups for other drivers/files in this directory. 
>  Should I combine them into a single patch or submit a patch series?

I'd do a series. One patch can be harder to review.

>  drivers/iio/adc/mcp3564.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> index 259ac4ebd..252c3886e 100644
> --- a/drivers/iio/adc/mcp3564.c
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -17,6 +17,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/iopoll.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> @@ -498,7 +499,7 @@ static int mcp3564_set_current_boost_mode(struct iio_dev *indio_dev,
>  
>  	dev_dbg(&indio_dev->dev, "%s: %d\n", __func__, mode);
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);

Blank lines around guard() please.

...

> @@ -840,10 +837,10 @@ static int mcp3564_read_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		mutex_lock(&adc->lock);
> -		*val = adc->scale_tbls[adc->hwgain][0];
> -		*val2 = adc->scale_tbls[adc->hwgain][1];
> -		mutex_unlock(&adc->lock);
> +			scoped_guard(mutex, &adc->lock) {
> +				*val = adc->scale_tbls[adc->hwgain][0];
> +				*val2 = adc->scale_tbls[adc->hwgain][1];
> +			}
>  		return IIO_VAL_INT_PLUS_NANO;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		*val = mcp3564_oversampling_avail[adc->oversampling];
> @@ -903,7 +900,7 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
>  		if (burnout == adc->burnout_mode)
>  			return ret;
>  
> -		mutex_lock(&adc->lock);
> +		guard(mutex)(&adc->lock);

If you're adding guard() in a switch case, make sure to wrap the case
with brackets, i.e.

	case IIO_CHAN_INFO_RAW: {
		foo();
	}
	...

The cleanup.h magic works thanks to local variables, which need some
sort of scope.

-- 
Kind regards,
Joshua Crofts

