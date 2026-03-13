Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8338C432;
	Fri, 13 Mar 2026 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411070; cv=none; b=eTFyxyVXsFpaKgiKbEhj8P6Pp7G6dsi8RW8Q/7TUOMv0dDGHlWcxG5GxYYr8Gam2Gaw9Fs25hfMXg/f8svOHRrNw1AeEa51B4bi48AgIHvK0ZPT/ffj+Yyl893qa/SM7gSY3MSCT+aqnmr2exSXYMCVyyDBYH1NnE4WDco0G41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411070; c=relaxed/simple;
	bh=opqVNSy2bAK557EZDTRo/oljyFLkR6HtY6ALIzcgakk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxaiUPalAAGTYuyAyR42cZgstR/Ucwz0Szvy2St2BMqkU2yLLTxkHO/0eUBQu7FgnJt40mOD/Nz2gcUwkaezd9BN4eqXMXCKFQD9GEnVLqBOCrxgFdW9eeV7q8eMafSg4zWkwl+x80xsyDx0UjcuYUQUMZShgVp0pfKkWi/3Nwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZB5i2RKY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZB5i2RKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773411069; x=1804947069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=opqVNSy2bAK557EZDTRo/oljyFLkR6HtY6ALIzcgakk=;
  b=ZB5i2RKYQceYYVAaCvPQDuMsn49Vpz1FYCM1HimnnA04T49qgpG4Lp7o
   /kp++h09FFvVXoFcn1JZJv6BAhy1BjjVmU5Ldm3Vvsui3cItgNK/bXG63
   lEj0pO3IkELd9P0fsD8Pxrsi4li+288N8WW/A3HZKeIWgB3zhyrSaGc5l
   qM2WOykMX5dM6124V9ZGqc3ORXzmKcnSZxZf4yNmk9KZIRdlBPgmuyBev
   xQ0uMNs88SnGXwQmY5ypuZVZKaCOKmZaNavaU2twMpZ8hD3qweeKaItsV
   0VHXnys/CeSNDf8OqpgSKs6WJk4Rtp7BvCbUcZksDkYem++qxAgJa8iP/
   w==;
X-CSE-ConnectionGUID: h+Nd3CCWQkqQQolIgYAqKw==
X-CSE-MsgGUID: asa6XTySQYmaYEywv84+aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="92093067"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="92093067"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:11:08 -0700
X-CSE-ConnectionGUID: AYDQc/IXQIuxYVLIyIRZnA==
X-CSE-MsgGUID: ULz4BgDaQ9ChXzckzC8MTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225628052"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:11:06 -0700
Date: Fri, 13 Mar 2026 16:11:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: frequency: ad9523: use dev_err_probe
Message-ID: <abQa9ZylDrukBY-v@ashevche-desk.local>
References: <cover.1773050333.git.antoniu.miclaus@analog.com>
 <7a43f75f91e94b7c91684cc18b16ed7ee9a91825.1773050333.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a43f75f91e94b7c91684cc18b16ed7ee9a91825.1773050333.git.antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 13, 2026 at 01:57:44PM +0200, Antoniu Miclaus wrote:
> Use dev_err_probe() instead of dev_err() in the probe path to ensure
> proper handling of deferred probing and to simplify error handling.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


