Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A912F8E84;
	Wed, 15 Jul 2026 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123921; cv=none; b=KabllB+l1A4pI52JnnngROqpbC1bxIwTM0cTgNRErXd/RMIJmRzQlcHyyGhkgBW74+tDDbU1i4eopEYuz5kPuBZ8Axm2cFQL+mGKMPuf3mxx5jkDjPs/8jL2HAMwqJxZsKPcURqu8N/NCd7v68INmIYzdrv2L2btzOElMyzv53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123921; c=relaxed/simple;
	bh=TtjaMHowmPLyOarWnAzWczSPO0iHg57GBSCKyQFi2+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwSMp/M5aeW7qfnUOJY5GVGrBqbZPXikuIC9U5oKyb81KpJl0ZKtQFq+Kf4l4X/7mM0DJpX5BUcTArL5GS4cxQAMBreo5qNcAdqSdQRbb3FocEckpjkNIwXwuEFQBGjUXtrqNdvos2ESL16w3n20d4LgB2coNVDMQW2Y/k+1qlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdZNrWZ6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdZNrWZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784123920; x=1815659920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TtjaMHowmPLyOarWnAzWczSPO0iHg57GBSCKyQFi2+M=;
  b=fdZNrWZ6n0pTEjFRKBs8qxlU2rL1ub2CmA9Pd9O5i19ClWNvYB2EofPu
   YaGiRVA4gGuxk/TW1Naf2HYxW+/Kq4nMoDQwXUn8P4aYFpo2N9j7M0pRH
   CByxolbLMKrkoyZ1gtQ7CbZeYd1m2huqf4HW7hRdUti9PdRw4/ZXnDINq
   iryy1G98iylu2gx754TUBXjZiKdk5kul2J7q2d7gRsZEKh3VSirC2RJ+c
   QumNMf05w78Dv4RsHHLFHdCojodk8nvo1kV6VWV+7yYpz3RauBKfUmY57
   RUO5EZBznmveI/XNCZfhO+4F/+yfx88LRLSoQ6GtcBd7AHzxspq81rRiz
   A==;
X-CSE-ConnectionGUID: 3HedL9J+SMe1h6Xmfa7nOQ==
X-CSE-MsgGUID: 8pNwl2jtSdOoldZL87fe9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88438409"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="88438409"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 06:58:39 -0700
X-CSE-ConnectionGUID: EmvoA7ksQvO+UFWeiyq1xQ==
X-CSE-MsgGUID: l5xnwVhYQtys7nESH+6k6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="279462800"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 06:58:35 -0700
Date: Wed, 15 Jul 2026 16:58:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Siratul Islam <siratul.islam@linux.dev>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <aleSCUZhZmhceTqV@ashevche-desk.local>
References: <20260715063652.368501-1-stefan.popa@analog.com>
 <20260715063652.368501-3-stefan.popa@analog.com>
 <aldGAbF4AN8X5CRY@ashevche-desk.local>
 <4r6grtnbddwtaflsak37y4hlofgiudksd3orxamry6eyhnueky@mg75uai5aeu2>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4r6grtnbddwtaflsak37y4hlofgiudksd3orxamry6eyhnueky@mg75uai5aeu2>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 03:41:45PM +0200, Nuno Sá wrote:
> On Wed, Jul 15, 2026 at 11:34:09AM +0300, Andy Shevchenko wrote:
> > On Wed, Jul 15, 2026 at 09:36:17AM +0300, Stefan Popa wrote:

...

> > > +MAXIM MAX40080 CURRENT SENSE AMPLIFIER DRIVER
> > > +M:	Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> > > +M:	Stefan Popa <stefan.popa@analog.com>
> > > +L:	linux-iio@vger.kernel.org
> > > +S:	Supported
> > > +W:	https://ez.analog.com/linux-software-drivers
> > > +F:	Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
> > > +F:	drivers/iio/adc/max40080.c
> > 
> > David usually asks this to be split between patches to avoid "orphaned" files
> > from the MAINTAINERS perspective.
> 
> I think checkpatch also complains if you do it like the above.

Yep, but DT people say that this is checkpatch's particular problem. They have
their own "maintainer" database via the special field in each of the binding
schemas. Since that discussion with DT people, I'm not going to fight for this
kind of changes, it may be just an IIO level one (if we want this).

-- 
With Best Regards,
Andy Shevchenko


