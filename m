Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62A3CF664;
	Wed, 22 Apr 2026 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886815; cv=none; b=YlggNXeVyXe3IeEDieh5VSh89D4+XA46rwWolmrgeZMfWJyqGBnAkiodQ4CHjqmqzvoHIJned89tGwKcbPxaOiPqa6KRpRMadAU2hJk0ogIh96JKEzqZzxAj25E8oXRp5HvQl7wqoO3wV/q7lTiaWRXxowlhmAnbPNavSjCFeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886815; c=relaxed/simple;
	bh=Nx7/3Gwx6UCQbneX0QIF4Ef+z97nmXu0HIGfK0bvYA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orhs9cwcYG6B7cMdDxlyYMXiAaSlTPUk0OfrkDt88CCT9s+PFcsqybo/FbeUqFBSoBS8Og9jyfBULsG14wMpF3iR2vpP49Swik9cuYvsF9xhPFPwZR59LgKXcHq/E4U7PJyX8uqEJlEPMyfr7b3SNxfjBHU8mNPGBlp+Wg5/J04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZRNtCwI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZRNtCwI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776886813; x=1808422813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nx7/3Gwx6UCQbneX0QIF4Ef+z97nmXu0HIGfK0bvYA0=;
  b=TZRNtCwIEqh5BL4W0S4yRI3ipylPjjWpGXaS8SjbU07/Yzq8H8XfTFfJ
   AJx9EIn6C32VFKK91Z58dCtzlogZ0V/bAmkGVQAfSHnS/9x+bWotx7CpA
   obACLFZJTeSC4jC4vzwakao7XylcgaF3PrW5F+vFCF87jI+OogIgNhj1F
   KFlcea992njbZNjjHhI8w8iDa8pRz0EGURGUdhoBRlM5Ihu4Z2f4O+d7T
   GQO9rOKzWs+VA2p+8UN1HXXe1I1uv4926B2gwEuwMEb7wEt9DIx2hmYN0
   jmicjSbwhdFLEJz+NWauAnPutwHEZesO0HCL/myJBECshwqLoFdsysVkL
   g==;
X-CSE-ConnectionGUID: +q9RcX0NS5Wy+SwemfKA9w==
X-CSE-MsgGUID: MNm2zA1dQemk8qBWkZN3tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77912490"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77912490"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:40:12 -0700
X-CSE-ConnectionGUID: xFDw2unZS4G+um+F7qRCZQ==
X-CSE-MsgGUID: AWZyiL7ISUmm93jayqLXCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="228102309"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:40:10 -0700
Date: Wed, 22 Apr 2026 22:40:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: accel: mma8452: use guard() to release
 mutexes
Message-ID: <aekkGKTC-GwPwakC@ashevche-desk.local>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
 <20260422165643.2148195-7-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422165643.2148195-7-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 10:26:43PM +0530, Sanjay Chitroda wrote:

> Replace explicit mutex_lock() and mutex_unlock() with the guard() and
> scoped_guard() macro for cleaner and safer mutex handling.

This one seems okay, but since it's not the majority of the changes that can
go, I won't give any tag right now, let's see v3 (but wait at least a couple of
days to give chances to others to review v2 in case I missed something).


-- 
With Best Regards,
Andy Shevchenko


