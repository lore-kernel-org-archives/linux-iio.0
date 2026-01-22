Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26E136829E;
	Thu, 22 Jan 2026 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114661; cv=none; b=r5A2gTaj4JEeDCHgWw2JtEjaHXiXeOx1fcmp1Oq1jZ+eZl5UwN+wKBzy78hmZwTsIQVBU+vYFeGWOTxf/BYO02+3zmvbBKtBrqJvV+SVpbACypMGsKR0FIdeYFE503LKbPgm7pi0hc912zH4y5WXJWZz0ntaJQp8Y4ZhHlC2DQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114661; c=relaxed/simple;
	bh=KKZs5FoX11fx/t8FG9Is7Y5wn9vUoesHgaL05TY7EZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5oOyQw5Qm3Ld0ob+MLLzgtwGI4VKUSuKtgtjW9jG135MPSChOA7yuhIW7pegd0/tDOqK3gKOGP8IfSYnW4qmRVeTZPe6ZMqRlZboY4TQVZDcdhHClhGNU4pZFiopf6AQdMqEVoXgh6B+GTwOoZpUxqy4qVdKTg4+bXXXkhOmP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBn2umNz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBn2umNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58B2C116C6;
	Thu, 22 Jan 2026 20:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769114659;
	bh=KKZs5FoX11fx/t8FG9Is7Y5wn9vUoesHgaL05TY7EZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eBn2umNzp04WGjS33Galur0+CJFsIoxtYv6t92xLrvRjNS3CZ/X+DvleWQNpdUksV
	 8HPxHUhhsMCYZGHRM84OGA5RAcXWh6fD+8g0tRsjf9MxPsjL6IoIirpzDq9fxT8KeK
	 NjFmCJQSMlAg7w4xvAB3syBm94MbVkZkrn2/dFPSpyZXTp2tbO9E8TR76qT/uuShlD
	 mFKj61A84rx9jFvEr6p/3mMSu8zHKZkwH+hr+1FBybd6Qywyl1FpxmXNWlb3P6jGI2
	 t5ktCU193QHalgDjkA/mYgRsd3qyeQB8wqOe4M/nkzjucq5ukmICSI4jDD5eEOHmTZ
	 4nkOalOjV0kEA==
Date: Thu, 22 Jan 2026 20:44:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: adc: adi-axi-dac: define supported
 iio-backend capabilities
Message-ID: <20260122204411.1e5684d3@jic23-huawei>
In-Reply-To: <20260121-b4-ad9467-optional-backend-v4-3-18d2c0d450cc@vaisala.com>
References: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
	<20260121-b4-ad9467-optional-backend-v4-3-18d2c0d450cc@vaisala.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 12:08:32 +0000
Tomas Melin <tomas.melin@vaisala.com> wrote:

iio: dac: adi-axi-dac: ...


> Backends support buffering capability so advertise it while registering
> in case a frontend makes checks for it.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
>  drivers/iio/dac/adi-axi-dac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index 0d525272a8a8378e616fae4d0af606979d7b7716..cd06cd4587af56cd2521efcaa37c407f172e7014 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -869,11 +869,13 @@ static const struct iio_backend_ops axi_ad3552r_ops = {
>  static const struct iio_backend_info axi_dac_generic = {
>  	.name = "axi-dac",
>  	.ops = &axi_dac_generic_ops,
> +	.caps = IIO_BACKEND_CAP_BUFFERING,
>  };
>  
>  static const struct iio_backend_info axi_ad3552r = {
>  	.name = "axi-ad3552r",
>  	.ops = &axi_ad3552r_ops,
> +	.caps = IIO_BACKEND_CAP_BUFFERING,
>  };
>  
>  static const struct regmap_config axi_dac_regmap_config = {
> 

