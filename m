Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8553A0B1C;
	Tue, 24 Feb 2026 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944950; cv=none; b=qcPUQoDD2bKyuS5/ZV7E3sZtQl0Sqtn7v+9d2xXaAqTGvUjZ90hbFR4Ywmt09GyV2WEGLekhsMFl0n6PUqMbJQIFzTLf2DZFA/P4214gOfvyQ6+xRz+kurffO/ZkoNQ7XdfGhfAqiSNMJyxZzmyJwSzEjIZPfRgCoVznbq2jiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944950; c=relaxed/simple;
	bh=lJxKAL5qDs58zhihPwhQBrlGFIUHljD85OEAlW0Ihd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtxV0a2ux6c+1uAMoeLrolUQEbl/+4wVZdYZDCz6LADpclo6gnfyPvru/ketmXFc7OJQhmHxyxobyRm+u5iz3B5mxhKg3YNv4c4t4ifIYVIodWYfb+AbA12e9PpRNIfwW/DVJsjInwN5YOGPiXGwPIZolLgFFlb1Tvq5az8KJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTls2qVM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTls2qVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771944949; x=1803480949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lJxKAL5qDs58zhihPwhQBrlGFIUHljD85OEAlW0Ihd8=;
  b=cTls2qVMyvn88oi0t3lFa0cwwff6QfFa4zFlnzJa7J19MJg5mmGRKrNN
   hKNWLwaUs1hjDx/NR/WkyRBcgOhpi6YGTShEgMhGcrO/nQajFtrq4YeY9
   +XWyHNMkv/oF/EvRmWWougTPPJWfiiyX5e8gN0VWdFrvVA4zgD2snzEUp
   qw0SvWEqj7H5TjcBAE33Z6JgAeEaJRV7lEJS7m7ayvR0Jl8uwHCFUZA2X
   /jczYkbdLxw7Degct8BHS0WG7RtBeDhNl6KodE2LlFv2zitmZg0k3cwYw
   wIioaGaZG3cVabcaRmE3XccphnAnirmMz38nIqYyCq7ygTHZFRwVW7lrO
   w==;
X-CSE-ConnectionGUID: mgG4PBSLSpGA88zT70p3LA==
X-CSE-MsgGUID: 11S/OXu/TZ6n2oIUIm34Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="75567203"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="75567203"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:55:48 -0800
X-CSE-ConnectionGUID: 7xxagAQfTXu9npeUBF3g+Q==
X-CSE-MsgGUID: UgcPexU/S3elkvHICdPJ1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="215797251"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:55:45 -0800
Date: Tue, 24 Feb 2026 16:55:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	rdunlap@infradead.org, skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] iio: accel: adxl345: Expose IIO_EV_INFO_VALUE for
 double tap
Message-ID: <aZ277iG58m-KGbI3@smile.fi.intel.com>
References: <20260224140351.27288-1-0rayn.dev@gmail.com>
 <20260224140351.27288-4-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224140351.27288-4-0rayn.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 02:03:46PM +0000, Taha Ed-Dafili wrote:
> The ADXL345 uses a single hardware register (ADXL345_REG_THRESH_TAP) to
> store the threshold for both single tap and double tap events.
> 
> Currently, the driver only exposes the IIO_EV_INFO_VALUE attribute for
> the single tap event.
> 
> However, the IIO ABI dictates that if an event is supported, its
> associated configuration attributes should be exposed to userspace. This
> applies even if writing to one channel property alters the value of
> another due to shared underlying hardware state.
> 
> Add IIO_EV_INFO_VALUE to the double tap event specification to ensure
> full ABI compliance.

...

> -			BIT(IIO_EV_INFO_RESET_TIMEOUT) |

> +			BIT(IIO_EV_INFO_RESET_TIMEOUT)	|

I do not see a reason why the amount of spaces should be increased.
The original one space is a gold standard in such cases as it makes
independent on the line length. With the formatted | it becomes a
burden for maintenance: each time one adds longer line, all lines
need to be adjusted for no good reason.


-- 
With Best Regards,
Andy Shevchenko


