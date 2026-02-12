Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6012FDC55;
	Thu, 12 Feb 2026 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902505; cv=none; b=lVKUdE0pLCjcVZ4YeBPdwe/0s8bZTIHCjmVCMLoCb8yOSRcr0sHe+DnGduc3cFYHH6uf5D8HCyLkQtMI1JypjhS9wt5uOT5iD3saTJNcFqrAeS4wrEj7GSAnHhS++ui77TnSQf5A5lM+NUDCPbelZDC7xX4uy4fqROB/0lrHmt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902505; c=relaxed/simple;
	bh=yecgSILlj+OPsWAhLLjDemYx7VhuEXHVf668rM6NN9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW5xulCbhuHDRhQsptqruDh6G+ynHIy5xURjLtlZZYpRRA/cycDYHF/7W0jyDu0rJKFzfnfhtAmPlSWqEwfItTeqsRMuwson+EUfJafhPkuwe9vNCzTMUxuXg/AkKu/pjjj28D/yGsnJ5YTGigeyMH3Tygk3MyjgJYfPlIx1FBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDuzFpQl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDuzFpQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770902504; x=1802438504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yecgSILlj+OPsWAhLLjDemYx7VhuEXHVf668rM6NN9k=;
  b=lDuzFpQl0KueC0PnCXIQHc00HfcR7hVM+Po4mF+1W+bzBL4AF34wBxyW
   PbRSjX1e1vfzJQQEVhr0yKabwiz8al9cVKuLZsAgzdSmjc9Z/o23UesYb
   3GydNUwhYfQiqCVkvoGQXchVov7h09g3t1oCN9r+dpn72g8D9sJ01Tpn+
   6cN3zU6CTJQXfE0OXyX6uCXlOZzl+f0ynGkVFyHonabID+Eg9cGc0ovSI
   bvHDAAGBkLy3TYVF67bl61a8vl0hMQNmmTrAp4mlGwlsgL0XuXQD88LcQ
   EemKqT3ar3AFfRDR9murQbAPl2DloVjGU4mp/Zo9HrAq4MLiiq3DvvlAe
   A==;
X-CSE-ConnectionGUID: OyXD+qcHSH+WWdRD+C8Igg==
X-CSE-MsgGUID: 2YB/2TrBRPmM1EzWbFwKSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83440503"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="83440503"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:21:43 -0800
X-CSE-ConnectionGUID: UKrgD+fKSO2Xlh/eSorJAQ==
X-CSE-MsgGUID: 6RfIX4HsQAqbGk9SZCFzGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="211417088"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.145])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:21:41 -0800
Date: Thu, 12 Feb 2026 15:21:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: chemical: sps30_serial: fix buffer size in
 sps30_serial_read_meas()
Message-ID: <aY3T44bsexx9s2jD@smile.fi.intel.com>
References: <20260212124609.24745-1-antoniu.miclaus@analog.com>
 <20260212124609.24745-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212124609.24745-3-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 12, 2026 at 02:46:08PM +0200, Antoniu Miclaus wrote:
> sizeof(num) evaluates to sizeof(size_t) which is 8 bytes on 64-bit,
> but the buffer elements are only 4 bytes. The same function already
> uses sizeof(*meas) on line 312, making the mismatch evident. Use
> sizeof(*meas) consistently.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


