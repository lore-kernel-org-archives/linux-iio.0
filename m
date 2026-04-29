Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383202FD7BE;
	Wed, 29 Apr 2026 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488095; cv=none; b=k5J8RpwvfXUUAsMIbxqtJxyDYuM9ThAv1KpFfxqMBxm5JGz5hDECyvtQqD4YV/cPC9CxOTm06AggQ2OTi/U1H/US/B1E9XpQXoRFIa/ZP45OKAEg808DCQRrFvaRYsOM1fHX2D9FcPMFrH7RS7tJAFLnSLwLziaOS0Wwar51Zfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488095; c=relaxed/simple;
	bh=MwO4qOlgwaSRgVWmqJfuANghsfAr0NebZUFTgiahG8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLVRmc2yB4z4zvA22kf8GhEmWVe7JRCsv8pX0/yHWCDjL0vrVXOmRCZnaqTFYVPSm7CZTtsm/Ntrhmqwr6/Oz5OUDjSXO7jb7lhij70wK1PGz4AtDzjUL02z8NTEl2US2+Na5+gdnuu32vSDGv/aMRLMn/rwPb2zMrWCMb9TYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5zlMygs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5zlMygs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488094; x=1809024094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MwO4qOlgwaSRgVWmqJfuANghsfAr0NebZUFTgiahG8Y=;
  b=d5zlMygsYEd2tqYw/8RUabasITYMONY4YXQkt9aXjtOvcjBNr+8DlaHr
   kW9qSNBfduDiarLInZbUJVSHNljPPkMfmlagi5vnuMmYBObJMw58elFmu
   aWWEGZ2viuAYh3EjyKP+mpt3M1gJ0sA1siPoqK04hq41CbtjzoCnBx4H0
   tVKGvpCMIzvj7ScsiB324E6UEfaTQs9Sn16ttfUqf1gmLUkaiBGx9TEUD
   K2hTHTAhrtWKZjYa+goV6qX+vGUWZPmwBjzHvQoLzXGiQm4C2O6v2VkWG
   62e8AfKT+RQoXG/+65ErND7X3Jjx9ZQXu4SMFf9yl4sq6VMsf0uBQzgx4
   g==;
X-CSE-ConnectionGUID: KCfxaLqpQUGZwqMx6iDc/Q==
X-CSE-MsgGUID: QHew+u4XS+G/w9vV2UqMCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89120656"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89120656"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:41:34 -0700
X-CSE-ConnectionGUID: 4tHHKXERTgGEyzD5j0hLOw==
X-CSE-MsgGUID: 4klv8xtERRqS8+sKLKqllg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="257928355"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:41:30 -0700
Date: Wed, 29 Apr 2026 21:41:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/11] iio: adc: hx711: move scale computation to
 per-device storage
Message-ID: <afJQ2Enf1821Arjj@ashevche-desk.local>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
 <20260429054544.123862-6-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429054544.123862-6-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 11:15:38AM +0530, Piyush Patle wrote:
> The gain-to-scale table is global today, so probe-time scale updates for
> one device overwrite the values used by any earlier device instance.
> 
> Fix this by making the gain table const and storing the computed scale
> values per device in hx711_data.
> 
> No functional change for single-sensor configurations.

...

> @@ -574,4 +575,3 @@ MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
>  MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:hx711-gpio");
> -


Stray change.

-- 
With Best Regards,
Andy Shevchenko


