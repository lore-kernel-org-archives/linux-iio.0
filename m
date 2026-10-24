Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806374;
	b=e8E/+F3kcUh62Xa8qd//cYwBdEmRDN3M84MIUOPAPsZhkb+zPz4nMRQJnkokxmNDj5XL
	 V2X6fLz88o8VkOa3feYAosRUfSRoZI5y211GA09MMnhQB54+FSpp5mdHkRPHAu0NsUSXl
	 qXV+kmUaZLom5Wnr81uoNM1RwoQyyNtZYlFplnkUAIMC+Hr04wztik6/RsGgeq70b5ghD
	 a+axJ6lwfyc47HfXq9D8Lhd1kR+SirIsi3EGrHvAuU3EUNjP8hZtiOcLIl2fw0svKQr+T
	 klImWKSHqjolb9ypicmx3oFxDElfDRlVGStyDYIJghyOjf1ucHZSDauzPDXy94tcdWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806374;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8qteQNDpyJRYcCjQMeI1Z51gCTwv1k/XmJZq28ISVvE=;
	b=al5fqalQh7Gti1C7qjdNyi+I879dgqahDA/S6tlM1LHtsI5673BCrfRFF17LP8L5WAgf
	 rImC3oiAtVPByng1bBe3WCCIg+Q/X0LqTp0oG8Em9jatnJx5X0dEf7qVS8wMXm18jihku
	 v4mUg/N3GIyvaMJZuJAijpabZVAQLrj7SoAW56eoGDNYw7Z02vGJZg+SvfBZRmF7+NPz8
	 gADR76XGxdsUq/Ao+1FFy4Kz61Q8CwM6NzFHLA/0xNHi+7jVq19zcdTOam9p1IcLPvq9K
	 1tjWSecFvqJXUslj17gLlvbb28/sbJkxs3yYoXbvbe3RxO71LYEXI/7XGQCd84oh+YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmiwuUsm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32C0606A31A;
	Sat, 24 Oct 2026 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmiwuUsm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD971F01825;
	Sat, 24 Oct 2026 01:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792806373;
	bh=8qteQNDpyJRYcCjQMeI1Z51gCTwv1k/XmJZq28ISVvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PmiwuUsmcckemC6VWC6pB/BzBnBEk5Hhtjo0Ak03ZYIXSzMkRpdUdwQkI/BAOJxll
	 KYmQjp1xNuKMRHXcI9IdBUXg+vKLfeLBKkDfUfVgUbU/TWse7UEpHZcrF/kDsH2KD0
	 odP052QF+1qQ5kq6fW5dZvO78fqEyZGmPGb03HWvFgZv1i7I91IClMUl+nZI8xG/l7
	 C5votZl+R5eLuA9dH876wzQy5qCd7pdOLq9/9eWdPqujDvzJ6IB51gpVZRD1XH2+wM
	 uajqwq1uG2t7/bDMbCd7nI2fJL/l6ainMOsy8YChj9TY7x7CHuSezWy2v13vPL/ONE
	 sxZPnOwWXCV2w==
Date: Sat, 24 Oct 2026 02:46:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andy@kernel.org>, <Michael.Hennerich@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v6 06/16] iio: adc: ad4134: Protect conventional device
 access from debug accesses
Message-ID: <20261024024605.0aecb6a6@jic23-hlaptop>
In-Reply-To: <0789a1dae09581f06bd88757ddbda3531e165efb.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
	<0789a1dae09581f06bd88757ddbda3531e165efb.1792792325.git.marcelo.schmitt@analog.com>
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

On Fri, 23 Oct 2026 19:34:50 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> AD4134 sample read operations may more than one transfer to complete and

may require more than one?

> are expected to run atomically to avoid triggering any DCLK count error.
> Though, register access made from debugfs interface may scramble data if
> they are run amidst sample read operations and read/write/modify cycles.
> 
> Require debug access to acquire device synchronization locks before
> running any transfer requested from debugfs interface.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v5 -> v6:
> - Better explanation for requiring debugfs synchronization.
> 
>  drivers/iio/adc/ad4134.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index 1cfa8066f13f..71f626bbe9be 100644
> --- a/drivers/iio/adc/ad4134.c
> +++ b/drivers/iio/adc/ad4134.c
> @@ -302,6 +302,12 @@ static int ad4134_debugfs_reg_access(struct iio_dev *indio_dev,
>  {
>  	struct ad4134_state *st = iio_priv(indio_dev);
>  
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	guard(mutex)(&st->sync_lock);
> +
>  	if (readval)
>  		return regmap_read(st->regmap, reg, readval);
>  

