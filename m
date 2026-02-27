Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2767327472;
	Fri, 27 Feb 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210025; cv=none; b=qgojL0rBB5BJfEalNyDlXpgCcxH8WsA3h5gG7bBdljuFbb1xnQO9OcyJSMWgeGdDYFD8fwweW1mtpFEmSp0zh+R+GveObjQ2CXrBsXyr2lE0BthLHo4NbBrjL+wTmKfk+rxFaa4kIHWpV+NvGNzL4yUSGJak5s0XiZ9xakeVJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210025; c=relaxed/simple;
	bh=fb818+VGffS5v8oPFFqidYRkpIgK0TxJtsrTpYLYlu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEYX5t/kEm4iPdgvS2fVEqvOhUeu+TbpLZ80PdxCmkCe6HRgM4DD1pmqG3CYgReGNQ0OvlYLFgEuRHtNM02QMaiIdQbXj5pQ0PsEVrm7ZU4fVqTL6DQ3W0JyCjszEERpg6yznAXf0pxfYhZUphDNlCN0at1Rd98zVkpE37ptC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rc/2V7eN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rc/2V7eN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772210023; x=1803746023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fb818+VGffS5v8oPFFqidYRkpIgK0TxJtsrTpYLYlu0=;
  b=Rc/2V7eNPVN3dSjqpSBKQsSuk7vZ/m9qZs7AX9Rrp2rzlKDE9RwBmxiP
   5OEyAR7s+9tac0YOyghFUWdpDye95XqFG9FQQ8eIHl+44TkvX9lIOgEdn
   o3g223o6nWpvdjCqL33uoXZriIhHPGdizupxGTbEkq/HCc/4+abAxsHWp
   /ni7NU/wSnoLA3epJtinATD3qRbnlNIQTXYgVJ+qQRfQh/Zh0bR+UD02r
   fEvo/wtHzp0/1z1j8OmwSXuk1DkiZ/X18bo3JEjFZmkJVWn/0aRME47go
   24P8KCJ/wzcODec04+9OUetxDEyXeBb2K0gm4QSo0qyTukMm00HI4ggP1
   w==;
X-CSE-ConnectionGUID: iOLe9jZJROuTLPpRnFUXVg==
X-CSE-MsgGUID: dRMxOPa5TQS6Je8DeaRgdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73362865"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="73362865"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 08:33:42 -0800
X-CSE-ConnectionGUID: T9dW3ATiReqnWSIetbvoVA==
X-CSE-MsgGUID: xj1CFBeLToGkYTThJsanbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="221445177"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.180])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 08:33:39 -0800
Date: Fri, 27 Feb 2026 18:33:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Robert Budai <robert.budai@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis16550: fix swapped gyro/accel filter
 functions
Message-ID: <aaHHYMY5hdxQYYPO@ashevche-desk.local>
References: <20260227122046.46710-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227122046.46710-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 02:20:46PM +0200, Antoniu Miclaus wrote:
> The low-pass filter handlers for IIO_ANGL_VEL and IIO_ACCEL call each
> other's filter functions in both read_raw and write_raw. Swap them so
> each channel type uses its correct filter accessor.

Hmm...
Would it be just a naming issue? How do we know that the code is now correct?

-- 
With Best Regards,
Andy Shevchenko


