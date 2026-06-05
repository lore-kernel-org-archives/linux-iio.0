Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83943FFF9C;
	Fri,  5 Jun 2026 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671710; cv=none; b=R58x56Y5Z52qKeaB/qizWLVZyybJzgMkVQVKdrMhSzcdgHasjR6zMaZZGXXAPHY23zmnJWBn9i2JPKkcCNNkvlktQ1xwQ5W9hpWneKf2Ql+dva3+m/USC5BNtwajBAw638KZxlWHjTgPH0tPCE9CPBgWfk6TtgHjodKrnCSfvZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671710; c=relaxed/simple;
	bh=YxuzlSh/VnNwv14rQUF1P2wVLgGgDexU/sLHpQJfJ5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+kG7/Bg5OLwg1akImaHRScAy2ztzwzJVuhwxVzgJBic2V81/Q1I/kjKwqOvtxpLKHVr2+5dnxJeHeEwUzeN6+ihgVv2zvw6+uDv1IrXNMq+OfJcv0baGfJTrCZ0aA43FTnrSn6fo8lyB0901zVDgsydFI1RfQFiCuvdCqh+j04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQ2RcQ6U; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQ2RcQ6U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780671709; x=1812207709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YxuzlSh/VnNwv14rQUF1P2wVLgGgDexU/sLHpQJfJ5U=;
  b=cQ2RcQ6U21CGXKbFQKYUTWUvWiPEjUWt36mT5s33sQWDlqgl+W1kP4lU
   dZSwaX3fLauLMrF6+QJoy4iDd2ePEEG9SN7NqD9p60fxW3yDdXZzbKdBC
   o6LxVHhD6JB/IVvjwDlO1GEBHDY0AX23TWFfJfjQ4Gj0WwF7LnOjQNNy/
   xRGLC//pacCSX5DZzZFr2DYVms6kkk9oYdwIqf5ei0X6sfMnAh4PjqucB
   IXQEMEqkuRCyKPRUQssrbaxHS0LBP8xzyoCY6stTmHToSXNcjmO9y1GOD
   qvKsjgkR6H9bG93L3BnSXtp4SEAOwKYii2ZReljnVjAm3LElJ/78Fba9z
   Q==;
X-CSE-ConnectionGUID: MwRC8xDoQYK2CDwzOilycA==
X-CSE-MsgGUID: oAss4ujCTC24LIjwyCu3VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81504594"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81504594"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:01:49 -0700
X-CSE-ConnectionGUID: PETfvNNATyCtwEjbUgTUSg==
X-CSE-MsgGUID: P+DsmMSnSIS6W00K3PfwZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="246691778"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:01:46 -0700
Date: Fri, 5 Jun 2026 18:01:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: linusw@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: restore cached sample rate on
 runtime resume
Message-ID: <aiLk14Q4raDZpBM1@ashevche-desk.local>
References: <4622fa440f1686e06d0828a6abdbda3181fa385b.1780649212.git.github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4622fa440f1686e06d0828a6abdbda3181fa385b.1780649212.git.github.com@herrie.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 10:47:22AM +0200, Herman van Hazendonk wrote:
> mpu3050_runtime_resume() only calls mpu3050_power_up(), which clears
> the SLEEP bit and waits 200 ms for the chip's register file to come
> back. It does not reprogram the full-scale, low-pass filter or sample
> rate divisor, all of which return to the chip's power-on defaults
> across a power cycle.
> 
> The driver's cached state (mpu3050->fullscale, mpu3050->lpf,
> mpu3050->divisor) is the source of truth for what userspace observes
> through the IIO ABI: in_anglvel_sampling_frequency goes through
> mpu3050_get_freq() which reads the cached lpf and divisor, and
> in_anglvel_scale similarly reads cached fullscale. After the first
> autosuspend cycle the chip's actual sample rate diverges from what
> sysfs reports, until the next IIO_CHAN_INFO_RAW read incidentally
> reprograms the chip via mpu3050_set_8khz_samplerate() and the cached
> state restoration paths in mpu3050_fifo_read_one().
> 
> That incidental restoration is only triggered by direct sysfs raw
> reads, not by buffered/triggered mode. A user who configures the
> sample rate, starts buffered capture and then leaves the device idle
> long enough to autosuspend will see chip-default-rate samples after
> resume rather than the configured rate.
> 
> Reprogram the chip from the cached state in mpu3050_runtime_resume()
> by calling mpu3050_start_sampling() after mpu3050_power_up() succeeds.
> On failure power the chip back down to keep regulator and pm_runtime
> reference counts in sync with the error path.

The commit message (at least) looks like AI assisted. Is it true?

...

> +	/*
> +	 * mpu3050_power_up() only clears the SLEEP bit; it leaves the
> +	 * full-scale, low-pass filter and sample rate divisor at the
> +	 * chip's power-on defaults. Restore them from the driver's
> +	 * cached state so the hardware matches what userspace observes
> +	 * via the IIO ABI (in_anglvel_sampling_frequency, in_anglvel_scale)
> +	 * across a suspend/resume cycle. Without this the chip continues
> +	 * to deliver samples at chip-default rate after the first
> +	 * autosuspend cycle, until the next IIO_CHAN_INFO_RAW read
> +	 * incidentally reprograms it.
> +	 */
> +	ret = mpu3050_start_sampling(mpu3050);
> +	if (ret) {
> +		dev_err(dev, "failed to restore sampling config on resume\n");
> +		mpu3050_power_down(mpu3050);
> +		return ret;
> +	}
> +
> +	return 0;

Can be

	if (ret) {
		dev_err(dev, "failed to restore sampling config on resume\n");
		mpu3050_power_down(mpu3050);
	}

	return ret;

-- 
With Best Regards,
Andy Shevchenko


