Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C25B330317;
	Tue, 10 Feb 2026 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753467; cv=none; b=IHeOoK4SNcr5axOO2L+X9bE5YbVCYEjCNwDAAgwqhOhSLsnAejwbX5XeqWpt4L3cJVgcM3jbe4PpG9DQ8KAmWa7qnnUgDsc/1kWwcQXUdFXR6+pXa4Vp3OIZOKrzCGDE5jTfnzw+0KpV2dfqqSbW29oB0n1MYoCJMnsyjM3vVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753467; c=relaxed/simple;
	bh=jIwkzBg3gcHokPK7nHBbf3C9XLmbxnOoagP8vsGpWAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRDbXgTNd0rRWOgq/SdLz2dLu5VUQgMbzVwCB5BnHzO8whT5VxkgWmnloBJKeZiSJv+goXYlzdgsgQv0zSrbgFi8joyAUHLebED0nnkWh92Y14JqlKbNdU9k4pyEHOTP+Kn1XZ6UOnawKLUgBknNk9Ho/ollQQmfGaE7JaQ3lpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LV4F1WV1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LV4F1WV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770753465; x=1802289465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jIwkzBg3gcHokPK7nHBbf3C9XLmbxnOoagP8vsGpWAo=;
  b=LV4F1WV1geuBxdyD/8+XUvdVvnjalnMobW1L/fuGSeY3TUydtGl7PYaL
   JUwoEYl0GlXwrS0M4JST/c/pNbHAiB/175MGq51wrna2ev8WTqBQc8Emg
   m61ozRzaIHAVIpUM1EvFy48vvRHquvK/DWHW+8XAntc0Q0nYVk88GiaHl
   BII8PBwfGj21q8z2CIB+KCYIQ+ijJz39kVX1gHHiv8TEnR1Mfn1XULRsm
   9aPFX00CePawZjYNg0AAz0pAPPTUpnEb32rYdfMB8VktWv0Zvi8/u7tE1
   3bej5CeOY8ILPv0LIWaYp1YYBA+bChWi1iSTvmL3SE8MM44HgBqbhpY+6
   g==;
X-CSE-ConnectionGUID: AMr+RHUzS7ec/r9Ciznl+g==
X-CSE-MsgGUID: OSpdcRlpSxaAvTQwJgBn6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75740684"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="75740684"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 11:57:44 -0800
X-CSE-ConnectionGUID: EljGVXRhSc2GNxu5FqS2+A==
X-CSE-MsgGUID: qcG6DOwWSsGNoCQ/91xSRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="234991223"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.131])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 11:57:38 -0800
Date: Tue, 10 Feb 2026 21:57:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 03/11] iio: amplifiers: ad8366: remove unused include
 headers
Message-ID: <aYuNr8alZt-mjd5x@smile.fi.intel.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
 <20260210-iio-ad8366-update-v4-3-15505f7b15b4@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210-iio-ad8366-update-v4-3-15505f7b15b4@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 10, 2026 at 07:42:03PM +0000, Rodrigo Alencar via B4 Relay wrote:

> Apply IWYU principle, removing the following headers:
> - linux/device.h: no usage of devm_add_action_or_reset, device_attr...
> - linux/kernel.h: no usage of container_of, kasprintf, ...
> - linux/slab.h: memory management handled by iio
> - linux/sysfs.h: sysfs interaction is managed by iio
> - linux/iio/sysfs.h: not using iio device attributes in this driver

Yeah, but it also means to add (a lot of) missed headers...

array_size,h
dev_printk.h
mod_devicetable.h
mutex.h
stddef.h

(might be even more, this list was made just at the first glance).

> Being a small patch, the remaining includes are alphabetically sorted.
> In gcc, compiling with -H allows for dependency visualization,
> which indicates that except for linux/iio/sysfs.h, all removed
> headers are indirectly included by the remaining headers.

-- 
With Best Regards,
Andy Shevchenko


