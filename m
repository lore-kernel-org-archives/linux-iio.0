Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5F3806B0;
	Mon, 13 Apr 2026 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075424; cv=none; b=MhT1yIKvz+iEFDR2EM9v86a51uiwuC8OrgPcAA73ao0nuRfTJZpEgEFK67mr0vSHW/fIb29gv4kye3dh/v+9CswLZrPb8KWkd1BFdc7j8zFV1v7LENFiqssLXvin9NAiEQt6Ob/2hmA8Z0mytiX96eGILrAEYIz8ahjULh0e7sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075424; c=relaxed/simple;
	bh=bJXW/L25AfgVc2j/U74dJ6XBjq4/EaaujPhecBaxi+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXMaOKklHaQVdWjMqOfG38jJrszJaRox7KtB3NVPv+hKfEfAWEtvxYM3lPsaZra/4DwBfTqEbS9t1F7J83VC5vHctG1NcpYns69xAtkWOQ23AijhSZCJhuzlXNFRulMG6Zq5LJoZniEai7s9ezY5QkY64+eKew/1G7tVDbNJCNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QN0nkhT6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QN0nkhT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776075424; x=1807611424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bJXW/L25AfgVc2j/U74dJ6XBjq4/EaaujPhecBaxi+w=;
  b=QN0nkhT66H/WJP+jKk8wJ45hmPzwVH3Uv+vtzLQzDDKdX8m9hUqD5in8
   KcQBquhSl7YB3dtn79v4Vl70k+WFHiBXnOAVs6wPIntwk67BTT1k2Xh2T
   HhMHRK7dsC9hcgl4kK+0j1FOv45emgkmN5MLaXRpq07i9cNpgfGyiZdVx
   rDV9f4GijYUcd/h3BuSVemkpBQIJnIcHb2yWJIoMgosQ4EtrAoR7Moa9n
   3lGoMma4Sw65web4NzhdOimtEydyjORsJrxnLdgrJmD2Yy4vURdXBGkbb
   Ah3ZyA7pAXADbMTy5+L1yjSkHd0kOWQkXasKXxAXNfkRJZFzoByQyPDYO
   Q==;
X-CSE-ConnectionGUID: lLqWbcw+TJOcyZEyandCpA==
X-CSE-MsgGUID: WYZZPQSiTRe+a1h+key+IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="77184377"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="77184377"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:17:03 -0700
X-CSE-ConnectionGUID: uGgcp24iR1+Wim5AVoF/Dw==
X-CSE-MsgGUID: yBO/q/uKS3u4/ciSldXZCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="231477238"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.7])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:17:00 -0700
Date: Mon, 13 Apr 2026 13:16:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: light: vcnl4000: register an IIO device with
 a device-managed function
Message-ID: <adzCmrGrdig6QTZE@ashevche-desk.local>
References: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
 <20260410-vcnl4000-drop-enum-v3-6-2ea2bc6f5dfb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-vcnl4000-drop-enum-v3-6-2ea2bc6f5dfb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 10, 2026 at 07:11:22PM +0300, Erikas Bitovtas wrote:
> Use a device-managed counterpart of iio_device_register() and remove the
> redundant iio_device_unregister() call in driver remove function,
> allowing us to remove vcnl4000_remove() function altogether.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


