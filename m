Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739768;
	b=mvkwoFSzFP0bfeR9pshHPa+PlJMIIywKKWMcjEZrI0LZxMWghC8cqvyktP3BnBtcvCW8
	 0MgVXI2LXdD5wa6OOaeLZHHR4nye9ruxZQRTzd79Uz+U7dPUg7wvEokamC72ArVHiUxnx
	 lETLWPcJbVECZd4DP4AK29xi/2a/V3RT/ghUgSZ6+PEHl3XixvXbyhS2twudIvHTEqH7u
	 2opG5nL8GxQ2X0Dmzf8R8I1kVWouNfBWwCUWK9aIn16QUGSIxXgEl+QzyHS8fzVLaG4Da
	 OpEFgjk47YiVdbkNSNWeNdwps39no9H+1+VyBBl4y18sFhZh5Io+/iuboEEtm7DIOQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739768;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=AoumBwPwca9miEGc1SHpoUEnfipBniOtLjtvtx30uCI=;
	b=E+7Y6Zxfa91gclFY0eEXItH+hFvnMQfcEaV9g0ods8sQURVhQ82GIzcFGJGgAfls1xsP
	 5xxchi1xwg5S/FOiULElbYkndc7vGYSQLtLGoeDKQYO1cC4PwvzLQmU7YibAuxAMvFymM
	 eA9FmobZlpbwfLCEUamERTXsBLNAiNA7gtVMTaNjDzT7bDYHNjtMXbPaf4hWcMw2ciK0x
	 RW3jvv2TLNqfEoSxPQ0fs4PSLOLUrUnVFX+OhU68dNicya8MMQTyD+dvJgXQlgyrG9V4a
	 detk/NxWpi8f089HnlVp+o083IlmF3lGde+Tw65SrBBYXC44VcUjR68HwPQgk60EcVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mMMhZfVB;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7607606A31B;
	Tue,  3 Nov 2026 21:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7607606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mMMhZfVB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793739767; x=1825275767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VY4V0BE9B7xeQEiJCHEdVFtkYm8MR9SaAOpurGJlgvc=;
  b=mMMhZfVBEpDyt8wKJD2CqDNdx0Wej5IN4lNIFI+vxRSPw1i/5lu+DKor
   IoRRtBfyP9crk5yT2SJ+vgBOHEcYLcytQ5H8kpjH1btQMVIcWoULbQKcm
   pCmM7ybiHb0XZojERu6BnkvIjEmhR1rIoZ0eLNb0otJdMQmovnTHCfvof
   f89ekA65V8MtblN6Okf4DdkYTOxc3MDNlQD8BusFeLShFrs0YuHcB5YA0
   t0h/dRiHlOr5KVEJ00Mqyc87nPZWOUFkYXQ8gdxoDU05aez1dGtMBLnGu
   xnvO+9yenIfqyB3Lcasr0VwY0NQ1nuqFE5DxjiY+HSI4ebxhWQ9Rzhc09
   g==;
X-CSE-ConnectionGUID: BVLmEnh6RZ6Ou0poUshKeg==
X-CSE-MsgGUID: yiTqIipmSJiNfTSXu0sgCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2573482"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2573482"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 13:02:46 -0800
X-CSE-ConnectionGUID: hHDp9oAxTOeDV75A2FyxWA==
X-CSE-MsgGUID: QtT5ImJoSvyYJ0V2Ml2LYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6648815"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 13:02:44 -0800
Date: Tue, 3 Nov 2026 23:02:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, tristan@talencesecurity.com
Subject: Re: [PATCH v7] iio: adc: pac1934: validate ACPI _DSM return type and
 bounds
Message-ID: <aupL8Yb61IPDu_hH@ashevche-desk.local>
References: <20261103185026.3139023-1-tristmd@gmail.com>
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
In-Reply-To: <20261103185026.3139023-1-tristmd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 06:50:26PM +0000, Tristan Madani wrote:
> 
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

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


