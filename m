Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C703E8663;
	Mon, 27 Apr 2026 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312975; cv=none; b=cY+Fbo+OkSckufvHv8/rOF4uWCd0E0gCSfkxSc+e1e16Z4p4mHcLCsypo6oN1EFTPISBJ/iWvMYbuKv6LumYmb6WRDzIcG0jt4DEZ3dbWAfqCoDWUjIZEdu0qPMZuRjLQFvvCMCeEBUsgVzgST4NgsTHLRiK2e4J16SMNRyDnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312975; c=relaxed/simple;
	bh=hi/QzVAPM7clbotfVnp4py1X23YCleiyC+4vscdKTBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGavMLTmMj1t8L3s9rIkm25YGptThN6jE8ggD97Ob6k93fR/11Pjk5siUQIagiDBJRu9K8ZlTyadlQVroEWmRg4sAON9udKJiJpbvzCtFmglfkwOAUV+mX7EJ5L5pa1+g5f4LsHn6D+dbdKfo4TN0gwrX8qWYGn6Wj4mrO1uQzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0qWs3Rj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0qWs3Rj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777312974; x=1808848974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hi/QzVAPM7clbotfVnp4py1X23YCleiyC+4vscdKTBA=;
  b=J0qWs3RjZlCFgHT28zc3vJbq1vmiQH8iddPSIe5PEuovKyf9jihTFz/w
   jNTJn9apQW7hHi2Dl/HABjmr5hBBssgQ09tfVcKb1UbhWnrXwUJOJRuir
   EOWDkNyQc2iwiIZN+LWlpC3unpcqP7d8/+pTczIJsPQa1/x4OVb1wikJS
   h7ZVPG1mcMlIp/cWq4X0msJ+5XzC4oMGwT//MdrFVRw/rlMy64oVkmDRN
   RvgjqZKie6sLkF+kkLHjHkjKgRiKpd2hXBDkrr0/Mo5igsoezdLt4pWsx
   8zI5hHYI7cthoURYPu4UGUZyZCuFsQsLeNC8KdhGM3gUbtHDqXHTU2LWl
   g==;
X-CSE-ConnectionGUID: R1Gq/QGNTb+27aAP4OgN/Q==
X-CSE-MsgGUID: GpA7OM9US2qU6ox6RUPT1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78089343"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78089343"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:02:53 -0700
X-CSE-ConnectionGUID: NvMPl20nTWCnyqf50c7WeQ==
X-CSE-MsgGUID: BQkpH6WETHiF+2lY5THp+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="264114442"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:02:49 -0700
Date: Mon, 27 Apr 2026 21:02:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 04/11] iio: dac: ad5686: fix powerdown control on
 dual-channel devices
Message-ID: <ae-kx3Igcj5mpEYc@ashevche-desk.local>
References: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
 <20260427-ad5686-fixes-v2-4-188e05199368@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-ad5686-fixes-v2-4-188e05199368@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 12:30:11PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Fix powerdown control by using a proper bit shift for the powerdown mask
> values. During initialization, powerdown bits are initialized so that
> unused bits are set to 1 and the correct bit shift is used. Dual-channel
> devices use one-hot encoding in the address and that reflects on the
> position of the powerdown bits, which are not channel-index based
> for that case. Quad-channel devices also use one-hot encoding for the
> channel address but the result of log2(address) coincides with the channel
> index value. The issue was introduced when first adding support for
> dual-channel devices, which overlooked powerdown control differences.

...

> +static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
> +{
> +	if (chan->channel == chan->address)
> +		return chan->channel * 2;
> +
> +	/* one-hot encoding is used in dual/quad channel devices */
> +	return __ffs(chan->address) * 2;

If channel->address guaranteed never be 0? This is UB otherwise.

> +}

...

> +	st->pwr_down_mode &= ~(0x3 << shift);
> +	st->pwr_down_mode |= ((mode + 1) << shift);

Now too many parentheses. Also do you guarantee that mode won't ever saturate
the bits outside of the given mask?

...

> +	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (0x3 << shift)));

At some point (I understand that this is a fix and probably we want to be less
intrusive) I think we want to see that 0x3 magic being defined and reused. This
GENMASK(1, 0) << shift seems an idiom that may deserve it's own macro / helper
function.

...

> +	st->pwr_down_mode = ~0U;
> +	st->pwr_down_mask = ~0U;
> +	for (i = 0; i < st->chip_info->num_channels; i++) {
> +		shift = ad5686_pd_mask_shift(&st->chip_info->channels[i]);
> +		st->pwr_down_mask &= ~(0x3 << shift); /* powered up state */
> +		st->pwr_down_mode &= ~(0x3 << shift);

> +		st->pwr_down_mode |= (0x01 << shift);

Too many parentheses.

> +	}

-- 
With Best Regards,
Andy Shevchenko


