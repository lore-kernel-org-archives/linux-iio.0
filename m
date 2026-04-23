Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E130BF67;
	Thu, 23 Apr 2026 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930482; cv=none; b=G0Xv2FAf818Xhimxz29E+sYSmm48UDEmJElgFtT0lELgzxZyXkYLPJU4jWBGKZICyV5xG0LSRJ/snihbwVAkvmQ4mHQN2yvMYNq0zZkVW9ZyflnK2kmIavYzTqM9jXiOTHMiE5b3iqStGpckjFprkEt+dqxvDVtZlL1ElXBDrjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930482; c=relaxed/simple;
	bh=m10nOwVc0LJHKYyb9eRM431D+YxDjCU74BjVoBBz3RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFtqnSwOPavWkdC7fQb0DbpW+zUW/11FjGrAFgLogCM4JEh5MC+uUQEgTUFDEwG1ngjlkYOoJ9POqzFeObIjSMo3EApiOoKRW9KzKZ9WvI6/OlvgcvOx7JqqRJnWFuyNc9+yG0GZeV/RD3mEIFFTXWxsbYv5leTvxJDybrM9a7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgVBAwHM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgVBAwHM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776930480; x=1808466480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m10nOwVc0LJHKYyb9eRM431D+YxDjCU74BjVoBBz3RI=;
  b=dgVBAwHM85OeE7VjAcsb1YLuXHc6uOCwHtY8yBSIODRFc+EaKD9l/lCl
   i17kwtBGZSN92TNGL0P8ObCkZ2pJ9Fty0XY/6eq6OVCXG3DsIPgbPI8Cu
   R6AjRNAxNp6U3Y1BO0NKRtdbn3AuZ+pQxYT0tH5+HnZvzXtSdHBrBM6G1
   SvMO3gWArMl4U3y138vbfSD5BzrAPdjkHuIxtoyOnPLEtl4w0JtoKStU3
   jgqbhj+b0LYwxaGpmI2NC0dt5X1t1FTp0iczNuhn5w+1AJBiF6RKtpSAC
   yQhcXhfg7S9SgD89NXN+XmqQo1EHgxKwU22vTqpxojKflZm/SR0IDXvz6
   w==;
X-CSE-ConnectionGUID: dUmoJApkQESfeYqgLEWclA==
X-CSE-MsgGUID: afRCPjt3TO2iYmVrZBR9Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="81501240"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="81501240"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:48:00 -0700
X-CSE-ConnectionGUID: ktnZ2OnHQvabl4AvL4YfqQ==
X-CSE-MsgGUID: 0RMW5iaPTFOzK55wMUmoNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="229920483"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:47:57 -0700
Date: Thu, 23 Apr 2026 10:47:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: accel: mma8452: sort headers alphabetically
Message-ID: <aenOq-6mIB-AGOhr@ashevche-desk.local>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
 <20260422165643.2148195-3-sanjayembedded@gmail.com>
 <aekhwk14at43zT7f@ashevche-desk.local>
 <371383C2-BA73-49CC-B2E3-17A1B11A2D6C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <371383C2-BA73-49CC-B2E3-17A1B11A2D6C@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 23, 2026 at 08:00:28AM +0530, Sanjay Chitroda wrote:
> On 23 April 2026 1:00:10 am IST, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >On Wed, Apr 22, 2026 at 10:26:39PM +0530, Sanjay Chitroda wrote:

...

> >For this driver the regulator/consumer is a regular header and can be moved
> >to be between property.h and types.h.

> Andy, Thank you for your review.
> Along with alphabetic sort, I have also grouped different header(s), at top
> linux direct header, then iio headers and at last regulator headers for
> readability.

The grouping of some subset of linux/* or other headers is done only for the
purpose of pointing out the strong relationship with the certain subsystem.
For example, driver of the regulator belongs to the regulator subsystem, and
grouping regulator headers (in case more than a single one in use) makes at
least some sense. This driver has nothing to do with the regulator subsystem,
it doesn't belong to it.

In the above I described just an example, the same applicable for any subsystem
and driver. I.o.w. use the common sense.

> If you suggest, I would include this in commit description.

Yes I do suggest to move it back to the generic linux/* group.

-- 
With Best Regards,
Andy Shevchenko


