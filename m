Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA1C3C09E7;
	Mon, 31 Aug 2026 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159914; cv=none; b=kq8eLTAwsTCDzz4uhcTJm1Gf7D/jPvu3NM9xF39q4vLmYMEJ+OAjtQ7qQqc6G43IGGCObhl9IcYVCbaUebFw/S+GYj6iwkFFg41WZtgqiXPkz4NZO4gocgAMYaVu4nexmJG4q7zjWUO1t2PymBKuhh/c0NYb5R0AEtxqMyGF1lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159914; c=relaxed/simple;
	bh=KMA0y2gJ+SIDBUH1IFare7qX+NGD24kexNWBIT9z0oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGQiOavlHUcxM3XQn7hDDZJcw2YdVO14FHJSP663PEYkMQ5BSGb4Qoj0IazS7FTSvtf8pki7E2B1IZz21kDUDZ68/zRk+L91Atzgj90bB4Eo0iEAZJaq44XJV2waqB6g6ZCB/a6xGjmoK1MXFWkYLPRJxRzW78cz93ps8ng0tl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/ZaFCL6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/ZaFCL6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788159912; x=1819695912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KMA0y2gJ+SIDBUH1IFare7qX+NGD24kexNWBIT9z0oo=;
  b=A/ZaFCL6d6g/TCDM8BzgxN+E4WBjRrNRurJ4RUuNgA6CmPYQaqrbGNS0
   /k1utL6MfUFQ04/U8qLdU+c6y3xB7IGN4mGdAr5Jc+KoveXnlPe/B2Nlv
   93eKVpMosIbKqQ7JzkGDVHfhV1tSyg2gtVdlLSBYU7b36XjaQw8UcGHr0
   iXIzHNlwMj0i3ZUwRrNf9qQVSIc+WbYdZU+QMXSUOvC3DhSq893LvLv5E
   TkesHAbdehuxEXpLrmGYaEmB3792DTl4bUFujwCwe0/brZ0MNFo1r6y0y
   H616jZNe2/OqJNu7ptRQzAAMrln6Pvqp5aV4zUW8WGmnhSrx+CPKpQNPQ
   w==;
X-CSE-ConnectionGUID: wgpYo6JCT8a5hnsC/1ZN/A==
X-CSE-MsgGUID: 3ZZf0Yv9S4yxK2ksTtZFiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="106082690"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="106082690"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:05:11 -0700
X-CSE-ConnectionGUID: DevC9x73TOm0q53Kyz17mw==
X-CSE-MsgGUID: 1MXxaRr8RWakykGavS//jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="269306552"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:05:09 -0700
Date: Mon, 31 Aug 2026 10:05:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Yang Zi <2959243019@qq.com>, lorenzo@kernel.org,
	linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hts221: fix division by zero in
 calibration data parsing
Message-ID: <apUnohaFf1HaqWN9@ashevche-desk.local>
References: <tencent_0F43B1BC41CE4066DA52B7B25FBC04C41A09@qq.com>
 <ao7zrbXG6f-pPxIB@ashevche-desk.local>
 <20260831010021.67cbf4c1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831010021.67cbf4c1@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 01:00:21AM +0100, Jonathan Cameron wrote:
> On Wed, 26 Aug 2026 17:09:49 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Aug 25, 2026 at 05:21:10PM +0800, Yang Zi wrote:

...

> > Do you have HW to test? Any fault injection perhaps?
> > The problem with div-by-0 is that it's implementation defined, meaning
> > that it's how compiler decides. Now, the question is, what will compiler
> > do in the current code (no patch applied)?
> > 
> Whilst all this is true, the code shouldn't be relying on any particular
> behavior.  So do we need to know?

That's my point. If code relies on that, it should be spelled clearly in
the commit message. Then we will deliberately break that (nasty and wrong)
behaviour.

> Reality is the hardware is almost certainly never returning values where this
> is true.

-- 
With Best Regards,
Andy Shevchenko


