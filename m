Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2EF2E7F25;
	Thu, 27 Aug 2026 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813143; cv=none; b=QoHD95QXwyn6h74C3u8Zdh1B4YhKxLoGkuq4iP77P0GAmPgwXhGsjTgmLQ9T+RI4t8fpowUFdneFJsiUaF/p9b8uInt0s17+NoaQTKR/btN08mKwnr3cZr5XEC8winmomHZz9XEb8rDrQ5/TXUoIeETpbQCWICxY0Wq+bAQtl2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813143; c=relaxed/simple;
	bh=r81i8jSaf5Zs6ob6azdt/DA70BWIBkn2ltg30YjO330=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYA7KrtWX2H3fAF0FuaOi69hNVj77FQKtyWiGbl1H5SH4/FLrDSHwsOqv6dSVLZZCmPltPHo+MC2guh2oJfKsKrDYGUCXPNPNoS+lx2V4Wm7MW2BgvpSFEOQHvwWRAIAfskbBNQggCZDG4/fvuhd+qeENTqnxiTurhOr2pELocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGO51eyA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGO51eyA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787813141; x=1819349141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=r81i8jSaf5Zs6ob6azdt/DA70BWIBkn2ltg30YjO330=;
  b=CGO51eyAGE269KWvG/vKRL8GQgdXAhb9mQloDFrU+hUWKGl9CEa4eO/u
   33hC47NJ7Lr87rvQxNunGzpsj6xVxYAWLaVPykpSUAbd4iC7D/OZQVZsI
   TlbJMDvv2dWuPI8i2rXa09oYFOi3Rv+b+YaAN/mum37qEHkRsFFIkFTmv
   BST5fqix4I6Rl8g1OeEwKH4zbo5B2Eb/KNt2sxp59Ms20Y39RGfI9TiQ1
   gSsvYsYu8DRpkbV1lleO0VtKMtW1q4ZaoYnTxZ/6cUuWnwybugEppjtc6
   LSZLgQ6u+MRx18c4exk8tHyOPC0a106S2NLVKK8htnPblAbcWl3UxrfFr
   A==;
X-CSE-ConnectionGUID: prMTnFodStaPYhNdpH5+9A==
X-CSE-MsgGUID: Pu11SQ0RSxCQLVPtGNgzSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88361158"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88361158"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:45:34 -0700
X-CSE-ConnectionGUID: Dn/Q9CMgSW+VHgUnCFwqog==
X-CSE-MsgGUID: N1629AFNTa+aYhqKHy6dGA==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:45:30 -0700
Date: Thu, 27 Aug 2026 09:45:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 1/5] iio: light: stk3310: lower-case the i2c device ID
 names
Message-ID: <ao_dCDDpw6eBIFhN@ashevche-desk.local>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
 <20260826175409.326131-2-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826175409.326131-2-jorijnvdgraaf@catcrafts.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 26, 2026 at 07:54:05PM +0200, Jorijn van der Graaf wrote:
> The i2c device IDs were introduced in capitals, mirroring the ACPI
> _HID entries added by the same commit be9e6229d676 ("iio: light: Add
> support for Sensortek STK3310"); at that point the driver enumerated
> through ACPI only, with no OF table and no i2c module alias export.
> ACPI _HIDs have their own naming rules; i2c device names
> conventionally use the lower-case part name, matching the devicetree
> compatible suffix.
> 
> The spelling is visible: a client instantiated through the i2c sysfs
> interface under the lower-case name taken from a compatible string
> binds through the OF table's name fallback, but has no firmware node,
> so i2c_match_id() is the only way for it to reach driver match data,
> and its string comparison is case-sensitive, so the capitals can never
> match. Lower-case the names so such clients match the id table, and
> receive the per-chip match data a subsequent change attaches to it.
> 
> The module aliases follow the rename (i2c:STK3310 becomes
> i2c:stk3310), and a sysfs client instantiated under a capitals name no
> longer binds.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
with all responsibility for the theoretically possible breakages
of the weird setups. But I strongly believe that no one is using
capital letters for I²C instantiation of this driver as it was
submitted for ACPI use and followed by DT support.

-- 
With Best Regards,
Andy Shevchenko


