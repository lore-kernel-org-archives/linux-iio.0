Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5842A3AE713;
	Wed, 19 Aug 2026 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149447; cv=none; b=kMRcuVkhUxQQLlTQ5bRdKo8JvxMiV1sqHb8p7DoSHZryzRoOYqI+QDnmmD9hlx8083Sc/kB/wKdXxDLv2qMaZsCBmWw+EziYl0Q3mEV3v5dp2VVtHIbThd4+AOL2hmE4/mXmm1tjOdvlBGCa+zYoNAJvVZpnVp95GnqWy/aVpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149447; c=relaxed/simple;
	bh=lfVsR5dTj03BNRRDwc9USnpgySM/J1k144lOa/rcVJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFtZJLdMGM//Ym2bNpZ3ys3/6T4UPZFSon0KikzHrTFyTBjz5haIe6Gyz7HJ9NOOTMcMAtaj6EGM9EfvDlU4/6k7GR0wmHdB/3hyZIx3ZDqwzOiKIquupD12L9h6RMbtXX0MkmTfo/mU105IvLIJc2JI3zfSjiwRxv+FeXYWBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MeNcmB3i; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MeNcmB3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787149446; x=1818685446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lfVsR5dTj03BNRRDwc9USnpgySM/J1k144lOa/rcVJw=;
  b=MeNcmB3iWe0qfZpaEMxYf/hFWCrzR6OvCyeSmqXzepUbPV6Sii9sziy7
   OuO/9NAAUHOi3xGeQNelojopUetUtTZZSTNtxkN3hhsOvofl+JDhhkHEe
   YZfXpx2e/m+m4zHn3bmQ88dda5MKYt7pGpmN2XFMcGjc0a3mpIxmVrUW2
   zfr2TcUeaIEqIOk4FtvaHjE543ocbVHpAyu/BAvggTUq4B3bSFuBqvdzp
   yvdsiIpST3fyzk2DBqZJ4sJbcHDpRDjZJxV+NbRTeMsz5Q3EkLeGThYxN
   MKQAmsDPNuiMYLQtlz9r4rJeNLGqoefvJP4gAyJeFxwDojfUoqslwha8Z
   w==;
X-CSE-ConnectionGUID: Iny+6nSeQyyFQfrwIwV70Q==
X-CSE-MsgGUID: E0G7WvZ7T8K0LBUqTDm+ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="90185087"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="90185087"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 07:24:05 -0700
X-CSE-ConnectionGUID: k6TzAmm7RkK2AqTnD/1LVw==
X-CSE-MsgGUID: EiiyeFXjSkmBY6+hLVbbZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="262311903"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 07:24:01 -0700
Date: Wed, 19 Aug 2026 17:23:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/9] iio: dac: mcp47feb02: use dev_dbg for invalid
 label
Message-ID: <aoW8f9wAm4uoJEkB@ashevche-desk.local>
References: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
 <20260819-mcp47feb02_refactor-v4-4-beb2aa3bfd09@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-mcp47feb02_refactor-v4-4-beb2aa3bfd09@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 03:41:08PM +0300, Ariana Lazar wrote:
> Correct unneccesarry probe error returned at an invalid label with a debug
> message instead.

Why?!

...

>  		ret = fwnode_property_read_string(child, "label", &data->labels[reg]);
>  		if (ret)
> -			return dev_err_probe(dev, ret, "%pfw: invalid label\n",
> -					     fwnode_get_name(child));
> +			dev_dbg(dev, "%s: invalid label\n", fwnode_get_name(child));

My gosh, the patch before this one should really fix the fwnode_get_name()
usage here.

			return dev_err_probe(dev, ret, "%pfw: invalid label\n", child);

Otherwise it's a good way to Oops.

I haven't checked the rest, but this is how it has to be when %pfw is used.

-- 
With Best Regards,
Andy Shevchenko


