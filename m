Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3EA1624D5;
	Thu, 25 Jun 2026 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370453; cv=none; b=NhFsz8h7bMwYKTWedUHFYQQMLenQLirSBi01kFIPn3hx1ovR1czdu54Snp62hrSyDlm+r7Cr6WFcSeUwOPX8fiGH5xiwSMTpTyBpZRgIZq0fVzNy0FtBLQ32EzeeUkBcUJE3WoWTPXEexN9A3a7QKfO31bXFYZmoFpBknRQU5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370453; c=relaxed/simple;
	bh=SpkGCVaXTH80i0ERGrvgfINFsE1ye+P/NMqAJfx7mQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zir9eRJwnK9iSGOF5ndQS3AS0mSRV64XQZpufUzP80cLRkqRKoEbAj9Tcach7l4B5aZdKWiSjnKSMTU5zmwCVcyMC3TqKLWWQKqG9uoEbJuNhvG5nSGKSr/+Q8x7NnA5kDCGY+EsG/x9gxy7/ixVHb6vuWGl80YeI4eBHxIb9kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWeugNaj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWeugNaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782370452; x=1813906452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SpkGCVaXTH80i0ERGrvgfINFsE1ye+P/NMqAJfx7mQA=;
  b=QWeugNajoy5TK+4MRxx+pMWZYela6hvdNKsO47Fr4vaOSFW+LOC+RfD/
   9lKLP+3lfrBBE+kRR4Won9O0lDW6CKzhN+DCNsC+/y20EDWUNu131ZNwi
   p72wQZ4cAoLetxhx6xTuNOvRnpKV2GWQOx1N1BJGsRPzbwXkNNFn3GLwk
   AdAct4PbWzq9u6HtnOcgjxNTUXvRr3jnbt+xK38FHkqKZdeORqaEjADOn
   jJhpcuE77RfQVZ0GJLic42eZ+qCvBNc3am2LBGSVMfceDap9WJ1OVZBOC
   ZFiEoYtpglMNAtAjIztc0Leiloswy713mJO1CmyUmoUCQBAmP7oHbOsjk
   w==;
X-CSE-ConnectionGUID: H5644WT3S+25MQ+ndaf+IQ==
X-CSE-MsgGUID: DKGuysKSR2eVw+Vi8SCqOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93744112"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="93744112"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:54:11 -0700
X-CSE-ConnectionGUID: dK7kHNpYTTSXmC6hMXSoZQ==
X-CSE-MsgGUID: 3KRRe1GJT3acQ9fhuYdgvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="255322851"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:54:11 -0700
Date: Thu, 25 Jun 2026 09:54:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: imu: inv_icm42600: add buffer hwfifo
 watermark attributes
Message-ID: <ajzQjmSDFvLo-eQE@ashevche-desk.local>
References: <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-0-5d9a4c662f50@tdk.com>
 <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-2-5d9a4c662f50@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-2-5d9a4c662f50@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 06:21:19PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> Add hwfifo_watermark/min/max/enabled buffer attributes.
> Hardware FIFO is always enabled and used.

These attributes are already documented and being used by a few drivers.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


