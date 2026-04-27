Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FB41C310;
	Mon, 27 Apr 2026 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319775; cv=none; b=Adbub5jZzUPIN5HQU2wxOUsvC0+mGRfYbPvospPQiedbwRyYzUtTITfVNh4UK+0M5gI2bBt8yuKEs2A8tTsSgbYMsQRt6LaczXPeFP6JZHuuLQm2F6X9/0zrMntnKWTGaySKRDbqwf6Honrkp6Iy6Uty4G0Ppn6OXUD0EKIx9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319775; c=relaxed/simple;
	bh=91dM+YYDhFk/AvAWMZqexadRydWvU4o0PPcoY6tTjyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCLEv7vVsZUEJAYgHK33TlsO9h9vgkxkobeWLNp62pTG3vrPw3bISYcMEUb+AfSjBC5fZm9pWISEQaXoOu+JnEpQsxQbXV6vOvF7zXhuZEgbOPbTaF7hvqNyLpnT3I1V4C8M95xmDmaGYq5NiAB+9vMUz6GlBet7q6aujPmTW6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WlXRBF8K; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WlXRBF8K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777319774; x=1808855774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=91dM+YYDhFk/AvAWMZqexadRydWvU4o0PPcoY6tTjyQ=;
  b=WlXRBF8KXEJuHz4f26tpuP5og0X85JzwN9bXRboOTmVpEJ2+uDYx9t1k
   qhoZCfvjEzGoPTnXoApbne+IWz5Z7c33n3xjfZIoseYhmX+QwCE2S8JBG
   aqQt7KDFtBwVjExNb8h1uZYNXvM/dv1nVx7iYMU+8gUWPvKRNpokhoK7j
   4HYy5hZvwrnCoXxM1JhnCsK4dCgMX+PWR9tAZ8vxqOEcHzAvKidumxwD1
   Be4tM4XOzA7Xsk/5ORJZ5RUpMvswTarbpBfan1Gl9n53mT+UiMXSZapCv
   WOv5shzzVHyq+uw0dnsShRT97fKdrA/87Gp1Uy7kP2xAoqK23hAagc/b/
   Q==;
X-CSE-ConnectionGUID: PgsXAyjBQkyXu7pL+Q7uvA==
X-CSE-MsgGUID: YFdFIPCbQl6PVJZwLeBx9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77925162"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77925162"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 12:56:13 -0700
X-CSE-ConnectionGUID: cEhFyhuySECz0H3hiVz6ug==
X-CSE-MsgGUID: EQK46oaaQCC0T6xK+Eez5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="235488963"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 12:56:10 -0700
Date: Mon, 27 Apr 2026 22:56:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: max5821: fix return value check in powerdown
 sync
Message-ID: <ae-_WDe36BNbdJvV@ashevche-desk.local>
References: <20260427184747.12149-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427184747.12149-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 07:47:46PM +0100, Salah Triki wrote:
> The function max5821_sync_powerdown_mode() previously returned the
> result of i2c_master_send() directly. This is problematic because:
> 
> 1. A successful I2C transfer returns the number of bytes sent (2),
>    but the caller might expect 0 for success.
> 2. If a partial transfer occurs (e.g., only 1 byte sent), it would
>    be treated as success by the caller checking for negative values.
> 
> This patch refactors the return value handling to:
> - Propagate negative error codes from the I2C core.
> - Return -EIO in case of incomplete transfers (short writes).
> - Return 0 on complete success.

So the Fixes tag is only for the case #2 from the above as the first one
is already being properly handled in the caller.

...

> -	return i2c_master_send(data->client, outbuf, 2);
> +	ret = i2c_master_send(data->client, outbuf, 2);

sizeof(outbuf)


> +

Redundant blank line.

> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret != 2)

sizeof(outbuf)

> +		return -EIO;
> +
> +	return 0;

-- 
With Best Regards,
Andy Shevchenko


