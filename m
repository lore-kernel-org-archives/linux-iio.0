Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C1F2517AC;
	Wed, 29 Apr 2026 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490214; cv=none; b=bBUSuDm84Yf0X/FYUoQDEQGn/mBiteDllqpGhaeGbgx/l0CEzTJVgM/DJZmEpXv1PQLjwRzXckboU1/1BsoO1tiuPpTcgxzJWLfQLNtw/TkLUYtDIhsN2g9PedwQPefWLN9OOAKl0PD35H+1lBQ+IhEYPKWDSJkcgtZPBVDU/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490214; c=relaxed/simple;
	bh=bwDurPtS8nOj3dSY9s0OhUxLopC9U8GzwWPP7f/wmpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzNfOl6exlpqRoHpn87lfpfcB7TChHBdTRBJpLvA9OT7lj8PwkeMY3bSx1s+UM96V8mL9g3lBMtVD+XPHfPAHZY3atdL7BPyRHbNnU3p1k7njj+PFco5aM/AAZdFUSTuSPfbCN/lpVKwecvMJcxhDZJkX28Z2AkuJObdiMQizac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlbJXAHn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlbJXAHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777490213; x=1809026213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bwDurPtS8nOj3dSY9s0OhUxLopC9U8GzwWPP7f/wmpc=;
  b=NlbJXAHnyIjEIzF4DQAntBy0rIotRjEa3nEiA5S0x4/qBLbONHyGejFO
   XVkhbgbxwlw4lKoXLM5qdh9C1z3nu20Jby+SXBJOCidg5TmKtbJuh1vH4
   dvoUF5A2FcDjEMHkyb8wZ/4uPo/OvjF3KMCGEdahZSLOml4FkH7UKQabx
   +beK3lIytrN4FMqm2kNjpDYUiZsRRIEYE0JEdpoqvfMs+g1/PadvtYEfD
   WGZedAe6UvAcH09Afq/vDR5QvCdoJ9xXbE6mJBLQSBQGOcxKRh7IHBDtv
   KlFllk0Nx72sQbyQhT6yBqQnIK+L4SQKnkkmn097c8l3mfu4dAbGY2mnL
   Q==;
X-CSE-ConnectionGUID: a4Eyg+jZSW6RANEDyI5OJw==
X-CSE-MsgGUID: PuyLU6iVTWaBRcwySJFoZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89028761"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89028761"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:16:52 -0700
X-CSE-ConnectionGUID: uGFw049+S8uIdzM9C2/l1A==
X-CSE-MsgGUID: IJsp0PqMTnWmJxUnZjxw4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="257935186"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:16:50 -0700
Date: Wed, 29 Apr 2026 22:16:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] iio: light: si1133: add missing include headers
Message-ID: <afJZIO34pvxeKp_d@ashevche-desk.local>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
 <20260429-si1133-checkup-v3-3-469f21d960eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260429-si1133-checkup-v3-3-469f21d960eb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 05:04:51PM +0200, Joshua Crofts via B4 Relay wrote:

> Add missing include headers to prevent compilation relying on transient
> dependencies (array_size.h, bitops.h, completion.h, dev_printk.h, err.h,
> irqreturn.h, jiffies.h, math.h, mutex.h, types.h).

...

> +#include <linux/array_size.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
>  #include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>

> +#include <linux/irqreturn.h>

Assumed by interrupt.h

> +#include <linux/jiffies.h>
> +#include <linux/math.h>

Also mod_devicetable.h
*Yes, most of the SPI/I²C drivers do not do that, I know.

>  #include <linux/module.h>

> +#include <linux/mutex.h>
>  #include <linux/regmap.h>
> +#include <linux/types.h>

-- 
With Best Regards,
Andy Shevchenko


