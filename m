Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBD368D55;
	Tue,  9 Jun 2026 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011720; cv=none; b=HkKJpUzMSG13VsRI0FTZ+QmGd+HUSNxqBskzS3yNJmdpFmDgjG4S6+xzHVZTRq775fnDY3pYA0ohN8dKIci2qZcvHzXiRPZnjDqkP0ggD1M5yB+aAL6dWgaZbp0gykKVi2V+Zd6/lUbYp/ZO2d3BSpHRnYvpx/MyvvZouBMMY9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011720; c=relaxed/simple;
	bh=+2DobK6PWj/gRo+sYKQRjT3nRO6wDy9v2BbBlQOiL0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faA67uuEmuqKgAeYnIu3KZzTzXmrCqYGmGb9pr7u09lZYNUwzDImyNszjl8cQTg2eeqJRhsyRbA7npv0CplX0SZP8j5b9cUUJvDuWlTpyVvfpRUDfU63fBlx7yD07iN7a/F3fFSJmXix9c2L3un3y2G5z3rTPqHFfGlLAKWqIPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kb4AG1u7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kb4AG1u7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781011717; x=1812547717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+2DobK6PWj/gRo+sYKQRjT3nRO6wDy9v2BbBlQOiL0c=;
  b=kb4AG1u7Dtk7FdWAV/qzwM8xYuuht5fRTgMxW/MhG6AmWEeldugIB52e
   IEyUGhnQTSt2cmU7XYe/04rvyZQpR61+DS7XInMXO43hvLroBju9MYHk2
   bAN/ObrDuIkuKCMxEEssVMAGC4dBnIDj3Vbi5YivUGrPeBVmQnPdoHq1M
   7ASLSdnmysRuYRhowGZCJ/l2G37Aumnll6WP/ssZdA79l+IG1c055+R7c
   wrwDQvLTTXRMKViZnerwEu4JGP2n1vD1PWmvM+jVC/kQcMbzggtLBaVAK
   uAyRQEgNq+0Yloe6fWI+lKhplMrwpyG0EhmPp4Gp/trvc78yOuxdeGz0T
   g==;
X-CSE-ConnectionGUID: +8TVKRgzS6C/utl6ghPUHw==
X-CSE-MsgGUID: EfPv7IRTQi2/X7aQ9aTPzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="107207616"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="107207616"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 06:28:36 -0700
X-CSE-ConnectionGUID: etG0tbUdQy+E3LaZph+UkA==
X-CSE-MsgGUID: rgW8aYkjSQiR5b1zIvFoww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245710022"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 06:28:33 -0700
Date: Tue, 9 Jun 2026 16:28:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jagathjog1996@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: bmi323: remove unnecessary cast in
 watermark limit
Message-ID: <aigU_yoAQxKb6POn@ashevche-desk.local>
References: <20260608121558.85429-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608121558.85429-1-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 08, 2026 at 12:15:58PM +0000, Hungyu Lin wrote:
> Remove the explicit u32 cast in the watermark limit calculation.
> 
> The BMI323_FIFO_FULL_IN_FRAMES macro can be used directly with
> min() without triggering type issues.

Right, now it looks much better.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


