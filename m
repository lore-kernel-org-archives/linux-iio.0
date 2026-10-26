Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020043;
	b=PO1GNsfW4guAA0/NfF59jgbs4UvreuxVx143CwfLgC+o35Qvy4qejZ54PGPBqwuuMA4a
	 1c+O8lYz6IO2IIwim4HAk+UOw1mQfgic9551egH4mQzErckDe5bSBzLTemD0FP/6XGxn0
	 3b77PuZrFaLwGLw4o1t+u4lZRzZtGXUrcl3tv7uyUfvRLb40kN2wL62Fnpf6RIN0VcqKM
	 nAPgK4gavMP9PUHaOlNJeYGgyWiH/YZI0v+TPU6TjYhrjy+4XiFIg4zkB0kl6dwWt3DJ8
	 y6leSefWNXh3j345s0EKR1Cp12mTat6AM3nnH15nVxKFyPWdvYuTamuYeAcHbxv3vEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020043;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=SG4q9H8LK6rIAC4M83ckUomTfrQoO3mMpRMQLZ+Aymc=;
	b=jisfRzOkSAnNFp63uOmFySLBE5YXEgbpOnBpo37hN1DTSfebAWe0A1YkiDtNrvCWs4hK
	 f08tJ3J9H8t8+fL8+PRwatNvFy8vLy+XM0PDkl1WCu3n303CPv+WqAqkvZvlxGXgktGQI
	 tRH9Q7OV0EeqWV8X6A4W423hh7ljviLhxVA2taA3+VPIB8yLNHnPXdr4nwsA+MLHN1mgW
	 AIHIJzxcStX+A32YOaGYhwS/WdFLBazXCJm2z1TVnqEz/9DMzLPkm5i7IG3YxGYvTYssc
	 H/nXGiMspQED4zQqPrp3Dd8cV9ot7S24FD5WfrL9A9HFa2qIR2jVMni7vOreCzbDtpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PnIZDaMp;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961D9606A31E;
	Mon, 26 Oct 2026 13:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 961D9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PnIZDaMp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793020042; x=1824556042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zCyKv0CD3wJJfw6FanjSGtwHVXDqiKBvBOkq6i4gY/I=;
  b=PnIZDaMpJ5rgk1WkmebwJjtBkxjbwUqw5e77VZ4QGkCqh0eKJb/Fpra8
   28Dvw4FVGRuLlA2M+RmgAu8V0HTdABziQ2O3FB6upI+N0arKmSvgsdKgi
   7niBzafdk/8L9tkLl5rsnVW5MtKBtSwIIHukqUKT7f5p4wDDowDTcROXt
   RB1y3mNmH/px5is37zCazV1mxw/THSn9Q6TLH8R5GDN5Q1KeN9EEECwlB
   8mECgMHQCZ7JSBuP0iarxOtv/Fdi0Bnifc0WrkgNq7YEKeM9kwEugVVvS
   bJM6Pr1rqXH/Ty60fTe57YMTRolmb4u29EXWmnrZZQeQkUO46mzHT+jjE
   w==;
X-CSE-ConnectionGUID: fix1NFj+SrqZkSSuLYQe/g==
X-CSE-MsgGUID: 0gmw7Ms4TuKSpBVdY5t73g==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1698594"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1698594"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:07:21 -0700
X-CSE-ConnectionGUID: 9qXtSX/mTvueKUDp0pyATw==
X-CSE-MsgGUID: uud9tvgQSmSP1xhNYZA5+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4318374"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:07:17 -0700
Date: Mon, 26 Oct 2026 15:07:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v7 4/7] iio: imu: inv_icm42607: Initialize gyro based on
 chip_info
Message-ID: <at9Qggd3hyGD1Hp6@ashevche-desk.local>
References: <20261026-b4-inv_icm42370p-v7-0-222e296ac1e0@axis.com>
 <20261026-b4-inv_icm42370p-v7-4-222e296ac1e0@axis.com>
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
In-Reply-To: <20261026-b4-inv_icm42370p-v7-4-222e296ac1e0@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 12:02:52PM +0100, Kanak Shilledar wrote:
> Update the chip_info struct with a new `has_gyro` property to support,
> devices which do not have gyro functionality. This is a precursor for
> adding support for the Invensense, ICM-42370-P. It is similar to the
> existing device except it only has accelerometer. Check all operations
> related to gyro with the boolean. Replace all the implicit comparision
> checks with explicit to make it easier to follow the code flow.

...

>  	odr_us = 0;
> -	if (accel && !oldaccel) {
> +	if (accel != INV_ICM42607_SENSOR_MODE_OFF &&
> +		oldaccel == INV_ICM42607_SENSOR_MODE_OFF) {

Broken indentation.

>  		sleepval_us = max(sleepval_us, INV_ICM42607_ACCEL_STARTUP_TIME_US);
>  		odr_us = max(odr_us, inv_icm42607_odr_to_period_us(st->conf.accel.odr));
>  	}

> -	if (gyro && !oldgyro) {
> +	if (gyro != INV_ICM42607_SENSOR_MODE_OFF &&
> +		oldgyro == INV_ICM42607_SENSOR_MODE_OFF) {

Ditto.

>  		sleepval_us = max(sleepval_us, INV_ICM42607_GYRO_STARTUP_TIME_US);
>  		odr_us = max(odr_us, inv_icm42607_odr_to_period_us(st->conf.gyro.odr));
>  		/* Track the earliest we can turn off the gyroscope. */

...

> +	if (st->hw->has_gyro)
> +		val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode) |
> +		      FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode);

Swap them to make lines shorter

		val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode) |
		      FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);

> +	else
> +		val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
> +
>  	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
>  	if (ret)
>  		return ret;

...

> +	if (st->hw->has_gyro) {
> +		val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK, conf->gyro.fs) |
> +		      FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK, conf->gyro.odr);
> +		ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
> +		if (ret)
> +			return ret;
> +	}

Use same trick.

...

> +	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->accel.fs) |
> +	      FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->accel.odr);

Ditto.

...

> -	ret = inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode,
> +	ret = inv_icm42607_set_sensor_modes(st, st->conf.gyro.mode,
>  					 st->conf.accel.mode);

Broken indentation.

>  	if (ret)
>  		dev_err(dev, "Unable to turn off sensors\n");

-- 
With Best Regards,
Andy Shevchenko


