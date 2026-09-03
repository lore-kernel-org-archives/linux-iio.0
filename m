Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3A38B14D;
	Thu,  3 Sep 2026 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422620; cv=none; b=KdZloWo+9oiN7wDKa8e7ZInW61lNAg2sb9+kblcseFaB26NkR/CNq5mCIIT3KdGAn8iUBMtx7fTXEvjho/5e4BbgpJ0FjTUIWUJO+RXcJ1aFG4fRzQWJierD56B4NLhxMn8HKuNAh1NpYAw4cM9FeT3C1Rq9DoBjhJyJIch2zOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422620; c=relaxed/simple;
	bh=+3ha8HdrqXKzXkERTTZdhY8zvQoWjuT6TU1RocTDtDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3v95BBHKp8+0+xk0Rl6m4tbt1PCJTavhGmnvR9ym1nPb0vtDs1KefZoG2PbJ8GaBsy4eFeRNSzroodnWM5SiogsI3iX5xTVadoVK/J4sBXcCobghd62U8D7CYFuV7C/a0IHylpDspZ/Q2fE+VGjwmHh+B/Gi7GZF1wHgS/xwhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLH2x0aY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLH2x0aY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788422618; x=1819958618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+3ha8HdrqXKzXkERTTZdhY8zvQoWjuT6TU1RocTDtDg=;
  b=gLH2x0aYdhpNZ1nNXkt6jXjAuehz3skETsVnpZFySEzQZQEX+tzJUk/Q
   Vy+AA1BGICHBBVm2khVNxecuCZWko0PS07BVrLLkOfM6VH+gtFrrlZ36X
   AR+BScLeN5nisRXZtMSAwnqxrzWtJsVl0EpBrfyuKzgm9OSNRNrppPT8I
   2YegYWzWseCiiBEH6Mc4wpyumx0izzCJzYYxdaqe0NncUTAGxsDJK7xiq
   F+nSiBD9T9/FojWwXpmEU/u4huyEH4ViUYGR5z+GM1Ccgw8mmcoP/MBit
   LoK8TIIzkYdEWUsJTAX1GWP0VPA3+4FLtQ/OavhtyrXtRwbZzSxi/lsue
   A==;
X-CSE-ConnectionGUID: 9IMXfopFRHC/rVdoFDQN+g==
X-CSE-MsgGUID: gh19/pa3Qs2yV1vmkh/7vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88772178"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88772178"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:03:37 -0700
X-CSE-ConnectionGUID: NQSkWHunSVGkIG8k/EhuaA==
X-CSE-MsgGUID: t16Ev3jBSA2lqYrbgFibtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273147814"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:03:34 -0700
Date: Thu, 3 Sep 2026 11:03:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH v3 4/5] iio: light: vcnl4000: Add IRQ disable callback on
 cleanup
Message-ID: <apkp1SdLzs_zZ6jB@ashevche-desk.local>
References: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
 <20260903-vcnl4000-v3-4-5e69c2e715a8@jacques.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-vcnl4000-v3-4-5e69c2e715a8@jacques.com.au>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 02:53:49PM +1000, Tsz Shan Chan wrote:
> During driver unbind, devm cleans up resources in LIFO order. The IRQ
> handler is freed before the device is powered down. This can lead to
> unhandled interrupts.
> 
> Register a devm action to disable interrupt explicitly after
> devm_request_threaded_irq(), so that the interrupt is disabled before
> the IRQ handler is freed. This prevents any unhandled interrupts.
> 
> Add a disable_irq callback to chip info structure. This allows each chip
> type to implement its own disable sequence.

...

> +static int vcnl4010_disable_irq(struct vcnl4000_data *data)
> +{
> +	int ret;
> +
> +	guard(mutex)(&data->vcnl4000_lock);
> +
> +	ret = vcnl4010_stop(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
> +	if (ret < 0)
> +		return ret;

> +	ret &= VCNL4010_INT_THR | VCNL4010_INT_DRDY;
> +	if (!ret)
> +		return 0;
> +
> +	return i2c_smbus_write_byte_data(data->client, VCNL4010_ISR, ret);

Since ret is in use it's better to follow regular pattern

	ret &= VCNL4010_INT_THR | VCNL4010_INT_DRDY;
	if (ret)
		return i2c_smbus_write_byte_data(data->client, VCNL4010_ISR, ret);

	return 0;

BUT, since ret doesn't care an error code at this point, it's even better to
use proper typing.

	u8 byte;
	...

	byte = ret & (VCNL4010_INT_THR | VCNL4010_INT_DRDY);
	if (!byte)
		return 0;

	return i2c_smbus_write_byte_data(data->client, VCNL4010_ISR, byte);

> +}

-- 
With Best Regards,
Andy Shevchenko


