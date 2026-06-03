Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D8230C17E;
	Wed,  3 Jun 2026 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496235; cv=none; b=GW3q5mCMWPmEJWx1Fw/yJ0xJrx71iFV5KK4v6vyY4vgE68Y2uQNFPitVGY4fkqCFG7fA67Yo+JKfmuHMUxJdEJsBkziIWX1tPac3MPTG0Q1mI4XxjEQ1HInHwJxWTwTleB3cMbg8AvimKeEPG/e824FJqDqo9w0f/5Lw011zR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496235; c=relaxed/simple;
	bh=Zwq+GV9zwcxNtn1SpGJjcRTCyi+iNcn3SKqnBW8/1KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYrqyMaO8XjdbUwxWWRqBxBdgIeOyvzpBJDvtJkLVMWw7wjTEqX1BTrwJOdoI5KDr3fJvsgKr1KmN7eDgLxo/eRSHiCcXa3hNiT0mudxsEQp0K5scabKF5xlLhbAHfBfYPpY3T1KuLPZWLIsxuUtnZBBbBUVqUVfT8n4xMK/sgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6V7uYuZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6V7uYuZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780496233; x=1812032233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zwq+GV9zwcxNtn1SpGJjcRTCyi+iNcn3SKqnBW8/1KM=;
  b=S6V7uYuZLMFJpOb8Qr8TE7CKUqKRDypoSWMqGK8pESvdbkIdGwq8TV8P
   //e4ig+dwBZiRgY+PPJhRTINhovqK4ottlK2ZK6m4NbM916RsFgG8KjZV
   u4T6T/GcJU7drTQECNL6h7w3zbQhUmG3QYCRMGfutZOHS0StC6G/v5zLC
   w4E1x6f4QQk5wpbcDvlcMT/VbYLezRqOLvm94Rf3l27TXMDwImEsb70Za
   s4vYpziTy0ZYsERwdX8YHBNnDXJ9CQkXtyFQF1TeCUq+AMDwLNlbEF7/h
   HA2nhvNg+X8u6ebTRw/NUg+6AgMMYdx4hZxh8BulQQVStCQMJJ1yMQBo1
   A==;
X-CSE-ConnectionGUID: yqWJVpJySqusjWQzY+6ySw==
X-CSE-MsgGUID: K3BAD6lgS5WWugSG/oYl0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="68847240"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="68847240"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:17:12 -0700
X-CSE-ConnectionGUID: IOZwMHEGSduCN5BRww1/Dg==
X-CSE-MsgGUID: 6YWnkAiaTm6QrRNwQvINkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="243415440"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.250])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:17:08 -0700
Date: Wed, 3 Jun 2026 17:17:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: types: add IIO_VOLUMEFLOW channel type
Message-ID: <aiA3YY6XKg-8o-GX@ashevche-desk.local>
References: <20260530205435.37326-1-wafgo01@gmail.com>
 <20260530205435.37326-2-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530205435.37326-2-wafgo01@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 30, 2026 at 10:54:30PM +0200, Wadim Mueller wrote:
> Add a new IIO channel type for liquid volumetric flow sensors.  The
> unit exposed via the standard _scale attribute is litres per second
> (l/s), so drivers reporting smaller native units (e.g. ml/min) only
> need to set a fractional scale.
> 
> Update iio-core's name table, the iio_event_monitor whitelist and
> the sysfs-bus-iio ABI document to match.  The new _scale attribute is
> folded into the existing shared _scale block; only the per-type _raw
> needs a fresh entry.

...

> +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_raw

> +KernelVersion:	6.19

This is wrong. It has to be 7.2 and unlikely makes it, so next one is 7.3.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled) volumetric flow rate reading from the channel.
> +		To convert to standard units (litres per second) apply the
> +		channel's _scale (and _offset, when present).

-- 
With Best Regards,
Andy Shevchenko


