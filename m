Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF803E3D93;
	Mon, 31 Aug 2026 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176881; cv=none; b=kMlkaafGS7wmyGnJ+cmS3kxCQGJ/AOH/r8lAkwH0Cjqrcik4Wu438lLK3bY18e1KiOJC6cXT65Utw4YHpQguytbFtKOA2t9v7TJFzxCx00mFiQGzZdBxVxRHXRgJSISEIT5JYOnNRNtet2b2QhrV3bV7ZS8DetZprqqp3ZLppVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176881; c=relaxed/simple;
	bh=CvMttDVzfIg/wSZ/U/3eOT2zV4o6k4iRmm131k2rxno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVm98VWLMIgekTZQcOprXHAQHMZpnKIFWril/R6z26XMEKVz5vqNPgOJ4eXDp5Rwe4ZKdPXS2S7XMm56JMMjqxJr+TAlAIQMClG/7sNMDQjSLkHQAyjVLTYx7lBSs3r9pS4lOC8E+CExPGAoVKXleGQW8JzO9cZX4OwfuUdO/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gm/qhjOC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gm/qhjOC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788176879; x=1819712879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CvMttDVzfIg/wSZ/U/3eOT2zV4o6k4iRmm131k2rxno=;
  b=Gm/qhjOCZSvoiMOSZ/Jf0L1Cv3dHKI/XavyJSFxFrBnXq9x9XXJqO97J
   FhJRi3g+Im6vFMI0HE0XUoV3uayRGxNSW4B4gQiWQpyOzVagra4OZ0MKy
   YmCZ9ThQ5TC6xI1rkkwSLqu/Oq4/iD2+LycRbhTPNZRx0haie4XSDOf1i
   xbwAEu9EN1Q2kUra7v/VJR6PLJheF17pTaPkW4MNAqVVR5pMx+ku+U/56
   bZi0K9tHCokWxOpceNBoFZ5KX+5naHa5OmFZHAZe2dIx1zc2G70jMxiRW
   8XCe+KSdzhYfN3R4Ichr5V3j/zCvGqEA5mvEx/Q7IfnT3NS3kHzkxdHwU
   Q==;
X-CSE-ConnectionGUID: NFvdCpJHS8aOlh5JBo2N6Q==
X-CSE-MsgGUID: xQzYecFtT1qx+EM7mn6PtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="87529105"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="87529105"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 04:47:58 -0700
X-CSE-ConnectionGUID: FTf/ggnXSdaHaGY8LwKjpQ==
X-CSE-MsgGUID: Lhg/lC6nTwieA7mGV4/2Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="272578495"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 04:47:57 -0700
Date: Mon, 31 Aug 2026 14:47:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: rename stale IIO_DEV_ACQUIRE_ERR reference to
 IIO_DEV_ACQUIRE_FAILED
Message-ID: <apVp6vRQmyPi4EQH@ashevche-desk.local>
References: <20260831-doc_acquire_failed-v1-1-3c8e59c07d18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-doc_acquire_failed-v1-1-3c8e59c07d18@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 12:09:09PM +0200, Javier Carrasco wrote:
> Update the kernel-doc reference left over from an earlier revision
> of the series, before the macro was renamed to IIO_DEV_ACQUIRE_FAILED().

I would argue that it might be good to be backported, but who reads documentation?

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


