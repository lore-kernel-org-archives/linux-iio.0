Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFE27874F;
	Thu, 18 Jun 2026 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781766560; cv=none; b=DP1HRutk2C6rYB7K0rSWy8BH5Gp0mGR388gmYRUut+uisQ+py0io/Wuy+srLsSMCVeOHgIU8aOTO5nOulNA8wjjkZI2oTaHTia6JqAsvf841pFq5QOjizkAwpw8hIndGMX/I1uVbgk36dNaxPS5c0HcEZn7nw+5/UrXECP3R3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781766560; c=relaxed/simple;
	bh=OYQevREwyP+F8RbnYpLnGihgHVkWXOVGf9P8HVkWqus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nv5VmrWM+7QLawmP0WecwHAAwsPmBbXL4354NcKjKDFHQ+jvFxJ66iobnvIFzJFyFHWkuFVt466ST6PHImS7NbcdBm4NfPZhkHaC00TEWJ2wjY5JTxPlNqi6+VizBfs41yXe/NmhwkhvjpY4QC5FDOB7SLkXTKGO1ywzeh+Z1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gL+UqVuu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gL+UqVuu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781766558; x=1813302558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OYQevREwyP+F8RbnYpLnGihgHVkWXOVGf9P8HVkWqus=;
  b=gL+UqVuuQI3NE7kQM97/3+HexP2bBpvzZ967P+LPrKjp7/cTGO30bS+9
   lu5OC0egUMw0TihIxkH/Yyo2kNaLOrsd+SyRUIAhLm9mc04YUAteHHFyr
   /kpzVMlnHRqwyv4uZf3MuiE238UD8g65Vro0gZAyW9Ty7xjBXMeqkB5lP
   GEQHN1JToZAvGWLr2ct0x/fTtvUx2TQ60z6pq842eXPGnyC05ZXsdQFFl
   uKsLnaGr/5j73IR+8/QbfKBalnwDs5d0dXCs8K8zh/297YnI9wtzi0oyT
   MesE21yzCyVrFg468VN9scQcrWLJTgoin48RXtDd7SkU1q0VV+pVUmY2Y
   Q==;
X-CSE-ConnectionGUID: AFX5752JR7SCXgd+HpmVHg==
X-CSE-MsgGUID: 8HrFrkIrSpugHko15mrAWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="86506874"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="86506874"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 00:09:18 -0700
X-CSE-ConnectionGUID: GHlmvmwIQX+HElh1E3DqJA==
X-CSE-MsgGUID: 6/39qH7KQxeYvbFRWPlwvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="243927010"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.10])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 00:09:14 -0700
Date: Thu, 18 Jun 2026 10:09:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <ajOZmLSyaZuoPcbI@ashevche-desk.local>
References: <20260617180147.3370346-1-salih.erim@amd.com>
 <20260617180147.3370346-5-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617180147.3370346-5-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 17, 2026 at 07:01:46PM +0100, Salih Erim wrote:
> Add threshold event support for temperature and supply voltage
> channels.
> 
> Temperature events:
>   - Rising threshold with configurable value on the device
>     temperature channel (current max across all satellites)
>   - Per-channel hysteresis as a millicelsius value
>   - Event direction is IIO_EV_DIR_RISING (hysteresis mode)
> 
> Supply voltage events:
>   - Rising/falling threshold per supply channel
>   - Per-channel alarm enable via alarm configuration registers
> 
> The hardware supports both window and hysteresis alarm modes for
> temperature. This driver uses hysteresis mode, where the upper
> threshold triggers the alarm and the lower threshold clears it
> (re-arm point). The hardware has a single ISR bit per temperature
> channel with no indication of which threshold was crossed, so
> hysteresis mode is the natural fit. The lower threshold register
> is computed internally as (upper - hysteresis).
> 
> Hysteresis is stored in the driver as a millicelsius value,
> initialized from the hardware registers at probe. Writing the
> rising threshold or hysteresis recomputes the lower register.
> ALARM_CONFIG is hard-coded to hysteresis mode during init.
> 
> The hardware also provides a separate over-temperature (OT)
> threshold, but it is not exposed through IIO as it serves as a
> hardware safety mechanism for platform shutdown. OT will be
> exposed through the thermal framework in a follow-up series.
> 
> The interrupt handler masks active threshold interrupts (which are
> level-sensitive) and schedules a delayed worker to poll for condition
> clear before unmasking. When no hardware IRQ is available, event
> specs are not attached and interrupt init is skipped, since the
> I2C regmap backend cannot be called from atomic context.
> 
> When disabling a supply channel alarm, the group interrupt remains
> active if any other channel in the same alarm group still has an
> alarm enabled.
> 
> A devm cleanup action masks all interrupts on driver unbind to
> prevent unhandled interrupt storms after the IRQ handler is freed.

A couple of nit-picks below, otherwise
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  #include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/interrupt.h>

+ limits.h // U16_MAX, et cetera

> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/overflow.h>
>  #include <linux/property.h>

...

> -static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int irq)
>  {
>  	unsigned int num_chan, num_static, idx, temp_chan_idx, volt_chan_idx;
> -	unsigned int num_supply, num_temp;
>  	struct iio_chan_spec *sysmon_channels;
> +	unsigned int num_supply, num_temp;

Stray change, and I would expect to see all num_* on one line, and
all *_idx on another.

	unsigned int num_chan, num_static, num_supply, num_temp;
	unsigned int idx, temp_chan_idx, volt_chan_idx;
	struct iio_chan_spec *sysmon_channels;

TL;DR:
in this patch the above should not be modified as the previous one should
provide already a nice structure.

>  	const char *label;
>  	u32 reg;
>  	int ret;

-- 
With Best Regards,
Andy Shevchenko


