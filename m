Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8AD285041;
	Tue, 25 Aug 2026 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650790; cv=none; b=d4RMVYUjtXlXwH5nRULGt78ulpXzl2ezvlrlwXe/9JvpGUJdlZvWo8cZ3ssUSE056DqqzYRFUpjKR76U0x8NiEe2hX4r9W6uH5CGAoOR1qpT58AIQgRB92e5wDKX0KATzGd7QMgsb9TbJxUsr83H43KOByPoEcmhnPjR7suzg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650790; c=relaxed/simple;
	bh=jTALHXbaVy0p1FEhe1lPDnisHS0A1/8mCTlcp9V8H68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElAL75Png8ISlvKuApNTB8LSqbgzNGducd3P1ynMWrnMjkrTOQn0wnRBSQd7K+H9OuGfgnFYtqaQ886k+bfIqsj7fJ2q+dThaxaA26JAwSlG8u5AvILWQBO3vwuGj1Ji5pfTvdhvok1VWXQVwShXwyv59DcdEd0qf1pci00JV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDBKe4C6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDBKe4C6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787650790; x=1819186790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jTALHXbaVy0p1FEhe1lPDnisHS0A1/8mCTlcp9V8H68=;
  b=EDBKe4C6lXj44A4jNF3N2xTKgseQN4ClOpEvM7vN3e6iszoV1F5i5BcI
   mVt27n4BadQYqObXVhZx34S//CzvOPfFO3cTo8j8sjvzYiJ4y2v0Sh+ok
   zklPhK/kfR9CmLEO4mEyHswfrzAtnbYPR3eWjjv0j2Y3qZFKJciFYvyhH
   PZ/cu3PPjtKFj2s+M2CIWjnKmh4eGkz6nuP0MUtkjnX9yWzbX0W/ff4yP
   Ub2mqUTUdXm3M8lS4Zt99lusDfEN3FhLxth2zBZCSqBYGD7PRe2GiqGn4
   c8PPWfaC5FZp1PgeMSJU3YRAluymFkFk19qrcFkEjQOlgLF+S3XCNOnGy
   A==;
X-CSE-ConnectionGUID: snB3r8wKSSqgHSBZHoeSLw==
X-CSE-MsgGUID: gsim5EF7R/aBySywJAB+GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98701598"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="98701598"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 02:39:49 -0700
X-CSE-ConnectionGUID: 5/NdtYmKQLGF2pKrrbqaEA==
X-CSE-MsgGUID: oNbNkVrTQxyYJ2KsCJSAxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="264615690"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 02:39:45 -0700
Date: Tue, 25 Aug 2026 12:39:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v6 5/6] iio: pressure: dps310: add hardware FIFO support
Message-ID: <ao1i3hKEpAgHLICz@ashevche-desk.local>
References: <20260824201203.396651-1-zoone.rupert@gmail.com>
 <20260824201203.396651-6-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824201203.396651-6-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 24, 2026 at 11:12:02PM +0300, Rupesh Majhi wrote:
> Use the 32 entry FIFO for buffered capture, so a reader wakes once per

When referring to the size, use dash: 32-entry

> batch of samples instead of once per sample.

> FIFO runs when no trigger is attached and stays off when one is.
> iio_verify_update() already picks the mode, so buffer setup ops just
> branch on iio_device_get_current_mode(), as rohm-bm1390.c does.
> 
> Drain is on a timer because there is no interrupt to use and nothing in

"Drain is on a timer..." --> What is this supposed to mean?

> tree wires the INT pin. hwfifo_flush_to_buffer is not enough on its own:

"The .hwfifo_flush_to_buffer()..."

> iio_buffer_read() sleeps until something is pushed, so a blocking reader
> would hang with samples still sitting in the FIFO. Hook is kept for
> poll() and non-blocking reads.
> 
> Pressure entries drive the scans and reuse last temperature, so the two
> configured rates stay independent. FIFO does not timestamp entries, they
> are estimated from the sample rate.

...

> +/*
> + * Bounds on the drain interval. The lower bound keeps a fast rate from
> + * flooding the workqueue; the upper bound keeps the FIFO from filling while
> + * nothing is looking at it.
> + */
> +#define DPS310_DRAIN_MIN_MS	20
> +#define DPS310_DRAIN_MAX_MS	2000

2 * MSEC_PER_SEC

> +
>  /* Make sure sleep time is <= 30ms for usleep_range */
>  #define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)

30 * USEC_PER_MSEC

...

> struct dps310_data {

Run `pahole` and check if there are gaps to fill. In such a case think if it
would make sense to shuffle a bit the added fields to make the structure more
compact.

>  	s32 pressure_raw;
>  	s32 temp_raw;
>  	bool timeout_recovery_failed;
> +
> +	/* FIFO capture state, used only while the hardware FIFO is enabled */
> +	struct iio_dev *iio;
> +	struct delayed_work fifo_work;
> +	unsigned int watermark;
> +	unsigned int drain_interval_ms;
> +	s64 fifo_timestamp;
> +	s32 fifo_temp_raw;
> +	bool fifo_temp_valid;
>  };

...

> +static int dps310_fifo_set_enable(struct dps310_data *data, bool enable)
> +	__must_hold(&data->lock)
> +{
> +	return regmap_write_bits(data->regmap, DPS310_CFG_REG, DPS310_FIFO_EN,
> +				 enable ? DPS310_FIFO_EN : 0);

_assign_bits()?

> +}

...

> +/*
> + * There is no interrupt wired on any in-tree platform and the binding has no
> + * interrupts property, so the FIFO is drained on a timer, at an interval below
> + * the time it takes to fill. See DPS310_FIFO_DEPTH for why late is bad.
> + */
> +static int dps310_fifo_interval(struct dps310_data *data, unsigned int *ms)
> +	__must_hold(&data->lock)
> +{
> +	bool pressure_enabled = test_bit(DPS310_SCAN_PRESSURE,
> +					 data->iio->active_scan_mask);
> +	unsigned int fill_ms, want_ms;
> +	int rc, prs_rate, tmp_rate;

Can _rate:s be negative?

> +	rc = dps310_get_pres_samp_freq(data, &prs_rate);
> +	if (rc)
> +		return rc;
> +
> +	rc = dps310_get_temp_samp_freq(data, &tmp_rate);
> +	if (rc)
> +		return rc;
> +
> +	/* Both streams share the same entries, so they fill it together. */
> +	fill_ms = MSEC_PER_SEC * DPS310_FIFO_DEPTH / (prs_rate + tmp_rate);
> +
> +	/*
> +	 * The DPS310 has no configurable hardware watermark, only a FIFO-full
> +	 * condition, so the watermark is taken as the number of scans the user
> +	 * is prepared to wait for and drives the drain interval instead. Scans
> +	 * come at the rate of whichever measurement drives them, which is not
> +	 * the pressure rate when only the temperature channel is enabled.
> +	 */
> +	want_ms = data->watermark * MSEC_PER_SEC /
> +		  (pressure_enabled ? prs_rate : tmp_rate);

With plain if-else this becomes more readable.

> +	*ms = clamp(min(want_ms, fill_ms / 2), DPS310_DRAIN_MIN_MS,
> +		    DPS310_DRAIN_MAX_MS);
> +
> +	return 0;
> +}

...

> +/*
> + * Read a single FIFO entry. Returns 1 if a sample was read, 0 once the FIFO is
> + * empty, or a negative error.
> + */
> +static int dps310_fifo_read_entry(struct dps310_data *data, s32 *value,
> +				  bool *is_pressure)

Instead of using this boolean, use return 1 or return 2.

> +	__must_hold(&data->lock)
> +{
> +	u8 val[3];
> +	s32 raw;
> +	int rc;
> +
> +	/*
> +	 * Every entry is read through the pressure registers regardless of
> +	 * which measurement produced it, with the type tagged in the LSB.
> +	 */
> +	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
> +	if (rc < 0)
> +		return rc;
> +
> +	raw = get_unaligned_be24(val);
> +	if (raw == DPS310_FIFO_EMPTY_VAL)
> +		return 0;
> +
> +	*is_pressure = raw & DPS310_FIFO_TAG_PRS;
> +	*value = sign_extend32(raw, 23);
> +
> +	return 1;
> +}

...

> +static int dps310_fifo_push_scan(struct dps310_data *data, s32 temp_raw,
> +				 s32 pressure_raw, s64 timestamp)
> +	__must_hold(&data->lock)
> +{
> +	struct iio_dev *iio = data->iio;
> +	struct dps310_scan scan = { };

> +	int i = 0;

Same comments as earlier in the series.

> +	int rc;
> +
> +	/*
> +	 * The compensation helpers read the cached raw values. Sysfs reads take
> +	 * the direct-mode claim, so they cannot be looking at these while a
> +	 * buffered capture is running.
> +	 */
> +	data->temp_raw = temp_raw;
> +	data->pressure_raw = pressure_raw;
> +
> +	if (test_bit(DPS310_SCAN_TEMP, iio->active_scan_mask)) {
> +		rc = dps310_calculate_temp(data, &scan.channels[i]);
> +		if (rc)
> +			return rc;
> +
> +		i++;
> +	}
> +
> +	if (test_bit(DPS310_SCAN_PRESSURE, iio->active_scan_mask)) {
> +		rc = dps310_calculate_pressure(data, &scan.channels[i]);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	iio_push_to_buffers_with_ts(iio, &scan, sizeof(scan), timestamp);
> +
> +	return 0;
> +}

...

I stopped here, I think you should understand what this code is all doing. Now
it's an AI mess. Split this patch to a few smaller ones each of them you understand.

-- 
With Best Regards,
Andy Shevchenko


