Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740436C9EF;
	Thu, 12 Mar 2026 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325169; cv=none; b=chGGSQ5rSC4hXPtY9GzY5zi5Y+gooQu6lpPCKCozjeD2wxgB16pKGSlrAUMbRJtqBwXiN24vZZGdG2vjakIYJMcFhgq96WKlKPzqRtdH1ajS/xjYBlxu/24Z9Sx39laeorh1YdINrvd5jXlOGqLpwoIbh0lB56pbtn7L2qzzzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325169; c=relaxed/simple;
	bh=7/9tfeXMQAWOxaof/jyltTdo/dGiHGka62i8DjCy1Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTouBQUlZP6dCLstsio2+Nq7NiCQRD+9x07BZKlmn/mdWe9Ys4yVBITGbH901GHYKYFEdLtiMKLS6zcMUIGwBWvWtxkjmYEzSPZ1VRwcWprmBPJ+ahJzT9Fjl/CJUTh1Z1VF7FfO40IAZaWpwrc0HogurYMf3UJW7EhBMf13vQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHd3sjWD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHd3sjWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773325169; x=1804861169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7/9tfeXMQAWOxaof/jyltTdo/dGiHGka62i8DjCy1Y8=;
  b=bHd3sjWDzFWBTFBCrhuJ9c5p2L18EWXKqsAGgQVaR0M2gyWcqSbfvPzi
   nScxK0e19dlgfK2LsdblXb3qIbtaAktgUaQ/Md5eEqs/t7ScGf05wP7Cg
   67KabepXy/DiSCEb4y7dZwtWLOT9TeWP/6UMlG/3dd8EXTZodfQAYoVqZ
   quLEnfnPrsWQ1VQ29PR0iO0OcQaccsKk8jCFbq/GpqQh0sWu6zhGtBdq8
   AkMk6fg/qjYgEBxIYAt4TiKWVCUfP1veUddU3ThqUMrH5ZNE34n2ZHO1F
   q4eNXjWpEYYuHjRPNq8z91fUTrimur4ZXqXPSwtcxG7YQ8441guHhfdei
   Q==;
X-CSE-ConnectionGUID: R+w9WWm+T2yVh8f+oJRWsw==
X-CSE-MsgGUID: QrBXBaIyQA++hH+4wRxWDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74460052"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74460052"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:19:29 -0700
X-CSE-ConnectionGUID: 6UqXitTYQSmDBFQ2RlzwAw==
X-CSE-MsgGUID: ULyi69ztR92wq7VHooWMzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="224976286"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:19:25 -0700
Date: Thu, 12 Mar 2026 16:19:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, waqar.hameed@axis.com, linusw@kernel.org,
	sakari.ailus@linux.intel.com, harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com, andrew.ijano@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: accel: bmc150: convert to guard(mutex)
Message-ID: <abLLap9bN3tTXfD6@ashevche-desk.local>
References: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
 <20260312081942.23858-2-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312081942.23858-2-rajveer.chaudhari.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 01:49:39PM +0530, Rajveer Chaudhari wrote:
> Replace manual mutex_lock/mutex_unlock pair with guard(mutex)
> in bmc150_accel_buffer_predisable() and
> bmc150_accel_buffer_postenable(). This ensures the mutex is
> released on all return paths and allows returning directly
> without a goto label.

> v2: Cleaned mutex_unlock and goto in
> bmc150_accel_buffer_postenable(),


> Dropped Header alignment change.

I don't understand why you can't do that as prerequisite. At some point we
probably go through them to fix, but since the new header is added, it makes
sense to put it to the proper order.

Same comment to other patches in the series.

-- 
With Best Regards,
Andy Shevchenko


