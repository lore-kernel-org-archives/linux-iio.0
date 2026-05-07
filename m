Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35113AB293;
	Thu,  7 May 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171500; cv=none; b=lKpSY4Ubqf7O3eRolywuMHIPcEtXyU9zfYEF3GHceAYHY3dtDST7Z/buwd0/gBuRkv2Jb9xq523JMEE5LxKzxvfmwP+X66bK3VR5SEZw/f8n4nfjgFZZBsIlyVM7V612Pb8CA9CVVWlKrSMDOSLcEYpFzrlXPHOMquDclkHDAqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171500; c=relaxed/simple;
	bh=D491JxIuLmq1AefAQYAHAYAXzEhRt9jw3sGHdRJnfKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFoXg0CC3JNSfcniav+zwG7CNgUoeb3lpuvUzS5aIJviJjtbvE6YRJEufbKws5GcjH6qCtHjS1U9zY+grQpAg1+6tMMatXLfabOVwS+gW5nolKsFJp5AqwpFjuXFa5FdsXq9pWjZJB3AXPP4ptH8pLvzIg4phxEYHfUgkizDMC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blpcjIZj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blpcjIZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2E7C2BCB2;
	Thu,  7 May 2026 16:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778171499;
	bh=D491JxIuLmq1AefAQYAHAYAXzEhRt9jw3sGHdRJnfKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=blpcjIZjDhQIhFKYgdMz9HCLN64ogZFpmM0VAcAg1YpEZvOYymT2jmM6Ro8tOUEMr
	 it42Z1AAzIn+6FkQBpG8Jp+OB7H/9NTJbv5d/sIKwJb/uGeocV+Coz+kLrrsBNVJyS
	 ULXQuPlC3KIZJDOOyLjiAOQsdGYliHZzYYB9UX8YSgYDGvu8ruiFXYPh2pzIEb0a9F
	 G7yns8VU4/SMFMant/HZPD2BduhbsBQWggQ+oTQtlzdApJ8UQuy60H2rjoBsC7xt6H
	 lbhpojkDwC+iRg4MEId/at5Z0uBg1IqyiR6B6eGJaMKYAmonOsV0UI4yj2d08VXfGP
	 fIxK+Ov//6DNQ==
Date: Thu, 7 May 2026 17:31:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>, mike.looijmans@topic.nl
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: ti-ads1298: Remove unnecessary CONFIG2
 write during init
Message-ID: <20260507173132.7741060c@jic23-huawei>
In-Reply-To: <20260507105129.25639-4-shofiqtest@gmail.com>
References: <20260507105129.25639-1-shofiqtest@gmail.com>
	<20260507105129.25639-4-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 13:51:28 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> The driver was enabling the internal test signal (INT_TEST), double
> amplitude (TEST_AMP), and fast frequency (TEST_FREQ_FAST) bits in
> CONFIG2 during initialization. These bits activate an internal square
> wave generator intended for device testing and calibration, not normal
> ECG operation.
> 
> CONFIG2 defaults to having only the RESERVED bit set after reset, which
> is the correct value for normal operation. Remove the write entirely
> since it would just be writing the reset default value.
> 
> Suggested-by: Mike Looijmans <mike.looijmans@topic.nl>
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
Looks fine to me.

I'll pick it up once you've addressed comments on patch 2 that
are outstanding.

> ---
>  drivers/iio/adc/ti-ads1298.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index 186bda3087..8957e873e1 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -615,15 +615,6 @@ static int ads1298_init(struct iio_dev *indio_dev)
>  	if (!indio_dev->name)
>  		return -ENOMEM;
>  
> -	/* Enable internal test signal, double amplitude, double frequency */
> -	ret = regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
> -			   ADS1298_MASK_CONFIG2_RESERVED |
> -			   ADS1298_MASK_CONFIG2_INT_TEST |
> -			   ADS1298_MASK_CONFIG2_TEST_AMP |
> -			   ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);
> -	if (ret)
> -		return ret;
> -
>  	val = ADS1298_MASK_CONFIG3_RESERVED; /* Must write 1 always */
>  	if (!priv->reg_vref) {
>  		/* Enable internal reference */

