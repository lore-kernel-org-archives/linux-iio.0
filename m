Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47622C158E;
	Wed, 29 Apr 2026 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488948; cv=none; b=A/Ysi10JillYG1K+Jm/0b7krj/BK8luuqJzI0jyO3MlqKDBb6jQTQf9T+HV7G5blCPWXxFZt+4vc0dQEcw6qvbFN+g/TIUJHL4N30nPyBYmxXA+YN0nyGBIhGDuXSIjHPyXnHVKNYTtUwEG5nbCzxtLp1UX2oRcnlNY3GWjMvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488948; c=relaxed/simple;
	bh=TkXBfbcBUsTDTFlHeqMI9cIUbtPyd9MUR7oO6ZDdSL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YythZBWpRrsbrnLZQUhuPhbfvMB6osnPk9U7nCzpOvTaqTaVTUEtxUG1qK9hQZ7+cQYRm37rV8uEm25Cgu7maSVHDodWATIPo80hC4/GseQobbF5Zs3hLr/7TtEYvEuZHuF9NXALbZubCQYt8EVXsqDy5gAK8qCPoGW1IJW0Ibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYBfgd3v; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYBfgd3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488947; x=1809024947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TkXBfbcBUsTDTFlHeqMI9cIUbtPyd9MUR7oO6ZDdSL8=;
  b=ZYBfgd3vsEjnz51Pm33fuAY5teO8dwEFqm7VY6geNdnTnS/7T1/q3OvI
   iRJ96vdDDyYAEp4HGySN7DDO6OOydpdLCZefYWgLrlUAnFXBW+yDgWTaN
   5YT4ZGOs6/qeMYmZXFO4AT/UzAcJBnHBR+HonFYtJHK9qLqY6+/Q3gptc
   5N9GU1c+hDo8mMqobVzm7MyX72u4mpdgjZ7HMwE63uWBvHmWod+OEX6WH
   hyeP5bh41JecEJre8DrVb3KBPgR0bDW0awjotVjO/gp4xBGpMdR50eQLe
   I//0ZS++7XRmYoWMS5epUdgkZVZ50Ih+/LDniLbOvAGG3PL9F6BTfvdfW
   w==;
X-CSE-ConnectionGUID: 5YkJehw0SAie9T91WqdJNw==
X-CSE-MsgGUID: t4ZYGoDCQDSxdrov9XNzEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82035712"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="82035712"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:55:47 -0700
X-CSE-ConnectionGUID: S1g5z951Q8WZiP6QlvriiA==
X-CSE-MsgGUID: RLtbXEF/SgG72QVfSpbApg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229998161"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:55:43 -0700
Date: Wed, 29 Apr 2026 21:55:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/11] iio: adc: hx711: split hx711_reset variable
 assignment
Message-ID: <afJULRfOToKsSL9a@ashevche-desk.local>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
 <20260429054544.123862-11-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429054544.123862-11-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 11:15:43AM +0530, Piyush Patle wrote:
> Separate the hx711_wait_for_ready() assignment from the declaration in
> hx711_reset().
> 
> This is a small preparatory cleanup before the later variant-specific
> changes add another local variable in the same function.
> 
> No functional change.

As I pointed out this also should be done for val assignment in other case.
And it should go before loop iterator patch.

...

>  static int hx711_reset(struct hx711_data *hx711_data)
>  {
> -	int val = hx711_wait_for_ready(hx711_data);
> +	int val;
> +
> +	val = hx711_wait_for_ready(hx711_data);

>  

This blank line has to be removed now.

>  	if (val) {

-- 
With Best Regards,
Andy Shevchenko


