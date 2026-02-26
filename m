Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E839447F;
	Thu, 26 Feb 2026 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097722; cv=none; b=DNMNmrUe9PzHwebDWi00PClxQL7fjtEDMVpbSnf2IWo2V0mf/+xXj/VJalUMsIaCBvsnFSZpUvQktdGZOGejcUAnew0/sUJS44YowllURPSBkq7LQEopEVcI8FNHMCoXpCJpMQj6nA2kvBQDTyN9Tt5UJ9ndLAwXjSE1mtFdtg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097722; c=relaxed/simple;
	bh=x36sg5SEmisj8Lmn/HL6sCB4Wkkksm/NsWePo1L1o7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgNlN8w1J21BUXbaGkq3UmhVgJY2IA8wtJMCzlJ26Jr0O09Ofyq9m4Gq8wvU69JPt4eZFkmrJlCRfXbMDZzQcODgevKroUzIG99eoVqa78L8lUlmklSDz+UqFSs2OHHTPxoHKQwAIYCUqwcIKGvA7MwKsIVFs5EN9rF0dO8H9vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vu+fRvMl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vu+fRvMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772097722; x=1803633722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x36sg5SEmisj8Lmn/HL6sCB4Wkkksm/NsWePo1L1o7U=;
  b=Vu+fRvMlJQFiqROfosVmQ5Y4++SpwdyKeBl82rtIcHIr9sl7DrU5U0E5
   Wy3v6IEP1Ea+3zCndKoSxlptQXowIablrIns5w95OD62MoPi0utMHuNUL
   cIv1sBDHkiKgKPYFccZv2OZ80r2OxWv8MXTpxf/nSKJGPUmXP/vAjWhbV
   QoKOvOgMDf8yICYrAci8uH+4la2Kp4rjKfiA8ZwUOgBpBxj/yoP65cri1
   HBYvFuk4JRYTb+y8LBC+n1jQ4ZvftR2bjxprolxYhajmNKc+uPDMKLwVL
   S6G3HWcoBHTBDuwn8xNvq+hwme0EPA0YSB927eAffJcwj6lDx2wkmEMZl
   Q==;
X-CSE-ConnectionGUID: 2YPlrmxNRTa17y7X2zs2BA==
X-CSE-MsgGUID: W4F4PTILRVWD8noeMijnpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="95768603"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="95768603"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 01:22:01 -0800
X-CSE-ConnectionGUID: o2TaSApZQZuxpvYS2ELeqQ==
X-CSE-MsgGUID: bD/Sj0sASMO86m0DnQObOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="215748300"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 01:21:59 -0800
Date: Thu, 26 Feb 2026 11:21:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Francesco Lavra <flavra@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] iio: ABI: Add custom data type
Message-ID: <aaAQtJ5WTDtkxi08@smile.fi.intel.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
 <20260225101806.2368391-1-flavra@baylibre.com>
 <aZ7gdO58NV6gjgWC@smile.fi.intel.com>
 <eeb28077-0886-42b4-b468-21f5c6a6444a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeb28077-0886-42b4-b468-21f5c6a6444a@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 03:27:55PM -0600, David Lechner wrote:
> On 2/25/26 5:43 AM, Andy Shevchenko wrote:
> > On Wed, Feb 25, 2026 at 11:18:06AM +0100, Francesco Lavra wrote:
> >> This type is used when the data received from or sent to a device cannot be
> >> identified with a standard type and must be processed by custom userspace.
> >> Any driver using the custom type must provide a driver-specific document
> >> that explains what the data represents and how it is to be interpreted by
> >> userspace.
> > 
> > This rises the same Q as for other firmware-hidden algos, et cetera: How
> > can we prevent the kernel from being just a simple proxy between HW and
> > the userspace? What would be the point of having the "driver" in the kernel
> > space?
> 
> I tend to agree that this opens the door for misuse or an excuse to not
> make the effort to develop something more generally useful on future drivers.
> 
> For this patch series, could we still use IIO_ROT and introduce a
> new IIO_MOD_PARTIAL_QUATERNION that is defined according to the
> description in the documentation patch in this series? This may be
> the only driver that ever uses it, but it is still clearly defined.
> 
> Or perhaps we could even say that if a IIO_MOD_QUATERNION has
> .repeat = 3 instead of .repeat = 4, then it should be interpreted
> this way?

Not sure about the latter, but something explicit like
IIO_MOD_PARTIAL_QUATERNION sounds good to me.

-- 
With Best Regards,
Andy Shevchenko


