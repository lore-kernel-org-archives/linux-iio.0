Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787D639BFEF;
	Mon, 20 Apr 2026 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695667; cv=none; b=ehq0VYnBY8+odMzY2hJ/Mft6Czt2CvWAfIXXY6UtMspWGomAXpJiveV5DlBUM/hHbOUeyJDkVGn6tGtpJmhXuajW7xwresHTN5rbGfo7MvPAiN6Vo7cR1/qK9aM0krPlauaqbNKXeGDb0iJHHkPJRj9h0vccDiMKYHtKILOWfOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695667; c=relaxed/simple;
	bh=SUtb5CzMWIe7+X4X+cgGbxrIVDYLq3Sb9l5qM49GdOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2qRAhbHRSreHLEvZQzpnFhqVNQ7xGXODDaIC0G4SjdZ4GuMU+pdh/ypTyTjpBy8IIR6WLsSTblwHc3fdZtgzk41hQ7B0hMhA3q74aN1fZcb0k1dd+EerMh0QlbxMq+VX2MWQJnBhrxRF7H0/7LeQrx1U5pmJjRND6P6MqxqyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHRDZM2y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHRDZM2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7B5C19425;
	Mon, 20 Apr 2026 14:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776695667;
	bh=SUtb5CzMWIe7+X4X+cgGbxrIVDYLq3Sb9l5qM49GdOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BHRDZM2y98jsTk91T8czK8km7nDwTMUjdR0DjtHx48Vfdg2OiHGV3/OmNV1z9Q7KX
	 LAoTlaCxTPtmzKxy+FqeddxD/vadaMoKXHtVoxez4vW91BYawXU0kGDqaVln/5ib1X
	 VNqpU4NvKAwhByxszmccO0OAzPFJ8RTWwsmgOdped7V0VqffhyPQ05xFW75C4xKwII
	 aweW7TUHssr5L0OF7OmWbilQJVY8Ca6PVZmvlURLBE2Dz+RRDkDv2gzB3vCj4yApII
	 hQyOyhcE4ExnP1w4TSlFgz4MS5HA47j3qSDaPjZ/0CRM8xHrofBldx7P3leUwdWdA4
	 sRm1gZ3ChVJ2A==
Date: Mon, 20 Apr 2026 15:34:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Alexandru-Catalin Ionita
 <alexandru-catalin.ionita@nxp.com>, "Radu Pirea (NXP OSS)"
 <radu-nicolae.pirea@oss.nxp.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: fix division by zero in
 write_raw
Message-ID: <20260420153418.21ef8f03@jic23-huawei>
In-Reply-To: <20260401152924.58073-1-antoniu.miclaus@analog.com>
References: <20260401152924.58073-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 18:29:24 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add a validation check for the sampling frequency value before using it
> as a divisor. A user writing zero or a negative value to the
> sampling_frequency sysfs attribute triggers a division by zero in the
> kernel.
> 
> Also prevent unsigned integer underflow when the computed cycle count is
> smaller than NXP_SAR_ADC_CONV_TIME, which would wrap the u32 inpsamp to
> a huge value.
> 
> Fixes: fdee77dea4b6 ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Ideally this would get an ack from someone familiar with the platform but
as it seems right to me I'll queue it up.

Applied and marked for stable.  Given I'll be rebasing anyway on rc1 there
is time to back it out or add tags.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/nxp-sar-adc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> index a6e4888a8464..c611f1c612e6 100644
> --- a/drivers/iio/adc/nxp-sar-adc.c
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -560,6 +560,9 @@ static int nxp_sar_adc_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val <= 0)
> +			return -EINVAL;
> +
>  		/*
>  		 * Configures the sample period duration in terms of the SAR
>  		 * controller clock. The minimum acceptable value is 8.
> @@ -568,7 +571,11 @@ static int nxp_sar_adc_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
>  		 * sampling timing which gives us the number of cycles expected.
>  		 * The value is 8-bit wide, consequently the max value is 0xFF.
>  		 */
> -		inpsamp = clk_get_rate(info->clk) / val - NXP_SAR_ADC_CONV_TIME;
> +		inpsamp = clk_get_rate(info->clk) / val;
> +		if (inpsamp < NXP_SAR_ADC_CONV_TIME)
> +			return -EINVAL;
> +
> +		inpsamp -= NXP_SAR_ADC_CONV_TIME;
>  		nxp_sar_adc_conversion_timing_set(info, inpsamp);
>  		return 0;
>  

