Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72173ED114;
	Wed, 25 Mar 2026 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450532; cv=none; b=bf0snG1J9vIwUgVRu6wHSXz2/k3tJaB7vus8W+eGMKrr2jy55eg40P6wBu6N4ZhhnjAC5ZL2qtEhzo0VOWBhVhicfAi3WT7Zm8TxPDbHI1nONN1AEeEkz4y0TeLWyasILAbyJj2IqGMnaUF5kabC1YqdH5JkDYv2qlYne0SegEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450532; c=relaxed/simple;
	bh=yJEaAhNInxkUPg/+xE1pFxzavxkhq+BfWo22ihZJyU0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSVK0dY/MFueViDNfxisc3T41oTHZuaxHo1D6XWbFmj5xPsVEZrbwie9J/nNeuyKRpoez2nxuMTbdWkhyfHlPcVBbfPlhyhUaBaUCWGm3EW2+0tjgTK3wpu9TQU1al+wBDx9Px/MGwR5+0BMsFwoFaFZswiBQKkQ1spyj9y5MVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgqgx11DhzHnGjb;
	Wed, 25 Mar 2026 22:54:53 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A3AFF4056E;
	Wed, 25 Mar 2026 22:55:28 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Mar
 2026 14:55:27 +0000
Date: Wed, 25 Mar 2026 14:55:26 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Francesco Lavra <flavra@baylibre.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v9 6/6] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <20260325145526.000071ad@huawei.com>
In-Reply-To: <20260324084808.654118-1-flavra@baylibre.com>
References: <20260324084655.653781-1-flavra@baylibre.com>
	<20260324084808.654118-1-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 24 Mar 2026 09:48:07 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> Some IMU chips in the LSM6DSX family have sensor fusion features that
> combine data from the accelerometer and gyroscope. One of these features
> generates rotation vector data and makes it available in the hardware
> FIFO as a quaternion (more specifically, the X, Y and Z components of the
> quaternion vector, expressed as 16-bit half-precision floating-point
> numbers).
> 
> Add support for a new sensor instance that allows receiving sensor fusion
> data, by defining a new struct st_lsm6dsx_fusion_settings (which contains
> chip-specific details for the sensor fusion functionality), and adding this
> struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
> populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
> logic to initialize an additional IIO device if this struct is populated
> for the hardware type being probed.
> Note: a new IIO device is being defined (as opposed to adding channels to
> an existing device) because the rate at which sensor fusion data is
> generated may not match the data rate from any of the existing devices.
> 
> Tested on LSM6DSV16X.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
One trivial thing. But don't resend for that. Assuming nothing else comes
up I'll tweak it whilst applying.  Same for Andy's line wrap comment.

thanks,

Jonathan

> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> new file mode 100644
> index 000000000000..9fb3e19e4a55
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> @@ -0,0 +1,243 @@

> +
> +int st_lsm6dsx_fusion_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable)
> +{
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	int err;
> +
> +	guard(mutex)(&hw->page_lock);
> +
> +	err = st_lsm6dsx_fusion_page_enable(hw);
> +	if (err)
> +		return err;
> +
> +	err = st_lsm6dsx_fusion_set_odr_locked(sensor, enable);
> +	if (err) {
> +		st_lsm6dsx_fusion_page_disable(hw);
> +		return err;
> +	}
> +
> +	return st_lsm6dsx_fusion_page_disable(hw);
> +
> +out:
Stray.  If nothing else comes up I'll drop this whilst applying.

> +}
