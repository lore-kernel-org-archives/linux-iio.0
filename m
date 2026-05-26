Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DCE25E469;
	Tue, 26 May 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807179; cv=none; b=X/YJlCw5JkzXkGhlQhi58OMl0xU5ar6u1+0pg0f/rnH5TUTYr9bjI5U5e0t+jhMvGHZVHFRahQrNZuYR0uoaqfDh+htyUktF8q5dwJOlWOzfGvlox6mpRgDXleF0K94ljuK8f5KKfUMBgREYnr7ztO/bTdkdPKTQAcPjnvkqbZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807179; c=relaxed/simple;
	bh=R3BfmIVF+hCZx3/9TSPILGFxW1CwqrqCB/fzWoL7EdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQFoHc0dmyPRDl79rW2zfjlnUvPuqdhRfIiPxiODxaN0bX0oIgZPF2BajTm3dJtSOChvp7tTj3c+gkIaDwUWY50uGXX5NfJvC9G436D5RFTDBzoFKLhCVQz6pc87oO00kLXrLyUYqZBGSpo9BlwP1WSJxWSRvjwCLiXFKXIptzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSn/nirW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSn/nirW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9921F000E9;
	Tue, 26 May 2026 14:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807178;
	bh=4uZKcZfQ7MjZEmBAJ/j5btvFmAbulQ8Ubm8Ta4r8q6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TSn/nirW2YoqX8zUrbTVYkjtVmoavSBrjUKwlxD6XjViv2Zym8L9Irnm8taLoYd/h
	 mD3Rsc+ARkRwJJpreaP1GVEu6b/6asfrX98p8ZF99C4SZEu8LS6UUkxLz+ulqAWbAY
	 KlCltPkzSpcCM9UWt4vA0nMFUDKeUSJjbRLIYR/zD0tzSFeFnHYNbf0xduDvi2pGug
	 cgyZL8VLJovN+8HqgF9Q+D017NXPQYl48iU4DD9a8kl2ybAakk6y4NFwAwoc2v1e+f
	 0n1kAc56IshLrxf3dbfLzoRLHJPv9gO0akbRzTUxSXVVcnYBaVUdORgdCvXdCgXjyQ
	 wwmnL8bDR0PZA==
Date: Tue, 26 May 2026 15:52:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, David Heidelberg
 <david@ixit.cz>, linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND
 DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] iio: light: al3320a: read both ALS ADC registers
 again
Message-ID: <20260526155249.1028be2a@jic23-huawei>
In-Reply-To: <20260523114505.73601-2-grandmaster@al2klimov.de>
References: <20260523114505.73601-1-grandmaster@al2klimov.de>
	<20260523114505.73601-2-grandmaster@al2klimov.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 May 2026 13:44:58 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> al3320a_read_raw() used to read two adjacent registers
> until the driver was modernized using the regmap framework.
> That cleanup accidentally replaced the 16-bit word read
> with a single byte read. I'm reverting latter.
> 
> Fixes: 1850e6ae7f91 ("iio: light: al3320a: Implement regmap support")
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
For future reference, be careful not to send new threads in reply to
old ones.
- confuses tools
- hides email threads in people's clients.

Anyhow applied and marked for stable

Thanks,

Jonathan

> ---
>  v2: use __le16, not uint16_t
> 
>  drivers/iio/light/al3320a.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index 63f5a85912fc..f40b8b36f22d 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -135,7 +135,8 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
>  			    int *val2, long mask)
>  {
>  	struct al3320a_data *data = iio_priv(indio_dev);
> -	int ret, gain, raw;
> +	int ret, gain;
> +	__le16 raw;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -144,11 +145,12 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
>  		 * - low byte of output is stored at AL3320A_REG_DATA_LOW
>  		 * - high byte of output is stored at AL3320A_REG_DATA_LOW + 1
>  		 */
> -		ret = regmap_read(data->regmap, AL3320A_REG_DATA_LOW, &raw);
> +		ret = regmap_bulk_read(data->regmap, AL3320A_REG_DATA_LOW,
> +				       &raw, sizeof(raw));
>  		if (ret)
>  			return ret;
>  
> -		*val = raw;
> +		*val = le16_to_cpu(raw);
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:

