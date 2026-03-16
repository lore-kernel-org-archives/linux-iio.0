Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758012701BB;
	Mon, 16 Mar 2026 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671219; cv=none; b=FUpky7w76F38/gG/Jzx7Tc2truaDE95H+Kg2GozCZlzcj1Rm2La1g6xXx1wlCXuH6Ha3YLZ6yVy/4VR4ZjmNMcrUMcZftpVfXGNMmTJn3nA/JsqS4CZMBB8WhQa1YaN46jFqZujOlfXx0DOTvyqSuipxl28olKi57yxk705r1h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671219; c=relaxed/simple;
	bh=FHZKMW2URFGAFnuWPY2dSlQRkpSj1pWYiDSSZoc4g/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1DAnVr2Kel0Z5Nrs36layBmwHqIMEW0NIZjHFozgWz2lcN382wWvtqNsR3towV7x6/8qB1YGaxe5P8oYYPcGOIG/umFdAFBUpFJAMFkgqmSSJYRa972Pw38rDsVD8OnJlWJmMMh38HinPocxHJQ8haxtQb2PGgyag9/piQQuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edLGMb3X; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edLGMb3X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773671217; x=1805207217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FHZKMW2URFGAFnuWPY2dSlQRkpSj1pWYiDSSZoc4g/A=;
  b=edLGMb3X2l0CBMjq1wrXwyGgFSuzrhZUifzM95eUlrRU3qjN3yEXm52A
   DmfyRyqSUmkB1fcSCvN2TexvIOS0eJEiuFrXmgsDdzcBDzV1bHRCN+ZZg
   FoqmhFCjsg3wADiRz/D38bG63GdRakuteH4euLZo9NdfcIv/+V/puBKKR
   G5oGrF6ABrcoteJWxvR/Pcqa8NoX37PDSBBYu8e20GXqzFjCjuc3klBRl
   vN4fgcdUilB61glwcDR2tObmHmhjJyUr0/jVOZ3nDHEXPuhBQWUm6At4q
   lD4KN6kV1la2fi8PP5oL3pYiKB81tU/5A8a3fP7YhCTA/qFlkCWQWb7x2
   A==;
X-CSE-ConnectionGUID: Y0G39zYiR/Gqd0hyJhWXlw==
X-CSE-MsgGUID: VqD2c+qNRBaiVXUWfMgglg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86039931"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86039931"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:26:57 -0700
X-CSE-ConnectionGUID: tsI2Z1KxQnWT9RmUCOp0KA==
X-CSE-MsgGUID: F04AREtNTA2z0GTK803eTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="216439404"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:26:54 -0700
Date: Mon, 16 Mar 2026 16:26:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	morris_mao@aspeedtech.com
Subject: Re: [PATCH v2 3/3] iio: adc: aspeed: Reserve battery sensing channel
 for on-demand use
Message-ID: <abgTKzfiDPFQJPVo@ashevche-desk.local>
References: <20260316-adc-v2-0-21475a217b09@aspeedtech.com>
 <20260316-adc-v2-3-21475a217b09@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316-adc-v2-3-21475a217b09@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 11:00:48AM +0800, Billy Tsai wrote:
> For controllers with battery sensing capability (AST2600/AST2700), the
> last channel uses a different circuit design optimized for battery
> voltage measurement. This channel should not be enabled by default
> along with other channels to avoid potential interference and power
> efficiency issues.
> This ensures optimal power efficiency for normal ADC operations while
> maintaining full functionality when battery sensing is needed.

...

> +			/*
> +			 * After enable a new channel need to wait some time for adc stable

ADC

> +			 * Experiment result is 1ms.
> +			 */
> +			mdelay(1);

Why atomic? If not required, use fsleep(). Otherwise explain.

> +		}

-- 
With Best Regards,
Andy Shevchenko


