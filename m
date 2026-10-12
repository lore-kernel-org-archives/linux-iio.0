Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FC4F4021;
	Mon, 12 Oct 2026 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837912; cv=none; b=MdGWAXDcvCPGsPfhC/GqQGiglJ6OVuqX0+AEHwjoU6vQ3DyHVQfZDXagn7F9SfP+jlUWd7+1imuHxrMaLATYHahZbevU0AkomznvfOZfEvVWivqx7Rj7Q5cFpGVCqKehJZRVrZygoh2j/yiMJPPicnlLM94WSdNVqpB4cPqYvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837912; c=relaxed/simple;
	bh=RM8jJmKmDKa8jkbKVsYAFl6lBaAbOK7EYH35y5dQQuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMeVKBCJVg7BsjTLYRNPlEKPyyEq/w394mr/NomwJoEJVfxJlaGBeI/5VSOI4TnCNAM5gRy7W39b/iVWvgkFLty6+v8In4u4xwj+sV7xivLXMfBVueWvA1WbLez62dnSfkJ778K7/kFSJlRfr1rN5/WwZES9NVk5FO8qOBtlqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0ngHwtB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0ngHwtB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791837911; x=1823373911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RM8jJmKmDKa8jkbKVsYAFl6lBaAbOK7EYH35y5dQQuc=;
  b=X0ngHwtB6XeB7GiRIo78bHCYhRz2i46c2+jH2zjODoEccx85q/aO+wmg
   XuWIaCNIJpGLZU78zpjTPBYjXZsu0rXFxXUJqlactYnk23nRyRk1REoTP
   k9Tf8DCPfPLUSSJ5WhMPTeK21vsX/r4rj9fbR9qSqR7pdp9ZZJ9Lomuzc
   AVTQiTlv3REqG6DjRbyOMd1SO7HK/A1TiC+BAFgioJAV77VZO6YziD5l/
   s+Zt/SzVpO/0lrBglbxZnKQEx4ZJtuJ51plTzuygulmKth10aUH91DG+d
   5LRCgMoN9RMMIowbmpW2/7fkaX3h+N2Q6Yxih5tytvXUQs7SeAvqBOPxh
   g==;
X-CSE-ConnectionGUID: WAN7i2JFR0iGiEWXaEh2sg==
X-CSE-MsgGUID: +VOA1GxRRGWv6Py3ExAeAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="452404"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="452404"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:45:10 -0700
X-CSE-ConnectionGUID: XnSA3fx6RsSQGEoQqpba3w==
X-CSE-MsgGUID: pcjhqoEDRVyRDAIRUTFsWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1099395"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:45:09 -0700
Date: Mon, 12 Oct 2026 23:45:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org
Subject: Re: [PATCH 1/1] iio: atlas-ezo: Fix humidity channel read support
Message-ID: <as1G0yGQ5wKhd-dh@ashevche-desk.local>
References: <20261012114553.3327-1-nikhilgtr@gmail.com>
 <20261012114553.3327-2-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012114553.3327-2-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 12, 2026 at 05:15:53PM +0530, Nikhil Gautam wrote:
> The atlas_ezo_read_raw() function rejects channels that are not of
> type IIO_CONCENTRATION, preventing the relative humidity channel
> from reading raw and scale values.
> 
> Remove the early channel type check to allow both concentration
> and relative humidity channels to reach the mask-specific handling.

Have you checked the Git history on this change? Anything interesting there?

-- 
With Best Regards,
Andy Shevchenko


