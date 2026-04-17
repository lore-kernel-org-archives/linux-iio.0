Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14936E498
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412793; cv=none; b=RN24t8Vy5vxOeVm1Ai6ygg2HF6rxmqFGiMqrPBfr63WVa628a82eA7hBLgJojW2tYH3l3P6b9urxLT04MyIhftK/q7RO6RRvxpegfoshRN2XCzWglA3aKMtceI8g2nVD5d7i2gQ9g/KfRdAzk12KFpxVOWpjtuunQLeL9N103+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412793; c=relaxed/simple;
	bh=zvbOX9Hlp1n9H2Y4czdMJxKJ3UeF6BDJSyL5KCNH8hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3fuKyXvi1lyRpivX7fQPQ2lao7FSt65HYiAZV8HnYOSuOuJx+RUiGFczXw/TBNeFQN0yz+OcykZLkys+YGAaPpt6JyAVMtaZOxJggOwXXqUTjECfjBzbaRnSlE+KoJZmxTahdLvriypo8QRW8q/dGVE4GW/GJC0RM+PNJnGli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SeCTKtsi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SeCTKtsi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776412790; x=1807948790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zvbOX9Hlp1n9H2Y4czdMJxKJ3UeF6BDJSyL5KCNH8hA=;
  b=SeCTKtsiOqAVGLezQRMMsHGhBXTQ0lBYysW/oAHctE1cyBwZVYFZ+xkO
   3okNXkgXyWOE7o60bO6Zq+ytWJSoRzs7qCzNoPjO+cMZH5JbtJcaOrpnt
   Go3Lr+vEJMuTpLo1VC5mxjo5v/p5GSOKRthRVSXo+nPfl8wniQs344c5B
   knArbsChPs6yDGvVHzqVn6frMNMwpX26h3gbzuORCH4Kpihh68DjgNCwh
   FrJV2keqco5tXY5wStoc+X/HJg8qi9erQ+jkf+DFTWSEIbJNNmknG/LZd
   WPUfVyRTM+v1+b2Q8IcliSM0Qt/xawzbffxdB6L7ShRvaJozaWxRGdc7Y
   Q==;
X-CSE-ConnectionGUID: trLTeoWyT6++JiPvbgfvFQ==
X-CSE-MsgGUID: 3AdS+noIQs2KHe9LZ4CZUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77334279"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="77334279"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:59:49 -0700
X-CSE-ConnectionGUID: moB7qmOgRwO1WdmMOqI4YQ==
X-CSE-MsgGUID: zxdtUtXnSe2JVBlYObIhJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="254444700"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:59:47 -0700
Date: Fri, 17 Apr 2026 10:59:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: m62332: Use guard(mutex) for locking
Message-ID: <aeHocG5WKr3q7Jzu@ashevche-desk.local>
References: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
 <20260415230119.17512-1-erick.henrique.rodrigues@usp.br>
 <aeHoIfq00521NwYy@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeHoIfq00521NwYy@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 17, 2026 at 10:58:29AM +0300, Andy Shevchenko wrote:
> On Wed, Apr 15, 2026 at 08:01:18PM -0300, Erick Henrique wrote:
> > Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
> > simplify locking and make cleanup automatic when the lock goes out
> > of scope.

...

> > -	mutex_lock(&data->mutex);
> > +	guard(mutex)(&data->mutex);
> 
> This is defined in the header that the patch missed to include.

I recommend to add a prerequisite patch that follows IWYU in the header block
and sort them alphabetically. With that done it will be easier to add any new
functionality that requires any additional header(s).

-- 
With Best Regards,
Andy Shevchenko


