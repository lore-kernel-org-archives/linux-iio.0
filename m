Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595216;
	b=BrUNshKhd7o2rLUcZb3cersAtzXIFXivk/krky2njrR1eGBeeVsuJ3T5jfWqE8HRwPsG
	 IpvKxvpFvkwuxbmUlW7NWtE4KegQFm6KiiQGs6oW6HvVWSSNHumt9D4FMVlA+WWBs2qsh
	 cvqEzB3kjSPhEA/Kz7R9ynaKdgoCShQSUJNVmLFsDSmvN2UkqqWegrtGQNuCQAK5bKmcb
	 CxN86mtDYDr+Bct7JTifgF6A2OWeJZVgsE3XrIEC5VPIcnDocw9LRwWsb2jxz2bJMN48W
	 y2RJvjQyHzPzh7llC5B9zCqh7YuEFMfzi2y3qLs8CkPYHIwoM6vSUJiX1LrMZUawGyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595216;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jIAh43IOLV0xvXg2nADBjKECV1gFB1vvfMqiMKoAItY=;
	b=ucrywuRQnOFLtxczLlEgndSalMy6x51807jo3vr9icF/RBUvAepjDuS4lUxxvEPHVaj8
	 kMVhF1I8zGbyZy2aG7HfG3bl9uGMO9kPXoi0vFkZK8XKm7SjGeeP3VZLpUgi/oDv4zHDD
	 VRLcX7bV5LXK/FhJRCOb7OuAiPp0661rXXU1LYusWq+eQHWBaay0nTuXMUVSlwCjHP5mI
	 ZtV99JEcG4sj+MPCmzW9PUjFOUdDxxCWwMhlGoqwb1DbNqDYQZf5VxixnO+PSOlaJH+bm
	 W+3Yse+PuJzaJQoNcNqUtQHmNt4lXsHHcjHSyH6JErC2L6zEY6wlztSH91gAfaUmlZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AKj32HPb;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6B606A31A;
	Wed, 21 Oct 2026 15:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8B6B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AKj32HPb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792595217; x=1824131217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lXuCJJ+UReprAQLjjbNsA4fxfCgtC4uNbnMiE6WjgHg=;
  b=AKj32HPbToK+GCaK2IiZiH53HaeKTcArRE4UvXmRGeejAvaQoEBBZfJI
   jsIo+ot8xmFmPZR5KslyZDwHcJBNfZVyo59uyGYxacphK/+CQOvyQ/vz8
   ydisEOtsGezh3V+dZ8+blXz2XKcDhb2IwR1ypJ2e5rJgrWXNY9i56kTuR
   AylGqe73ZcSD6qYpbREsjkebAQsS03z+8wJmZNvqURiR3SdA9MPvNrerh
   6ilCVVUcKRzEr/M6km3HFRXEPhBN4EokEP+f10VMN6Pk8G2uy63NRGM3y
   5bn4O9JoBemi+bMnNGzALbB3hdTA4pVRXyU0zkVBt7vuJTwGOQB4yKcWh
   g==;
X-CSE-ConnectionGUID: 7WPZYhUuSzOBq7CiKGk2CQ==
X-CSE-MsgGUID: lX7LQ4nsRG+Q3Lvgz0Yh3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1303390"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1303390"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:06:56 -0700
X-CSE-ConnectionGUID: MRg1WDyISu6XGhF61//vog==
X-CSE-MsgGUID: EsGAWDFPSbi7nqlxq0YY1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3583603"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:06:52 -0700
Date: Wed, 21 Oct 2026 18:06:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux@analog.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	Michael.Hennerich@analog.com, nuno.sa@analog.com, jic23@kernel.org,
	dlechner@baylibre.com
Subject: Re: [PATCH v4 4/9] spi: restrict CS logical values to a contiguous
 sequence
Message-ID: <atjVCVNzq3j34hjv@ashevche-desk.local>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
 <dd50e45bff4b59ad656f94fffecca28a49f1d2d3.1792435248.git.Jonathan.Santos@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd50e45bff4b59ad656f94fffecca28a49f1d2d3.1792435248.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 10:57:28PM -0300, Jonathan Santos wrote:
> When a device uses more than one chip select, require the logical CS
> numbers to be consecutive (for example 2, 3, 4). If they aren't,
> __spi_add_device() now fails with -EINVAL and logs which CS breaks
> the sequence.

...

> ---
> Changes in v4:
> * New patch, suggested by Andy. I assume this might have impacts on
>   existing users. Should we make something else to complement this?

But do we have any sparse chipselect lists anywhere (in DT?)?

> +	/* Restrict CS logical values to a contiguous sequence */
> +	for (idx = 1; idx < spi->num_chipselect; idx++) {

		... prev = spi_get_chipselect(spi, idx);
		... curr = spi_get_chipselect(spi, idx - 1);

> +		if (spi_get_chipselect(spi, idx) != spi_get_chipselect(spi, idx - 1) + 1) {
> +			dev_err(dev, "cs%d is not consecutive with cs%d\n",
> +				spi_get_chipselect(spi, idx),
> +				spi_get_chipselect(spi, idx - 1));

		if (curr != prev + 1) {
			dev_err(dev, "cs%d is not consecutive with cs%d\n", curr, prev);

> +			return -EINVAL;
> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko


