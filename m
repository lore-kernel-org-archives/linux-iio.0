Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507653;
	b=b5M/xdCl6enGtVY7OAZncv5cSkslkv0P41ZQgHGL8K8hjedR2d7izwuHPYvUFMrptK5K
	 ZGkce6OwgPSwkEowpbD145NZK9vA5SIioSsJMXQ9L5Aau9m2nqNCW2KIgFzFHYO51eaSN
	 BxKHiBT2iw4U5JYOW0SYp5bYJeQEfqIMhcBpaw1L3saXAYUY8anPlf75XP34qbMFHTNGa
	 QgRqnhGc1u9d60z5aPlK1iNCmI1jT3WQbRIxv1PFhEvKHRJp23eDVcgYg+zJhl2+bwkR2
	 UQ0HXnDQUwYJ+VfKCYFIGjcUXbrHZSa2CUAZRuz8ys1bGE3R8/bKKSNRlYbWUcmDVTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507653;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=TXjuy9t6nOHTJtLRQXdLUShEUY5KmItm2Pcy2hChb6k=;
	b=hTPpNIQAO+M1ZAM8aXDswj99X7gLcSJAe6JQilk5CNrCdYSyTCinJKOyOfxTEB9kWxrS
	 2mJUx1D4ZdLuGfYvgo+Y9mFcYwR+RaEEDYMMLgXgGXvQlBMNaTe8rzhDqrCGf9v23ThF9
	 Zh1zI9FIJgIEDLWsvuSM5FUORyOxqxESddyK28/jkIuaxZcRKzm2nXh3xwAoX29mNpyS7
	 yI0E4ZxK5FdCmLbzv5Lk5050eO0uWlH3fo0lOR3a1NUqdarzF+sl6W7w1g09uszZhZn2f
	 ippBjJPWXyRxyp0BbqA80dGullrLT4edGDTKS5h34rJbhv52yzLjafqCp2KPlyjYVVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kf3OgYKZ;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187D606A31E;
	Tue, 24 Nov 2026 08:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7187D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kf3OgYKZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795507653; x=1827043653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sFrReYpz+AS1F0ZhRgVy+hdv9fvuI46nOoUDx8crNJ0=;
  b=Kf3OgYKZR7quiI4T/sGdhRLrHokbbMVFJXxJtf/xF/VCi+ZVuAgFbqUb
   RfIwgOOrC32vK47uYtR/YVwfD4dJ3XQdxjs8I7Q93+PTaqFUDGgUPrk9A
   Yj/8hmedcSqPZF8t8qhQo00V/EIUQVWBJ3bo2gmLIEGbeef2lMZnOVqNe
   igsu9zKd39kF5IaLN1xsuggp9N1nIscESzbgyNo0H4jCZBV8UOViw6dhR
   V1weiiZ/1UxTASSaSBgyzNzKx50J0xebAukwLQyvgjoH9HJcssbC5pl3z
   fVMh1XGHmAVKcJoQ8VJOMQwF4kPn1svGtAbWcp7Y5HQAkq9rtOlDC3P9w
   A==;
X-CSE-ConnectionGUID: jvFCrG2oT7mS8EaKO82RTw==
X-CSE-MsgGUID: 4OAhAnYqS0y5f4vzDXWU3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4318843"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4318843"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:06:45 -0800
X-CSE-ConnectionGUID: /eXoImYIRJWhbb5B8+yT5g==
X-CSE-MsgGUID: SWfCvlk8QriTV/ihnjbCzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11847151"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:06:40 -0800
Date: Tue, 24 Nov 2026 10:06:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gerard Marull-Paretas <gerard@teslabs.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: magnetometer: mmc5633: Enable the VDD supply
Message-ID: <awVFjlPKydiyqV3A@ashevche-desk.local>
References: <20261123202616.17334-1-gerard@teslabs.com>
 <20261123202616.17334-4-gerard@teslabs.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123202616.17334-4-gerard@teslabs.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 09:26:14PM +0100, Gerard Marull-Paretas wrote:
> Boards may switch the supply of the sensor, so get and enable it before
> initialising the chip, and wait the 5 ms both parts need after VDD is
> valid before they can be operated.

...

> +/*
> + * tOp, time to operate the device after VDD is valid, per the same datasheet
> + * pages as tSR above.
> + */

I agree that it's close enough and easy to refer this way, but the problem
is (and as this patch shows) that two definitions came independent into
the driver and might live independent lives. This means that I would expect
the more precise reference (check my previous reply to the patch 2/4) with
all the same information given here.

-- 
With Best Regards,
Andy Shevchenko


