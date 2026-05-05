Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422DE2D877D;
	Tue,  5 May 2026 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978158; cv=none; b=PX/42pefm/3R6gsja2rFwklF3H+Eyr4NTh5fhzXPtDVQ9LKJuEkfVHd7alCmf1unJUxv+21XV10Gq772vjQxgy2i0wt3Rouqk+RHB/YabsxD5j4Gk8iSVJ2g9/rooBhJuD5zebZ05kHoN/JXFLYGiYcRfDVptXQg51OqOpiT6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978158; c=relaxed/simple;
	bh=cmpZwE7rhlF3xtQdi4N9xlqRTNKqAwGthv4iX8nMvh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3/XoUhN6k8DlZfa3nO8qwarrlr/vXleunm2aoSYxISneOn3Oh31hCmr7cwxGYXi5HlXoan3LpPv8iWslLOrjWK7e37B+N8ShsxXfteSv5SGQuIV6t+j77QzMK3CjhqBU+6fASKFpX4QCPVOVXclb64DaVBtbDPxCOdQmW64GNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBT76w+R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBT76w+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E71C2BCB4;
	Tue,  5 May 2026 10:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777978157;
	bh=cmpZwE7rhlF3xtQdi4N9xlqRTNKqAwGthv4iX8nMvh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MBT76w+RsYeR38bN1lqNTpfpRdPdoO0k7r1K1CcLHs1bJh6zCS9+T9wq7XWNnqErs
	 swdp6rzOdIZcFQAyawKrJqG3sifPd7gvTtkto+mNtzUm0WR802FExsYQsuQdi4Lr7z
	 tcTTj9+/ZS50pX2h8G+zCFf6c+4pttbReEc3IqQYocuRMhM484C5SE6tVzA2zWelQa
	 0i7WWn56L6XQuEUX/EtfndDgV+xuqUzrvg6SIHq8POV6XRLF9Q4DEZ6knLB4K/u+vk
	 G6KGFqA73fz7TUvgSfUa2ZiKHA+5iUI4r0IvI/TbtXHWYLn2JFljzS+l7GkPF9DQn2
	 vUDTat3LcPuMQ==
Date: Tue, 5 May 2026 11:49:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Kevin Tsai
 <ktsai@capellamicro.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Move MODULE_DEVICE_TABLE next to the table itself
Message-ID: <20260505114910.0488657f@jic23-huawei>
In-Reply-To: <20260505102903.187598-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260505102903.187598-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 May 2026 12:29:04 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
> exports, because this is easier to read and verify.  It also makes more
> sense since #ifdef for ACPI or OF could hide both of them.
> 
> Most of the privers already have this correctly placed, so adjust
drivers
> the missing ones.  No functional impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Fixed up the typo and applied.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/sgp30.c | 3 +--
>  drivers/iio/light/cm3232.c   | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
> index 21730d62b5c8..d42b62b7081e 100644
> --- a/drivers/iio/chemical/sgp30.c
> +++ b/drivers/iio/chemical/sgp30.c
> @@ -498,6 +498,7 @@ static const struct of_device_id sgp_dt_ids[] = {
>  	{ .compatible = "sensirion,sgpc3", .data = &sgp_devices[SGPC3] },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, sgp_dt_ids);
>  
>  static int sgp_probe(struct i2c_client *client)
>  {
> @@ -566,9 +567,7 @@ static const struct i2c_device_id sgp_id[] = {
>  	{ "sgpc3", (kernel_ulong_t)&sgp_devices[SGPC3] },
>  	{ }
>  };
> -
>  MODULE_DEVICE_TABLE(i2c, sgp_id);
> -MODULE_DEVICE_TABLE(of, sgp_dt_ids);
>  
>  static struct i2c_driver sgp_driver = {
>  	.driver = {
> diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
> index 3a3ad6b4c468..90aa77e3a03b 100644
> --- a/drivers/iio/light/cm3232.c
> +++ b/drivers/iio/light/cm3232.c
> @@ -369,6 +369,7 @@ static const struct i2c_device_id cm3232_id[] = {
>  	{ "cm3232" },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(i2c, cm3232_id);
>  
>  static int cm3232_suspend(struct device *dev)
>  {
> @@ -400,8 +401,6 @@ static int cm3232_resume(struct device *dev)
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(cm3232_pm_ops, cm3232_suspend, cm3232_resume);
>  
> -MODULE_DEVICE_TABLE(i2c, cm3232_id);
> -
>  static const struct of_device_id cm3232_of_match[] = {
>  	{.compatible = "capella,cm3232"},
>  	{ }

