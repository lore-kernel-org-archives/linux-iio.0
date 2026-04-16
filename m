Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8938A716;
	Thu, 16 Apr 2026 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327939; cv=none; b=jbJCmWTJB3qxweJWKBqpMs5iI/VcWxCpBPxysW7iDrHMSIK1/yqbXzqdHs9v4D+mUnVUa3w33esvR9FkGRvLNq8IImO8RDQ1ZWXMLl2qBURXZs5nVqsdFLKDyXn1CfDGwmYKizmCyEXZFLa/yi5Y20U77W4zO/uZm/xAMGNsyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327939; c=relaxed/simple;
	bh=X0t95ywWKNEm5KRqxgy4Tuox39Cz44G2vQvbq5E02TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvfjKz3WhlL4HLPMtqwnWoL8HRU7wUvVmw2F4QIv1wbSQf5TcWkCcoNV1bdxSHjxKrr2jJhvHOvealRQ5iigPpIynossI7eknodzwsywDzNCl4XjNP2YsO8GCPLW199Sx1gH7mG1ina51RhQJttDirorfsR2WWO7Y/Lytgjv6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWBqhyj/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWBqhyj/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776327937; x=1807863937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X0t95ywWKNEm5KRqxgy4Tuox39Cz44G2vQvbq5E02TU=;
  b=KWBqhyj/7KHgT3ei+YjoMC4HL3djhYtbhggsVGKP8LXNQ9V2FmXn3FbI
   IqUb01HBwbRJOPDGSWOft2R6UkoowEYqIxlcf29d4cDbAO39pcBV76d5z
   13xwQLgl2VO9x/gSdcZIZArU+zdCcE+ejKEyxlajyM9rjVXHv+/DHRcAI
   Pr7IjdlVNNrgIrPKj7NwMKwfWWespCC+/MpA+C63yb5xOB5aCV4mE5de/
   SngZSy4/dJcb1DLV4/jvoOJBJjHtuoI/d+Qh120wv5lveMZkt+J+lWkpF
   xy9RhSrn96N6FUr44cRmlDsaRYGlnSlA6FuV1kx+YQzlt0LB74v6ngvlu
   g==;
X-CSE-ConnectionGUID: JDMhGQYwSFqaLoOrwnnK/Q==
X-CSE-MsgGUID: rdhWzYF0TBO+sFYJ06SoSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77503405"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77503405"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:25:36 -0700
X-CSE-ConnectionGUID: b6YlvsADTfeSf1Nt3SwMMQ==
X-CSE-MsgGUID: CMsGHh+2QfmchiMl7U+PVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="234685271"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.173])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:25:34 -0700
Date: Thu, 16 Apr 2026 11:25:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: accel: adxl313_core: Use devm-managed mutex
 initialization
Message-ID: <aeCc-1p9qKlMf0wH@ashevche-desk.local>
References: <20260416051631.551250-1-sanjayembedded@gmail.com>
 <20260416051631.551250-2-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416051631.551250-2-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 16, 2026 at 10:46:29AM +0530, Sanjay Chitroda wrote:

> Use devm_mutex_init() to tie the mutex lifetime to the device and
> improve debugging when CONFIG_DEBUG_MUTEXES is enabled.

This one valid.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


