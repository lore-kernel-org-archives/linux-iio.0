Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D639D48EBC1;
	Thu,  6 Aug 2026 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049833; cv=none; b=ZNj2ZoDijX413tlJa5RX2U/CUpU7VPKh05+5Sv3FAlPSaea0AUz+AEacdtes43NRCmeVQt5HragG5Ht9pgodUHtTVSBS0AjnIvN9gCrED99C5VRq1qDdmvk4aRODzoN7HEwX4Q/qVHzaioPemxHSYXiOFmFIojWpPp9n5bnDNxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049833; c=relaxed/simple;
	bh=5VHHRFvGkmLObQWQw0BUeitBTfxe2qzuvS/8Id+Z8Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uyd6m1nigzQYM1iexQ9mvBoH8lJH8umkY4EQL9w3Nh/O8tYz+1XgSYbW1tYEUB2H1jbYoShb9+24IG+IC/HDCB5BsWRQqapeWTtVbEPTTnoQ36ptHVLkHSgqHAK0h+gp2pez+UfK1RVPP2K7qL48IMHirCr+dvFNiExeg4zzV70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3xuUmDY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3xuUmDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786049828; x=1817585828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5VHHRFvGkmLObQWQw0BUeitBTfxe2qzuvS/8Id+Z8Jw=;
  b=L3xuUmDYNicdCvvWzdipu7gvrzupD7shFRwYyQT7swYYVwi1GfK6d+9V
   WuerpM97CxOWt1mK+ow38lPsHQ3+5VyvrpUWvmmKt8VvdffYFasZ/3+H1
   JtcpU8uax/ZepCfbNt90QdP8lyITjGxtE4yBou9jIJvF7EuBzPVSMph8X
   GdiipPnH2YWUJGNi3UJCx485/A4t8a9vj+F5LH+mzkchXtl1BFGF4rxbB
   Fk8Z7EbCxx9mENrcZV8i1oUyitVqkoWQu50GZNtdDn9yVzSHXjdRQ9RHw
   GqVin9cL6AKqbhfuM8bNizJFrwoPx1CfKcxItF5uVRe7/AdWaqa3f2MAx
   g==;
X-CSE-ConnectionGUID: CqsjuUv4RXuA8hjkQOWaPQ==
X-CSE-MsgGUID: ieUq4EHQR8K9Qi4Ozu1bdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85627637"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="85627637"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 13:57:03 -0700
X-CSE-ConnectionGUID: shSRpJhIQdCaFnkIsj36Sw==
X-CSE-MsgGUID: g9lUd6qdRaanxc1EucnNPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="264204745"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 13:57:00 -0700
Date: Thu, 6 Aug 2026 23:56:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com,
	gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
	me@brighamcampbell.com, jkoolstra@xs4all.nl,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: frequency: ad9832/ad9834: add comment
 explaining do_div usage
Message-ID: <anT1Gl_zWWYrKG5Q@ashevche-desk.local>
References: <20260630032322.5805-1-raizudeen.kerneldev@gmail.com>
 <20260722082227.18768-1-raizudeen.kerneldev@gmail.com>
 <20260722104617.000050fa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722104617.000050fa@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 22, 2026 at 10:46:17AM +0200, Joshua Crofts wrote:
> On Wed, 22 Jul 2026 13:52:27 +0530
> Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:

...

> As for the comment, I think it's good, however I'm not sure whether
> this should be split into two patches, given that this is a small
> change. Andy, what do you think?

This is simple case and I think that Jonathan and others are okay with a single
patch. But, up to you if you feel like splitting is better.

-- 
With Best Regards,
Andy Shevchenko


