Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB63EB807;
	Wed, 22 Apr 2026 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862443; cv=none; b=aqVXN9hVBmdWyzOAIZK1q74xaODVnUp25DQs2M4oldGOTPdY79CnzlaGZxOKubf7jcTaDQdmpePPL3606dTpWsndhdGAmb4jDPum0A/tvpUk9kRbv54uqQI61CM9rvP8L+uz3I8V0sAHz/i0SjsURzYD+g6XMOJ5qh7jF5d+yss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862443; c=relaxed/simple;
	bh=ffO4vB7FODGnpzOhhQ2CVXjjmhr4zAF47rtNc7wzv2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYEx5tsMUI6vvRkt4bNKMmnAOzayxWujIhrq2ZmoksT2SzmFg5plt/Rp+5/Jd97HgnDuaxcTQ+cSe5ogKSBO1+4nqbS8MBztVWYJfVficTWc6RpH0PWXmg4BdsEov5orXUjRcowKa/d2jWzw9WiqQOLt6k3eQvRHq2RdrG5MALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glkZlrU2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glkZlrU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776862441; x=1808398441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ffO4vB7FODGnpzOhhQ2CVXjjmhr4zAF47rtNc7wzv2s=;
  b=glkZlrU2kmEOnuYPQYocxUtp+LW0HZFQDuYztBiAJ63X5Gt7ajLLTTFG
   rHfqSYUPoP1zRN5LD6ryzI0Psj05DagcaXM24C0v2/w5mzsId9FSAM3Tn
   2MSTVswGhir5DI7wJ/9k8px7rXTVSPa1KJAcjX5APy9zgnvYZ08g90uY1
   VgHRxtvD3Zrl1pNfRZ7iyRjtsjHvHxDD3IOnwPG7Hf+KzUDSNvML/RY/h
   2iI00Ei0n6Oun6WjXYUNswSkJbcgQfn3UH2uSYq6ZMtzbv0nvK82WASHo
   HfwpIiv+GaCAndo2qpRrFU7Tcb/lPvrpFbvx3GTr/wSATKORX0ihZY/Vm
   A==;
X-CSE-ConnectionGUID: UBlXlw+kShOphBPRRFJTDA==
X-CSE-MsgGUID: kQS2LEIIR7S+KO+79WB7BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77930933"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77930933"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 05:53:59 -0700
X-CSE-ConnectionGUID: cJkMNDYyQ3qoSrxwNmAhQg==
X-CSE-MsgGUID: X67dLhyPTXirCoavW2xhXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232253106"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 05:53:57 -0700
Date: Wed, 22 Apr 2026 15:53:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: proximity: srf08: Replace sprintf() with
 sysfs_emit()
Message-ID: <aejE42knD_s5rsGy@ashevche-desk.local>
References: <20260422124505.8875-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422124505.8875-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 07:45:05AM -0500, Maxwell Doose wrote:
> Replace sprintf() function calls with sysfs_emit() and
> sysfs_emit_at(). While the current code is fine, sysfs_emit() is
> preferred over sprintf(), and will help modernize the driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  v5:
>  - Reversed decision to put sysfs_emit() call on one line per Jonathan
>    Cameron's request.

Oh, I missed that. In any case I consider my suggestion is still better,
it keeps driver in limits and makes the wrap on logical boundary.

>  - Fixed some of my editor's tab-spacing issues

-- 
With Best Regards,
Andy Shevchenko


