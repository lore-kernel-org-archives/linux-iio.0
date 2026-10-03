Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01B138F92A;
	Sat,  3 Oct 2026 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791055331; cv=none; b=WxYoqt6HYV6xmGQb9C98BqOHU27MnO29MUqJOUi69EwKROFd/LCh12HtKzoc/mzWZ/WBLZXNx3ncNMsc1Uja3/HWIJ11RTHuqJRk5k0mM6GLWyQB/MnPdkKSs1BpuK0HjVV1v1Dl52nDHg34YLISANM7yNx9n3UcbHMlU9Dv61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791055331; c=relaxed/simple;
	bh=P8aUsVLlVUjpiMlZZxjF2Hwg/5HPZlSyJquKdKyA9nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxWGMXbuH/Uu+tg8QY2fKTdfu1RhJIKvZiln/TrKJHQOnlRN5cV81LJfsBPUDcYxKR9X4ubLupav56gKuRQPf/agpbHAHDbt9jvxAPogjmP+gnBTabCbJ53t8VtkKU6fjmCHDvZtc4Q4/uosR/CzTC+uktHZegTp+Aa0uJ/Fhmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETym2Ezb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETym2Ezb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791055329; x=1822591329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P8aUsVLlVUjpiMlZZxjF2Hwg/5HPZlSyJquKdKyA9nQ=;
  b=ETym2Ezbhq1i6C/up7ZyhFT0r00iIZV/UmOmOVTycNY1A8QDc+km5+4C
   RwfXrDh0MXR6akeiTMhLVN2p4tJ5ZhinGncnKv+JP+m8NDMSGMqHc82BU
   4UwHWjDnOr20zle1Ze84tkRAimRSwKBZbzNhGPUuVPlWIhFiLa7O2c3Vr
   kxa47YP8srv/Eu7s5sDXsq9nBvFMdQrqlLMJWEakV/cGHg2NYFTjKqCD4
   P1baobwZNs2aK2K2TxXPH4WWbu36E63i8jboi1ZWLyR7SiYAUTpQICD4q
   5EBoQKHA1QhXQeb1FCgcKx02MxQQflvt7KRAFjaPUujtXOa26NAkp0q4z
   g==;
X-CSE-ConnectionGUID: UAmQ32EQQzSwZBMcpRmG6w==
X-CSE-MsgGUID: wWivzCqcT9qc7j93QJd13w==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="90841189"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="90841189"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 12:22:09 -0700
X-CSE-ConnectionGUID: SaO7kchUShSrVAVbgNoFeQ==
X-CSE-MsgGUID: AWT0LZpBSXeovEo30CNzwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="281216184"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 12:22:06 -0700
Date: Sat, 3 Oct 2026 22:22:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: drop stale vdd_supply kernel-doc
Message-ID: <asFV3JlT-YNYa9vw@ashevche-desk.local>
References: <20261003055339.143977-1-kapoorarnav43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003055339.143977-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 03, 2026 at 11:23:36AM +0530, Arnav Kapoor wrote:
> The vdd_supply member was removed from struct inv_icm42600_state when
> the driver switched to devm_regulator_get_enable() for the VDD
> regulator, but its kernel-doc entry was left behind. This triggers a
> W=1 warning:
> 
>   Warning: drivers/iio/imu/inv_icm42600/inv_icm42600.h:186 Excess struct
>   member 'vdd_supply' description in 'inv_icm42600_state'
> 
> Drop the stale line.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> ---
> Comment-only change, checked with scripts/kernel-doc -Wall.

Is this the only issue with kernel-doc in the entire driver?

-- 
With Best Regards,
Andy Shevchenko


