Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663542D5926;
	Thu, 27 Aug 2026 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812879; cv=none; b=Ss5Tor7CO+1lvusXgu19AAHE+1OrFlPQLpSuSPbbSerp7Ft+3yyIkg+fuWtbpBYvRZ6cYwhWkq6X+6fNSGZqrN7PZlYiFGUs5cGk1d1UmLSCf10JFr1D1ChDTrZzVwXzdkdbcQbGkB6Abd2jHgn2HBGuHxxjK1BTDHjEU1ZUee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812879; c=relaxed/simple;
	bh=92AMRd5fSTaimx3s0XBX+AxH3laOwBEtzOBiZL1vS/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iyjmqh+wtP/cxEN3yMK7j3Klc4hNy8pd7ehIvyNId/U8ukABMd0MVu3WY4ZN6ajl6oDKWyudRmV2irMH21/ZT0sYHoFCkQp01iWIYJCn4tzcmYgRNMb5zn/WMf14q2z5ZgFcZzKdaxFGyTxM6ecwazNygnfpY9Uwa/SU5HDaV9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7fUqXe1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7fUqXe1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787812877; x=1819348877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=92AMRd5fSTaimx3s0XBX+AxH3laOwBEtzOBiZL1vS/s=;
  b=j7fUqXe1fKxwq8kkSl23Pyz/grwtizOyGlECmlzxP10eUf2kQgTZgLVq
   yna/ywN2BL+kVwC4zRk0IXU5TiLyyIXXpBm2aJsbTpXYHcOJri6fvqWms
   LbD8zIsnDtWGkRN+MVSZSQ6VT/cxlqEwcehVFsZxVbhMqJR6lZYd0J+qt
   O4XYgn2uLAsnNJcZDnQuOyHPRieCtfFIzr0tIwVWcFhqOHPBqkiK1vblH
   oByEfxE3YDunHYP9ekP2HIFuLEWR3oMxCr+eDOqvWxeV5dkxYteUeaO/u
   5oLvY1BlmM6NlZ8K8U2fMxU9IiFKyRQpBQylToyRcx9GN8ftNwMnmuWco
   A==;
X-CSE-ConnectionGUID: Z44NERSNRSW7rYrLfPrDFQ==
X-CSE-MsgGUID: h/LL+vP4S5qmEpnmZe3OVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88360695"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88360695"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:41:16 -0700
X-CSE-ConnectionGUID: 2S8yh1VhSF6cpVoEXa7cFQ==
X-CSE-MsgGUID: CxdoPa/CT2aDKwmPNeK1TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="266000944"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:41:14 -0700
Date: Thu, 27 Aug 2026 09:41:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rishab Madhugiri <rishab.madhugiri@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: core: Replace BUG() with WARN_ON_ONCE() and
 error return
Message-ID: <ao_cCHTp9kKfOV-U@ashevche-desk.local>
References: <20260826213140.37437-1-rishab.madhugiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826213140.37437-1-rishab.madhugiri@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 26, 2026 at 09:31:40PM +0000, Rishab Madhugiri wrote:
> As documented in Documentation/process/deprecated.rst, the
> use of BUG() and BUG_ON() should be avoided as they could
> cause a complete system crash, preventing further debugging.

Right, but deprecation doesn't mean the _old_ existing code must be immediately
changed. I leave it to Jonathan, but I see no value in this change except
the unneeded churn. If we ever want to drop BUG(), it should be done tree wide.
Hence no tag given.

> In iio_get_time_ns() and current_timestamp_clock_show(), the
> clock type is already validated against supported clock
> types prior to these calls, making the default switch
> branches expected to be unreachable. Replace these with
> WARN_ON_ONCE(1) followed by an error return to avoid a
> crash and to log the highly unexpected condition.

There is like 10+ character space on each line, the commit message shouldn't
be that condensed.

-- 
With Best Regards,
Andy Shevchenko


