Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A603B7B6B;
	Tue, 31 Mar 2026 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943776; cv=none; b=fNyKI6aKVai3osZmWIMoF+ZyMnFW44cTsSPvXGncKNpMrpkcgsvj7CbmhlZyS7JI54Vtu4CYuyKwlSZqn3bkor6mJl87XVBwit1YL7Dbro0WCDxNON7mjCkb80LE+dGWXgKkSJQ9GAU5AvaQjv3RkAVrwth017CjAOiOumsr5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943776; c=relaxed/simple;
	bh=JE6T/jS21njoSXwNF+VK6+Tug7sIz5xOpT8+vRYJb1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe0YG6cO9094y1mImWu4+170iiSiOd4nt65SqFOvRi1BiSGcpQr7jU611AKygsBEzUXrUfzIz8F6TUw1Ge1WC2ePMYL3Joc362uwYyDflttc8eVOD/xdbPTFrSU8NWAlaC24MJ+n0XGcJRJQ03OdTL8p5mmRqSSvy8PanS7fmJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ye6DhCkx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ye6DhCkx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774943775; x=1806479775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JE6T/jS21njoSXwNF+VK6+Tug7sIz5xOpT8+vRYJb1I=;
  b=Ye6DhCkxGVrvrXiKrePZS6QxzZB/O2cIztrknl8BsHtxPBQ+BUAIQQyA
   Ylkn7rR4qh/GHXSsaf5LTu8RZMx3Qgm7DtsjEBKHAEtJiGm74wMmU+frW
   0V26LcMZuQjVHmz42XLrorowYHsJuTvEVhm/Eb7KulG+WSPZN7ImtLBig
   hrgdXo/ybk80vbIBpSslHljOaAAkZkMxjjUDg37WcjJAcQgf/yP7wKhDN
   +5Cbruuy5HpElndo1ozGa9TdRmznWThC+9GZ+KsGXKyTm8kqF0kQz+3M4
   igfTyBffo+ORc3n4ADbSOUTMBz0Zm39rgTqbHH/w9YOJPk7GkrUoXW56P
   w==;
X-CSE-ConnectionGUID: ecAGQNPxQUiKcogfnZLL9w==
X-CSE-MsgGUID: eOmNJ1AZRPO/95ON+HHGkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76008206"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76008206"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:56:15 -0700
X-CSE-ConnectionGUID: HhBItQHYQlS+SujF/hxnvA==
X-CSE-MsgGUID: XI6O6GNNTTS+EU6Q+g70yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="249336427"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:56:13 -0700
Date: Tue, 31 Mar 2026 10:56:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: grondon@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: ti-ads8688: use read_avail for available
 attributes
Message-ID: <act-G43FAjg_6BZm@ashevche-desk.local>
References: <20260330181527.65362-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330181527.65362-1-grondon@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 30, 2026 at 07:15:27PM +0100, grondon@gmail.com wrote:

> Convert the in_voltage_scale_available and in_voltage_offset_available
> attributes from legacy IIO_DEVICE_ATTR with custom show functions to the
> IIO framework's read_avail callback. This uses the framework's built-in
> support for _available attributes, removing the need for manual sysfs
> formatting.
> 
> Precompute the available scale values at probe time since they depend on
> the reference voltage which does not change after initialization.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

(Still BIT_Ux() may be used to avoid overflow warnings.)


-- 
With Best Regards,
Andy Shevchenko


