Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819232;
	b=AZxA0Ps/2xZGmZhjNz7lPH5u6ZBJgEIA9l/VlhmL2TmG1b/3ZEbqk17pRgMvSCV+heCX
	 CPSJ1z7I1G3KZj/ly5GiwInJz+CS/O3Z+8Sw1GOT9SPYzQ8g/wyTYXCAIncYXh2rrBSHH
	 5hCZrZj0qIZeD3/DmQ73NlfuzitSZ43UQFDj/r9bP7i1Za/L6+vwTmDzR0W6NRmA/8+80
	 boe2aw1dD21LrdBFBxdP5/gwMybuldmQE4kALKACpHBw04cM15N3339gZqckklFrEtNLA
	 G+5WRT33ftRI6bzu/fXcjrI6A8NyYLeMICDX5aKMxtugnYJNt+8A94qI+7PfqxmnrcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819232;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=WJHptjq5aiJfdXZI3gT+b9duppbFkdL96tNofJMtcsc=;
	b=0VB/KXMZS6p1rVdPpZ2EAaiGcS7Gp6op0JrAw+b53n0hRsqpTon5MKdhuWX3IsUQcTLL
	 N/cVLEg0A9GtFp5X9CyDcH9AhAMQfdNxfpr5guh/cP895/1vxbwF8QbCjOXqy1Tr3oBLV
	 sQeQZeoiOprJ+5rnlQxuU6l+5h9rtPp0BlK6LVlBiMuU+sEs87ohSffs/dG0MHQUiVGsX
	 nQiYbMicMApQzLMXW8uMDrQ0MSxaW5DrhIz2Rj6aAZwaNgFQu/EHV4zCI0Ur8WT30gfem
	 scxO87m1bBbO7lbrJ/BovyyADjnrusZFGPKbCLkBGc4JG0WbaZpXCu8Bvv+fr2dfjZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="J+2/szqW";
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39A7606A329;
	Mon, 16 Nov 2026 08:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E39A7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J+2/szqW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794819233; x=1826355233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4G4yGIqnrHxQl+5LajxFWIp2dJ6cElXZhM/BoJ9cdY4=;
  b=J+2/szqWQxZLxusz+NAHwE62IP3wZWddOmF9nQWR5qIL5GjrbjmeD/NL
   aTEv2qrqaKO3wKu6G3LJBSN1lXRgLPdtlhmR3l3b8CjREneynn6frsVM4
   4xRFYVE8WcTvw9aOLg8Fw7LFPe+43EmNXFVHNtw00Qq3OxqjkQlq188so
   PNzaqYqC5EtJpmOxDdTeHv05LPK7S3zwEwD1N0GMj/M0tP80Og/SkwwHl
   aR9UZfV+WYRKLOuSsSz4ZFchETn7n41Sz/v2+1YAMxHOInOzbduVMN3o6
   JMoAfIVobIqnmPnICp8zy61Y29WmiwEWXaBfyzuILe7IxpVMB6+z1tLvP
   Q==;
X-CSE-ConnectionGUID: klUIzpNaSb2vFuSvoteQCw==
X-CSE-MsgGUID: MhM/0ajqTEGLAbFFlCIiNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3588429"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3588429"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 00:53:50 -0800
X-CSE-ConnectionGUID: 2IZIwq5zRBa1Yz4XQCXOEA==
X-CSE-MsgGUID: +HN8DcJpRSyF/9wpu5KGow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9507060"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 00:53:47 -0800
Date: Mon, 16 Nov 2026 10:53:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: proximity: sx9310/sx9360: reject
 out-of-range hardware gain values
Message-ID: <avrEmbZJSX5qtGS2@ashevche-desk.local>
References: <20261111164041.341776-1-kapoorarnav43@gmail.com>
 <avXeSbAEGhkMjMJa@ashevche-desk.local>
 <20261115014333.120063-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261115014333.120063-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 15, 2026 at 07:13:32AM +0530, Arnav Kapoor wrote:
> On Thu, Nov 12, 2026 at 05:42:01PM +0200, Andy Shevchenko wrote:
> > Now it looks better.
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Thanks, Andy.

You're welcome!

> Jonathan, a related question while this thread has the right people
> on it: the Semtech SX9xxx proximity drivers (sx9310, sx9324, sx9360,
> sx9500 and sx_common) have no MAINTAINERS entry, so get_maintainer.pl
> only finds the IIO maintainers and reviewers for them.
> 
> I've been working through bugs in these drivers for the last few weeks
> and would like to keep doing that. Would you be OK with a patch that
> adds a "SEMTECH SX9XXX PROXIMITY SENSOR DRIVERS" entry with me as R:,
> or M: if you'd prefer the drivers to have a maintainer?
> Gwendal, as the author of most of this code, you'd be very welcome on
> the entry too, if you want to be listed.
> 
> I don't have the hardware, so anything that needs a real device would
> still need someone who has one.

I believe for an M entry it's kinda implied that you get an HW to play with
(at least one of the supported sensors by the driver in question).

-- 
With Best Regards,
Andy Shevchenko


