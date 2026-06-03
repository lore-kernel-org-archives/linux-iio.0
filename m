Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67E388890
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480579; cv=none; b=J0Cii5zep5CttM4odsnr1IfPOj3luLlE6++A5N7HS9dGzFGiVDrsMegKvJZEsBZFZB7u8FK7yyw5PFyXthiEBjKn4hCYTtPxxZikXV0Cem/HK4vG1RBtprWfMHfSHGT8KWBec1CLnAQF7T2/7n2tH3gOx7C75Ieltcvws+ir/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480579; c=relaxed/simple;
	bh=OCU3gAgJrE7PHIE3SNFYbft059kJ6XgePl5C/f0HiWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giXlRgpRg/BRfvkha0B52m+pVVMjawMIJrvE8x4wydSmIDwN87k83rrgaZ/u7MpWpRD5/nB4T5TojiIDTwOo0EGFwmEKN0M9EhQR34mRXgB0X9mmpWwqchIWnUgXXWkI938kEwrebp8ooe5MmicPKaZM0vbfnrlpVYPYfPa7560=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAgSrvwC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAgSrvwC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780480578; x=1812016578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OCU3gAgJrE7PHIE3SNFYbft059kJ6XgePl5C/f0HiWk=;
  b=ZAgSrvwCXaQi7bn1puOg2rUf4ZVwu/nPvz84F0at/KLDqx0plY8AbEB/
   dgoeMJzAzLQD1I9Ny/bVH0jtFFxwU9R/61o8DPn+BYGq4qfYklqUDCAr8
   ZKbZfkc8RkLq/dxrmVgZoU+5DampygDhCHRgtZnSF0L4EPZXdEOBVPMy2
   1piuQui0m6Y14v1rmzFtqWt5CkcuzCbLHg5FVo26KNbuvphhmEMe0rTYs
   Hb65wFs5TV5xbGWeygZCJCBgWnqXMMPNITFst1WlJ1MHgc/cvpZsxeXIj
   soL9VYwU1dX8O/Vyz7Qoxiv5mcuhgA6yzYUR+gjZvHDeiR2qX3fvisjCM
   A==;
X-CSE-ConnectionGUID: fSpoVU2vTlql4lWHl9KnuA==
X-CSE-MsgGUID: j+viqTNZTp6amfQpP17Vpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92765418"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="92765418"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:56:17 -0700
X-CSE-ConnectionGUID: yT9I/tO/QuaknT84Wn624g==
X-CSE-MsgGUID: ZceHqozzTlmUYwICObBf/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="249258144"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 02:56:12 -0700
Date: Wed, 3 Jun 2026 12:56:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Sam Moelius <sam.moelius@trailofbits.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Stefan Popa <stefan.popa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	Samuel Moelius <samuel.moelius@trailofbits.com>
Subject: Re: [PATCH] iio: adc: ad7380: select REGMAP
Message-ID: <ah_6OuI5wKAq-kiW@ashevche-desk.local>
References: <20260602153926.1540911-1-sam.moelius@trailofbits.com>
 <dc7f62261b4bf665482ecd791e425bbc68aae515.camel@gmail.com>
 <20260603102007.51485e82@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603102007.51485e82@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 10:20:07AM +0100, Jonathan Cameron wrote:
> On Tue, 02 Jun 2026 17:28:35 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> > On Tue, 2026-06-02 at 15:39 +0000, Sam Moelius wrote:

...

> > > +	select REGMAP
> 
> Would REGMAP_SPI be the better choice?  I assume either works from
> build point of view, but nicer to select all the support this actually needs.

Nope, it's custom regmap. The patch is good as is.

-- 
With Best Regards,
Andy Shevchenko


