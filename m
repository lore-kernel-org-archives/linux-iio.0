Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E23E404BE9;
	Tue, 11 Aug 2026 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434016; cv=none; b=ImRz+RGhHGwPCAS3M0c86vIQytJcZSeZQ6hKQ+CQSWUxiw3AusnBWDmYFONuGwbZCJfJVG4ex/F4J8vQwo7BS/Age0lva0v2yBAQCLQySNhWdJWKE/5sDSvKI7JzoHIG9L+EZVY2CckhYz3dmjYDfmerdB1Qs7qSAO3DPqURNZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434016; c=relaxed/simple;
	bh=LK5t6avF57Z3afkyDOfrv8/HijJQDQFviGadHL6LbX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UL2SotY3J+bGMQMaRbgNgAyo+ahxt8dJFe+CPdyMuoBpBP2YC3tuzipcPj6clDqAceILfyoAP4s+Lh8Dofx/iUmuUFEWWAqycgX6U+8P+kr5t3lxS/d9wet3fkgpgPtxsc6U9q8SZ7JSTWPVPxIl1AbNxAAcX/VkSKNrnZBjIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0Vhk4jO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0Vhk4jO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786434013; x=1817970013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LK5t6avF57Z3afkyDOfrv8/HijJQDQFviGadHL6LbX8=;
  b=m0Vhk4jOZMu2LQWliUvRA0pn2ZaN24RlOTskrwvAbexycIItUGUNVSCJ
   BdM4HTUoUl3FJFV5PeVN4EmYhqYFowuCP8NRinYVxmIgaTo6D8S5vHkUP
   Abh30Jrt7tvFRzXm4mgo1QzRlCMODTFq5WROWbR4EBZNMRsf19z4miniW
   MfouJt6apt0uapQpQpm/zfFD6v/7u6aSB0aJ/u5PtsxOD+Dl7vU3vDweO
   /qF7JFjzsRMsDQ3/8EPQTDOQSMJHLSw5H7mFaBvFsXgIt91cqKkXGFbWj
   t8pAhpBb3CwBm0EW8AdEmr00DMJotGn+TEzXwAeIimysgayGY+l5HQ1Lj
   g==;
X-CSE-ConnectionGUID: rLuAf9sGSrSTKZDlJCMnnw==
X-CSE-MsgGUID: QUAhHX2aSKSNgVqw5c9gWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="90771918"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="90771918"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 00:40:13 -0700
X-CSE-ConnectionGUID: F0weX8JsSXKegrEnOAkgRw==
X-CSE-MsgGUID: cwq4H5e1TweVJFTtWV59qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="263855322"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 00:40:10 -0700
Date: Tue, 11 Aug 2026 10:40:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH togreg v2 0/2] iio: imu: inv_icm42607: fix PM error
 handling
Message-ID: <anrR2F2bXlV4WO3I@ashevche-desk.local>
References: <20260805035451.487465-1-lilinmao@kylinos.cn>
 <20260811020345.950137-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811020345.950137-1-lilinmao@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 11, 2026 at 10:03:43AM +0800, Linmao Li wrote:
> The recently queued ICM-42607 PM support has two error paths that can leave
> the PM core's state inconsistent with the device.
> 
> Patch 1 propagates sensor shutdown failures from runtime suspend, matching
> the behavior of the sibling ICM-42600 driver. Patch 2 ensures that system
> resume restores runtime PM management on both of its error paths, so that
> a failed resume does not leave runtime PM disabled for good.
> 
> Changes since v1:
> - Patch 2: split the device side of inv_icm42607_resume() into a helper so
>   the PM bookkeeping stays in the wrapper, per Andy's review.  No
>   functional change.
> - Rebased onto the current togreg head.
> - Patch 1 is unchanged.
> 
> The Fixes commit is in iio.git togreg and has been included in
> linux-next. It has not reached mainline.

> Based on iio.git togreg at 350d1fb9204b.

Unneeded info since you are correctly used --base and we see that below.

> Both patches were compile-tested with W=1 and checked with smatch. No
> ICM-42607 hardware or fault-injection setup was available.
> 
> Linmao Li (2):
>   iio: imu: inv_icm42607: propagate runtime suspend errors
>   iio: imu: inv_icm42607: restore runtime PM on system resume errors
> 
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 41 ++++++++++++++-----
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425

-- 
With Best Regards,
Andy Shevchenko


