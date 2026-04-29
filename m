Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6223BAD88;
	Wed, 29 Apr 2026 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453389; cv=none; b=PgEB92GoATbAiNqpUdcSxJ32gdGvezwDoyNxck0wlucqDkEN56h4/CN6OT2j9tBrxRIQ+Tj2imeqxXFhGWwDT1SF/2284DjpFG8XUVz2AydKyGv5m57eBHTOYjw57sV1E22j8eGvi3IdF5cnJbqkFDkhyze18eyLJM/Hjj0JM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453389; c=relaxed/simple;
	bh=iwPT3uDvW77dDqxcfpEOuy3+fWQNjeG07Cp1xt5wdN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKzUOoQKPkrIkpoRcykFHoXALQokxORrTHVZOPN2D69VNdcy9VsQcbFtkGXCyNk0LIjzJHjFlyUbjcijgP0gAUd9QByQ80G1DQ47CLFeMpdj1uAFf7TlIeo3yn//qQ50zLdqQaYCOcuE+bAe6qTGew9nhcRUKvmHl8bOtZCy8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crEm1TUS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crEm1TUS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777453389; x=1808989389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iwPT3uDvW77dDqxcfpEOuy3+fWQNjeG07Cp1xt5wdN8=;
  b=crEm1TUSLdjvCvyeVS5K1UhDJpK0W4+q7NV92LRZ0VhcOenZCSTXgoTS
   2sz/OEuLEXQoOeB6iVTMe/R2rw+BqEDpJeZ5vuB/piUWkJxKzd4kEA0ys
   Oc2xguMLlLkVxDNBRM7Q7JwQKJ3o1qSSyGPj2Bn4VftTc7BHloOAsAt5x
   KPUov+Pfr6QbiSXRS8eZamr/iB8KEuXMjjSHug4NBA9aq5coaEMDOK5f0
   W3aMJ6Wkc9l3zHx9GDsNxNRMkolFzTpogDuUfGQ9rdNDtOgrn9zZ46BMO
   JkdIe68QHdR+aci1NZ+1h0goVTQH46ynqKlG0ZzZTyqpyehE8e0U6ihL9
   g==;
X-CSE-ConnectionGUID: pP6RRkoyRnKMHUJHXiiuuA==
X-CSE-MsgGUID: 9i/VxkO9QHiC4tvDK1tG7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78393353"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78393353"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:03:08 -0700
X-CSE-ConnectionGUID: u9IfXBJfQeKvXsL7CToG1Q==
X-CSE-MsgGUID: maUbhilmSl+z4ki2US8kzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="233182929"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:03:05 -0700
Date: Wed, 29 Apr 2026 12:03:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, andy@kernel.org, dixitparmar19@gmail.com,
	dlechner@baylibre.com, nuno.sa@analog.com, waqar.hameed@axis.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH v3] iio: light: stk3310: Deal with the ps interrupt issue
 in PM
Message-ID: <afHJRjol87hCHOvw@ashevche-desk.local>
References: <20260428192213.7c5c80e5@jic23-huawei>
 <20260429071402.209438-1-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429071402.209438-1-limiao870622@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 03:14:02PM +0800, Miao Li wrote:

> On the Inspur HS326 laptop(which integrated with HiSilicon M900

'...laptop (which...'

> processor), if the STK3311-X chip's PS interrupt is configured
> in "Recommended interrupt mode", the interrupt cannot be triggered
> normally after waking from suspend or hibernation.
> 
> In this case, neither disabling and re-enabling the interrupt nor
> resetting the PS threshold register can restore the interrupt to
> normal operation.
> 
> If the interrupt is disabled in suspend() then reset the PS threshold
> register and enable the interrupt in resume(). This resolves the issue.

...

> +	if (state == false)
> +		data->ps_int_enabled = false;
> +	else
> +		data->ps_int_enabled = true;

	data->ps_int_enabled = state;

-- 
With Best Regards,
Andy Shevchenko


