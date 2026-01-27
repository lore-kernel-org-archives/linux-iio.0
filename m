Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1227603A;
	Tue, 27 Jan 2026 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548885; cv=none; b=Mrr+yqkM3U2kcf6niwpdkpXzcbDqpffCwzA5wFzEd/YzzPu++RnObIs+HQ+RFxlqtUe3Ymjyy2FXa1Ag/K5ZL/0aLeVB9god95w3+KFGVkXLeCEjo2fMVYMD3YQt1TI2b2/anA6urt8n7tGMmkom15oe1BpuXbIa+5z23da9boQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548885; c=relaxed/simple;
	bh=WIudJyqYjgNb4UJwGIp5U4RhIK6L/d9A0RKcKfMRozU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPyWr9msikkRCU4wQcOZMDibvDonduTJDfETH3mLyBDCU/yn36KmOJgMgFb1X/NB/UEiy+ErLyLDKb+/Ta/BmXXD6gTHxQrF8F9sU/FW1nb1wR91TmSUtvGazHO+Px376Jx8IF2yDW3T4/P2UBOz1nR9lEMUePd5FYalbNt9Udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWkl/kcJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWkl/kcJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769548883; x=1801084883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WIudJyqYjgNb4UJwGIp5U4RhIK6L/d9A0RKcKfMRozU=;
  b=DWkl/kcJ0FJ4zUAu8ogWIva+SlUY4THogOyvb14cMCHYuJkGbcd4NzPc
   BNxzlIzBdSR16WqmdffqPi4D3P8HlhZcsujYDpVxcs7dafk0RKNUFJpS/
   YFZLYbUiYTtsz9rzC9DuNNepDW8vM+1DNbdErq5p6s2VeI7fewW4RZV+v
   S0W6kehGTfFwkf7YoD1nrkqi7R0ljrn4eMmeJv3cnwwK8F8cQd8f3JVVr
   aTHt74KyHPjL8b9H0kA6rKNbrC76BOGs8nJVuauY9FF2jv3ImCimlXqJ9
   VBdIT5RY5BUrfAblHkjyI7p6vRyDtv/XBixxJ+oBTrguW1QeJvpT1YZ1l
   w==;
X-CSE-ConnectionGUID: l5n5Ld/VRP6qj8/KQI1ucg==
X-CSE-MsgGUID: rhGS/U2mQMOIuM4V3ZtOMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81862461"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81862461"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 13:21:20 -0800
X-CSE-ConnectionGUID: HMEQzzcWShGBXCja4snHjg==
X-CSE-MsgGUID: GmKajvpYTHie1OxvVpU+Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207982170"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 13:21:16 -0800
Date: Tue, 27 Jan 2026 23:21:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 4/6] iio: amplifiers: ad8366: add device tree support
Message-ID: <aXksSjsyNn6if3eQ@smile.fi.intel.com>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
 <20260126-iio-ad8366-update-v2-4-c9a4d31aeb01@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-iio-ad8366-update-v2-4-c9a4d31aeb01@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 01:51:05PM +0000, Rodrigo Alencar via B4 Relay wrote:

> Add device-tree support by dropping the enum ID in favor of extended
> chip info table, containing:
> - gain_step, indicating with sign the start of the code range;
> - num_channels, to indicate the number IIO channels;
> - pack_code() function to describe how SPI buffer is populated;
> 
> With this, switch cases on the device type were dropped:
> - probe() function adjusted accordingly;
> - Simplified read_raw() and write_raw() callbacks;

> - mutex_lock()/mutex_unlock() replaced for guard(mutex)() to allow
>   moving to early returns;

Shouldn't this be in a separate change? I dunno. Let Jonathan to decide.

...

> +static size_t ad8366_pack_code(struct ad8366_state *st)
> +{
> +	u8 ch_a = bitrev8(st->ch[0] & 0x3F);
> +	u8 ch_b = bitrev8(st->ch[1] & 0x3F);

GENMASK() in both cases? But I don't see why ch_a needs this at all,
isn't the 2 LSBs are not used anyway?

Also missed header inclusion for this? And also perhaps sorting headers first
to see what's there and what needs to be updated (ideally another patch to move
to IWYU principle).

> +	st->data[0] = ch_b >> 4;
> +	st->data[1] = (ch_b << 4) | (ch_a >> 2);
> +	return 2;
> +}

...

>  static int ad8366_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val,
>  			   int *val2,
> -			   long m)
> +			   long mask)

Seems like unrelated change.

...

> -	/* Values in dB */

Do you think this comment is useless? To me looks like a stray change.

>  	if (val < 0)
>  		gain = (val * 1000) - (val2 / 1000);

...

> +	st->info = spi_get_device_match_data(spi);

> +	if (!st->info)
> +		return dev_err_probe(dev, -EINVAL, "Invalid device info\n");

Only useful for the developer, dead code in production.

-- 
With Best Regards,
Andy Shevchenko


