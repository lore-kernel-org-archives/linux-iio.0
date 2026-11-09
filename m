Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264268;
	b=oH04JHj43nfsVZQYRQqkCUWRqdxsKC5jsSHUakHNDWhONoeI1YYpROQDoyFSWKSRiGtR
	 r/55DfKVpmp8N5gK8oiKITMAaP0kN2QlqLsN2K4CWUDDeukPSSBhjBFoPiio6j38Oc+1A
	 N4k9sctyGdqGpaxFITqmW98ZEu0IMUMnEixUSq9tB2TTj5+lRpln0b5VLYpQb7UsXrbTA
	 +F63OjH5Axa+9e9bNJpCnS6nxExpJGNy00rExxwH+WPSQcwa7SI3OMbHjVpsJebOFnLkz
	 e1d3KxoaqaaohcS8iSGbQfFQJn4R7btDjm84E6Ic2Bam4WKXtY1Ivzpq8pxeuSaObWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264268;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=sW2OTlXXKR8dKl3QHSI6vhpdFVcaiQtobE/De/1t4MQ=;
	b=c94+Sb+cv9RodmO3KzXMB9iAZQ7W9nLBI/iNifjYxlKxcaKHxX6y6yr0V+YXRajaOtlR
	 XIOqNYectQjlcaQA0pCE7huF7txdxnAUdhVo0nmflIu4/dwoTYE/rUUsAlqnIrQy6iRjV
	 XQrg98Tko0jBDrgH2tNkDUIbYd3dcgTrV5UaxykQf6iJS1oto1hI6/b939R14qJ6etDFp
	 0TcDfrueW15cyBgCYgRUJY00BnnVnpINBWnanhuMxfd0I2TpBV/YEFBrHzRlW46J331W/
	 QcOgMi1fjn7RDz1wlXN+5tQzQYNXXEvG958Mv385luyHPPImHqchNtVZyvqHinuksDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SbkdXtyk;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0C7606A31C;
	Mon,  9 Nov 2026 22:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F0C7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SbkdXtyk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794264268; x=1825800268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EAUjAeXNL95mChqC6/84jUL0sSnQ+BJmmJ8PzdF0zvQ=;
  b=SbkdXtyk2zKAcu9PgBGrmMtlaq7/L3VL6fORRB0OlpVHSlalyUOB1ET1
   /8//puB40JB7BUM2Kn4fk+hhj6bGPUci5dPgtRgIq2U1WodyOSEN+aJWK
   yEdhvc2BADjiAqQqm4Ir81Kj7tisRHnqiWjASk8LAI8rMXpYEVL8jZH/h
   xJpMJyvmEHt5LN084Ciop8tmpoIZF7So+bpw0U44T9iSFYPwJ8scWz0gl
   qmWCHK2OZ9Rn4k+b4fPOjvRtdcA+2N4Tkv061RoWgXsS8Gkr8gstGo4gj
   BElgAecGM9Z2dcJMw4fVEUkVBr6Ccvpgde+9ijo77IRFI6mwMBNb0oSnh
   w==;
X-CSE-ConnectionGUID: /YhBnHLITLGcopfFxV6FHA==
X-CSE-MsgGUID: /TrdXwgjSry0nVMhq1OO/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2993819"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2993819"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:44:27 -0800
X-CSE-ConnectionGUID: FyfHAJkOQXu4b5KDXPQSZg==
X-CSE-MsgGUID: 1ZcJkbugRKOlBr+mcyMBRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7852337"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:44:26 -0800
Date: Tue, 10 Nov 2026 00:44:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mcp9600: Bound thresholds before
 scaling
Message-ID: <avJMxjqjpgDO-web@ashevche-desk.local>
References: <20261109093518.5418-1-zhujun2@cmss.chinamobile.com>
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
In-Reply-To: <20261109093518.5418-1-zhujun2@cmss.chinamobile.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 05:35:17PM +0800, Zhu Jun wrote:
> 
> mcp9600_write_thresh() multiplies the integer part by 1000000 before
> clamping to the supported temperature range. The multiplication can
> overflow int, so a request such as 3000 degrees can select the lower
> threshold instead of the upper threshold.
> 
> Clamp the integer part to the hot-junction range before scaling. Keep
> the existing final clamp for fractional values and the narrower cold-
> junction range.

...

> +		val = clamp_val(val, MCP9600_MIN_TEMP_HOT_JUNCTION_MICRO / 1000000,
> +				MCP9600_MAX_TEMP_HOT_JUNCTION_MICRO / 1000000);

Use MICRO from units.h (but be careful about sign.

>  		/* Scale value to include decimal part into calculations */
>  		s_val = (val < 0) ? ((val * 1000000) - val2) :
>  				    ((val * 1000000) + val2);

-- 
With Best Regards,
Andy Shevchenko


