Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233BB3AEF59;
	Mon,  9 Mar 2026 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073747; cv=none; b=nLvTnt+Hve+5Pb4SirzB6aEKudkFTBatwH3v1qx1aGEh59zeoffyXNYG2QHzL2KCFvjv9zyAPi3MuUFu0ixjogPFyRw21naqWzAAP+HyJsUTJ9BfVva2TugoD2kOZ5/LLCvLG/lNvWqHpAhL0XweytO6nO0HuUnHKjX6y4MAa64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073747; c=relaxed/simple;
	bh=9fhBg4Rr03DHi+xPgBWnhdnkTkq9lEnjy/6YuPBeSOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEhgs8ig0DEYod3OiGT1NMcSV3ysuM4RM4HhQsxdHWWoSXHJL1jeNqsv7sI00d1JK5G8FPKbm4lQRyoY8IhNyALhS6+tX1RJKdiOFzDZ+MGzVPAvG2XlVcJqXYVM+n93o/WchzuNWAMl0NGbzua4puaAzIP2rfWL62HAoo+bYzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1xRJofp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1xRJofp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773073744; x=1804609744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9fhBg4Rr03DHi+xPgBWnhdnkTkq9lEnjy/6YuPBeSOk=;
  b=A1xRJofpxpzi/goVv+NPExzBEWDR7L95+kWG6XQpHTk2vWcxDAmkwtB1
   GxeTYfIvbDj1W3ZCmbxlyGmd8wUBJS70ZFY3IKiE3XNKsrElKDpXLJwG4
   K7xnXBj+XR1sYBiMfuyGCps2mGv2DBCclZJ5IRtC0a5Pa8j7z/KoPrnnW
   Rn+dWy6DzVQCq2PgaToL6n7m9nOCPRhzv6zzsCNLBP6/YEQD8wESGZT1m
   ZJGe0XxAuzWzbzj3sjgBS50fy1xfa6bLL3JaX9C8UI2Mb0rHeOsH86UZo
   al/bzyszCHjJXKh89KLCvsTETsGDTsFS306rJ4U5k7YL59Q9G2dnjiafe
   Q==;
X-CSE-ConnectionGUID: ZzQAxjc5Qt6J9lxs23mr3A==
X-CSE-MsgGUID: H2SB9tbJSzKN0gmGR3ot9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84738815"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84738815"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:29:03 -0700
X-CSE-ConnectionGUID: vhaoo5PQTeC7L7g/Yc+ubA==
X-CSE-MsgGUID: AzBvvBCsRGWjxq1gT+bqNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="242826631"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:29:00 -0700
Date: Mon, 9 Mar 2026 18:28:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, waqar.hameed@axis.com, linusw@kernel.org,
	sakari.ailus@linux.intel.com, harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com, andrew.ijano@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: accel: bmc150: convert to guard(mutex)
Message-ID: <aa71SqlaSrXdpl89@ashevche-desk.local>
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
 <20260309153408.71512-2-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309153408.71512-2-rajveer.chaudhari.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 09:04:05PM +0530, Rajveer Chaudhari wrote:
> Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
> bmc150_accel_buffer_predisable() and
> bmc150_accel_buffer_postenable(). This ensures the mutex is
> released on all return paths and allows returning directly
> without a goto label.

Wait _at least_ 24h between the versions of the patch or patch series.
Let others give a chance to comment, review, et cetera!

So, based on the discussion in v1 it might make sense to have a sorting patches
as precursor for each of the drivers in question. But since it's indeed cosmetic
change I leave it to maintainers and other reviewers to judge.

-- 
With Best Regards,
Andy Shevchenko


