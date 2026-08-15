Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E9C17AE11;
	Sat, 15 Aug 2026 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786827132; cv=none; b=XAz1ZIfb+nmhVjklEBXVe9H6XuJvZKR+cULSZbWugdyWoGJqhDqzfKfQ73trZS3EDptOXpK95IndekXxdeNaUz4TlAK+2yCzraosyvvPXV1C/UW/kx92G6BN1yFOwAh/SoyI0kYbVtQ0WcuY8Nirg3yEyJ3h3tEUjY9g419O2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786827132; c=relaxed/simple;
	bh=JdcTcoWLZ5UQKkuiKZJLaDN703UaO+qjCS1LIZ4G4A0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnM4OnMCgwxIpGhWPNaKPW0pgit4Pqw1vwuvpsuOZTiuhZm7lCPKyno3NHZ0pCmyOU3GcSks9CNlgkN6ULLdxBGEECv/+SKWDh+gEA/mC7cypoZ3AaB+0HBhbqFM4+9DccefHmEQOf0uwgF/wzIrG8ZEB5WtjhAMqVPo5HhSEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX0PFg6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX0PFg6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FB71F000E9;
	Sat, 15 Aug 2026 20:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786827130;
	bh=YWOfhrtZbTGF098WPpe7b6D57PvFgJzCv/32vhZEOPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GX0PFg6tPzNH8mnR2n3gUCDCOMBFc2pTDuKXXalFUru0l0th3gaI9a1l+4f9arXsg
	 8cj4QDWqdZcSn9WTvB5+KqA5kKNoCf40q7RKsCsIgdPx9kyCozdYVQLWMzJLU02RWx
	 vel+p1rtbGtqnkAK+6/dUYnEzHFa24jRMLyXwSxzsKxzlCn0UFUfzfj9aZ0s/4J+F5
	 AAhGgWUeMIK9c8/EoG0frNUQ80/1TPC+YZyiQmhRDW5zeekpdtW+mQsUdy4HkuBkX4
	 sSxjyOuQzWUIl1yGYnIfvVskLaTuP3XFa0Dhl7o3J5xIvFIuEjbjcYFvHDeUNv4gPa
	 6L9woKS1ZcREw==
Date: Sat, 15 Aug 2026 21:52:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Chris Morgan
 <macromorgan@hotmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH togreg v3 1/2] iio: imu: inv_icm42607: propagate runtime
 suspend errors
Message-ID: <20260815215028.784c7579@jic23-huawei>
In-Reply-To: <20260811103301.1157404-2-lilinmao@kylinos.cn>
References: <20260811020345.950137-1-lilinmao@kylinos.cn>
	<20260811103301.1157404-1-lilinmao@kylinos.cn>
	<20260811103301.1157404-2-lilinmao@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 18:33:00 +0800
Linmao Li <lilinmao@kylinos.cn> wrote:

> The runtime suspend callback always returns success even when updating
> PWR_MGMT0 fails. The PM core can then mark the device suspended while one
> or both sensors remain enabled.
> 
> The sibling ICM-42600 driver propagates the corresponding
> inv_icm42600_set_pwr_mgmt0() failure from its runtime suspend callback.
> Make ICM-42607 follow the same behavior by returning the sensor shutdown
> error. Keep a void wrapper for the managed teardown action, where errors
> can only be logged.

What is the practical affect of a sensor remaining enabled?  Bit of
power loss or something more significant?  This info matter when deciding
if we should rush this in during the rc phase, or wait for the next
merge window.

Jonathan


> 
> Fixes: 3007c1530f96 ("iio: imu: inv_icm42607: Add PM support for icm42607")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
> Unchanged since v1.
> 
>  drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 190e998f7b8ef..0da362967f63b 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -537,9 +537,8 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
>  	return 0;
>  }
>  
> -static void inv_icm42607_sensors_off(void *_data)
> +static int inv_icm42607_sensors_off(struct inv_icm42607_state *st)
>  {
> -	struct inv_icm42607_state *st = _data;
>  	const struct device *dev = regmap_get_device(st->map);
>  	int ret;
>  
> @@ -552,6 +551,13 @@ static void inv_icm42607_sensors_off(void *_data)
>  					 st->conf.accel.mode);
>  	if (ret)
>  		dev_err(dev, "Unable to turn off sensors\n");
> +
> +	return ret;
> +}
> +
> +static void inv_icm42607_sensors_off_action(void *data)
> +{
> +	inv_icm42607_sensors_off(data);
>  }
>  
>  static void inv_icm42607_disable_vddio_reg(void *_data)
> @@ -619,7 +625,7 @@ int inv_icm42607_core_probe(struct regmap *regmap,
>  	 * Ensure if sensors get turned on at some point, they're turned off
>  	 * as part of teardown.
>  	 */
> -	ret = devm_add_action_or_reset(dev, inv_icm42607_sensors_off, st);
> +	ret = devm_add_action_or_reset(dev, inv_icm42607_sensors_off_action, st);
>  	if (ret)
>  		return ret;
>  
> @@ -688,8 +694,7 @@ static int inv_icm42607_runtime_suspend(struct device *dev)
>  	 * however the tradeoff is that an unused sensor won't be
>  	 * turned off until the entire chip is no longer in use.
>  	 */
> -	inv_icm42607_sensors_off(st);
> -	return 0;
> +	return inv_icm42607_sensors_off(st);
>  }
>  
>  EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42607_pm_ops, IIO_ICM42607) = {

