Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD9501F4D;
	Mon, 28 Sep 2026 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632540; cv=none; b=GkMmJSa01sVbLTDxL5PMhm+hHeCCPtHodFuH7LavWbue2UcKKn5ABgt2skJ7vVNjN8+cpeUSagDTs0wpSAMKYj/MAUnI5q+X1sn4i1WGDc2nxGHcphSwz+a2XP8FODTgq6GdmFLaTGm/PMQ5R5P3nrXumBdgJtlUor1ZcRZWqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632540; c=relaxed/simple;
	bh=ABiUFVNS3iLTYKg7UWWl42akGSZK3ukr+x1NuURpY3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXS+5saRxMzy4z5xMx/DUZFvCPN4xJmu8cjmfRCqu5S4Sjg/qQkqw9WWeqlWuepahRNJkyGoSLXBYKa8hxDR0HQePVG1cPJxgWTO5EMf4bfmpqnK6zAKDA5sDAZFkprdaxri/yM53Rwrihyb6qNLJsGh+28H2BzuA2iEz3ziX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5T1GPD2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5T1GPD2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790632531; x=1822168531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ABiUFVNS3iLTYKg7UWWl42akGSZK3ukr+x1NuURpY3k=;
  b=G5T1GPD28QKds+FSehbcuRFcffF0UsgfZuN/TvSWjKitWc8HD+qq6RL3
   /l8mDPW3xmxp3TlDJdobnE9d3DQF++cbCLt+Zy44z2+6xawLWaMUQ3NYa
   039uNiWe0uzbTxkhQ7JTu/2MXHiNmH97G+exmaOuYUA7J0CseMj18FXwN
   ejG2j5Xa5GgjeeD+XBTAiytM5MOxPpLVDmDxdN6d0lIDUFnslrV6SRkah
   3jZ0WI0hmtdyVASk7PzzOjq2TUMzRh7gOwFsLh9JofrLhZFkDud1gvBIP
   QmOd7fl/iQ3gMgV82yBc6lyJfPeVlizfr/fpMyDL3086jc9wgsm8cApdE
   g==;
X-CSE-ConnectionGUID: 7hMe93HoQpidVElp8RH/rA==
X-CSE-MsgGUID: CFTDWmjASdiExnCoKPPDZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90109746"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90109746"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:55:27 -0700
X-CSE-ConnectionGUID: B9t824BjTC+QwXu6Ta2aMA==
X-CSE-MsgGUID: 1WOf1fgZQ8CAGwf8nNZP6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="313095544"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:55:25 -0700
Date: Tue, 29 Sep 2026 00:55:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/3] iio: pressure: dps310: read buffered samples from
 the hardware FIFO
Message-ID: <arriSm8L567yqOjV@ashevche-desk.local>
References: <20260928211127.641828-1-zoone.rupert@gmail.com>
 <20260928211127.641828-2-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928211127.641828-2-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 12:11:25AM +0300, Rupesh Majhi wrote:
> The DPS310 has a 32-entry FIFO shared by both measurements. Drain it from
> a work item and push what it held, so a buffered capture needs no
> trigger. Nothing in tree wires the interrupt pin, so the work rearms
> itself at half the time the FIFO takes to fill.
> 
> Entries carry one measurement each, so a pressure entry is compensated
> with the temperature ahead of it. Pressure read before the first
> temperature of a session is held until one arrives rather than dropped,
> so the first push can wait a temperature period.
> 
> FIFO entries are not timestamped, so postenable refuses the timestamp
> channel unless a trigger is attached.
> 
> Tested on a DPS310 on a BeagleBone Black.

...

> +#define DPS310_DRAIN_MAX_MS	(2 * MSEC_PER_SEC)

+ time.h

...

> +/* Returns which measurement the entry came from, or a negative error */
> +static int dps310_fifo_read_entry(struct dps310_data *data, s32 *value)
> +	__must_hold(&data->lock)

Hmm... Don't you want to also add lockdep annotations?

...

> +		if (kind[i] == DPS310_FIFO_TEMP) {
> +			data->fifo_temp_raw = raw[i];
> +			data->fifo_temp_valid = true;
> +
> +			if (!pressure_enabled) {
> +				if (!dps310_fifo_push_scan(data, raw[i], 0))
> +					pushed++;
> +				continue;
> +			}
> +
> +			pushed += dps310_fifo_push_held(data);
> +			continue;

You may deduplicate 'continue'.

> +		}

-- 
With Best Regards,
Andy Shevchenko


