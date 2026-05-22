Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D23BB9F4;
	Fri, 22 May 2026 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459292; cv=none; b=bpym34guRwST+5TCPI/5N52cE/hKruKcExZ3p+uTinv4xQApCp91Wbe5Wi4RYzDZxVMsLmuoFXrVC+hBNTYTwS8xH1E7FWLrtoVB8K1wanJeGsFT2BqP2di4IwqciQeW6OYTAIdPe7BoWSkWfYZ2qwPF7g3FsjrA29dB1YrauNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459292; c=relaxed/simple;
	bh=NA4o8ASIQxTR6NLDIhELCzRKwfmZTx3xYGhzNX/bioc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUm5KGeltQj6BvzlU7Lg6LFl17XrWwMJS+VtDf+BfdzKsUruYvBStKT3VftwbuVkvOWLCpgVA2m1GTPFVX+/B2iEsQ9FIDpHsuCWY7s/FCaOjWuH9XKgRykenbKu4/guOsPFf4hPegPRwfmU22WiKGlSMRS3+FPJ4Um8txeB7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkGTv/Y1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkGTv/Y1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC1C1F000E9;
	Fri, 22 May 2026 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459284;
	bh=pXm2zYEQluRuIzdTEbCaiuXgMN+Db9bXe2zms0gwbkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AkGTv/Y1ZsdqonFmV4i2XFdE0NpZZ04d4hJBgcZJ9CvPQnKl+Fs9bUyEclDyfTJ+j
	 7r0AnYiF7V2vq5vVlodENmgGMEa3oEUX6Utgbohx9vrGwVGkTpezVGGvXgSnpkE6Qn
	 Duw2AE9nyP7lneRFlGTEwqu5bcFM502/2K4SQbvFnfVYx+uadjjzJXaVK6nqCwpciJ
	 98ZbnIEl+ppktzTwEnr07KZnL8BszFhNAacXhC4RQhqWG0VNK4r4w2FD2XzhzpckBz
	 nNNqW5mK6ct5ffQsQHBBmKX4bkx829R5yMyiJXrXrpoZZ8xsDU7UwXLMglvv7SaEk+
	 koOALcMpPTAYQ==
Date: Fri, 22 May 2026 15:14:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, David Heidelberg
 <david@ixit.cz>, linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND
 DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] iio: light: al3320a: read both ALS ADC registers again
Message-ID: <20260522151435.21e31610@jic23-huawei>
In-Reply-To: <20260521041041.542095-1-grandmaster@al2klimov.de>
References: <20260521041041.542095-1-grandmaster@al2klimov.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 06:10:35 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> al3320a_read_raw() used to read two adjacent registers
> until the driver was modernized using the regmap framework.
> That cleanup accidentally replaced the 16-bit word read
> with a single byte read. I'm reverting latter.
> 
> Fixes: 1850e6ae7f91 ("iio: light: al3320a: Implement regmap support")
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
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
> +	uint16_t raw;

Just for completeness as same as the other one.
	__le16 raw;

Which is what the bot is also complaining about

Thanks,

Jonathan


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

