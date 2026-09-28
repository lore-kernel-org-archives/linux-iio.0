Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5E489FA2;
	Mon, 28 Sep 2026 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586558; cv=none; b=JtZ9dKCOJY7BR3Rkfe4YAtaQddwD2XSSN0J57nx0nO4U1piap712BLNFxWHKbiGZhJrQu++tAKAtvCxtZ5+or46o5ySJheZbtX5/IILk/0RlcUeLzG/3wtJW8e8dHNCCbBSEhwrx1ND9zemF3kaG1GUTUocwcZzK7PfNsa6bR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586558; c=relaxed/simple;
	bh=6ix0AEtuiczWjQ8vr+b5h0mjePvMaptADz08saX3fIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbLxRjv86yaMwEsKb/6v2j6xETWjoFgMOn77fxGFpGTG4JxhEuVtH1ku6wYd15JLS5ppch5JRoljpQ7nfP7I8dCqPjwmf6M4xI0wvedPExU+ZrUf+y5YfefDdLsv+0di63syiNXO5YxttG56HCIVvZmOYUHdRZPB3mSIIVLEqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvrjjHeF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvrjjHeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586557; x=1822122557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ix0AEtuiczWjQ8vr+b5h0mjePvMaptADz08saX3fIA=;
  b=dvrjjHeF3LzEptRMxNYNJ1+qvUoTGwRqTEt6QH1XwOuHoAB26bJFcnjg
   mcHYvIF30ev/GmvQOaC5CDY0q06Rj/fd38EipMcYIGtmHGryYgEGgtZ3d
   rCWgx4dRPd4Ci9cUjZPCfHejQi4V+cLlHrn8TLNOopGUJyCn8tFREErOd
   V0AJ70Tf7xYAg4mbsBqROfxgYK5CGPOfbIvPhweBDZNJU/EBAztWAt95a
   6QpWIXquX/uyF4606/GXFaWjkzHcN+GrTl7Z5l5qpa1325y/2AMe38ScR
   IyQhmFvXkuIkquWUJAE/SoMTFNwRtqoJQ/vRwaFe/esjHprq2cVawsMSo
   w==;
X-CSE-ConnectionGUID: jwqO+VIETPeDMZbtf4OGQw==
X-CSE-MsgGUID: RlWbXGxWRJeZVn3KTd3Imw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="94161618"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="94161618"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:09:16 -0700
X-CSE-ConnectionGUID: A7fRBLXHQ56hB3X0MuF15w==
X-CSE-MsgGUID: a/vblZQXSzaUIpqcYpxYpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="274539930"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:09:14 -0700
Date: Mon, 28 Sep 2026 12:09:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jared Wuerzburger <jwuerz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Dionne-Riel <samuel@dionne-riel.com>
Subject: Re: [PATCH v3 1/2] iio: imu: st_lsm6dsx: Drop trailing comma in ACPI
 match table entries
Message-ID: <aroutl04Q99mqJor@ashevche-desk.local>
References: <20260927220559.24169-1-jwuerz@gmail.com>
 <20260927220559.24169-2-jwuerz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927220559.24169-2-jwuerz@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 27, 2026 at 05:05:58PM -0500, Jared Wuerzburger wrote:
> The trailing comma after the last member of an initializer is only
> useful when more members may follow, which is never the case for an
> acpi_device_id entry. Drop it, as suggested during review of an earlier
> version of the next patch.

> Link: https://lore.kernel.org/linux-iio/aVFmec8JA6ZX18il@smile.fi.intel.com/
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Assisted-by: Claude:claude-opus-5-5

Assisted-by: LLM

> Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>

...

>  static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
> -	{ "SMO8B30", ST_LSM6DS3TRC_ID, },
> -	{ "SMOCF00", ST_LSM6DSO_ID, },
> +	{ "SMO8B30", ST_LSM6DS3TRC_ID },
> +	{ "SMOCF00", ST_LSM6DSO_ID },
>  	{ }
>  };

Thanks, but while at it, also switch to C99 initialisers to avoid an additional
churn (there is ongoing activity to switch all ID tables to use C99 initialisers).

-- 
With Best Regards,
Andy Shevchenko


