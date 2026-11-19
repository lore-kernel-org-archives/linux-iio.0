Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116811;
	b=0G1y14fyHh0/5eFf4SoI2jqQJLQ3k1JMILXnBBZU77rImWixVXZVPsYTfXbMGc/1vw0p
	 M2izQmi8scWnOcQpOf3itrK7B5k39c0R/loLu33wGwsTuJkQc+Y3BSlEuy5aicGS/q3d3
	 WGilvkC7AiWoV4CCvftkN6tZUqDDaK0IqdlQIQwpT+2nK7/+a61XsDYjQPyGJuRUcYTN3
	 CT5K10oITzU2T5FwKI+1nxvVNrBg1zbHmUGTBVJU+JhQA26o8cdaa9gNlX/bZM7Sf4PPJ
	 iuI6onO5mYhbt/QETfGdT4IGvXGMmTszV28ZluWsgp6jRWk4mNvGKQDmo58ajbeTo3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116811;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=1EL9YQB9efPuRHId8JnfmWzy3x8RsPbX1IKGgECbaA0=;
	b=eLHS+JabDZfCqm+cvCric3nWaYWS02MNBz7AOX/J0datsfMrEu47xiHCpDBblzpXQIQW
	 l2eJFdMaXCu1gGCbZHBqhX92Cm10/O5xH0tJrIHgxEMemQYB2jibsDl4kTaw+48JE1Kj/
	 QTZuj7pQA44+WRFDsHX5bCvKYIDl98WKKx2VFgb1QieslhjFOAKcs8uP5Ir1r2izyZKXT
	 cxOsBn8DdmVKolMnvasnKwpW9ubLo4oVpXoCpIro0He1EVdYUWol2xIMo62ryXuaoaMR2
	 9ydIcWv7yzkGf0dDcmnfu6ELO75Z7kwjm8FD6088hL4eWizeU1q3UhPdqYyg9cCwzzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ZK3SZVO/";
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D10606A326;
	Thu, 19 Nov 2026 19:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99D10606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZK3SZVO/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795116811; x=1826652811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bdTEokAD3JcME9ieegFeUH1z2YJ0LruEhgCbp1EEbS4=;
  b=ZK3SZVO/nUXIf/LA1e4XbNtMeotlTP3OKO8JAk5QzPxfv/EZgbL/1V74
   juqGIPSS11tHOeZHi3HHtzuKvb+ZqAuAy6u0Nbbh0kq25n16z/mWPiSSm
   po59XqbSgcDJGPgoaEvypAS1GiBgd0OVyOzEpN7mxxv6olaHoLB/9YDU0
   W3rLKdaPATAuEt9/Sebp8ppsMPsdhINjJfT91+wwwH3mzQtBenkmQhTfg
   vXnpL2hDi3NoTxmfYCgPkCwjWV5TRCZgBMg85wA/eZQAkGo1ci9LA5ua1
   V0fckC3hWoqknVFMU3jul9GOE0VfqbI0Gq3d5Zf1fzr2xgRd9j9Acxp6Y
   g==;
X-CSE-ConnectionGUID: eCm2O/O/T0OGBzPPIZ1ctg==
X-CSE-MsgGUID: LkB5HigLR1OvmzRfTBuvmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3877996"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3877996"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 11:33:30 -0800
X-CSE-ConnectionGUID: fTaIjd7aRtqRPe7Z9Hs4rQ==
X-CSE-MsgGUID: fDodAi7FQwiRU1u5TPCDGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10802271"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 11:33:27 -0800
Date: Thu, 19 Nov 2026 21:33:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH] iio: pressure: dps310: read the first temperature in
 probe
Message-ID: <av9PBU_CNlBms2by@ashevche-desk.local>
References: <20261119190827.36947-1-zoone.rupert@gmail.com>
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
In-Reply-To: <20261119190827.36947-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 09:08:27PM +0200, Rupesh Majhi wrote:
> The first temperature read is in dps310_fifo_interval() instead of
> probe. That function is called with data->lock held and takes it
> again, so enabling the buffer without a trigger deadlocks.
> 
> Move the read to probe.

...

> +	/* Pressure compensation needs a temperature from the start */
> +	scoped_guard(mutex, &data->lock)
> +		rc = dps310_read_temp_raw_locked(data);
> +	if (rc)
> +		return rc;

While at it, making branch in scope

	scoped_guard(mutex, &data->lock) {
		rc = dps310_read_temp_raw_locked(data);
		if (rc)
			return rc;
	}

helps to avoid potential issues later on.

-- 
With Best Regards,
Andy Shevchenko


