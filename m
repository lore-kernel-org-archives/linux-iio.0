Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96A344021;
	Mon, 28 Sep 2026 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633063; cv=none; b=TW/zowEyn3heZLd+aGy3qk9RS7zEqp+l5TptoY6aYdOuhNxKYNot5ieGJaGSDwaUpXYSxliADxAD9N4T2ScFNeyRPo5YxRj4/YmScF6QDKJHtfvCA5V8b+2SPUBmZP+15MZoRHVc7MUdwhsRw+NlzJWLuI0TQ/F4Nk2uGWAekJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633063; c=relaxed/simple;
	bh=BwsjGz6iUh59cLgLUFJKdhLkOfQobRfo4RrxZOTVLJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLLiBKIQ19l8a3iSSUFeW5ux36kbrR17YzBPHxaQZ1yehIQLmzw43Bnvfl5g79zV89R0EZ1ZdaE7CnsluAkqzUlcOKRN66vDLUxTiMShHcACZ9x9lgwteZzuHRXh4urDey+iiNfD9vLxp9ovLgSoTXHqd5ku05kl5Ig8cATGTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWTWbsW9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWTWbsW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790633062; x=1822169062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BwsjGz6iUh59cLgLUFJKdhLkOfQobRfo4RrxZOTVLJw=;
  b=kWTWbsW945It6wCjqnGHXPKJnQ9D76mTKUkyEyYWZrChYXA6e6oPgHpl
   yCzw+nfQECsiMflIXb1ucTkMiXyodauFzCVfpxKetI0E/eYa4+NG5BcGp
   aXUqpMl9P6R0lFI/vpu8kegLLu8ILTon76zKPXPhPSavCXfctyGcKBSkq
   e0yYP1X1NhBf9iWJPT9rNlSVFxawGecwiXb1qlUy2whLPtKeNTtuHmbWb
   V5l9TX9w6iCQ5zJiMoxgTav3C35NmLEnQoIuPe0dMyIwI4vOrEnayVbbH
   B97uMgn03jxrbfyAJorjfnKCKaZtNQpQLK/3JfLaXAK0gknhQBTCuHvk/
   A==;
X-CSE-ConnectionGUID: qvu2TkIsTby6dP+zrEh3DQ==
X-CSE-MsgGUID: UT5IMSR9Rk2A/67G9lhNxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90563416"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90563416"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:04:22 -0700
X-CSE-ConnectionGUID: YR79f9dTSi2hW8CeEJUDag==
X-CSE-MsgGUID: xr+Z/rNgS2yClAwIheWc2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="278539058"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:04:19 -0700
Date: Tue, 29 Sep 2026 01:04:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: pressure: add Sensirion SDP31 driver
Message-ID: <arrkYNNlD6_bCgiO@ashevche-desk.local>
References: <20260928215422.3720-1-m.abubakar365@yahoo.com>
 <20260928215422.3720-3-m.abubakar365@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928215422.3720-3-m.abubakar365@yahoo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 02:54:22AM +0500, Muhammad Abu Bakar wrote:
> Add an IIO driver for the Sensirion SDP3x family of differential pressure
> sensors (SDP31, SDP32 and SDP33). The devices are accessed over I2C and
> report differential pressure and temperature. Each measurement is
> validated using the sensor's CRC-8 checksum. The scale factor is read
> from the sensor at runtime, so all three parts are supported.
> 
> Tested on an SDP31 connected to a Raspberry Pi 4 I2C bus.

...

> +#include <linux/cleanup.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/once.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/unaligned.h>

Follow IWYU principle.
At least types.h, err.h or errno.h are absent.

...

> +static int sdp31_read_measurement(struct sdp31_data *data, s16 *pressure,
> +				  s16 *temp)
> +{
> +	u8 rx[6];
> +	int ret;
> +
> +	ret = sdp31_trigger_read(data, rx, sizeof(rx));
> +	if (ret)
> +		return ret;
> +
> +	if (sdp31_check_crc(&rx[0]) || sdp31_check_crc(&rx[3]))
> +		return -EIO;

> +	*pressure = (s16)get_unaligned_be16(&rx[0]);
> +	*temp = (s16)get_unaligned_be16(&rx[3]);

And casting is for...?

> +	return 0;
> +}

...

> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			*val = 1;
> +			*val2 = data->dp_scale * 1000;

KILO?

> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_TEMP:
> +			/* raw / 200 = degC, so raw * 5 = milli-degC */
> +			*val = 5;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}

-- 
With Best Regards,
Andy Shevchenko


