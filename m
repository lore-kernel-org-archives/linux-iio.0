Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80432AAA0;
	Fri,  3 Jul 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081513; cv=none; b=adev5HtwgEhAr55HEFJcfp+wh+9E0OYsUMhr7agWcnZdgvSBp7vjyZ/pazgSehXeZkprahsOvMpyXMd6i8VlnWq06pewWpjTfjWj92RJNpvC+IzHJhGzk9FnmGhMrPbt6QlTn/t952JcQMCkwY9kXKVWFlXIHDiXjd+/BrhBces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081513; c=relaxed/simple;
	bh=e1nuJFUrHXMqYPp1Om3pEOEhsrVbohkdZMw63EKJXbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVAlKcx6R4Rs9h3ZOqcPlo7nZgKXi1R+l6HYD4ib0hHbWBuK83UXsLBYBUsIMsQPP2xqLlwpMOqmVpGxwYK3Z9fiIeP2mAsTjjwPEWjm5UAL5adhKgpj1HNb19T/0EAWiuHq6Zn8HsgvDbh17A24P9Oyh4y2cLETx4V3JDtHpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfUcXudw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfUcXudw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783081511; x=1814617511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e1nuJFUrHXMqYPp1Om3pEOEhsrVbohkdZMw63EKJXbo=;
  b=RfUcXudwyw1TZKEg3M4kOMinWmBjMedi+7twg2tqnU6vwZFZBfwGM+nz
   3iWZqGc7NvkTZUH4I/nLADEmL8pRLqRmkTtFH/MBKJRTUqio23cENtBox
   lKBn1xIYhnPnJDW4IByHo58HNL6yMNofhGU4iRvSWWQ7t0II/2P3i4TZP
   +knL6cK8+SYe+wSPtvDHX0hiJW3NriMW49wrQj+znwNXyhjFdOlFgaLVc
   nleVFQ566V5291lByEhEFsIt1x9V5t8A2by+DMpn/7wMrXcNAfe3cfODf
   tDyJDUi+5bLsncZmBIBNdxWhBb6pbtTufUJT5HMbeXqRWGXyCSG7Qawzx
   g==;
X-CSE-ConnectionGUID: V2M6UINaTB+ZowNXs3d66Q==
X-CSE-MsgGUID: xPXd5qUXRnKCPINFJpvOSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="84025596"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="84025596"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:25:10 -0700
X-CSE-ConnectionGUID: iNPxtoVzTEKEebHT+8Duaw==
X-CSE-MsgGUID: p06MYZFKTeShTzSljCHreQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="255020015"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:25:07 -0700
Date: Fri, 3 Jul 2026 15:25:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/6] iio: dac: ad3530r: Convert sw_ldac_trig_reg to a
 function pointer
Message-ID: <akeqIffrdSE4bZO-@ashevche-desk.local>
References: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
 <20260703-iio-ad3532r-support-v4-3-69d9a336f4e8@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-iio-ad3532r-support-v4-3-69d9a336f4e8@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 06:10:08PM +0800, Kim Seer Paller wrote:
> The software LDAC trigger register is stored in the chip_info table as a
> fixed register address. Devices with a multi-bank register architecture
> select the trigger register based on the channel being updated, which a
> single static address cannot express.
> 
> Convert sw_ldac_trig_reg into a function pointer that returns the
> trigger register for a given channel, mirroring the input_ch_reg
> callback.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


