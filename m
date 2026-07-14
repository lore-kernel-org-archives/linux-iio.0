Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457EA47A0CB;
	Tue, 14 Jul 2026 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037381; cv=none; b=hvxV+YF2vqPNVwetYe9kAow1kiW2v3AwvO3B39uqpks+HnSlOFfGxx0cbgUJbeLuM5lRpfypwOem5rAl3HdPAUBIS2Iv/mCqxG58he4qhviXemGdoIhlBg/C7dIZ8CcJqK0UrUTZy855IsUTCuBRpRvpovROQ5K160QPHDpQWLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037381; c=relaxed/simple;
	bh=aEJbmoPDzDww3V1e9yF0lMmpRxnxMbp6pV6rlgS6oFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vyq6OU2WHH7uTYWhrNH5IJuDJqt4sJKcglO0t0mHkSDnfdu0dCg+L4TyY6xCozC7vYKrCgE2vVImN6YigNaTNlegecUxT95bdlcskz8/jDVxOQUBBOv+v1p2q48dXdGkRALm0jPUN/Dp22a7KOyqQhIReWT7EaprIxizh6FlmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPjE2q0h; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPjE2q0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784037380; x=1815573380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aEJbmoPDzDww3V1e9yF0lMmpRxnxMbp6pV6rlgS6oFI=;
  b=KPjE2q0hWCK9gW1vQTsjCrsuzkepJYGHU45Qt0/28sAJTLgTXPRlcZY0
   DhrXI+h0N7pk0BmSLtOGBy13xwhEA5vzCsUAeoG1ZKYTMUye96Ap4XtU1
   bSZI5Ui958Db240MPCC/WtATNsWzCSv8ZST4FDZb6Q1HgHZdbedTSJnFb
   hil/+D8rSsGCKqr4TBlTl8CkDfuU/LL7A8IWMZeJuY++7m67YwVQeXnaJ
   xyfbwIMMZqWQ7C3fviGIMfi/0RUc+8cWiZNa1lgNj1u6Pel/0kAOev0DS
   6VILkGGeOLGyAC+YfTgOHDcG2Y4HrDY2vMSfAjhY3kyS6eGt7iCa97gtj
   g==;
X-CSE-ConnectionGUID: TiFFzhCvTQyOLJ2a4zUn+g==
X-CSE-MsgGUID: ffGGMwbSQcaGgW1u6DvjBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95805178"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="95805178"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 06:56:19 -0700
X-CSE-ConnectionGUID: yu99UfNKSKqh8Oqg3VoWPQ==
X-CSE-MsgGUID: HMXMCAJpRbiYz0gSSSFCDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="257824274"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 06:56:17 -0700
Date: Tue, 14 Jul 2026 16:56:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: OrangeBlack0765@outlook.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: tsl2583: migrate to sysfs_emit() and
 sysfs_emit_at()
Message-ID: <alY__8S_fp2rs9Lt@ashevche-desk.local>
References: <alX5FkSyqo6taYl9@ashevche-desk.local>
 <OSZPR01MB823573E3C75B7D3813708F75AFF92@OSZPR01MB8235.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSZPR01MB823573E3C75B7D3813708F75AFF92@OSZPR01MB8235.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 09:39:00PM +0800, OrangeBlack0765@outlook.com wrote:

First of all, do not reply with a new version into the thread from
the previous one.

> Replace sprintf() with sysfs_emit() for single-value sysfs show
> functions, and use sysfs_emit_at() for lux_table_show() which
> concatenates multiple values. This ensures buffer safety and
> follows the modern kernel sysfs API.

> Changes in v2:
> - Fix indentation for multi-line function arguments (align with first param)

Next, the changelog should be in the comments block...

> Signed-off-by: Chengrui Liu <OrangeBlack0765@outlook.com>
> ---

...somewhere here (mind the cutter '---' line).

>  drivers/iio/light/tsl2583.c | 12 ++++++------

...

> +		offset += sysfs_emit_at(buf, offset, "%u,%u,%u,",
> +				  	chip->als_settings.als_device_lux[i].ratio,
> +				  	chip->als_settings.als_device_lux[i].ch0,
> +				  	chip->als_settings.als_device_lux[i].ch1);

And last, but not least. Indentation is still broken. Now it's mix tabs
and spaces (in a wrong order).

...

Do not hurry up with v3, wait at least 24+h.

-- 
With Best Regards,
Andy Shevchenko


