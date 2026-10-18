Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C81BD9D0;
	Sun, 18 Oct 2026 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792294231; cv=none; b=sME4rybwHu/dW1c6ZUroNXr+o/PTJ0NSDtFPdKBud8WFsrA6ZHGEhhgOdH6jmDVu2Sa6juLs2Ypz2dkNZzkdusk41lh8msMxTFIdx1El6G/2+TOXQh+SXRhyAtZJR3MfXN3YWM8TYZylX7TAxrSgj4ubwLxTL0aCy209xdBSdbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792294231; c=relaxed/simple;
	bh=JguZV1+0IrRdOB30BtSxAg/vguSQGclONVyrcO1N71M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEZ0IhfBdIXoy+59YK2RrvfCI43dZ5Q6IvSEyUmKpN9TuwK3bha0O08CDQ5P3OresVN25D9RZm6g7rUEJTq0GH6qN7mXHSUUITlQR3e9V/hHS+avoTPOqxICAt3MssSNP3hBCKFs+60BfYdOwvxG793nQz9pysaF+BFduhe/SDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7f1IUga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7f1IUga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D361F000C4;
	Sun, 18 Oct 2026 03:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792294229;
	bh=SuAKlG81oXxDMLny82s88G0fKI4/sznAQbkODVMg9Jc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L7f1IUgaCe5b3f3UNHnAikrWUdzs3bQSaoc/+iEqZBO0X0uDgnV6I84sclN2yDPS2
	 bVa2YMnA2Tx5PDxhLAFH0ZCOPNqsomVpnrfxUCGhDfYU9CLD7pfVhrsy58wUeqj76R
	 8BueIIsUS6cGEjhhVs+yKFFqHpRJq6QSRtg01SlzCXqa0cuzEMYlJTBrOeHARAd/eg
	 OROi0AxfdcEO+NLOrJwiJTLQZW1y+yRvrnLu362ORO77eptNOP1F3hRirVukJj+Nwd
	 9nDMuTQTQeibA7Jkheyqmf6PFo74dGFLHdKSHszkyoDx5mdZcT6GsJL8HibLWIKXEr
	 W6ok7FVWS7POg==
Date: Sun, 18 Oct 2026 04:30:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrei Stancovici via B4 Relay
 <devnull+andrei.stancovici.analog.com@kernel.org>
Cc: andrei.stancovici@analog.com, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: adc: ltc2497: enable line-frequency rejection
 on LTC2493
Message-ID: <20261018043023.21071516@jic23-hlaptop>
In-Reply-To: <20261009-submission-ltc2493-support-v1-v1-6-3dad1d4b152a@analog.com>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
	<20261009-submission-ltc2493-support-v1-v1-6-3dad1d4b152a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 Oct 2026 11:43:39 +0300
Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org> wrote:

> From: Andrei Stancovici <andrei.stancovici@analog.com>
> 
> The LTC2493 carries the same second configuration byte as the LTC2499,
> with identical FA/FB line-rejection semantics and the same per-rejection
> conversion times (50Hz-only being the longest at 163.5ms). The generic
> filter_mode infrastructure is already implemented in the core and enabled
> for the LTC2499. Enable the same flag for the LTC2493.
> 
> Tested on live LTC2493 hardware connected through an IIO network backend:
> all three modes are selectable; conversion times are respected; voltage
> and temperature reads succeed in each mode with no -EIO.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2493fe.pdf
> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
> ---
>  drivers/iio/adc/ltc2497.c | 1 +
>  drivers/iio/adc/ltc2497.h | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index 0df2ad9b3243..d668a81f1ff7 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -195,6 +195,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
>  		.name = "ltc2493",
>  		.has_temp = true,
>  		.has_speed_mode = true,
> +		.has_rejection_mode = true,
I can't see a reason not do combine this with previous patch.

>  		.four_channel = true,
>  	},
>  	[TYPE_LTC2497] = {
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index 34ea62c2a4bc..af939e57e1f8 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -50,7 +50,7 @@ struct ltc2497_chip_info {
>  	u32 resolution;
>  	bool has_temp;
>  	bool has_speed_mode;	/* SPD bit in the 2nd config byte (LTC2499/LTC2493) */
> -	bool has_rejection_mode;	/* FA/FB bits in the 2nd config byte (LTC2499) */
> +	bool has_rejection_mode;	/* FA/FB bits in the 2nd config byte (LTC2499/LTC2493) */
Particularly as reduces churn here.

>  	bool four_channel;	/* 4 inputs (LTC2493) instead of 16 */
>  };
>  
> 

