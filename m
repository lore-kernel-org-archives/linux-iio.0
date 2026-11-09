Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254605;
	b=ElnIrFsrdGHETjbKxXd0xTrmlj+Zhl8odQqOIhGm96r4xEMzrceMpa/s6XWBuTEQKY8w
	 ky/mu8phQTmUUbJK+Erqa8yy1/up0Joj7xR2s457RuSIIFjLC/RPVysh3v7+N8/L0RuoE
	 /0wVFOuZnm+2JEBtby6s7IOf08bOQlr3evbhAx2pI90ejkTzu9TDztEI6AJKr9V+KcU3c
	 mxN70m9Pyn/OsJt5aiPmIwP+X1BVNaSOwYS+IXgqaQNljvkY+fB7TOGSmKhK9I6dUUu2K
	 KT1SQFIFX8a0+fB+Q5T28YlIDx/hLN5Y8CxDOcrwQwkPcZrkFltrjtP7SjC+7qeEaGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254605;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=XdJLJbVIQHqVGKpuMShdQSgSFsm+69CBaBnXPW98sOs=;
	b=vs4pVYePCXhHjIdXpzBQ6tynyAJKBxWp+tkOw7uMUceNrKKOEXlGJkQdM7fPyngEZnaI
	 jNljZOHTaDDYouyhwyFrTcNbIfhaL9BbSW0Q3y8QDBdEk8KhbKnGi6InJJgqdXv8V9NsZ
	 djZvU8ob8lUFFLllpBIA2rFwXY/jjfX3ctZmIDRhPGE8HkYlZKGXJcJUQdJagrW8YbWFL
	 aKhi8E1uLz0wtpHUNBXYrIvKsS6QFrDxTTLfZiDMthzPi6iiHYmLJLqe2F3RwqONy16W3
	 v5NM/UAcc1torSg7LtA36IQEbC3Pa7IRM6NM7tSeiEP/KF6IRc0toVfYqw4DmU6n6vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CgcfhwZg;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C851606A338;
	Mon,  9 Nov 2026 20:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C851606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CgcfhwZg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794254605; x=1825790605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XiFIr4wIIdZ1lLJz6CyLg064mfrzts0usX5vfZ3FSIQ=;
  b=CgcfhwZgUSX1lY81cRELxJRoEomZ8Wu4haOPqMQ1jS2OqwhSz+hnH+Qv
   hVsSjm4yjZNXut4e9p+fgsRJcbJWVA1K852M4GxDiqU/o62om20BJ7+Ox
   985zt2OAk5FfQODDwxmFmcrABzIYq0017USjPxl5jBa4MyofzFX0nHSqi
   j4yoAcIdIo9AK+EccLpi23pKbo4OqBekWiUWNG4ZPvxbx+msQNUzVBY0j
   fy4TaV5J5VjFMZEyd0jSUoTNi8WY/6NxDMCJVcum1GlBGtO7j2ZdrRcEy
   Im7KsEtxeeVTNTEleL331iNBGxXAu/nVHUCVW9CQdX9Nzb7t/lJIlekyH
   g==;
X-CSE-ConnectionGUID: bmOTn4s5QE+pSxL+dJUBCQ==
X-CSE-MsgGUID: pVLlQRE5R6mlk9cbcXU2yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3024009"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3024009"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 12:03:22 -0800
X-CSE-ConnectionGUID: Nz1IaT65RqW47aDh6LK3Dg==
X-CSE-MsgGUID: BKmsxJrwTT6uIgKFs3l55A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7777487"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 12:03:17 -0800
Date: Mon, 9 Nov 2026 22:03:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: light: ltr501: Switch to read_avail() op
 from manual attribute registration
Message-ID: <avInA0Qgi841Fd9f@ashevche-desk.local>
References: <20261108094253.83899-1-clamor95@gmail.com>
 <20261108094253.83899-2-clamor95@gmail.com>
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
In-Reply-To: <20261108094253.83899-2-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 08, 2026 at 11:42:50AM +0200, Svyatoslav Ryhel wrote:
> Switch to the read_avail() operation from manual attribute group
> registration. This eliminates the need for per-chip attribute_group
> structures and related ltr501_chip_info iio_info entries.
> 
> Adjust LTR501_INTENSITY_CHANNEL to account for the new
> info_mask_*_available layout, allowing the removal of _shared since all
> intensity channels share the same layout of available entries.

...

> +static const int int_time_avail[] = {
> +	0, 50000,
> +	0, 100000,
> +	0, 200000,
> +	0, 400000
> +};
> +
> +static const int samp_freq_avail[] = {
> +	20, 0,
> +	10, 0,
> +	5,  0,
> +	2,  0,
> +	1,  0,
> +	0,  500000
> +};

When an entry is not a clear terminator, add trailing comma.

On top of that it's better to use 2d arrays (yes, it will need some casting,
but this will make it clear that there is a tighten dependency between odd
and even indices).

-- 
With Best Regards,
Andy Shevchenko


