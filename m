Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F1371CFF;
	Sat, 15 Aug 2026 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786783759; cv=none; b=iVyt9EArZplzdHvTxXOZfl1CK+oBBb2UAC8f5wRDQNNBpVRWN+MUREih2p8a9c0DMtf8XOQnGthl4VdrPuMbxMuelgGHqMog1ps74KtOEGjRuJP9nNrBzJ8xu3Nk53bziNV3WA4kkSDnZkFfNAGujCxFQSPercNTxe0w/tZiuKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786783759; c=relaxed/simple;
	bh=alo5Ov1DLMQhxy0GSEloN9eIXPJMkDGaQRlhTtaIq/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2a7fl7x4MeXxf/tbma6UAMZiTXCNF7ZiRl2Euz9uNRZoZOcu8WL18kLjEuLUnYQz2KSvTQkfR8EX82xemaaOs3G0EqXuHV6tFa8NbRl/ka0cDxQoBL3b2OoSJ2xzcVmtqUp3X2Ul9I1I49Usv0E+uZXO3ejgs4Pvs6p8Ni39EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4O61wow; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4O61wow"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786783758; x=1818319758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=alo5Ov1DLMQhxy0GSEloN9eIXPJMkDGaQRlhTtaIq/U=;
  b=T4O61wow17cr+sN5lCiq8VY+u/rs87U7oWxDA9CC8Y5RzPRcxAGebSJc
   LT3zWx4LOIZEstcX/VTyhD1ryHQ9OlodrtU3eZqeT6+zU9SAtkBoqLcaW
   dcVjEpWtSk4bisJTpvuXcDy2+OXA/DqlUZ2hotfZC6hw91RqA4VJvLu9k
   IDccfN7j9dA6rFHtjhXv9ZelQIMOxqQCwpuzuGqZPVZ86iXMwfBHDSQaL
   KKhNy3entjkdXU8kO2vgJXbjiBpyI7i9TdEEGpL9ZltbhlFjnZ+NGSxJc
   5kHGk3JxrC9316r2DBsJipevZdAnCZdxhBdGD0GsdoTMPqJsSA0bSkRwm
   w==;
X-CSE-ConnectionGUID: TiXvr6UEQGe+tQUUyorARw==
X-CSE-MsgGUID: vL23lhw8RZGlWL+/c3o6mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="97690859"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="97690859"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:49:17 -0700
X-CSE-ConnectionGUID: hns83MNWQZOfj2TwOSxhlg==
X-CSE-MsgGUID: ifDXhbmwRJeDTNof1AEe1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="265049019"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.12])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:49:14 -0700
Date: Sat, 15 Aug 2026 11:49:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arka Mondal <arkamondalofficial@gmail.com>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org,
	venkat.prashanth2498@gmail.com, rohitsarkar5398@gmail.com,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: gyro: adis16136: fix unprotected debugfs reads
Message-ID: <aoAoCBgh048wLxtZ@ashevche-desk.local>
References: <20260814090728.965922-1-arkamondalofficial@gmail.com>
 <20260814090728.965922-3-arkamondalofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814090728.965922-3-arkamondalofficial@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 06:07:28PM +0900, Arka Mondal wrote:
> The serial_number file operations are open coded and never call
> debugfs_file_get(), which debugfs_create_file_unsafe() requires.
> debugfs_remove_recursive() therefore does not wait for a read in
> progress, and unbind frees the iio_dev underneath it.
> 
> Use debugfs_create_file() instead.

Same question as per patch 1.
But if Jonathan likes as is
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


