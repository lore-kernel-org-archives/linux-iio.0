Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6549B5DE;
	Fri, 11 Sep 2026 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143013; cv=none; b=QYh+vlnSMWLZJhk/iuLpZH6BUy5zPG9tcVsDyGdO6GgHASBbrC/StNLvaaUvroDOilFjVHCSsThbVnTL1BN4wp8vxeayxYPlBX0ayEfb/eMEPglOyLxanm5auf/Rv3XVingginYJx3XRDgu9n9Sv1PHlrlRD1Fp28xDJwmFoeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143013; c=relaxed/simple;
	bh=a2Ztu5w1m+CAwAK5FGI24VNtN5jt6xLSkd9xsYrPPHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dytFKnti6QJKJyLvzCFAATVHuwVde81aIMqCWUuiXyDH/X03H+AeGbmVrwrydKAEryHue/9Mj9W7kc3ZBDAc2c3yxIS51eCWphxx2X2JlgaXALMsfUSH2Y6vWZ0JYn0UT9fIYe4tDboYVyqDN4PLkQ1XlNcvlCkV2yqMkvg/qy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sx++J6/P; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sx++J6/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789143012; x=1820679012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a2Ztu5w1m+CAwAK5FGI24VNtN5jt6xLSkd9xsYrPPHY=;
  b=Sx++J6/PJdy5FQdLsAOCaez5ujB34g7hjoITlMb5BzwXWNuFvkmfCqWE
   7IexH4S3J5jgPI7No8znSyYLF9Y0opS+dfNuPj2jugCpCYQRppD3SSg+a
   M8C+Sc6UXPn/RzlaZjMZrmDLwKrbuQnbGh/A784Jusz2YrpCQHMfXVvXU
   MZFNsdn3DsB26Eja6RiQikj9v2xFYJmk2EnMsKTaTtxP+vKwOPVGTWeY/
   8OywbWa8EFTYDJutbr6fIchqTG3g33JLphV1VtVGjJTozMeH5W2u1oZmi
   1doAH5iLHglCzfLNvh3eZq/Yf3bvhN0l/EFjYDyn2FP92V+snW8Y7yMNK
   A==;
X-CSE-ConnectionGUID: +xcL8RKKT66rka1422Pmeg==
X-CSE-MsgGUID: xjlmAsAVSRqmNALpdNnAvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="115146463"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="115146463"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:10:11 -0700
X-CSE-ConnectionGUID: g9HwgI7bTsWw/VlF8EqmjQ==
X-CSE-MsgGUID: zzF8Ff4xR7qIRYRhDh1l7g==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:10:07 -0700
Date: Fri, 11 Sep 2026 19:10:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Marek Vasut <marex@nabladev.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 2/8] iio: adc: stm32-adc: manage characterization voltage
 diversity
Message-ID: <aqQn3Tef1MJvIz7T@ashevche-desk.local>
References: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
 <20260911-adc-stm32mp25-v1-v1-2-cef26eecdef2@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-adc-stm32mp25-v1-v1-2-cef26eecdef2@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 05:51:24PM +0200, Fabrice Gasnier wrote:

> The characterization voltage used to calibrate vrefint depends
> on SoC family. Add vref_charac field in stm32_adc_cfg structure
> to store the characterization voltage for each SoC, and use it
> in vref computation formula.

Vref

...

> + * @vref_charac:	Vref characterization voltage (mv) used to measure vrefint calibration value

vref_char_mV or alike
(use unit suffix and you may drop that mv in the parentheses).

...

> +	const int vref_charac;

What does const buy you here?

-- 
With Best Regards,
Andy Shevchenko


