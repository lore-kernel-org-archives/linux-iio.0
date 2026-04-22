Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E633C1401;
	Wed, 22 Apr 2026 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849805; cv=none; b=UOusQx8GglLQu3Bv5YvvjoctsTMI7XpHiKWE3Gm1ziE/a+11VEfonUBYz4Y9HMLbv78xi2SaIqAJEPxTEx8T6JX3na+Bbqy7pjbKzR0zkqbDxXZOOcx+4hM5RSX6tfM6HV9zkJeTPcYza5c2p533cuuX19csU4lDV+7iOJt2A78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849805; c=relaxed/simple;
	bh=CkR69VxmlCOoplLrM+KwSG8Br7V+OXosWD61iWEpOTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKbbcb3YMzxKnzpZhtkguY9QLouDZ1gIuLAD4kf/z7aDz/h2A2oGEeQz25AsguaRIi96u0H5bI4O70ehJ1U5eDnz+Bhsku0qfQD8zkFTt4S2nNAPyEq/zkTD8sHmTj3je+olQvJECCRm1iZnKPs8cPYOtuC/8Ro0Fq0/8IkEGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exjbOYVm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exjbOYVm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776849804; x=1808385804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CkR69VxmlCOoplLrM+KwSG8Br7V+OXosWD61iWEpOTI=;
  b=exjbOYVmfSskLozUzkDzhYChk1jsn4sQS7AuMTYkho/YGjoThMKNQn1d
   TQFwmc7FWvxFR5NBRsUS0DAV5qnK7yhNDsc/Rd9mkoL9lefSO3i8+bySG
   GQvnXKm89dclONzXkivLFgHFOBZvLeYpfi83iL+JIXg9OnDx5Y9DoGs/e
   YerK4rx7oZ3csRrmTZ2loGiza9LU/3xA1fKYAiPV2C7oGFUXTygbyZneZ
   79e6lD1CzgaQ/I6gXLKJHJVQwYbXlFpmQXXxJyYrtzzQJIqjXn/vj4Yb7
   iDu57TP2WsPRyVCj0DakkEbWk8y6kVeoPPXsMG6icI//lGCoc9Ywjnzzt
   w==;
X-CSE-ConnectionGUID: FiaPP1zMSt2Z82HSMHpLzQ==
X-CSE-MsgGUID: lpDBx3VSQRG6WTqS9fkUWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88494246"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88494246"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:23:24 -0700
X-CSE-ConnectionGUID: pMuUEDqFRT6k0HkzK1ZeTQ==
X-CSE-MsgGUID: bX/mTto5TbmGMECxGhAEaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="255565007"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:23:22 -0700
Date: Wed, 22 Apr 2026 12:23:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: magnetometer: ak8975: change 'u8*' to 'u8 *'
 in cast
Message-ID: <aeiTh6uw6yLW-D43@ashevche-desk.local>
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
 <20260421100722.1296-4-joshua.crofts1@gmail.com>
 <aeiMPrBs4BJE0H_k@ashevche-desk.local>
 <CALoEA-w7T-15paJ2j2kGyaWjeK9FpHynS+vD0rpv1dBKEo3gcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-w7T-15paJ2j2kGyaWjeK9FpHynS+vD0rpv1dBKEo3gcg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 11:19:06AM +0200, Joshua Crofts wrote:
> On Wed, 22 Apr 2026 at 10:52, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > "While at it, fix the indentation of the parameters in ...func...() call."
> 
> Indentation is fine, but the email client clipped it.
> https://lore.kernel.org/linux-iio/20260421100722.1296-4-joshua.crofts1@gmail.com/

I was not clear enough. There are double quotes on purpose. They has to be
interpreted as

Please also add to your commit message this sentence:

" ... the example of the sentence ... "

-- 
With Best Regards,
Andy Shevchenko


