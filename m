Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0803376BCA;
	Tue, 24 Feb 2026 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927627; cv=none; b=XgTtOkCBdf0Bo7dbwPiIKduruZXCbOm8KINgJnVWdX/BcQNlymtlaKevOvM7BqE4RDr6ImMoLEffk0DftHr3eli0yc2eV9E0g8xfSV1McurGT+tWbbvEOibxtUhODEiBh5HaxgO/FUd92HF4lN1fPX6TIDr//qwu0/+HxgEqjX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927627; c=relaxed/simple;
	bh=sFWZCKCL4Iv8ix/G0v2lLfXDZOUfAoRefg4uXnM3C6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYZYsmCiHnVIWNYoiOALqYGNuneDl2g/eFFVTGbnuRVxAGbglZJGU2dA5Nnqu/vAfB+PPIjKlqIaOv6WAdC7yi2f67psTUuwnJSwID5D6FQF+97p1qhFszUgqR3VfIESggoxvXwbonSYxaL98Z0aB2eYGVaOf4owHlhxvTxTs3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O56VEg7p; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O56VEg7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771927625; x=1803463625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sFWZCKCL4Iv8ix/G0v2lLfXDZOUfAoRefg4uXnM3C6E=;
  b=O56VEg7pG89nSDgRvFOznZxOgraF7tsSezOe7IQgXOY7+z8HFgHeVodA
   YPW8TvQe8AlENia98GBnmFULwYSCAK7Di5tQwf/udjvDopAm4oi2CkBCJ
   UZolUHIe3mjXc5BnnZor//Yzkq/GLhTxNzTaqncnjLLvd2sJQafCpuTuB
   qKzYicirskkxqAIxlPcImFwtmTeVTg5aNlx4wwpPKe1lqcjHfDyNfvQOL
   vEAdMvfYcaSsOT6n068wh0LEk+b06bhrZ/ks18Xkrq1cN1jo8XAPpY4lL
   1sVM8kEyIuyNrDb2TICQKkb2UUa+d2+romi1bwbahFdj1Etfl1ll74LVU
   w==;
X-CSE-ConnectionGUID: 3W2UomLzSWGaOCuZzlqGSg==
X-CSE-MsgGUID: /b4l9KW3S7SsK6EuvksAAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72814124"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72814124"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:07:05 -0800
X-CSE-ConnectionGUID: y3w3/C5YQzW+p4KVMriRyQ==
X-CSE-MsgGUID: zUrf5wS0QUK2Jnk5tBDlMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="213687639"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:06:58 -0800
Date: Tue, 24 Feb 2026 12:06:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: gyro: mpu3050: Fix out-of-sequence free_irq()
Message-ID: <aZ14P8c_s1AWLwUO@smile.fi.intel.com>
References: <20260224023511.274038-1-ethantidmore06@gmail.com>
 <20260224023511.274038-5-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224023511.274038-5-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 08:35:11PM -0600, Ethan Tidmore wrote:
> The function free_irq() is placed after iio_triggered_buffer_cleanup()
> which breaks LIFO because the IRQ was setup after
> iio_triggered_buffer_setup().
> 
> Place free_irq() in correct location.

With this commit message it's unclear why it's not a part of the patch 1
to begin with. You need to rephrase to make sure it's all about
iio_triggered_buffer_cleanup() in the first place.

-- 
With Best Regards,
Andy Shevchenko


