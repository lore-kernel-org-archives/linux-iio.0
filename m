Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D5330B14;
	Mon, 13 Jul 2026 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958828; cv=none; b=VHqbOXY6Pml6V/7jiXtnt0DO7RxQf9SKCiRZSguiUIUhf/IN5TjGaaJ+FrwDAnbH9wJevwmyDrH6V/1mSmWH+xmkaQrag9wiGOXpDn9RRXGkTi756vceP9sS5HGJ4C8zYgWBkAx5z2o8L0FzYnrBxcUV9ed5EjRs/cCSUuWHjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958828; c=relaxed/simple;
	bh=KUbRFjuc54T87PW71f6FERCmO17oINJQt2zuZOvc0y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/nZaLq0bhbWb6W0I4zleRvySJ2PltDd5kwv3HseOGO3mm5EiAqK8ZnpbFBJQ6jTY2GlQZXmH3w6OX7NXWCvN6g5/TQn4F2RPObweBioViLjugIOh43fKijqMer5XYOOsNH+LYI9Jk4I26gX1cccdExiJEBVHenLapOZ1SdwOSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CiNTTxSz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CiNTTxSz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783958826; x=1815494826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KUbRFjuc54T87PW71f6FERCmO17oINJQt2zuZOvc0y0=;
  b=CiNTTxSz4sYcDychBQRj2cLugMzySitj+fNpznCEiwbzZD3X0xDein7z
   Qns/Mg1V4k4HqLiqzTztEcYrNG/GOoOQT5e/0Na074hsojkUen8aOrvIA
   CGuvkLMXXgtCWp4laFXLDXqEYTxgwWXIC72F6gvcZehb5UcdvltX/RFh7
   jbZacjRCbol7L7Olmd8mjNvdByg761/iQwytul0h8sIW+qtzK0dVIZ3KN
   l3G6LJ/Nf/v8hl61VPCH8ribZbSSF7KAnfz1v6rKgmiVccii/69ZgRbNh
   OTEoHZY3RmQbiwDZKUZZO+AhVvJIl4lmTyPQPTTl2Sza7Kd6Zy5O1UmvQ
   A==;
X-CSE-ConnectionGUID: ZbpHe3w0Rny33w/VUEDrJQ==
X-CSE-MsgGUID: KKc5D4dPR3KYXcO67+u6Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101996440"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101996440"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:07:04 -0700
X-CSE-ConnectionGUID: oWruuOjXSl+pg5ZDGxDGrg==
X-CSE-MsgGUID: KuWpQOJ1Q66aZOu8Q3+fHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251642496"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:07:01 -0700
Date: Mon, 13 Jul 2026 19:06:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: light: opt4001: Fix reversed GENMASK()
 arguments in fault count mask
Message-ID: <alUNIpZWdSV1Q3tk@ashevche-desk.local>
References: <20260713035736.11346-1-nikhilgtr@gmail.com>
 <20260713035736.11346-2-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713035736.11346-2-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 09:27:33AM +0530, Nikhil Gautam wrote:
> GENMASK(h, l) requires h >= l, but OPT4001_CTRL_FAULT_COUNT is defined
> as GENMASK(0, 1). The define is currently unused so there is no
> functional impact, but fix it before anyone builds on it, and add the
> _MASK suffix for consistency with the neighbouring definitions.

Cam you check my comments on previous version? This one seems has the same
issues.

-- 
With Best Regards,
Andy Shevchenko


