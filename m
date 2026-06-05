Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B73EEADA;
	Fri,  5 Jun 2026 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671544; cv=none; b=Ab5Bcfykop7yi1pw6O+ST+ZMm/LpcdRoM2WbSwTdixtONSxEHp9l5IPhr8uQqaSlMpMSngyOfemnh0r5+Jeqo4qxTPAhzPvk07Bc3qWV9ZhImerjv5xFQaPFdRIvc43xt9ZN/Mi4AaCz3vYIet8tUqFmNhjpSHpUGozzlFhscCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671544; c=relaxed/simple;
	bh=YtUWoF8b6w9hBx+0sbPAOY49NFqfABOcos5LLMOyEFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smIKbrtsNqSkl0B6dhq0wa2h/Ugqgd2Ga7IE+MT/2O0tKu5SdjpU4TyMEMYzCGFGcwgvk1ciZqdsdvakfvuVt6woTncP5vzEOiEKFkXoCq/5PE3OX2ETfMTimsN4xy7SGSWa6QLGlXcg/4IIb1eGADWJHGwwTqf2TA07ywLg5g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWpPZScw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWpPZScw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780671543; x=1812207543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YtUWoF8b6w9hBx+0sbPAOY49NFqfABOcos5LLMOyEFc=;
  b=cWpPZScwhvf24uJ1gANnSZh9dOGBf9VbBAio707ycWG96j/R7ZnEs22i
   jFOhLv1m507y/38w0VKgCJyc4tDFI70Jj9VCxLsYqME2syHtK/SOmj25U
   uiIfawJiGghQwNPosYtjcTb2gz+ly4AVy21QaoqZ++Y3QkWXhtKOI1rb+
   /0HOFCgEgLjVHYjJZrb8zMsUoRT6L2hOxFKHGVN6VBVqrh7rZzw5zBOXj
   76gaXpphF1ocTjqYikHJFY99ol9vdtVmuKjJejC/owNmY99qmhTAjOyNS
   rZus29Vqx0udWAzYT5vA3zGhYXzVbCFI3JBhacqdKXbKU/pFVQPe/CBQY
   w==;
X-CSE-ConnectionGUID: essLhdr5QdKZ22h3h6kvZA==
X-CSE-MsgGUID: hWb0Lt5+QYieNkBQCDnJuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81565791"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81565791"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 07:59:02 -0700
X-CSE-ConnectionGUID: tzVH5uAlRFKML/xZ0N061g==
X-CSE-MsgGUID: n9brUnkpQTqYX5ua5kVMZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="282944665"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 07:59:00 -0700
Date: Fri, 5 Jun 2026 17:58:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: linusw@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: read gyro samples via FIFO in
 IIO_CHAN_INFO_RAW
Message-ID: <aiLkMW_1yynJmGgu@ashevche-desk.local>
References: <cover.1780648724.git.github.com@herrie.org>
 <81c02804b9ae3bc194ef1da95f58da4c5e19b609.1780648724.git.github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81c02804b9ae3bc194ef1da95f58da4c5e19b609.1780648724.git.github.com@herrie.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 10:46:21AM +0200, Herman van Hazendonk wrote:
> The direct gyro register file (XOUT_H..ZOUT_L) returns stale data on
> at least the HP TouchPad (apq8060): X high byte is stuck at 0xFF and
> Z reads as 0x0000 even when the chip is otherwise sampling and the
> userspace i2c-dev path returns sensible values for the same chip from
> the same registers. Y reads correctly, suggesting the issue is in how
> the on-die register file responds to back-to-back two-byte reads at
> specific offsets after the reset / PLL settle that
> mpu3050_set_8khz_samplerate() performs immediately before the read.
> 
> The chip's on-chip FIFO does not have this hazard because the sample
> assembly is performed inside the chip and the host only reads a fully
> formed frame from FIFO_R.
> 
> Add a small mpu3050_fifo_read_one() helper that:
> 
>   - lowers DLPF/SMPLRT to ~250 Hz so exactly one fresh sample lands
>     in the FIFO during the wait loop (at the previously-set 8 kHz the
>     FIFO accumulates a sample every 125 us and races the FIFO_COUNT_H
>     / FIFO_R bulk reads, producing per-axis byte hazards even though
>     the oldest 6 bytes are nominally a clean frame);
>   - configures FIFO_EN for gyro X / Y / Z only (the FIFO-captured
>     TEMP slot occasionally returns stale data while gyro words are
>     still consistent; mpu3050_read_raw() reads TEMP_H/L directly
>     instead);
>   - resets the FIFO and enables FIFO read-out in a single
>     USR_CTRL write so the chip atomically resets the write pointer
>     with capture already on (two separate writes leave the FIFO in a
>     brief transient state where the first sample after re-enable can
>     land at a non-zero offset, producing per-byte-shifted frames in
>     the readback);
>   - waits for one 6-byte sample to land with a generous retry loop;
>   - reads one 6-byte X / Y / Z frame from FIFO_R;
>   - tears the FIFO capture down so subsequent buffered/triggered
>     reads aren't confused by stale FIFO_EN bits.
> 
> Route IIO_CHAN_INFO_RAW through this helper for IIO_ANGL_VEL. IIO_TEMP
> keeps its existing direct TEMP_H/L read because that register is not
> affected by the gyro register-file hazard, and the FIFO-captured TEMP
> slot occasionally diverges from the live register by several degrees.
> The triggered-buffer path (mpu3050_trigger_handler()) is unchanged
> and continues to manage the FIFO itself when the hardware interrupt
> trigger is active.
> 
> The chip is left at ~250 Hz when the helper returns; mpu3050->lpf and
> mpu3050->divisor are unchanged so the sysfs in_anglvel_sampling_-
> frequency value resolved via mpu3050_get_freq() keeps reporting the
> user-configured rate. The next caller of mpu3050_set_8khz_samplerate()
> (any subsequent IIO_CHAN_INFO_RAW read, or the buffered-mode enable
> path, or a companion runtime_resume fix sent as a separate patch)
> issues a full chip reset and reprograms the hardware from cached
> state.
> 
> Test results on the HP TouchPad with the chip lying flat, 15
> IIO_CHAN_INFO_RAW reads at 200 ms intervals:
> 
>   Before this patch (direct XOUT_H/YOUT_H/ZOUT_H reads):
>     X = 255             (high byte stuck at 0xFF, permanently)
>     Y = -99             (works)
>     Z = 0               (low/high bytes both 0x00, permanently)
> 
>   After this patch (FIFO read path):
>     X = -95..-156       (span 61, mean -127)
>     Y =  46..80         (span 34, mean  61)
>     Z = -15..23         (span 38, mean   3)
>     TEMP = -13440..-13552  (span 112, stable)
> 
> Steady-state per-read latency is ~89 ms, dominated by the existing
> mpu3050_set_8khz_samplerate() reset + msleep(50) before the FIFO
> helper.

AI assisted?

> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>

...

> +	int retries;

Why signed?

...

> +	/*
> +	 * Wait for at least one sample to land. At 250 Hz that's nominally
> +	 * 4 ms; the retry loop gives a generous margin so a stretched i2c
> +	 * clock or NEW sample-rate-change settle time doesn't trip the
> +	 * timeout.
> +	 */
> +	for (retries = 0; retries < 10; retries++) {
> +		usleep_range(2000, 4000);
> +		ret = regmap_bulk_read(mpu3050->map, MPU3050_FIFO_COUNT_H,
> +				       &raw_count, sizeof(raw_count));
> +		if (ret)
> +			goto disable;
> +		fifocnt = be16_to_cpu(raw_count);
> +		if (fifocnt >= MPU3050_FIFO_FRAME_BYTES)
> +			break;
> +	}

Can't you use a macro from iopoll.h?

> +	if (fifocnt < MPU3050_FIFO_FRAME_BYTES) {
> +		dev_dbg(mpu3050->dev, "FIFO timeout (%u bytes)\n", fifocnt);
> +		ret = -ETIMEDOUT;
> +		goto disable;
> +	}

...

> static int mpu3050_read_raw(struct iio_dev *indio_dev,

>  					"error reading temperature\n");
>  				goto out_read_raw_unlock;
>  			}
> -
>  			*val = (s16)be16_to_cpu(raw_val);
>  			ret = IIO_VAL_INT;
> -
>  			goto out_read_raw_unlock;

Stray changes.

...

>  				goto out_read_raw_unlock;
>  			}

> -

Stray blank removal again.

> -			*val = be16_to_cpu(raw_val);
> +			/*
> +			 * frame[0..2] = XOUT/YOUT/ZOUT in the order the chip
> +			 * packs gyro words into the FIFO. scan_index is 1..3
> +			 * for X/Y/Z so subtract one to land on the frame.
> +			 */
> +			*val = (s16)be16_to_cpu(frame[chan->scan_index - 1]);
>  			ret = IIO_VAL_INT;

> -

...and again.

>  			goto out_read_raw_unlock;

-- 
With Best Regards,
Andy Shevchenko


