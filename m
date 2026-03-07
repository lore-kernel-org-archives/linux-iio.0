Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16ED292936;
	Sat,  7 Mar 2026 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772883995; cv=none; b=PLaWJ7C3aZa7G4ZrenHt4f81iun8OmymTiW19NtRrYjdF25fGrXB5bd6v7xxseJE7JwZvix1nfGBdb6JQDkctRPZRQVYX8Jd/uahMGVkDtL1P1putqGEAd1WeOqqzRdSojmTl6Z8Mz3V7m5+C7n5iQ63nDHQ8K49CReb3MF0mYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772883995; c=relaxed/simple;
	bh=e2sgILYvwWn+n1AWi5JDySrL+cwEdM04cBkm6xfJJJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fs58z3AbRw3mIBtOHSdcAaFcxfeT6BLMXkD2jwnZNg3xdJWqJdYbjH9Y6IvRNz6IysC11IsgYFwu4iKcn8QxAvlM26Y8FYKFtlZixPgtIqCW3bB0xlNQf9saRhkfUSk2mi9krtTjA1FKSSZHigoHTTb4bKJigM7OSNYjQMGNGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6kqDjNu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6kqDjNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C62C19422;
	Sat,  7 Mar 2026 11:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772883994;
	bh=e2sgILYvwWn+n1AWi5JDySrL+cwEdM04cBkm6xfJJJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i6kqDjNudrzuFt2hjdiw/J6C+tyvrKJpLnTJwPudGS/hZCFFoLXPsupPY0ylBRDOm
	 u65aBihRd9G+2W4Y+orapHvcgrAFneiOOKqug0uBJO1+zvA9Fru2B/7WRAjnRDnLMX
	 Db0Bv1U+AGSwPjH8vBoqDCao1wdODw9HIhFLmfqJjGQDEkSQpMjoPpG6HCjNqGEiSs
	 qIwwVzlqYrIkWq8k24B16knzvD5luZE1J+B8nsCbqpLqKO2mPyta5D0qsFoaOZ6X/y
	 CkMAUyiEp87iQL/6hVTekA5crUwEJp0posjh3G+i59Hzs3nnvGTHH9DH0mMiMH+Xmg
	 FBHrW/ayPd7rA==
Date: Sat, 7 Mar 2026 11:46:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 4/6] iio: adc: ti-ads7950: simplify check for
 spi_setup() failures
Message-ID: <20260307114625.7904edf1@jic23-huawei>
In-Reply-To: <20260305-ti-ads7950-facelift-v3-4-a23fdd1a079e@gmail.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
	<20260305-ti-ads7950-facelift-v3-4-a23fdd1a079e@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Mar 2026 11:21:55 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> spi_setup() specifies that it returns 0 on success or negative error on
> failure. Therefore we can simply check for the return code being 0 or
> not.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/iio/adc/ti-ads7950.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 1515089dd759..273c35e03185 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -527,7 +527,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	spi->bits_per_word = 16;
>  	spi->mode |= SPI_CS_WORD;
>  	ret = spi_setup(spi);
> -	if (ret < 0) {
Given it doesn't really fit better in patch 6 than it does here
maybe drag the
	if (ret)
		return dev_err_probe();
here instead just to avoid tiny it of churn around brackets.

Not important though.

> +	if (ret) {
>  		dev_err(&spi->dev, "Error in spi setup\n");
>  		return ret;
>  	}
> 

