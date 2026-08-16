Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03E3A6B6F;
	Sun, 16 Aug 2026 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786916578; cv=none; b=qDGrUDDrsxho3m/JoVUmEqTirty/sh7hbu5zMNPyKzN/p4HMGXKXlp6At+JLjl9kDhLwsigZ8oUptP26TyIElgsshLngWSgkNtMl0dtCQ7ZZ/ARTpYsY1BUV60O7AJ1rxaShT4ik/R7nxgv6P2eOuWYlt5hcR67h55eKAUK2ZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786916578; c=relaxed/simple;
	bh=g9NI6/t7U+majt69fXXl84uenC/USov2u0/+6235jwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIjO0qYMyyfnksQFU1fzohi3mQyXkX2qKZGU2LvSDdDko0+2yC1GGiWUZ6K3ZM4F1ida6MlXmAUL9Vq5CNH3vDSetFKHuwBfvDXuCR0gOQHxf/cnYjFPq9/hNnhz2A+63oWSEtSOCR7NYntCQj0Fef9G3WeWiUqUrSlccb0DHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXv84bmw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXv84bmw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7E61F000E9;
	Sun, 16 Aug 2026 21:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786916577;
	bh=f5hGjvaBq/EkvqZaFRseehrMV+lFdJc0juaWPYutyxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DXv84bmw5gzsqlfJrYiiIUMS1SwMzkL1EtSTWVvaFfZfNUG0sZn0QZYEqRjzUcKJX
	 4Ue5c3ANyFcvd3Ct7llKZegAb3Mx9wogO9E0LF62GCRDCXAIoiSXFC9oTNuioEmflB
	 OfAqU0qmq2qRNcJHEBhmF15H1TXBSFE2lNvI+lfXy4muLqOGFZmZcpNNg++8n+g9OG
	 pTHlPzalRc0EQDYdnFdhUr9y7xEq1hrqi+L1Gveq60en3gg9Q1kfmRxEVohmtDl5vS
	 VXVFnpUTTePjvS8hN9iZnpd3DDUYZQBFqiJ1J7k5QnIQsC80qztgWSnXVpRpkEdrQZ
	 Iy4YrjwQb99yQ==
Date: Sun, 16 Aug 2026 22:42:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 6/9] iio: adc: ti-ads1262: support excitation
 currents
Message-ID: <20260816224252.0c449ee0@jic23-huawei>
In-Reply-To: <20260807-ads126x-v3-6-f89925d72792@gmail.com>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
	<20260807-ads126x-v3-6-f89925d72792@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Aug 2026 22:58:28 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Support the two IDAC excitation current sources. Each channel can route
> its IDAC1/IDAC2 outputs to a pin via the "excitation-channels" property
> and select a magnitude via "excitation-current-nanoamp".
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1262.c | 101 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 98 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
> index e2659941e1af..d5464b4f2bfb 100644
> --- a/drivers/iio/adc/ti-ads1262.c
> +++ b/drivers/iio/adc/ti-ads1262.c

> @@ -277,6 +282,25 @@ static const char * const ads1262_ref_sources_neg[] = {
>  	NULL
>  };
>  
> +static const u32 ads1262_idac_mags_nA[] = {
> +	0, 50000, 100000, 250000, 500000, 750000, 1000000, 1500000, 2000000,
Where we have long arrays like this a useful convention is to break them into a power
of 2 elements and provide a comment that says /* 0..7 */ etc
just to make it easier to count.

> +	2500000, 3000000
> +};
> +
> +static int ads1262_find_one(const int *array, size_t num_elements, int val)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_elements; i++) {
> +		if (val == array[i])
> +			break;

Assuming this doesn't change later, an early return on match makes life simpler.
			return i;

> +	}

	return -EINVAL;

> +	if (i == num_elements)
> +		return -EINVAL;
> +
> +	return i;
> +}
> +
