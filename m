Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F0838F620;
	Mon, 16 Mar 2026 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656668; cv=none; b=cCXVNnbjHqm1SLcUPjGqS6hCmUv4vvTXcBSEMbKCtTkGgdk9MKQln+I9bfUNkNxv2hRXOGI6njgqui34K6Zwq2m2rEZgLkeqBgyIVUslotSiZCurfyowyo7pFX+19rEspS0VNTzlsZc+0oVRrO3Acxy5uDtTXPL9to+XmC7cHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656668; c=relaxed/simple;
	bh=agLLKnC6utTurhdFvGrWvOs5pfXbj0I1fdGfI9RxrJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZ+4mJULBq5/XfcMn+Egfs/bAU2SJuUg66hoUBpkg4K0uFjkR2gnhQWjC3iJqPe+tHLjEBDPOKAtSVh0mhgFuFjF2ZcdN8ybIH0MttTH8aVD2/ofDdaqQuPVQkT8vEYdZXEjeu7NMnNrw2K3IF0n1rtnVi+4p2uVqT8AWHovBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbKtc5i/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbKtc5i/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773656667; x=1805192667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=agLLKnC6utTurhdFvGrWvOs5pfXbj0I1fdGfI9RxrJU=;
  b=lbKtc5i/YwcZefaYDL1j+spIWkbgMVxrrVcizQY/YFDVnKdMiQFU9c2g
   AMv+P23sIZL3ifWNUrnpwvfmJEHQUOC5XsNfqhtd4p5PGEN2o8pFsVlZp
   GbJokUFzg2sH1rNtrUUBG6GIBsGpdW2nodD4L6CZII7NyTqsi2rls9ZLJ
   szZPQSxV+G46vpp43UDNHD7bCfmvqxbIiO7t5+29eCtbcRxq11DB41WIZ
   lOtXI/8U7yaL5j7hN0sP4nqiSDEsaeKK1F5XTVSB2VfuxToatjjGnglaU
   cededC5xYFAk13RUjMEXCa/KrhvpEcmQ3aLlIJgR9zJeuaasY5YsC/prG
   w==;
X-CSE-ConnectionGUID: 1m47uOFlSJ2RBekgyeryvw==
X-CSE-MsgGUID: /AGpVidFQ8i0FlFigtdYbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="73683289"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="73683289"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:24:26 -0700
X-CSE-ConnectionGUID: ksaPXfGxS62GDR/izTPb0A==
X-CSE-MsgGUID: c5k2Fh94T8qW/OPqQgGq0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221956135"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:24:23 -0700
Date: Mon, 16 Mar 2026 12:24:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: light: vcnl4000: replace mutex_init with
 devm_mutex_init
Message-ID: <abfaVL7_tI1d4zcR@ashevche-desk.local>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
 <20260314-vcnl4000-regulators-v3-3-3c4a48d30676@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-vcnl4000-regulators-v3-3-3c4a48d30676@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 06:06:32PM +0200, Erikas Bitovtas wrote:
> Replace mutex_init used across driver with its device-managed
> counterpart, so all assigned mutexes get destroyed.

...

> +	ret = devm_mutex_init(dev, &data->vcnl4200_al.lock);
> +	if (ret < 0)

Do we need ' < 0' parts?

> +		return ret;
> +
> +	ret = devm_mutex_init(dev, &data->vcnl4200_ps.lock);
> +	if (ret < 0)
> +		return ret;

...

> +	ret = devm_mutex_init(dev, &data->vcnl4000_lock);
> +	if (ret < 0)
> +		return ret;

Ditto.

-- 
With Best Regards,
Andy Shevchenko


