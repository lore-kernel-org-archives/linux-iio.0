Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2B4C97;
	Fri, 20 Feb 2026 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771572291; cv=none; b=Ixovp8ib1yBC8jecOGDw0FX/fYc+XzzKnseJ0bwjxGfBGRzgN/mkaeV7lx3zOeEfKH2S/3jtM8V75DneOFNvToJQmq73ODxRZ62fWX9JLxe27W9z0s3tTCsBx6jBMZNFcM7QOO26MEGgPf9ahNHqHLgq3lFxAyFC0XnMCcNAj04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771572291; c=relaxed/simple;
	bh=fXOR4Xz2pe/nQ5N86PCT/PnHFOiNYtQz9Y7bVsnwViY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNiGvgWdvifzyLzpUFg1tUHN3XLAYokWpGRLAQvxClb3IQAlm0VTvLs2o6UIss5TMkwrvJkIvd/vq2EeHzH/2uBL8DUWSTIHHDs+qRcCCa0d4U7A2q1oK1fN6v0StxigHhbFJ/AICPv9kBEAs+1EgzcIK0LDlg4mmU4YkpUAf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZT+z3496; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZT+z3496"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771572290; x=1803108290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fXOR4Xz2pe/nQ5N86PCT/PnHFOiNYtQz9Y7bVsnwViY=;
  b=ZT+z3496OdeLLolzeFDJRWKejC+IQ8/U5eh/a+pndv3ukYhKgArBRyjt
   /gTvxRbgLP1Fdo00ohDMpkeBDk7lc2yPPYRedW1wHbCMP5Femw6xd1FxA
   ql6JAzIaRrsqFQdKbEffZh5SU2l6I6ZBbVQu5qGCGmkxoZYJxZZxaf3qM
   1PMsscIAaJNus2cK1o9uAHABpZ/ag15EQaGjp8v3AIfWDSs8ojbKR3DJk
   qFmOyGHmSgj3PSsPvxtSqRUeqbVR2o6qa4U1IsttK7ARyl8huoYA4qpg0
   0Z1mXckUecQk8mqn8Z9ytUJHGJnY1HvQB7YL6QpPSnIrwEH4sjbhTu3Vq
   Q==;
X-CSE-ConnectionGUID: kZzjZT2TRBOBxERt2GI9uA==
X-CSE-MsgGUID: +bCk1W8USgmEMnDswJ+a/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83769499"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="83769499"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:24:50 -0800
X-CSE-ConnectionGUID: dZ+0ct6GRjW+OrK23Daojg==
X-CSE-MsgGUID: /w+weJ7FSFGurrHgJtWDzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="213366813"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:24:47 -0800
Date: Fri, 20 Feb 2026 09:24:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: bhargav <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: frequency: ad9523: fix checkpatch warnings
 for symbolic permissions
Message-ID: <aZgMPcv4EYsrrjY3@smile.fi.intel.com>
References: <aZd2jAVnTIuz2o7h@smile.fi.intel.com>
 <20260219213549.59645-1-rougueprince47@gmail.com>
 <20260219213549.59645-4-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219213549.59645-4-rougueprince47@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 03:05:49AM +0530, bhargav wrote:
> The driver currently defines device attributes using
> symbolic permission flags (S_IRUGO and S_IWUSR).
> Update these to use octal permissions (0444 and 0200) to resolve
> checkpatch warnings.

Same for the line lengths in the commit message, use up to ~72 characters
per line.

Otherwise looks good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


