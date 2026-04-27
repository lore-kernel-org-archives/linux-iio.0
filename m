Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3072F202C29;
	Mon, 27 Apr 2026 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777276844; cv=none; b=oh1PcavDDKJPGQf4KKadYn2homPUztWpwtU9A09ddObnTdbathalcEnTrtJBlxLTgNkoUI7lleAoh+BJqUFqCdQEyLRLrQO6ao4c4kZfQ9TAZ7yTvwhgSiVrQzSv8kynGYPlhw+VHyGE8dJzKybmHw9u1iZauF4Q7KoQWgGGjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777276844; c=relaxed/simple;
	bh=ghHqDIqs32eUFTycC0DpOZQQV3jB4QTZS3gfByluWEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCYGVjAmf9XlH8I1SgluCJRzOhECmoCCeWF+m3n+yeRxvJA4HWPbq3QWnhRnrNMr9k35TW2o+sYL9Y8YFf9F9ww4mIPG3l0iO9xJairyWXt95giSqzvCm3YLQZnD8HOwQh+Pe7TGGUfnU3c/ePcTSWduHu8fp/FcnneMW/o6Qj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXVAvoM5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXVAvoM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777276842; x=1808812842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ghHqDIqs32eUFTycC0DpOZQQV3jB4QTZS3gfByluWEY=;
  b=SXVAvoM5j7WlbxWOSSQa+5wlEN/5A1Apr9msvPojG5IUei+YbA4mwwCT
   /CVV463ZIrvvBX8c27xofjBrU5nlmenfyRWv1792eZhNuCiZr98ks7ZSX
   Sis/itBK9mRevl7/DYXpYvHcDzTJ9MBX+xste7Ginv96rK3389Hz/u2vJ
   Zf6E3dbVJoHvxBZChV40wOLWPQ8eiL5zJYwTP0WyhSty9rlQ0URu3MyTD
   iWeYtIng72JcYMS7bpEcjZC/fKtUFgG/ysdT3y1LayAOtrzx2I8twcX9r
   sMc+Xuhqq/pagqjiBLsdCjNBAP8jct3jLhrFdT9CddfodKJhif+RKa2zM
   g==;
X-CSE-ConnectionGUID: kCpl4TjMR7+nc6chiQpPcA==
X-CSE-MsgGUID: oSn4XnfaT7SuF6D2Fyheaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="103620037"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="103620037"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:00:41 -0700
X-CSE-ConnectionGUID: 06e07tFZROadNQbdhA/Jvw==
X-CSE-MsgGUID: inMbxc1JSq+/EI4UzWSfgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="237890794"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:00:39 -0700
Date: Mon, 27 Apr 2026 11:00:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ssp_sensors: cleanup codestyle warning
Message-ID: <ae8Xpcm1iiOlWT15@ashevche-desk.local>
References: <20260426105653.3764291-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426105653.3764291-1-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 26, 2026 at 04:26:53PM +0530, Sanjay Chitroda wrote:

> Reported by checkpatch:
> FILE: drivers/iio/common/ssp_sensors/ssp_iio.c
> 
> WARNING: Block comments use a trailing */ on a separate line
> +	 * */

...

> -	/* the allocation is made in post because scan size is known in this
> +	/*
> +	 * the allocation is made in post because scan size is known in this
>  	 * moment
> -	 * */
> +	 */

Fix the English grammar and punctuations at the same time.

-- 
With Best Regards,
Andy Shevchenko


