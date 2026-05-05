Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449BF2EBDFA;
	Tue,  5 May 2026 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969036; cv=none; b=CR1kHgqvNZM/kbkAemMj5Kosdeq8IIZn3SvmuT0K5BsKc74ZGZBqaEIRomC5pcfeLJqEnqGQu1IVEqgSiISUs/s0d/8mqdVPSqh2m34dsJqcQWddBSYAoRy7J614WvgpfxUbrxm4F5WLkZG1HWt4qln1VoqMXynY2Yt1e8i5oHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969036; c=relaxed/simple;
	bh=8SD0U/zGj0i2YxFSH7nIFBO7d96EnHl9ib1TOIdCKq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF/sOu+qydzYAgXDYSc38+QYv4I+UaZEpCbZfcjuRY5P1Qppovf1bsTs4c4lsHEQUhfhKZWXKkdhiEwfvSqNBGv1mWBv8XhhGLOsYTQEv0QukKRZxxB7b8xkbZpLpA+bC9sPxP5fvCIW+WBF8wjnGDR45EvyJra6a+2Ssq7NLjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5YS78qR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5YS78qR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777969035; x=1809505035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8SD0U/zGj0i2YxFSH7nIFBO7d96EnHl9ib1TOIdCKq4=;
  b=O5YS78qR5RWjNEs8yYAot6bX2VRCM+VxR5NXV3Yq5+TEUfwuu2NFABSO
   K1VGlbAPSBd0rRmQE+Hy0foldLu+2TbhU6hG40YwgFDutcPTBxAwtV8JV
   Hcube2AKnWqAp9dLM76sg5OzoitHkavV14UTm6bCXPc26OhDxLf4sAsSM
   pJitz7gBaNK3azHhCpyhBTVwWio2R1G4N7BbKnEGEk7wvnI00x2Ui42Tq
   O+qWE9y4mzsTP+tQFtDP8xG075lILIwiIOJNlAtEEOLr3pn1yIoKR03wO
   fPOsuCY+OaeAoNo6IdnGX5mYbagv5C2SQto7eJJdv3oM8004Gy+7wAKsP
   g==;
X-CSE-ConnectionGUID: xsMS2cw2SxuNwgtcHupESw==
X-CSE-MsgGUID: lc+VEiQFRdCxhHfIQfWWkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78737994"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78737994"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:17:13 -0700
X-CSE-ConnectionGUID: vIGsgZt/RSKZxuqxpZVCQg==
X-CSE-MsgGUID: i5h/cm5GTFme7EWeA2xcWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="240739938"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:17:10 -0700
Date: Tue, 5 May 2026 11:17:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/17] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
Message-ID: <afmnhB-DnW4cICkC@ashevche-desk.local>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
 <20260504-magnetometer-fixes-v4-6-a291c2a7c71a@gmail.com>
 <20260504160606.07f87f10@jic23-huawei>
 <afl404iaPbSsK5XF@ashevche-desk.local>
 <CALoEA-xkOVvGqwWdHMS3HbJSCrSbyBd4GQ2CkczkT9Tn-xO_bw@mail.gmail.com>
 <afmag-hFCs8u6jN7@ashevche-desk.local>
 <CALoEA-zs+Qf8QOD6zE32Es3iGOo12KsvtAKYcd3LTQmoBwLw0g@mail.gmail.com>
 <CALoEA-z6omi2JzqWrtrXKwGTx372pjcFZikutPVeVc2x5QthTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-z6omi2JzqWrtrXKwGTx372pjcFZikutPVeVc2x5QthTA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 10:07:57AM +0200, Joshua Crofts wrote:
> On Tue, 5 May 2026 at 09:26, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> > > It's better to integrate it into the series either as a fix (should be first in
> > > the series) or as just an improvement after readx_*() conversion patch.
> >
> > Better to do it as an improvement after readx_(), rebasing would be easier. I do
> > agree with it being added as a separate patch though.
> 
> Before I forget, is it better to return the negative 'val' or -EINVAL?

The (negative) contents of val. Shadowing the error code must be justified.

-- 
With Best Regards,
Andy Shevchenko


