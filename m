Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AAC3AD524;
	Wed, 12 Aug 2026 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522131; cv=none; b=kskmpgTQl9OtMQytCFbBBoKORejz8bWEL29Pwl+KPQefDNmZxoJhJYG1p76LwiFa/y839jjo56otptd6EcX2f1mKJk69c7SPQH/dWAa6vAZfJjHOgltHEGwir+Z5w1QpORllvaNI2e3+dbMqgIvMMtTyVA/GmAbPRYEG9l9OD8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522131; c=relaxed/simple;
	bh=uGHVplJ0RM+lfuLOlZrVgYVcyhc6dJcmyHmU+Fbjhso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm8bvL0+Xti5lXgDvXgK4kGShH7SGSqeod4MpKKemjnTFdT8s9EVWMjxR8ePObl50oWz5/3z00Iz58w2XC214dGLArI2KSpdaR4axqQiHNz1fSvOAknynfeE45aUcuc+YowTVqdmSCyJEec7hBy5HJkZs6hv0TZB1e9zO4cf3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXJ/szZf; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXJ/szZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786522130; x=1818058130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uGHVplJ0RM+lfuLOlZrVgYVcyhc6dJcmyHmU+Fbjhso=;
  b=EXJ/szZfl9A/MwMQX1+e406NFp+nvuQf9yrLKEJ4Sork2m5J446sF4iP
   zxSlxBGu8WYgoEMUfkzz1DztzVHJfP9MMlnikZS5494x9yCJNvgL6MrXg
   VWVvWGTMPCV9qPUE4KKXvE+6kmN6qplefi5z/8kXz0GwS4y+PHsKlr5wq
   8m7Yyzacc6stKPGJf3w75JxlJ2Fbb7JAoLhx3WJJcmCjpFtshG1nQgjyE
   v1IaOi3Lx579fz0VD905niZBxzxpHraXbF0WHmkyA8cDnzR0Lvi6FONyt
   LcuhZi8bTJbyo7hpKK0VMQ8JfL+yWJ+RpqfD0cPpLhY4Ze0g9hEEBZObP
   g==;
X-CSE-ConnectionGUID: XqMdu6/ZQPiry6mU09BTxQ==
X-CSE-MsgGUID: krPzjmNCR3KpdbpwTVcSJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86187119"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="86187119"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:08:49 -0700
X-CSE-ConnectionGUID: MPVVy7tIT/eLoHU+VCad1g==
X-CSE-MsgGUID: HYd7vTSoQOq3wxNzyEmNlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="301820113"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.92])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:08:46 -0700
Date: Wed, 12 Aug 2026 11:08:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shengzhuo Wei <me@cherr.cc>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: adxl367: reject out-of-range FIFO
 entry count
Message-ID: <anwqC4tczcdnmF1u@ashevche-desk.local>
References: <20260812-adxl-fifo-v2-0-86bea20faf1c@cherr.cc>
 <20260812-adxl-fifo-v2-2-86bea20faf1c@cherr.cc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-adxl-fifo-v2-2-86bea20faf1c@cherr.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 03:58:50PM +0800, Shengzhuo Wei wrote:
> The FIFO entry count reported by the device can be as large as 1023
> (the low byte plus the low two bits of the high byte), but fifo_buf[]
> only has room for ADXL367_FIFO_SIZE (512) entries.
> adxl367_push_fifo_data() passes the reported count straight to the FIFO
> read, so a count above ADXL367_FIFO_SIZE overflows fifo_buf, a heap
> out-of-bounds write of up to 1022 bytes into adjacent memory.
> 
> Rather than clamp the count and silently drop the excess, abort the
> read: a count beyond the FIFO size means the device is returning
> garbage, so the data cannot be trusted. The message is ratelimited
> because a stuck device can raise the IRQ repeatedly.

Aren't they already were discussed in linux-iio@ mailing list earlier?

...

> +		dev_err_ratelimited(st->dev,
> +				    "FIFO entry count %u exceeds FIFO size %lu\n",
> +				    fifo_entries,
> +				    (unsigned long)ADXL367_FIFO_SIZE);

In majority of the explicit castings when printing a message they are wrong or
unneeded. Use correct format specifiers to begin with.

-- 
With Best Regards,
Andy Shevchenko


