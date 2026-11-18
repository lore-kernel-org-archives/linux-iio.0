Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031321;
	b=5OyxTyx6+Dh5Ql3Ee7Y+DBmZyAtedC5ZCeVmQ/c+apdN/p9fJMC9yVh/WaH2JRoDxC65
	 P0xE7uZJ26ucHB0MbWwFpzVqpJTMtFQkjRRGcub9CUyWRqdpxPBRtOpVd1nHdz32ZVOz1
	 79iLlUXjUgC7VOrAuVUa9Rg5pzRrh2mZzADv7UUXJdr5W7Cl70PANqDIf8oNaifgb6LL5
	 ek27hFktwDJIdnOBDe4pBdesDSt51fvR09CZ7R1wPDlL7epBgvI/p9R1GRfzsEWXIwihn
	 2AWq2y+/hL3ZPa6FvIkkZdlkCteYvYhjv+fbZuxHDjljh95ePuYQ0V56pXwG393kl9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031321;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZVZcTuEkVl19Sk9hoXJWLHXnpH2fDYQZ47U/6HO+JBA=;
	b=xeP90asoOfd7RO79Z4YSZcY7OtLiyZN4i1mUvejpvKpcJ9N5fkV4aCkYqkOpatimPA3T
	 Y0WpO4xDM4pLihm0zxUSIWW1GrvTpvC6TCz6+qyouDJSTokrN5Z9v4yqrxJhYue/X/38B
	 mkFM0i+A2RAxsCCV1XyBbxmm3UaHQmWJFBfa4ABWaiu0gTlEGBSWyY/pepBZ2CJTvjfKL
	 rsY7/D8t21uxhYqq3go2ZKvEEbVPvML14Al6ETquU6Wex6ZHvVQb8K6MBnP/S0Jt060Bh
	 bwyzNEaJ1cvoKFCPc+zyGbf82skYt4JSoG86VMZ4lwjH8PuGq4yVWsDlK+3cs5wYnJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3T5HMez;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0D606A320;
	Wed, 18 Nov 2026 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3T5HMez
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0A11F000C4;
	Wed, 18 Nov 2026 19:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795031320;
	bh=ZVZcTuEkVl19Sk9hoXJWLHXnpH2fDYQZ47U/6HO+JBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D3T5HMezjl0O7dtrU2l5yGkb+SOCimj6DoTg+Y/+5ZG3hc0j6ONmiKh6BgvzZvhOR
	 0zqtCvBqm8ntn4w1K91GV4vQIhQMppt3V3ZDlXu9Y+mNCkAUv0lYtSvMyhMR6itKyg
	 fDZ8EeomY/EH1DVDXMO3dsXn9S6o+i2Ws7snv4A+ssP/W7B2NZTt4KQiF5ZVtofjkB
	 NwDIczacZZAQIt6Xdoe+kAkLlw/QWjM/Qh3GIIkWR+Naqyo3WMkKhukTt8K69TtFzg
	 IoHQkqrDQVBWM89hd4y8yV8ly38iqseYNbOp9nwzLj24AvgD1YnlZJfYP96Q4YTFV+
	 eeMWUU5KFx1gg==
Date: Wed, 18 Nov 2026 19:48:36 +0000
From: Lee Jones <lee@kernel.org>
To: Daniel Balint <dbalint@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] mfd: cros_ec: load cros_ec_pwrmon on supported ECs
Message-ID: <20261118194836.GJ98456@joneslee-macbookpro.roam.internal>
References: <20261106193129.43493-1-dbalint@google.com>
 <20261106193129.43493-4-dbalint@google.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106193129.43493-4-dbalint@google.com>

On Fri, 06 Nov 2026, Daniel Balint wrote:

> Load cros_ec_pwrmon driver when the ChromeOS EC advertises
> EC_FEATURE_PWRMON.
> 
> Signed-off-by: Daniel Balint <dbalint@google.com>
> ---
>  drivers/mfd/cros_ec_dev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

I can pull this in when Jonathan is happy.

> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 529a23b804f7..9cf85636b7f9 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -115,6 +115,10 @@ static const struct mfd_cell cros_ec_charge_control_cells[] = {
>  	{ .name = "cros-charge-control", },
>  };
>  
> +static const struct mfd_cell cros_ec_pwrmon_cells[] = {
> +	{ .name = "cros-ec-pwrmon", },
> +};
> +
>  static const struct cros_feature_to_cells cros_subdevices[] = {
>  	{
>  		.id		= EC_FEATURE_CEC,
> @@ -151,6 +155,11 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
>  		.mfd_cells	= cros_ec_charge_control_cells,
>  		.num_cells	= ARRAY_SIZE(cros_ec_charge_control_cells),
>  	},
> +	{
> +		.id		= EC_FEATURE_PWRMON,
> +		.mfd_cells	= cros_ec_pwrmon_cells,
> +		.num_cells	= ARRAY_SIZE(cros_ec_pwrmon_cells),
> +	},
>  };
>  
>  static const struct mfd_cell cros_ec_platform_cells[] = {
> -- 
> 2.56.0.455.g6c5a503b38-goog
> 

-- 
Lee Jones
