Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEFA3B813A;
	Tue,  2 Jun 2026 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390197; cv=none; b=KPap9l1izflXGKdPF8cyuRg43bIcVIL1VptAFq75EYW5pGqwzKlhv+GP2e1UFgA1EzNdz0/iTs/SrgbuBEkqFKcWZx9Dsjc+bf0/OinWRfIt+o+pqS8+0Nu721vOf8UdghpBIx15jOPzhQDssYmDpoj+UGkaSH+UDXJaKMmghag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390197; c=relaxed/simple;
	bh=9am3bDpn3nEZCX6fvmlapFDuvJ6ioEZQrTIjE317IPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ox/okqzmnIbLUrsWmiq9jL2zD7dSTUJiV7X64NrzBSUz5gNFJ1AJcUsHNpvfwnlc9fYCRWtA91xxwVQ4uoqWtb7cEsQUROtdMN4lnxT2NgYL6hAkPaea0ZZUBbmW/DdE8H+BMZtPJ83/tp7B+xyNBRanpAjlHRwuWjVplIRdgtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OpeAwY6n; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OpeAwY6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780390196; x=1811926196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9am3bDpn3nEZCX6fvmlapFDuvJ6ioEZQrTIjE317IPk=;
  b=OpeAwY6ncHGf3LBTkMdi0ueMSv4ni6nvL5M0yisXbWFDh4gW5MUV4Wkg
   6Z40SypjtjOWMPT4j04uELiSIq/vxEcN7LvflOZPTAxXHIoLoearqu/OL
   AKWYvF0/U0UpfSMMIL4sPDBLGGpoZ0Q74jANzmHP3CJoZj3VzIjA2DPhz
   /sobKXETLeAqGcOX8rJX0FjB5PNnO0Xw71iNXJJGeBNeuB2MBi8/RqkCk
   tD2Dfr0ree6Hw0c5uoHuD8VjcEySQYsS0hFf4XBCiRthFBaeYPdwPjWs8
   dXXZlReZJEfeYXwshPOC/2wjBsbt9QSPVf9+Mri7+W53L1JZonlUO4JRZ
   Q==;
X-CSE-ConnectionGUID: 6ZZTqxjkRtWc76c2esHiuQ==
X-CSE-MsgGUID: TzjmUdrTTmSO4vD41yd75A==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80314086"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="80314086"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 01:49:55 -0700
X-CSE-ConnectionGUID: r4weIqLbTryJDiEqzMLHtA==
X-CSE-MsgGUID: 1dKRMAFkRnKtJE0w6feQCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="248126670"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 01:49:54 -0700
Date: Tue, 2 Jun 2026 11:49:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: todo: fix typo and refine resource management items
Message-ID: <ah6ZLksLwz0lc9hd@ashevche-desk.local>
References: <20260601190836.2766703-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601190836.2766703-1-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 12:38:36AM +0530, Sanjay Chitroda wrote:
> Fix a typo in the staging documentation path and adjust formatting of
> existing entries for readability.
> 
> Add TODO items to track conversion of selected drivers to device managed
> resource APIs and evaluate usage of cleanup.h helpers for simplifying
> resource management.
> 
> These updates aim to better reflect ongoing cleanup efforts within the
> IIO subsystem.

...

> +- Evaluate and adopt cleanup.h helpers (guard, __free) in drivers where

(guard()(), __free(), et cetera)

> +  manual resource management is still used.

-- 
With Best Regards,
Andy Shevchenko


