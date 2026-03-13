Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E639EF17;
	Fri, 13 Mar 2026 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411390; cv=none; b=uL9U6Mz2v/Kvru4D6cwPI7+QZK8xE1x9o5cbCfeleFAdWiAR21MMCDb8MqRvPl/tMA1hbLh9YspyCj7yRaQL7TpL+f695aHbVLpYGfjGytuVLcO4kxQETbkACf46pbEKRa6N1bBT6zRzQkUgpJUGncUdJ1rZFP1qOle15vNRKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411390; c=relaxed/simple;
	bh=z0suur1BvJ5sBXswvEPknYSglcvChaaHYLqGhohtWrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSTAt/uopQP+s1yfG5coQk4Yht4atNFzRPU7WdXeh/0ciC6K8gXVnYma1O9D+edjBqRs/jBknr2Tkq1DF7HWvPjSC875Rrb3i0gnH5xICmVFRqy92dOnfjOijo/oDr0+qMwFFZeiqGsMeYlRj8TCQydYQyhnjX3M4CigPkyE5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtAOjy3v; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtAOjy3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773411388; x=1804947388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0suur1BvJ5sBXswvEPknYSglcvChaaHYLqGhohtWrs=;
  b=JtAOjy3vq1KqRlnhlagiq+4WER7GFk5iKsbvb1r5oyx9w7JsdkrCWwnx
   N2pp1NuDxI9UFHWNa+T+nLg8MT+PfgmM4ufe0xqWSeovVpuoOG1QJaoFj
   WhGUBHodqNJynuuHSM9/fEKyvuo+txNnpbMtHFqYmg3O+Oaz7kIPTZiBJ
   LgzvnZYmRDEXHgS1SGh4FzStcTfeCHMT/1fePAlwTXhNhPU6oMe3CwxB+
   3LYH9gkBHAEkHMQydcRygL3aNObjjtGJlv9UD+Nj4CHcHWm9sOC4lKHbz
   Lc5RCtmchMWzgD5X8au03dnwo+K2OKZakTKdzNcntosr1OW1A1ECy9PXD
   w==;
X-CSE-ConnectionGUID: khlRnc4wQzaNrOppagZvMQ==
X-CSE-MsgGUID: MB6RJJTzS4u3rsl32dgVng==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74488326"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74488326"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:16:28 -0700
X-CSE-ConnectionGUID: Iz5NM0HWSYypeBik+/yL/w==
X-CSE-MsgGUID: Y/+1t00KQYCe1BhYv5Opsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="217179506"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:16:24 -0700
Date: Fri, 13 Mar 2026 16:16:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] iio: backend: add devm_iio_backend_get_by_index()
Message-ID: <abQcNb7xl-twuv92@ashevche-desk.local>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
 <20260313115856.87763-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313115856.87763-3-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 13, 2026 at 01:58:51PM +0200, Antoniu Miclaus wrote:
> Add a new function to get an IIO backend by its index in the
> io-backends device tree property. This is useful for multi-channel
> devices that have multiple backends, where looking up by index is
> more straightforward than using named backends.
> 
> Extract __devm_iio_backend_fwnode_get_by_index() from the existing
> __devm_iio_backend_fwnode_get(), taking the index directly as a
> parameter. The new public API devm_iio_backend_get_by_index() uses
> the index to find the backend reference in the io-backends property,
> avoiding the need for io-backend-names.

...

> -static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, const char *name,
> -							 struct fwnode_handle *fwnode)
> +static struct iio_backend *
> +__devm_iio_backend_fwnode_get_by_index(struct device *dev,
> +				       struct fwnode_handle *fwnode,
> +				       unsigned int index)

Why out of a sudden to shorten under 80? The rest seems exercises 100 limit...

static struct iio_backend * __devm_iio_backend_fwnode_get_by_index(struct device *dev,
								   struct fwnode_handle *fwnode,
								   unsigned int index)
is under 100.

...

> +struct iio_backend *devm_iio_backend_get_by_index(struct device *dev,
> +						  unsigned int index)

Ditto.

> +{
> +	return __devm_iio_backend_fwnode_get_by_index(dev, dev_fwnode(dev),
> +						      index);

Ditto.

> +}
> +EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_by_index, "IIO_BACKEND");

-- 
With Best Regards,
Andy Shevchenko


