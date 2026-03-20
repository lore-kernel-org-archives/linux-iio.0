Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E89931B11E;
	Fri, 20 Mar 2026 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002820; cv=none; b=NHB0neZD6hE156ErRjF3DXhud9joeRS+VnQbO9jraKbYOFS8pHfzWQaMXE5QeCkD/+Ua0ZIvP28GNk3yK8e3ZSaYKNVAfiB5nGcMea/atRlXlWZueQmyQca1gAptcPJXnvrxKNk4c+BE/saT8dm/rY7+bmqymTOy5PS3zv90dCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002820; c=relaxed/simple;
	bh=LSQf6TghFoqm6GEMOdcWK6utgEtFgdJISULngartkrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKS4dc0wCf/AI6PSnp9QiiD3VmA6Dsrj74wYJBYztG6XAKpY0evksHlPcDNEKSuwUMkMChiKQNjqV5yMNO/M7/QXk3oYBKhs3kIY1bZS6PtSQ16KLBxp8Pbgdo2+uN65A1co+4Fqm/WYDGzpueBfurgLXByrowPJAp9Kh+I0+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l242Ynfy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l242Ynfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774002819; x=1805538819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LSQf6TghFoqm6GEMOdcWK6utgEtFgdJISULngartkrk=;
  b=l242YnfyBaLeQtLMvGYx2LeAZ/cmqUpmiBxoJTnUsQaEHd4P5Ld53jea
   KFppTm2hqmuiqFNGMZKD5D/DtwOv8aj3D/3xbtPRZd5dAED9qpHNacVlk
   uHN212pRXaKxBQj3SgeHvVoF1LQDlRFJh8o+Nv8+mSt/X3rFkgKCfLLYf
   SffXrOAPPWaYAZfrifgT3gDS0ZWqOO9oAe1cMRVZzyK1HTtQ5hMAfxdxD
   Kz3F0/BIX99XrxHjo7vlcFBLD2yXASJs4+MU2OERYAGX788d4f6HmBDkw
   rfXXlvsx1SyXn7Ao580w6OHwrTzNqZ34+4+nE5sMUHZvWrs/2pMjOZ2f7
   A==;
X-CSE-ConnectionGUID: mxPGNB6HTwu+p8BW/LS2uQ==
X-CSE-MsgGUID: UpfCbzVISLSPmndSMj8QTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="78989474"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="78989474"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:33:38 -0700
X-CSE-ConnectionGUID: FEilcUbeSraVdBth6Vgygw==
X-CSE-MsgGUID: 5JXG02puThGdgHPVUyvk/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222340475"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:33:35 -0700
Date: Fri, 20 Mar 2026 12:33:32 +0200
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
Subject: Re: [PATCH v3 4/4] iio: adc: aspeed: Reserve battery sensing channel
 for on-demand use
Message-ID: <ab0ifBMNuY4BwqA5@ashevche-desk.local>
References: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
 <20260320-adc-v3-4-bc0eac04ef7c@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-adc-v3-4-bc0eac04ef7c@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 01:46:38PM +0800, Billy Tsai wrote:
> For controllers with battery sensing capability (AST2600/AST2700), the
> last channel uses a different circuit design optimized for battery
> voltage measurement. This channel should not be enabled by default
> along with other channels to avoid potential interference and power
> efficiency issues.
> This ensures optimal power efficiency for normal ADC operations while
> maintaining full functionality when battery sensing is needed.


...

> +			/*
> +			 * After enable a new channel need to wait some time for ADC stable

Missed period at the end. And you probably wanted to say
"...for ADC to stabilize."

> +			 * Experiment result is 1ms.
> +			 */
> +			fsleep(1000);
> +		}

-- 
With Best Regards,
Andy Shevchenko


