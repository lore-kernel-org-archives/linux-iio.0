Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA9845038;
	Wed, 28 Jan 2026 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638904; cv=none; b=KjmhvUkNWlnPefMjET7bbWix33jQw/zMqva/4GITOEGYjLp616dUq6xkqWDMmwSgeidfVMmCEjrAQEzDdEBwDgzu/jjY1X5OmsjjcVy8xYPpJFqIYEIrM0JvrlRUKcIdVZT0oGSyubUmV1w3TD9wAOnSmuXaU48pNNe7eM3Sv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638904; c=relaxed/simple;
	bh=FPjJRQCEZBhs7jA/3YfYte0MmhOZgUQN3GjUfB2zQMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWTWVoTUT0ju00N2p4Anwq6fL6/yle+uQ5urnKhX+DLld4LYgrJOd/hwdBE33Cx8ERF1zQxNjBqt36M7kY4fbPTv3a5BfuDZ+YwmgWLdd66/hVPywt/U6WE6zLU5TJGo98J5PQ9zIUEeOLWcIhmB280P2K7v2PMOxbYMpWWT3Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afIkjjmH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afIkjjmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769638902; x=1801174902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FPjJRQCEZBhs7jA/3YfYte0MmhOZgUQN3GjUfB2zQMo=;
  b=afIkjjmH/XE2+vKK1+yXL7ntNjG/sb9qdmFRFhPRYjO1McKvua5VWsfI
   Zm9CpyPvMdDbSHiz5rCYyjghJMekjA2AbOTArYqFZkyXWUyLiBbm8r8N1
   iF335xn/bOlt7trRFfImddn6fBTsQhA+ZfleaM+097Jh9mQRz42zSQ5RM
   O4CAkVrS+8b+V9h+BX0DPpgPD/EVco/vpsMxpDcY5sy5ve/XeQZ9SslZb
   0l3LDM1TclgRO9jNSgjfroxQPFe9ONTiseM18DcffDG7AxNXp2Swy5rhW
   ZIOqjvj1eHXkJQvlheHJuMF7DPXNWC1jUHkQO06OPCJyxVHWdguPl4Fk+
   w==;
X-CSE-ConnectionGUID: W74rffUVQey533b+ssxnHA==
X-CSE-MsgGUID: exe8Nu93TP2px1dpmJyINA==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="96328204"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="96328204"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:21:42 -0800
X-CSE-ConnectionGUID: 6oOSuCZvQC6Kdp1s+GSTrQ==
X-CSE-MsgGUID: LMgScZW1R+O/XC+OZAT35A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208821085"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:21:39 -0800
Date: Thu, 29 Jan 2026 00:21:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/6] iio: proximity: rfd77402: Align polling timeout
 with datasheet
Message-ID: <aXqL8RCxk_cF0TA6@smile.fi.intel.com>
References: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
 <20260128-b4-rfd77402_v5-v8-2-36388fe7b95e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-b4-rfd77402_v5-v8-2-36388fe7b95e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 11:21:49PM +0530, Shrikant Raskar via B4 Relay wrote:

> Update the polling delay to use a 100 ms timeout, as specified
> in the RFD77402 datasheet.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


