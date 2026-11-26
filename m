Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699059;
	b=LYJ1PHTWp6MuNtAAmIbZsw3l2WaJahYvyazPT5bkVOlNnM1xWrMm3DfzQCGEL+bhpDCI
	 +gsLWfbFULDMT9voA6Y2sUUtNYLIYyotc65+IbiKWnQE9gpFQkZy57KnzkdOZXrqMvvoa
	 2OFqpyGL5fHUAj7iuku5Q94ImdWe5YhpjTQ3egL/gZ9sBmxbzIOZzOxbAXQ+Bg3CzWK/x
	 4aUj46nDI8xwtgW2kAEwy+rp6TGKmJK12+bZIA7xX+eQNKTplArzahw5jGQvYmAmw5tR2
	 gW8qImcsncjtZh19JwymFIyUN1TYGuxELrifdR9FpObzcMOfIie7zs4bVsv0vWWUi6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699059;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=amnfFFZbB1qsMx2Fq1iBCm2q663dBkIInVBJD2wgJeY=;
	b=OwQnV0+y6SO8i6tI6JsCDjbjydiyL5HSKFlTZc0ZdFfoRPo6UR8MF/6gvbSor5Lp8o5q
	 VRX5KxBs35VoS/d/PJqGkG2nHDpzu20jZNRXI8767HLk0CM+maMeAYimlzzTHJzeiqNPV
	 IefHmuwvCHXVWfl6zYJ8V+0Y8Np8Ygc9syBDKvQ+D40mQ5Gi3baAgmBrDLkgsSRp5Dnk7
	 VSbDfA8dRgUxKg+jy2csYOrdvIuQu8QeZkFT+1eL5yZ8KdYdvoBs5zoq0DCcIB8tzuSts
	 g7LBO4qEl7dTJd8TtYnE5QnYnWYj/9cAk1mQuWxwYRUIoCUf1q5TnlM82+Vsf6QRlIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G75ZU8MR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD07606A31C;
	Thu, 26 Nov 2026 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G75ZU8MR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A171F000CF;
	Thu, 26 Nov 2026 13:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699058;
	bh=amnfFFZbB1qsMx2Fq1iBCm2q663dBkIInVBJD2wgJeY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=G75ZU8MR/nZSBbNsKif9tOQY641/by2TFKLeLGu4XXzwkV+E2y/5ImHykofx8pWOQ
	 l4mE2/Xnc6R9BsK89+DtQODvdxtounEHw+yaJ3wcSaxpUQBBoeeVWmWuwcMGqf48im
	 fDJh8UCGrjKcCG7qeX/ZutZpZ/udHE7elPMDLbvT5YaIrXl+4pSPAZexYGSe0B3Yz3
	 4UKqfXZl4RG1YUTmsop4DwzZVktg3PlWoRIrAcL9JT0aOzKJtRVf8Lf7wYG1JzlS58
	 SIlwifIA6dOuMM8KxUscqLWW8H1CPEjOyGK5fRMRgB13GRt3z5fUHZGV5avEGuhEpQ
	 gU0VuUOtAeopQ==
Message-ID: <065da662-2670-4f7c-93dd-410e9c11d18a@kernel.org>
Date: Thu, 26 Nov 2026 14:17:34 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/7] iio: pressure: dps310: use time unit macros for
 sleeps and timeouts
To: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
 <20261126121331.10438-6-zoone.rupert@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261126121331.10438-6-zoone.rupert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26-Nov-26 13:13, Rupesh Majhi wrote:
> Write the microsecond values as multiples of USEC_PER_MSEC, like the
> poll timeout next to them already uses USEC_PER_SEC.
> 
> After a reset wait 20 ms with msleep() instead of 15 to 55 ms. The
> specification says 15 ms, so this keeps some margin.
> 
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
> v2:
> - wrap the poll call on logical boundaries (Andy)
> - msleep(20) after a reset (Andy)
> 
>  drivers/iio/pressure/dps310.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index f802c2c59072..1d46817ad04a 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -20,6 +20,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/cleanup.h>
> +#include <linux/delay.h>
>  #include <linux/devm-helpers.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> @@ -103,7 +104,7 @@
>  #define DPS310_DRAIN_MAX_MS	(2 * MSEC_PER_SEC)
>  
>  /* Make sure sleep time is <= 30ms for usleep_range */
> -#define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
> +#define DPS310_POLL_SLEEP_US(t)		min(30 * USEC_PER_MSEC, (t) / 8)
>  /* A period plus a measurement time; silently handle error in rate value */
>  #define DPS310_POLL_TIMEOUT_US(rc)	(2 * USEC_PER_SEC / max(rc, 1))
>  
> @@ -369,8 +370,9 @@ static int dps310_startup(struct dps310_data *data)
>  	 * Calibration coefficients required for reporting temperature.
>  	 * They are available 40ms after the device has started
>  	 */
> -	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> -				      ready & DPS310_COEF_RDY, 10000, 40000);
> +	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
> +				      ready, ready & DPS310_COEF_RDY,
> +				      10 * USEC_PER_MSEC, 40 * USEC_PER_MSEC);
>  	if (rc)
>  		return rc;
>  
> @@ -558,7 +560,7 @@ static int dps310_reset_wait(struct dps310_data *data)
>  		return rc;
>  
>  	/* Wait for device chip access: 15ms in specification */
> -	usleep_range(15000, 55000);
> +	msleep(20);
I think it's safe to use 15 as specified in the datasheet, as msleep()
guarantees sleep for the specified time + a max of 12.5% slack.

This can be tweaked whilst applying though (or not, at it's pretty minuscule).

Either way,

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts

