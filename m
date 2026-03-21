Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89D306490;
	Sat, 21 Mar 2026 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774120280; cv=none; b=THE/K3oy86WonaOlYXRBHZItNP90xDy+3jzfVydTIlv9kBrLSOv96MP7PxXWU0joICx8zwBMgaV9aJQKuHrgMTvvhq2i9tbuwpdHTXNNXYY7DZrp0y3pBCPrbxr+JQGPCDi9kJGw1LdfhPFMfbKN6Ameq3Qte4yhecahcSBoRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774120280; c=relaxed/simple;
	bh=sTUe3enVmdxUH7ylNIDTsVi4cu+rXg5Zdec6X8Ubzyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbqDsNeEOFoaVfrtb350nv9Hz6mOWE+AFkeP3NovY2OTm57ufwSLLN9CrLGQ4Y/vrpGWhD+cvNxBr91iVkxjy6Z+kTi8CIIu3Urk4oO5oqcpsjeeYZGQo+EKFDlOCpiRzKE+ae39pWb7rnlU0rkaYSDQ95JnRT6cZallxE2C0E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY+iaEfn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY+iaEfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AB7C2BC87;
	Sat, 21 Mar 2026 19:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774120279;
	bh=sTUe3enVmdxUH7ylNIDTsVi4cu+rXg5Zdec6X8Ubzyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cY+iaEfnoUwrs9IjCAmG4V8R8g8/a/bNTIFFl5wzzpgVSQBia0nMt4tJsmQv+uHzI
	 m+3x0I40FbBMH4mV5ilt0mBEI4n2/eaHklptjepxRI9e6VQ4F2ZsoIVqVu0Lu174ri
	 KvYcu1JF62q4dRPrNNdYJ8tUuV66HuCG6z8PrnQ7OBL8DAcUnroDfyTP0I/yi0YZGh
	 8gsuFg/7fh/yyInXGXyMk8PFZNynRIzBf87o7aREQwUyJYVXr2UZ+HjmefDYN9aRtg
	 u7jih53NTxLMphwTfJRPXP4N0nC+k6XpQ4bpvvYFojvY/ndNkLXkZ00yXFboP6JwNg
	 Ca/vjAkmyfZtg==
Date: Sat, 21 Mar 2026 19:11:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 01/14] iio: accel: fix typo celcius to Celsius
Message-ID: <20260321191110.6f8b77a3@jic23-huawei>
In-Reply-To: <20260316090023.14691-2-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
	<20260316090023.14691-2-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 14:30:09 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> Fix incorrect spelling in comments
> - celcius -> Celsius
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
I want to reduce the number of patches that are floating around so
I'm going to pick up the easy bits of your series.

I'll note that having pulled this down with b4 git didn't like it
for some reason, reporting corruption at line 11.  patch was fine
with it though so I applied it the long way.

Applied this one, so don't included it for v6!

> ---
>  drivers/iio/accel/adis16201.c | 2 +-
>  drivers/iio/accel/adis16209.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index 5127e58eebc7..ba0f97944c6d 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -147,7 +147,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
> 		/*
> 		 * The raw ADC value is 1278 when the temperature
> 		 * is 25 degrees and the scale factor per milli
> -		 * degree celcius is -470.
> +		 * degree Celsius is -470.
> 		 */
> 		*val = 25000 / -470 - 1278;
> 		return IIO_VAL_INT;
> diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
> index 41ffd92f27fd..04e169f221c4 100644
> --- a/drivers/iio/accel/adis16209.c
> +++ b/drivers/iio/accel/adis16209.c
> @@ -186,7 +186,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
> 		/*
> 		 * The raw ADC value is 0x4FE when the temperature
> 		 * is 45 degrees and the scale factor per milli
> -		 * degree celcius is -470.
> +		 * degree Celsius is -470.
> 		 */
> 		*val = 25000 / -470 - 0x4FE;
> 		return IIO_VAL_INT;
> --
> 2.53.0

