Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980643DA5CF;
	Wed, 18 Mar 2026 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845835; cv=none; b=Kb6zdEKcwG3KjB2D2fjkEcXAj35wa4yivoJY1jiUiEqMlO3QjjQceLr2g8XaMscbCxSvrxPu45bAGsJ2D7YATgeX8P1sKapEaGCp0Dwxv2fTYNqNIvPldgMtY7Re1mavv2eHfk1B88hT4dcbCCRl3IYFhx/dYXnyifqyBjS0qRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845835; c=relaxed/simple;
	bh=xRnPqAZQZ0x1PoBQ1+qTXwJ2WQqtGL4R4H8wesG6Rzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSCay10QaQ8TC4Y0wpxDMUfnFIolvAntWHVCRis2q4slmCH5yXcZRem6rAS6o5rFJxyfBWqJ3VAJla1qQ6WisXDEUbKCu6vyGpC1hA8V5PJKa0W4XysPRXakXPHSSQSjgYTq1KHodLkmEWcG6eaHJI0hmKcc/szwIdRBHtFOP5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoWNFLJC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoWNFLJC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773845834; x=1805381834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xRnPqAZQZ0x1PoBQ1+qTXwJ2WQqtGL4R4H8wesG6Rzw=;
  b=YoWNFLJCk9fIywP2tLwhLDYrA0OgbuQWKN2FR+Gym5EdkWtFlCWoqw/R
   socVgnxE7pqgObaEl2nfGejpXF9KEmko5YaTYwjJE0yoqpHimLd1skiku
   f53kzZsv5DrQTcDP5qK4K0KxByM7tJpu/HJ04r1h3hvw3g3V77QnqPUA1
   HqOG75U18POqY2owIS9t29cV/b8Jb4gqxD9bwa1XZyIZ/QZ/vk3ug9JK0
   rfm9ehAQYXcnJ8JCtcs/tGxO0WoOJxbb07RMQxEdIPE837OXE5pZXM3Gr
   aRaWwjtAsTBFIhAOA+x3SqyKN1GF05b+67AXYP92HJjpWfUeUI8LygkJ0
   g==;
X-CSE-ConnectionGUID: SMPkfZOPRRm8wwyBrcJdhg==
X-CSE-MsgGUID: KA7oOEntQpqATuPyz3ViDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75082264"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="75082264"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:57:13 -0700
X-CSE-ConnectionGUID: 3YRhrJykQ2WTE8d3EyWWhg==
X-CSE-MsgGUID: CB3lNrEUSduuxXip/IsMyQ==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:57:10 -0700
Date: Wed, 18 Mar 2026 16:57:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David =?utf-8?Q?Marinovi=C4=87?= <david.marinovic@pupin.rs>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: dac: ltc2632: drop enum and use individual
 chip_info objects
Message-ID: <abq9RCfFjGVzhrMg@ashevche-desk.local>
References: <5d4fb8998d9634c3e5a8ed17b80dae07@pupin.rs>
 <20260318135736.91564-1-david.marinovic@pupin.rs>
 <20260318135736.91564-2-david.marinovic@pupin.rs>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318135736.91564-2-david.marinovic@pupin.rs>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 18, 2026 at 02:57:30PM +0100, David Marinović wrote:

> Remove the ltc2632_chip_info_tbl[] array and related
> ltc2632_supported_device_ids enum used for looking up chip-specific
> information. Instead, use separate static const struct
> ltc2632_chip_info objects for each supported chip variant.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

(I have not reviewed that scrupulously, but at the brief look for the values
 and names LGTM.)

-- 
With Best Regards,
Andy Shevchenko


