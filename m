Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EACB3D4128;
	Wed, 25 Mar 2026 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440883; cv=none; b=bw8Qbgosj8NgUhug4mxkKN/PYe2y+jMITTnWSEjx+NZADg94UCNX1fg63UUXPw162ond0AiNbr14lw25+by7k+9Gea9KoVoJQXDKrcUO+EtekvViKO3U5VPt4GZpDRiI8qLy9+dYVFecRQAAsqwzrfY+FW8NibQpfGMKxLWxAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440883; c=relaxed/simple;
	bh=Z2QGNbGQunB6gC8GkyNFNu0iUogVyb4EPOvr4xamuAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Epju78+5UX5zjB/Ru0aztjxoMSvJ++3gqBmlwf0QBfyRl/MLn+f7Cx0LdcdhTmZTCBsij0tTm1cn+Yvfixlb+nBNpJQNWHtGoCsPMwXAroo7fsOMJYMkBSSiLXn+Ban2p6KPR3rcUddo3Jmdq8nwBQSDBK1PJsrrNawdNsm8YJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c76h36xU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c76h36xU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774440882; x=1805976882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z2QGNbGQunB6gC8GkyNFNu0iUogVyb4EPOvr4xamuAU=;
  b=c76h36xU44HHub73UPepOhONGrD25jGigCrsl3tVm4AkgDlO8kE/+Mie
   bYeAZyHKzc1SDgqwzq5J8zB0bbppz/egtZsics8Uk87/39dOZmtIugQlW
   DzrdEKolEJoRXiqtkFPcVIPUd8iku7UimQQrRv6gUJYGzJZvGAKZmBT4X
   oMlHDU2gWTx7xDA5focq9ChQNRZeVeeJTnrWnmDQfJ5qAdUpWPyU7zfbI
   dwg4yWQ+PcrGbef9AFEAjPWGIx6BRhLPiK7iZgUMqawjWWI/IhKRLITbR
   A0bUqgK9mxKFgAq1PaLQJdwABrTLcfZ26z4hKJU6T2uxGag693J5HXKOK
   w==;
X-CSE-ConnectionGUID: FonBwajLSK2By3zkHRyUlQ==
X-CSE-MsgGUID: ReCHyWRsR8SebPLE7IVzfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75191182"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75191182"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:14:41 -0700
X-CSE-ConnectionGUID: gv/T/1SzT5CTm5/NS9Gpzw==
X-CSE-MsgGUID: avtsUyQkRMaHpuJJJ2s1Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="218090002"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:14:39 -0700
Date: Wed, 25 Mar 2026 14:14:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: spear_adc: cleans up, update and sorts the
 existing includes
Message-ID: <acPRrE_6G4bbqhx7@ashevche-desk.local>
References: <20260324221313.119473-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324221313.119473-1-rodrigo.gobbi.7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 24, 2026 at 07:09:24PM -0300, Rodrigo Gobbi wrote:
> Remove unused includes and add what is being used (IWYU principle) and
> sort the remaining ones.

Thanks, make it two patches:
1: sort headers
2: apply IWYU

-- 
With Best Regards,
Andy Shevchenko


