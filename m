Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793457705;
	b=Eigc4pGxSYX6binmvrLhOc56Rrv4hxOWmNDHgsTfsPc+7rKf95WIcbar7dJZXvS4o29w
	 YEw2Bylk1wAlgWCw71ezR6vL4tphg46JutwNkt1wInXjuSKfrE816ksbvjN/i689qccd8
	 8UeFvkvHtWRMeg3uXgXk/MlyHnsJavhKtE9QuWEpcTb/8pMIYyq4EZ6qiqhgzwEw8tj0g
	 IY40/RADsls5vMReznngjaM07to8VDBHffao2VOtTnwDRqx+qa99QpO666aOwTRl3Vofs
	 bYMJDDInDjHU8LQPxYNVpVF7wWnyD9/peltlvWun7f0/8vv01VoxifoEprLjzJ1y28Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793457705;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=qMiezCVPRvfmEAcVXWIKedu9PC/DGE1ePhNgy9uq5x0=;
	b=BDfWvfn46R6TI7EiafU1uSktD0bPhcj+ftjD76YYop1+sr2KL3D6g9FVzoBQvuChZ44s
	 yGVzgZ9UYp6+wWBvqNIkigGII+9xONk7w/JlNsvbyqPjexmaYoE8FMKP+cpXASxf8oJ2d
	 U0yOnrVgDZ7W13RQXmVYukIYTlJHbj9wIssXsC0qcyvnaIsK93rgfwYgxLp30SnnJI28I
	 QgPJBN3QA9ccrvKwFQhykaXn4kvHD28VprBonFNtHftWD7Oy59YVsyNqLGm4AfHh3DBjK
	 d7phBPBT8QMsotqQtLyQs/ALVHK8XI2W6eAfmIXkvSKu3y6lSXOipnTrRquOsv1gIRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nJS4ZTDL;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D58F606A31C;
	Sat, 31 Oct 2026 14:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D58F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nJS4ZTDL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793457704; x=1824993704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xFSfPWA9RT3drrfXpaWPsgnK3xaYD29USKn5rSBjZpc=;
  b=nJS4ZTDLIKFnRH9fi8UVN7WYrwgCEQSE3DxEx342bSOO4EX3UhT3tl3u
   NjQgTAphNU2go838hXagp8VFvWU7RS76s7cAw0o1UaDBAkNW3B3pLoiwt
   8YUE2F2Npx+VQmnrjAfAk90rdmKCbgWvYBGMmGaLEK/eITutJ56wHeAF1
   fSSrfrp15odArEFwitKbU3ALS6kCLQIvK7HdKzcxoKvXTk1j9abj+NNTd
   vOZJe5BSA1LTylPPPL88ccgvWR30ByTggNzz5kDvKPmPwYi4/J0mBHp9o
   5SqdzXH5ikf5dCEZfCWVBFQhHdveNnSeXE25I3F0W6/GkihBowBr4uL4e
   w==;
X-CSE-ConnectionGUID: LH/WTP9FSNazEzA4xLy/oQ==
X-CSE-MsgGUID: ++fdntvSQEGauVDCfixI3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2093748"
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="2093748"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 07:41:43 -0700
X-CSE-ConnectionGUID: OTKt/FKUT2q7bd+ZmrxpQw==
X-CSE-MsgGUID: 7bxzTIlcSPmVUBRBmPd5gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="7478984"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 07:41:41 -0700
Date: Sat, 31 Oct 2026 16:41:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v5] iio: adc: pac1934: validate ACPI _DSM return type and
 bounds
Message-ID: <auX-InQPSh_vTNoH@ashevche-desk.local>
References: <20261030123528.606107-1-tristmd@gmail.com>
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
In-Reply-To: <20261030123528.606107-1-tristmd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 30, 2026 at 12:35:28PM +0000, Tristan Madani wrote:

> pac1934_acpi_parse_channel_config() calls acpi_evaluate_dsm() four
> times to read channel configuration but does not validate the returned
> object type or array bounds:
> 
>   1. No check that the returned object is ACPI_TYPE_PACKAGE.  If
>      firmware returns a different type, accessing rez->package.count
>      and rez->package.elements on a non-package object produces
>      unpredictable values.
> 
>   2. The loop bounds use rez->package.count directly without capping
>      to PAC1934_MAX_NUM_CHANNELS (4).  A package with more elements
>      than expected causes writes past the fixed-size labels[],
>      shunts[], and active_channels[] arrays.
> 
>   3. The bipolar and sample rate DSM calls access elements[0] without
>      verifying package.count >= 1.
> 
> Use acpi_evaluate_dsm_typed() with ACPI_TYPE_PACKAGE to validate the
> return type at evaluation time.  Cap loop iterations to
> PAC1934_MAX_NUM_CHANNELS, and verify package count >= 1 before
> accessing elements[0].

...

> +	count = min_t(unsigned int, rez->package.count,
> +		      PAC1934_MAX_NUM_CHANNELS * 2);

We have already discussed that, that min_t() has not to be in use.
Ditto for the rest of the similar cases.

I would recommend you to slow down, drop AI assistance and check
the code (variable types, available macros and their usages) first.
Don't send a new version until you understand what AI is trying to
do and what we want to have at the end.

-- 
With Best Regards,
Andy Shevchenko


