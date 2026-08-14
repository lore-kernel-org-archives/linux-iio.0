Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F441421239;
	Fri, 14 Aug 2026 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694982; cv=none; b=gOxBfxZTK7/yvAgsWnys7CABIcxnrMAodjU9wsI02rcVTg8Rd+R5AgvlYjm3mmy6EXGjUdxZzrQoQoJhE0nNc6nCqA0UsY9lYGBWf6lLDwMX57R9VHaB+fCJS6aK+TgxEHLPOJGGJddqlw5ecFWvpuAgM9/k0T6BcqG31eDNyD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694982; c=relaxed/simple;
	bh=jQr2b3VxS81BP2AonMpXYLNWd/ONbEFOrTkEGF0su4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJcbTM/W/JDNqHfnucXpsVE4oNKG6fUXcX8OQxOXjmP/lAk9T6uHfZfnceyV9N47iqxJ8E62j/xekU4NwNzusJBD132PmimQ5eo/kplEFCpoRLzNTdxhGvdgTJ43b9SUEP2SbKKLMRzOgpdD4jD7Ku0pNCIxHn5J0iSXB/RJpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmkkXOlP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmkkXOlP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786694980; x=1818230980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jQr2b3VxS81BP2AonMpXYLNWd/ONbEFOrTkEGF0su4c=;
  b=dmkkXOlPTqv/fkxE+7pPDJh5XPi2t+JiLlfEFcmz8l9e8NC8fXhb7m3X
   R0heASzTdugATAT+pyy59ZlrKQV81mRvSdimWwj3xXz/PGK4M3Kgr1+6C
   fnEO2esX8cDxv6edMpsYG32lwVY6hm+I8CsOlAPdIohco5a3gd0sigIGH
   ASEANm3BXaJQSeFFSnUsphAtUr8gJrV8MlicaLhXv4pl232UaMgYFucbB
   +vbybAfuBw0PXDHlVvjwArWCcuHdz/T0MqcSQ7OcIt6LfYQYOZS2hlH77
   CKnVon4yJCyBVH1kS+4QLDPMMjhF4tcmbhi+TQncIZaaDAEXwYN02/2o3
   w==;
X-CSE-ConnectionGUID: SbYhxX1/QuC8ETau6WOnaw==
X-CSE-MsgGUID: Aw1QAbGsQQa+uz1zUTC5rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="112817949"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="112817949"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:09:33 -0700
X-CSE-ConnectionGUID: +IP4D+yMT9aiiDRBUWnPeA==
X-CSE-MsgGUID: wUl26I7wTLe3o6/YFTlx2w==
X-ExtLoop1: 1
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:09:30 -0700
Date: Fri, 14 Aug 2026 11:09:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] iio: accel: mma8452: Support interrupt sharing
Message-ID: <an7NOEOw8Jn0id0N@ashevche-desk.local>
References: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
 <20260812-mma8452-open-drain-v4-4-bfca15d02b59@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-mma8452-open-drain-v4-4-bfca15d02b59@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 04:30:35PM +0200, Esben Haabendal wrote:
> Adding handling of rutnime PM suspension in the interrupt handler allows
> sharing interrupt with other devices.
> 
> Keep in mind that the device by default is using push-pull for the irq pin,
> which might require additional hardware design to allow interrupt sharing.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


