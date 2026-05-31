Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3437937BE9C;
	Sun, 31 May 2026 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780230104; cv=none; b=W9qBcxhbkjZ5o2/HV5afcM5VU1pvmU24hCauGZuFVAUhX1gPiUFn+xcXiKBJWP5ZVkD8eVlxMHPFWyJZIX83G3D4W0cAfjDl0ZNN0Fhzet2HVWylJlNN89P3/vguZyh12higDke0+/PcDPbrTqx0pQI9XsYW4Rm6Q/pkKNPNZTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780230104; c=relaxed/simple;
	bh=2sfvOWNeBGhrYaDc7iTdO27VGkQSuanYL9q49zzyVUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/tOjzNQCg4jjbFoUFLikCw8FmGW0JPOi0TQS4i9Lz68aAuGzU7EqTtpBLB296sqpAbszJGhGF1StzbMD7CK3Qi+LAlLxmYuiIMFgBaF4zMViWgwYeLyawmz/NGc8L70Uy5xsG9G9vchsjXWncc2mCExXErQqpqQ273b46AGVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHsSeGsg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHsSeGsg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984261F00898;
	Sun, 31 May 2026 12:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780230100;
	bh=7MXWgo0KbjYJW/KbWQ7yZM7FTW4BsZwz60DkdhXDW/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fHsSeGsgx54Vx3yJ+fvYkXFSqMbE4/2KBlJsUvGgiaE3o3oZQuViKjv9bwN26lSR7
	 gQHfm7EQcYcNeZq3ivhKXCjvvHqnstLbee7s/G/iLPx/MT2nb71rU3Apr0QKetmfAd
	 F81H1qUnBVQklju/QYLhZxlZx/mEep65iz3/BgspQuSB1IheRsePXDisk3tVRbHgDl
	 jCXBIoj0cTGIWWBDznjVLQhZ74yMruojhcQXDNRnyJHseC/R+VwfxXlQ/9kQByiV9N
	 pCHiRm3W0vVILKNelf03H3Jv1KwtFRCY21+cJEy0yqj1cOGj9DGVq2lxmSWvkZc37b
	 03NDHmDpGoT8g==
Date: Sun, 31 May 2026 13:21:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V9 05/11] iio: imu: inv_icm42607: Add PM support for
 icm42607
Message-ID: <20260531132130.17b4ae26@jic23-huawei>
In-Reply-To: <20260530031739.109063-6-macroalpha82@gmail.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
	<20260530031739.109063-6-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 22:17:32 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add power management support for the ICM42607 device driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris,

https://sashiko.dev/#/patchset/20260530031739.109063-1-macroalpha82%40gmail.com

Points out a deadlock.  Suggests maybe you need a few more test cases!
More generally I think you've misunderstood how force_suspend is used.



> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 3dd4cc8c6b1d..cfdce70ce25d 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c


>  
> +static int inv_icm42607_suspend(struct device *dev)
> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (pm_runtime_suspended(dev))
> +		return 0;

Force suspend will deal with this for everything in there.
I'm a little confused on why runtime suspend effects disabing
vddio_reg.


> +
> +	ret = pm_runtime_force_suspend(dev);

You'll need to do this without holding the lock.
Also take a much closer look at what it does.  

(sashiko points out why what you have here doesn't make sense).


> +	if (ret)
> +		return ret;
> +
> +	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
> +					 INV_ICM42607_SENSOR_MODE_OFF,
> +					 false, NULL);
> +	if (ret)
> +		return ret;
> +
> +	inv_icm42607_disable_vddio_reg(st);
> +
> +	return 0;
> +}

> +
> +static int inv_icm42607_runtime_suspend(struct device *dev)
> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
> +					 INV_ICM42607_SENSOR_MODE_OFF, false,
> +					 NULL);
> +	if (ret)
> +		return ret;
> +
> +	inv_icm42607_disable_vddio_reg(st);
> +
> +	return 0;
> +}

I cropped the resume cases but they have the same problems..
