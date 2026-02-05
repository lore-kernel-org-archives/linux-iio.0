Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53A436372;
	Thu,  5 Feb 2026 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308685; cv=none; b=nttJPtFOu8fVWFoSZEkD2Cv0RZodY4buJ7VvITO6keu0RQd+uPssVcnM6ntbKVjyfGVYFp4tAq8wp4mAtk28+87oFtIQoghJU7DW2RkCa8p5J/w/X241adzYUPhNhreTS2zrGiq46aS3CBk0ikIST2VN5ExhEG0f5RkmiSkEpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308685; c=relaxed/simple;
	bh=ACPzu/0m5RPCbYNbNxhPsvI2JtfMXxp6pvl6FtQsmyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nicNMqH9mpSxD9PDN0D+ZTLWK0TIerDsmA0hGZD259G60enB6rzYrVgmlI6WVj/pnu01lYGzDLaOwOsxOeE7TYvo7foUdU01YeONPSi9yeISImD1quTzwmz26ssZ02vc75vaSnVt4f5kAIEhkJoXgZPmvYdb1+xEkqekjBVx9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LX+MHZ6r; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LX+MHZ6r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770308685; x=1801844685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ACPzu/0m5RPCbYNbNxhPsvI2JtfMXxp6pvl6FtQsmyw=;
  b=LX+MHZ6rlOiYQYhM4IM5Etxh/phcEZ8D/JztWAfNtRcM72586wOOIxle
   kHgy8zi5bqYEcw5oXStBAfCfvz+lXTCRVPyCTx3yz7yio5fyTu8UwqlSX
   +3eIQmgJWxvMEnWoytf1sGebOaHjJcHt/eSg1HamP+bPiqzbJma8CLrdv
   izuu8G0ZyejFgOnKuc0RCE4+eesd96r4qLYkGhaEG0GQznYIY4GHzHS6Q
   wjAkupYFcDKdEfV3hHt1w5PRxBYjX1huncI9B0u2o5kuFyCA7xd8rnWtc
   zRhpXViAiCNID1FnJ4f3aKoLeH298bcjAn+0XRCgsAHSbrKgX5qB9k8kt
   g==;
X-CSE-ConnectionGUID: 6T0/LumcT5u0qoiLNZJ3lQ==
X-CSE-MsgGUID: lm+ij+mQTLGkl5JBkjkbCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71609127"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71609127"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:24:44 -0800
X-CSE-ConnectionGUID: Ck301MD0Q/qZspLbDi5ciA==
X-CSE-MsgGUID: Q7+1twY0S8SuOf1c50a2OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="215069653"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:24:42 -0800
Date: Thu, 5 Feb 2026 18:24:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gustavo Bastos <gustavobastos@usp.br>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v5 next 4/7] iio: sca3000: make stop_all_interrupts()
 return void
Message-ID: <aYTER3TlrvhjEXC0@smile.fi.intel.com>
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
 <20260205131234.3244467-5-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205131234.3244467-5-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 05, 2026 at 05:12:10AM -0800, Harshit Mogalapalli wrote:
> sca3000_stop_all_interrupts() is called only from the driver remove
> path and its return value is discarded, so convert the helper to return
> void.
> 
> No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


