Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD183793D4;
	Tue, 24 Feb 2026 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932262; cv=none; b=s7vckxIx6GfaYRjkZw0hnsUhyfxLsitGJsZ8c3a0tEnYcT8DkIQ5G9qH0cKysrqEEps61E8zRIdLbHsWdhAL9lfxwxnNJbOq1GXb/cpZCvKVcPz1haf2POrOtZmBE/se4lxWdl92xHb+1K9e7ZCK0+3bIvr1Wodz2VFOeoDhwEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932262; c=relaxed/simple;
	bh=P0jZjq1E/P3sDtaglV9UuSTYVpFAVDD9OXZT1D8ZukU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzfxrVqMFpKsaitUEcNmhEHQyg9CPxI5UXfqbqloQcnuhuE9JqDKATFTr6gzpC7DrBXWb02p0RQzcTysHRTqg/nszkUek73A+X16dlskajt/xRarvRGtqz78EhB4vFoMZoltOUJXqxcny/DV3mH0vb0ZYP4x/2wDDheX3oc0We4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2OG0TTs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2OG0TTs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771932261; x=1803468261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P0jZjq1E/P3sDtaglV9UuSTYVpFAVDD9OXZT1D8ZukU=;
  b=L2OG0TTsypyrummlDpQtG2WYj215hcU2J+tGHkWrIren28Jkes00LW4t
   nYA1FjT0pC1szse2rEEyo9K2BS1Duqz7UV8GCPkrBvMlfVuIVI7uNeCOW
   bKVxU2eYaBcfY6JpFt9MJ5w9EF+ii45Dq8mnlzFLDy6PWxm8p9y0Z4d0e
   ytbupZbzjhTZTv73RKKPPART2VvOychy0iDTuphbWH6enLPYf4ntA+fui
   gNtD3QaMWc5a0khfnI+Ujtg0iWga/31MuFoJej6qtKgn8I2cS/WD2tF1H
   WU4jqYAfPAq7/K66/l5MtNu1DSXGw2KkoRr694cLAF5Pv+0ff1rburaFF
   A==;
X-CSE-ConnectionGUID: Hh0r5nxCQbSji55rGY7Rhg==
X-CSE-MsgGUID: gyWFUoDrTRuJ8iA9XyOy6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="83566396"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="83566396"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 03:24:20 -0800
X-CSE-ConnectionGUID: tDiWXSQ2RWeujk3FrXXrAg==
X-CSE-MsgGUID: gFrDI0qFTNC042SLecLqQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="214968339"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 03:24:16 -0800
Date: Tue, 24 Feb 2026 13:24:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] spi: allow ancillary devices to share parent's
 chip selects
Message-ID: <aZ2KXVpH9LVl0BdE@smile.fi.intel.com>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
 <20260223162110.156746-2-antoniu.miclaus@analog.com>
 <aZ142CVjMQ8Dypnb@smile.fi.intel.com>
 <CY4PR03MB33992FF58E620DCE44FE0B419B74A@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR03MB33992FF58E620DCE44FE0B419B74A@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 11:12:57AM +0000, Miclaus, Antoniu wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Tuesday, February 24, 2026 12:09 PM
> > On Mon, Feb 23, 2026 at 06:21:00PM +0200, Antoniu Miclaus wrote:
> > > When registering an ancillary SPI device, the current code flags a chip
> > > select conflict with the parent device. This happens because the
> > > ancillary device intentionally uses one of the parent's chip selects,
> > > but __spi_add_device() checks against all existing devices including
> > > the parent.
> > >
> > > Allow this by passing the parent device pointer to __spi_add_device()
> > > and skipping the conflict check when the existing device is the parent.
> > 
> > Isn't this already applied?
> Don't think so.
> V2: https://patchwork.kernel.org/project/linux-iio/patch/bcb1eb34fc5e86fd5dbb4472ad1d3ea3cf3e9779.1770393792.git.antoniu.miclaus@analog.com/
> V3: https://patchwork.kernel.org/project/linux-iio/patch/20260213144742.16394-2-antoniu.miclaus@analog.com/

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-7.1&id=ffef4123043c5bb29e61052a41e577ae1ee6837a

Will be part of today's Linux Next IIUC.

-- 
With Best Regards,
Andy Shevchenko


