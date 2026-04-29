Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6C194A6C
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492309; cv=none; b=IBuhPOqFmhzcuSOUHDm0mE3zGD0w9VwzfE+ZxzhuMMDCgn028kG/+HZewM0luwGaYavFgvjFUG6GW7cbh2sjmyRYlPjorYwPi1OFBJj+rlfDIunvhNPwQzZ2E1CXctePfU6/bi55wBpY4T8peqzLhwvTXnpd8ieE0xXN4k9qs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492309; c=relaxed/simple;
	bh=3Nttbq/PIIK4KlK+ad00cMJ8K8S3m/EBb1GMHfn+W6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVJnBOIPfVlA1HeyTnS0ealHUboZWI0CL9VTzUBOzltooiOrGRwrsK4a/FNyZ2AtMK23sa+m7m+dVLe4SZR8Mv+2d7taTAzJ98C6x2daC1iq0Rbo7WzA7xrAR8a+ta2V7dU0p5Y7G/prvDNcQQfDxbJaA/UaQv7C8ACP1GOa4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHDW2KF7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHDW2KF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777492308; x=1809028308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Nttbq/PIIK4KlK+ad00cMJ8K8S3m/EBb1GMHfn+W6U=;
  b=LHDW2KF7J9r06ETbBCzKuNV1ncVBQ7/9o475011xDJmOR+fwgRAK1zAR
   +s/cA4Rzh3/cuvwXD2ZnSNAG2ex+4H1C+n8NBsLs93vVpv1Dy0M9FEQz+
   Ui8Y4cWBRq4HWFaO/ikpQ2Zyzi8E3fKoUhC7jOyQcWbrFPL9HAW947Fzo
   Fe0A2pb1KkFDSONAr9EpU07ZggmO4p25ptqKX+wuKeXXTnfyz0+ePeInK
   1Jtpga1RTp7gLHMy1mkBQx11HVyUg6k8Xq6JUkz/5wNWnbwZgTNVLisYz
   mRQrzdGYc8tPcuNCxd6HCkHp56S0SVS7P3CnlTV5vXkrkVTs+I7MhEWAz
   Q==;
X-CSE-ConnectionGUID: 6NAjYEtfRM+rDk9E6I9QIA==
X-CSE-MsgGUID: HY1SroweQYqcCxeCRZ+G5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="103889027"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="103889027"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:51:48 -0700
X-CSE-ConnectionGUID: 8vbcAx/BQzywcsMoTWJfCQ==
X-CSE-MsgGUID: UOm2hiHBQI2tmzelVyRSkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="236139143"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:51:45 -0700
Date: Wed, 29 Apr 2026 22:51:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>,
	"Rafael G. Dias" <rafael.guimaraes.dias@usp.br>,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org,
	Felipe Khoury Dayoub <felipedayoub@usp.br>
Subject: Re: [PATCH v2 2/2] iio: light: stk3310: Update includes to match IWYU
Message-ID: <afJhT6z0qwQL-tuQ@ashevche-desk.local>
References: <20260428161339.1187956-1-rafael.guimaraes.dias@usp.br>
 <20260428161339.1187956-2-rafael.guimaraes.dias@usp.br>
 <CALoEA-zxZgPwgb7o_=F9Q=bQSYiQi=THtCpgu0mW3EEzbXEAcw@mail.gmail.com>
 <20260429112300.696e2722@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429112300.696e2722@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 11:23:00AM +0100, Jonathan Cameron wrote:
> On Tue, 28 Apr 2026 18:49:36 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> > On Tue, 28 Apr 2026 at 18:14, Rafael G. Dias
> > <rafael.guimaraes.dias@usp.br> wrote:
> > >
> > > Clean up the included headers in stk3310.c according to the
> > > Include-What-You-Use (IWYU) tool. Remove the generic <linux/kernel.h>
> > > header and add explicit dependencies to improve compilation accuracy.
> > >
> > > Co-developed-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
> > > Signed-off-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
> > > Signed-off-by: Rafael G. Dias <rafael.guimaraes.dias@usp.br>
> https://sashiko.dev/#/patchset/20260428161339.1187956-1-rafael.guimaraes.dias%40usp.br
> Had a few comments.  I added asm/byteorder.h and linux/sysfs.h.
> 
> Maybe we could argue the sysfs.h one will always be included by
> iio/sysfs.h but I think it's better to explicitly include it
> for struct attribute_group and similar.
> 
> The asm/byteorder.h is simpler one as that should definitely be here.
> 
> Anyhow, tweaked whilst applying and applied to the testing branch of
> iio.git.

Please, also drop irqreturn.h as implied by interrupt.h.

-- 
With Best Regards,
Andy Shevchenko


