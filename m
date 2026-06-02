Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029FE3D45E9;
	Tue,  2 Jun 2026 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395009; cv=none; b=LMVDgG7NFiwLs3i+Iwhg8pr6Rcge34B4wAVqwsYc3opNw3xY+XHX0aMA7MQb5q332nKgrnYphv0DigEF3Dt/paXK7BE6XZQqbQCghJL1G5yAoMQbwUTqtV7e7KWpZGUJL3Akc+GJi+mq1Ka6Dw0cyXvr368gg2Xjjz4XfnkRUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395009; c=relaxed/simple;
	bh=PSupo4XG5wJE3VdT2NoXu7XsQnHKRm0bDvhLxERvChI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRSU7oN9fpswGytEmsN8ktBlmktvqyT8084AV/d/DyxAhLwctyxygOQY4GcvMNQOAtJd0K0f4XoTT+VObYxq/KlLWZg0/vWRrj4DWL04MNdwSHO6OUqfLLr1pvqYJeQ6TJLhuI0rSKYaZf9gLH8+Ap60rEWQdQnJuEiYC90mwtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eibFwWAM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eibFwWAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780395009; x=1811931009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PSupo4XG5wJE3VdT2NoXu7XsQnHKRm0bDvhLxERvChI=;
  b=eibFwWAMFs5iXsARM7qkpn4UwEgk4AAZ1eyt28hgkzbAn6pJ3X2kTtuC
   d/10U7vQg09MlB6XgJu7WFMPYK6FjhF4HOPkULYe8BLuTg0lg3jrt39VN
   v/DQfphNLwCnN5XUQD0WNXLPXmrLbJgLZOVJim2CRhC+872LToV7ncBB1
   FbOGvcYnsLL1lWmVaglCO9oqeUJmP5IIt3zzsXK7J/6oIb5MYDZ5K2ZZ8
   ZKny9fKrX//hNFqL5nmtV37bjY9hx+woPMw8h1PqeYPm0G5oFJ6Lyv/4S
   VfEfERj8VNSLuGauPK+1j1Hc1POx5bPIbGt/C0SaCXrj7KOwP1wgvt25t
   Q==;
X-CSE-ConnectionGUID: JfVxaPB9ThmqGht7/6oSYw==
X-CSE-MsgGUID: aJ+QmhT9Q5SxSSj4WSaUCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81076672"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81076672"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:10:08 -0700
X-CSE-ConnectionGUID: gdjoF3+US4CG7At2JRbilQ==
X-CSE-MsgGUID: aNhtmc3DT+OyjVVfYw9dIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="274129105"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:10:04 -0700
Date: Tue, 2 Jun 2026 13:10:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: light: veml6031x00: add support for
 triggered buffers
Message-ID: <ah6r-ZnAb_zIZfeY@ashevche-desk.local>
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-3-e64f7fdce38d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531-veml6031x00-v4-3-e64f7fdce38d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 31, 2026 at 09:58:23PM +0200, Javier Carrasco wrote:
> Add triggered buffer functionality for the two channels the device
> provides (ALS and IR).

...

> +static int veml6031x00_buffer_preenable(struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ret, it_usec;

Can it_usec be negative?

> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret)
> +		return ret;

Wouldn't be better to use respective ACQUIRE() macros from pm_runtime.h?

> +	ret = veml6031x00_get_it(data, &it_usec);
> +	if (ret < 0) {
> +		pm_runtime_put_autosuspend(data->dev);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Wait one integration period + 10% margin so the first triggered
> +	 * read does not race with the sensor completing its first conversion
> +	 * after power-on.
> +	 */
> +	fsleep(it_usec + (it_usec / 10));

fsleep() adds up to 25% of margin, wouldn't be that enough?

> +	return 0;
> +}

...

> +static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ch, ret, i = 0;

Make 'i' unsigned and split the assignment so it goes closer to the user, makes
maintenance easier.

> +	struct {
> +		__le16 chans[2];
> +		aligned_s64 timestamp;
> +	} scan = { };
> +
> +	if (test_bit(VEML6031X00_SCAN_ALS, iio->active_scan_mask) &&
> +	    test_bit(VEML6031X00_SCAN_IR, iio->active_scan_mask)) {

I hope everyone understands that this testing may be immediately false here
(without any additional protection added). Even more, the _ALS bit may be
cleared just before checking the _IR one.

> +		ret = regmap_bulk_read(data->regmap,
> +				       VEML6031X00_REG_ALS_L,
> +				       &scan.chans, sizeof(scan.chans));
> +		if (ret)
> +			goto done;
> +	} else {
> +		iio_for_each_active_channel(iio, ch) {
> +			ret = regmap_bulk_read(data->regmap,
> +					       iio->channels[ch].address,
> +					       &scan.chans[i++],
> +					       sizeof(*scan.chans));
> +			if (ret)
> +				goto done;
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_ts(iio, &scan, sizeof(scan), pf->timestamp);
> +
> +done:
> +	iio_trigger_notify_done(iio->trig);
> +
> +	return IRQ_HANDLED;
> +}

-- 
With Best Regards,
Andy Shevchenko


