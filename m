Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648F3F9268;
	Thu, 15 Oct 2026 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094072; cv=none; b=qX4zPvn7BWF4WRigd4fwKbzXt2EBhUc7/b0lHY6fVoxxd4mjF1IEzuZZ0fhpkJuso+IjNsHsHmSCc0GpfoG0AgeGWCQ34pMZ5b+GKVFgC//QzTS62biIqVdOhsvwWdSzqjnmn+m60Yic4PnESazMqDtzMRNO35uoMsGfiyDHxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094072; c=relaxed/simple;
	bh=JFsWwV0EnmhXusnURRHJsleGQwtPYJm6GUAsuf+oGxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gloxxIO59V/Fwzbo+13Ju3KCILtPEt4ZEe9pj5ny5IGxni8OopneOt2SosSCkMo6AItityoz7UW+9KEibBlpkJOfs8dt3dH7TqaAISzM7M63+M+bHnbG08iP+uYBsmjFtmyNGURg4zO8zMUQ070FTf8WX9qCJuznut5uBev5qQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZHmO6qc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZHmO6qc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792094071; x=1823630071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JFsWwV0EnmhXusnURRHJsleGQwtPYJm6GUAsuf+oGxM=;
  b=iZHmO6qc5Z6IvtpDpvOL/3l7Efowl0a4lhHXRdoRTf2pLVonNe1v46lw
   14gF7HZwEkmB0z8uX4GI8UbBrwaRufGWEiY2SeGZ+72LLQ+7/AyxoTB0G
   b1hcggBpxdi8yx9jSbCxxtX0Skje7NuBIBrMxNLO+HcRq0EzZtmIuxU6M
   wNksz/bIJEzeh+9XhgUyyNnS9RixzfRzP0w5pv5TzieVmd9gaLKSJ5TGO
   b4IW+ihlO9OAgcSoz9aDzUJUIOX911cSUguUt+ruA/+wW1cMr+hP4Nqfq
   cvjby0l+/afDKLUrgijSrK8JdVi1CWKihTGl73oHEFgqEmqvMUhV0R2Si
   g==;
X-CSE-ConnectionGUID: 5uOCb50USiaaLEq/CNdOfA==
X-CSE-MsgGUID: 6FSxnzrdTeuIGa4e7AkaMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="908534"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="908534"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:54:30 -0700
X-CSE-ConnectionGUID: TA5lRrtrQ/i1FocHa1ABuQ==
X-CSE-MsgGUID: xYrP0xEyTFSBRkQZ5DTJBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1705421"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:54:28 -0700
Date: Thu, 15 Oct 2026 22:54:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: common: scmi_sensors: fix truncating 64-bit
 divisions
Message-ID: <atEvb5jQsZCywGKs@ashevche-desk.local>
References: <20261006045244.13993-1-kapoorarnav43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006045244.13993-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 06, 2026 at 10:22:41AM +0530, Arnav Kapoor wrote:
> do_div() divides a 64-bit dividend by a 32-bit divisor: the divisor is
> stored in a uint32_t on all architectures. The driver passes 64-bit
> divisors to it in several places, so they are silently truncated:
> 
> - scmi_iio_set_odr_val() divides by uHz, which exceeds 32 bits for
>   sampling frequencies above ~4294 Hz.
> - convert_ns_to_freq() divides by interval_ns, which exceeds 32 bits
>   for update intervals of ~4.29 s and above. If its low 32 bits happen
>   to be zero, this is a division by zero.
> - scmi_iio_get_odr_val(), scmi_iio_convert_interval_to_ns(),
>   scmi_iio_sensor_update_cb() and scmi_iio_get_raw_available() divide
>   by int_pow(10, n), which returns u64 and exceeds 32 bits for n >= 10.
>   The SCMI exponent fields allow values down to -16.
> 
> Truncation results in wrong sampling frequency, timestamp and
> raw_available values being reported to userspace.
> 
> Use div64_u64() and div64_u64_rem(), which take a 64-bit divisor.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


