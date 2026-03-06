Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D70F2D322E;
	Fri,  6 Mar 2026 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799901; cv=none; b=OpeLYmGTZO7WjcrGmwFjKZVTEoxLIxwiNTgvarD+BZu6T02WN8fvz0Ye9//k9Sw4QVazQ4B9OlAGju6ZB4OJRQQPMjM9O5y0nCo+tf1z3It+ueoc6CYb8rRGbK9mMWaHi67ItHX05XHK46KxdG71Jv1pLuEQspARZUnY9+f0S9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799901; c=relaxed/simple;
	bh=UFaCTgibj/ctFsqyf95oZE0azwZ1wC23S5ZPa5jTjcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAQETHPp2nMpFlpO8a1j9rYITGcgQ9XiutKzFrXON1Dnm/9VhZHgu5noy6Wo2DGTRAO6K2lSq8DNYKlSZ6vuPLh4s0gouLSbbLqO/1G15JSC/Rd4ZeLlprfJBEynob5zIbCz9KAM2op5Cft2FHPDgAzZrUsE3hDDqIct/ehpxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDoIwQZ6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDoIwQZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772799900; x=1804335900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UFaCTgibj/ctFsqyf95oZE0azwZ1wC23S5ZPa5jTjcc=;
  b=dDoIwQZ68pVT7JEz8/7divSNSoKeQbnmU/sR58+0cB7fuXkO19eSMVDE
   fgtXmEFCWCePN8VquKDYoQJMzECXzOtLXepMymooQY/0WqNgO3qAtMUcy
   FORAr6o55tTx9zhNx2hTo65TbBZ/ix8C6bUDoYhBcEWi59E5uLQBBkn2C
   K5a3pvDwf1fDZY7nGCwjXVzsqPublig6M6MAMppyk7PgOPViSbPN3ADog
   EXL9v4fmsQLbsqcpZhBdoFe8WeqRk8Jl4Spg7bx5ZmKH4t9qePIHJARhY
   FSy1xb5qkTu+Pcta/D31XKcB5W7h0zmUAQL4FOaVj6eQ5lLtWmj8zkgO6
   A==;
X-CSE-ConnectionGUID: zKc6kexuSKWcTxYkCbq4eA==
X-CSE-MsgGUID: 33mjb2KzR5SXHK3B2jy5Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73808496"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73808496"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:25:00 -0800
X-CSE-ConnectionGUID: FYvF9DnsTReCCTIzdf4jHg==
X-CSE-MsgGUID: rALAtwOoRuOahx9cl4FHXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="216136086"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:24:57 -0800
Date: Fri, 6 Mar 2026 14:24:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] iio: frequency: use dev_err_probe for admv4420 and
 ad9523
Message-ID: <aarHltUfqjWAOC39@ashevche-desk.local>
References: <20260306102504.42395-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306102504.42395-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 06, 2026 at 12:24:44PM +0200, Antoniu Miclaus wrote:
> Use dev_err_probe() instead of dev_err() in the probe paths of the
> admv4420 and ad9523 frequency drivers.

In the subject you need to use () as well: dev_err_probe().

-- 
With Best Regards,
Andy Shevchenko


