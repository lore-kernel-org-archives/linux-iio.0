Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CA537E2ED;
	Mon, 10 Aug 2026 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391526; cv=none; b=Ki0JqggouUKYj1QEpv2Dt8Nm5BcBb4VIx4dw9FN6MJFozx84HEVrzn2Pu18Ko+V2+m60nSLB9RI98zkGKccWfbRiwMwzpatzsFXBlQ/2BqP1ZZKC0OF15q2kf7l5xrGdeD2bYNzwSaZo0hsT44AAZkMmK3jsMqGlZdOKftwXHPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391526; c=relaxed/simple;
	bh=3E9JKUGHh3Bphur8ewBI2aYVOmD/kOR3W/Q+NYYrAjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx1YmYpwVDS9tS+48eWqvj6aqVP9PGICPnwmN7YpBjDJNF2jITYOfAprbjgHzIpt2B2OV7UiTBJekh06/lmJ8yQqUn15MzppVutJvZHDWrZAoeFLHUsKY9kEeR4kv95AMDM6GmgOrQG2q/TQDRYnX5J3RLiOVcH1nE30xR4LUKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yu7mwoWY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yu7mwoWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786391524; x=1817927524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3E9JKUGHh3Bphur8ewBI2aYVOmD/kOR3W/Q+NYYrAjA=;
  b=Yu7mwoWY66q3DCmSZ6MvKqkgIp3IdaV/OI0UcihkaAgPfqOJbcIH2kZh
   jETDA1j4GK/N59izRbHP6Nhz05FIYpF2pknqRAlW+zj4aFonY6gQNVGsi
   JIOiUyXPfrt5o1tymxWblE6CpJ80seLFU4DGZwRHq+pzUPSHE1OHCHMXo
   O+9KOn6JThENQbXfOxu2GBt4fqwox5zQdF8kDClnuro7xVeeiznfDuPOj
   TDYCY//5mJvxGBeYLI8tN0nbXdBsfbaofX3x4EN+g9Iqn7OJd59FaHTrq
   d7LtWP0BS9xXABDgSARCN8HNcymFdXYp/eW0meRSoPiNA7xGrHDXpyoee
   A==;
X-CSE-ConnectionGUID: RkpJgYQYSQ6F6bX2VpsFXQ==
X-CSE-MsgGUID: 49WkHhH8SAmlCddlskbNrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98276797"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="98276797"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:52:03 -0700
X-CSE-ConnectionGUID: akfeCHbPQOaFajEAOXIExA==
X-CSE-MsgGUID: 2z1K1TqOQRWfEzwAuUxolw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="262630046"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:52:00 -0700
Date: Mon, 10 Aug 2026 22:51:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: accel: mma8452: Allow open drain interrupt
 pin configuration
Message-ID: <anor3Yq60APxW45c@ashevche-desk.local>
References: <20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com>
 <20260805-mma8452-open-drain-v3-4-6149f406a409@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-mma8452-open-drain-v3-4-6149f406a409@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 05, 2026 at 09:21:38AM +0200, Esben Haabendal wrote:
> When sharing interrupt line with other chips, the interrupt pin most
> likely needs to be configured in open-drain mode instead of push-pull.
> 
> The PP_OD bit in CTRL_REG3 is set when open-drain mode is configured,
> allowing sharing the interrupt line with other devices (with same interrupt
> polarity).
> The IRQF_SHARED flag is added to request_threaded_irq() flags, indicating
> that the interrupt line can be shared with other devices.

OK!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


