Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4846AF20;
	Fri, 15 May 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841997; cv=none; b=TM9jxdwNKqD81SOvMYWt00f8tnh4Qb75peqacn5SRVAT/GD/4tkm1IVnik94igYR7kJCrOJDc+IqdRf7GQM8N98VUJuX1fIaKbmQ8lZn06SYxQqXqfHEFmUtbNiIa6VjKsZY5ID7j7+4QvD0ZbCVZIhtbXVev0sV7YYNO8RbhVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841997; c=relaxed/simple;
	bh=yWaQo4DtjTlu2qgF6hPs89S9rgVcfBCEa95/SdqPx5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq1Pcs9piC1Lim9ZEqKaSYXVJaLNZy6HV3Q001QfjXd196y71GNkIqv2m8ypRsxxu5jnXopmqjnXnLYbsE/OoFzkBy6SjRNm+Vqs/ZgEg9RCWk4yRMZUxU61pnvw8pDy9Tg4RuvLCwJQo10KfhwNB4gn0Y9HcD8v1B8SMKDAsd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Irx6DGWX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Irx6DGWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778841995; x=1810377995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yWaQo4DtjTlu2qgF6hPs89S9rgVcfBCEa95/SdqPx5s=;
  b=Irx6DGWX2kvh4qmHCEUS1yTzAMASkfAMLQba0DoI8YRabNAORrA3NxoY
   a4DikunW+r9wy/u5Qo9JRlWtzDq6UqHpSUrSyBGp0NxjXjhRSzquClT8C
   KveDM9C54IEjWGq2Qnh2z+i2QoJ7AR9z/PtngUkQoEmSHsjbMjY1qlAZP
   lcD1G6st97Vr0CW0DCv7C/4ata4w63pWxT87YXfDXP+KXOocEMQRMvx2/
   ZMeJwuxN37BPxJDQJhubpgicEy/gm1IWdC5DON0UiOE+WSouRastsZ/U4
   epHBFbaUu6XkM1LrOhH0iN0iypFdtc/9gSAD7oONYyldpX5+IbuPtn+Ij
   A==;
X-CSE-ConnectionGUID: X38laD9TSSGqLZS+oPK23g==
X-CSE-MsgGUID: QU/xYxi/S2+uSQDWN37nSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83410909"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83410909"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 03:46:35 -0700
X-CSE-ConnectionGUID: iBy8N1H3Rl2XbASVpq0K2A==
X-CSE-MsgGUID: 3II6IXMpQ8us6cKbTOBDqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238545365"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.33])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 03:46:33 -0700
Date: Fri, 15 May 2026 13:46:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?utf-8?B?0JTQsNC80ZjQsNC9INCT0LXQviDRgNCz0LjQtdCy0YHQutC4?= <gdamjan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: only set IRQF_ONESHOT when thread handler
 is provided
Message-ID: <agb5hiF6GhNwGa6c@ashevche-desk.local>
References: <20260515-patch-iio-buffer-v1-1-667dac4e55e5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515-patch-iio-buffer-v1-1-667dac4e55e5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 15, 2026 at 12:46:00AM +0200, Дамјан Гео ргиевски wrote:
> iio_triggered_buffer_setup_ext() unconditionally passes IRQF_ONESHOT to
> iio_alloc_pollfunc(), even when the caller provides no thread function.
> This causes a warning in __setup_irq() when the trigger is later
> attached:
> 
>   WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x4ee/0x700
> 
> IRQF_ONESHOT keeps the IRQ masked until the threaded handler completes,
> but with no threaded handler this is semantically wrong. Only set the
> flag when a thread function is actually provided.

Yes, please read the mailing list archive and find the previous attempt to fix
this and the associated discussions.

-- 
With Best Regards,
Andy Shevchenko


