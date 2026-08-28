Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD2136196F;
	Fri, 28 Aug 2026 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902787; cv=none; b=VarPowayAYEbIsjpQUt1OnRKzwT1RsGbgAkeAbGQz+NSKehqZeLGrVp6lByfPNTRErAt+xSSURpr0+7v1+6s03LoxaZ3vQK4K8YdURzFTVNKpn24Dbjrpf0bl0ZeDCXhGpOVtaYj/yfTs4V4L16vQjJy6xKEB+cOEk6MZ2uZvfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902787; c=relaxed/simple;
	bh=YGDtoi7z1qF/EdutfKRk13HBqjJlvaN8H0vRTMLNEX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loBY6XHHwwgGEumTTD0nVz8SqllrhfgIANoI4CYVgDO3654IgTUFeNuh1fQRUR4xflnY9BjTi75lv+aLj7bGmZfHrAvb6AX3K3Juyu3xW9ykythnWGryL0fwaLkPVcOf9hxJ3Ky1+L/RD5UBc70xHr+wxxjAmCt31y2Irr8xtwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aa/CdGrl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aa/CdGrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787902786; x=1819438786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YGDtoi7z1qF/EdutfKRk13HBqjJlvaN8H0vRTMLNEX4=;
  b=aa/CdGrlZmp2ygN4pKCojp5Mni4o9Vz7uaes7FnlymJAJsQ3ZiWUfAES
   uN7HZld+QMJS8dehIaSQvQ4+SgIduoNzIFd4YH+oiRw/0LI+d3T79LWmT
   1ISd5jmDZYx3U5Co+GDI09s0Atu3yCphDwVBNcr7+pkzvx8uKDacu8+5D
   WEV24/HDPDUx2UMWe4un4jefyygTizmFBdQPQ/+YS9bQO34UdqqnqluCA
   JgfFx6fJ+OOXANcUrPB5UYI6Gd9NVorb3jY6QQWB78biyCol6l6qdqjb1
   T2Xhpa7NHmg4Mw2oc+gMCWrAyICFx3HM0h61e8aitiwac1O4bQdxBslV/
   g==;
X-CSE-ConnectionGUID: ik6z/39WR2C0xNTnHSEqyg==
X-CSE-MsgGUID: uGNlrAefSW2v2IOMNaQyBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="98745016"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="98745016"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:39:45 -0700
X-CSE-ConnectionGUID: sjIk78kTRayang7xymgZ1A==
X-CSE-MsgGUID: bXiI1jbFSPelaeYRmI+z4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="291582662"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:39:44 -0700
Date: Fri, 28 Aug 2026 10:39:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: ABI: add sysfs attribute for _burnoutraw
Message-ID: <apE7PFLScvP8ciPa@ashevche-desk.local>
References: <20260827-iio-adc-ti-ads112c14-burnout-v2-0-00a1fab9e2d1@baylibre.com>
 <20260827-iio-adc-ti-ads112c14-burnout-v2-2-00a1fab9e2d1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-iio-adc-ti-ads112c14-burnout-v2-2-00a1fab9e2d1@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 27, 2026 at 05:27:03PM -0500, David Lechner (TI) wrote:
> Add a new _burnoutraw attribute to the IIO ADC ABI. This is likely only
> applicable to ADCs (but is seen on multiple chips and vendors) so it
> gets its own file instead of being added to the main IIO ABI file.

...

> +What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_burnoutraw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_burnoutraw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_burnoutraw
> +KernelVersion:	7.3

Can't be possible. See https://hansen.beer/~dave/phb/.

> +Contact:	linux-iio@vger.kernel.org

-- 
With Best Regards,
Andy Shevchenko


