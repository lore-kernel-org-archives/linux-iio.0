Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938562EF67A;
	Sun, 10 May 2026 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404870; cv=none; b=TcUPVynD+aCi6f2RRZdMhW6CljJN9bkZUWVTG4WrotpZytN61EB9xf9dqyfPMwMrELW4bxGe4jgV7m7IrkkQaDffArcsWH1MQiulfLVRYjN/fQBsDW0v+0HYIfvY9UuYXC7NmS8T7VLR5RkkXu7YaNW0pUFCc/fEasbVMHDaF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404870; c=relaxed/simple;
	bh=C4b1bYnFGuVujbg9Y8JGTiBzfNfNrEuwLUAPIMG+0ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Un+dAe5Bwyh/kRFRpOryQtQP00NAxNZu2rPFQVYIqK4IEK1Yh4D4QiCVAm5Ah8ywTPUYSiO/dcSQmxJ99NICOiR/HTvpAZEL+2Ma3QbhctujpVQFmHgFWcVlQbxNZHW3I0nCuCuIRJC2Y0c6CZlcnxApnPe2XWdc830xJsoZwas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NU2w9YnH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NU2w9YnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778404868; x=1809940868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=C4b1bYnFGuVujbg9Y8JGTiBzfNfNrEuwLUAPIMG+0ag=;
  b=NU2w9YnHfT6Iw/+/1B5R1YOJV1mzm/xHTtD5Zqge2S42a0ioJRQt2SU5
   fvrHF8LGSR7/Z/VDlFmd6UMyfxaBjlojY94kC9Kc3s4iv1hCX8n8kTqPj
   5ZsY/VQJxfujxIWMeAewXw9OrRv9x5soxpnqDfv7IaUNpFySK1+rEG7+Q
   lSyQmp0LFXe09LR3zpsDF54txfGEqV1JeuMeidiOyeUoy1hDc5iF3AHg0
   56bDG383sUZZFpkxdZpZ/dRKtHW6iKoNVc1+HBbRBZBYXv6EK+yaoB7yY
   vMSlrANCV1dDIewOUMvyJlyjGGzbG9CmG61elBZ3upFmfY6jisjTvpOwm
   g==;
X-CSE-ConnectionGUID: x9ixFyyZR5e1oo5aIx9rmQ==
X-CSE-MsgGUID: 66l2mQkvQv6ORQUyFcUJOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="83169315"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83169315"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 02:21:07 -0700
X-CSE-ConnectionGUID: N+qeKfgxR5u5o37/JJtvTQ==
X-CSE-MsgGUID: S04jVMeMQ9e1WJZNXldpSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="236217599"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 02:21:05 -0700
Date: Sun, 10 May 2026 12:21:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: scd30: Cleanup initializations in
 scd30_float_to_fp()
Message-ID: <agBN_htQ5qGc_e0H@ashevche-desk.local>
References: <20260508225501.86448-1-m32285159@gmail.com>
 <8F49F478-AAA8-4AE8-B6BC-BF3C3923AAD7@gmail.com>
 <CAKqfh0FOJ+k3E8Kc5+acsvhK7ATapbhPsas4YZOzjXBkSRFKuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0FOJ+k3E8Kc5+acsvhK7ATapbhPsas4YZOzjXBkSRFKuA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 09, 2026 at 07:27:38AM -0500, Maxwell Doose wrote:
> On Fri, May 8, 2026 at 9:56 PM Sanjay Chitroda
> <sanjayembeddedse@gmail.com> wrote:
> >
> > Thank you for the refactor change.
> >
> > The previous version was more compact and readable. Splitting the variable
> > declarations and expanding the sign assignment into an if/else block does
> > not improve clarity significantly.
> 
> Are you sure? I find it to be far more readable than the comma mess
> that there was before, plus not a huge fan of the ternary operator in
> such expressions. One of the goals I have as the new maintainer [1] of
> the scd30 driver is to get rid of "clever" code and replace it with
> more explicit and readable code. It's going to get optimized by the
> compiler anyways. As a wise man once said,
> 
> “Programs must be written for people to read, and only incidentally
> for machines to execute.”
> 
> Plus if we need to drop a printk() or whatever in there to see the
> variable assignment we can just add {} and add the printk(), no
> messing with the ternary required.

Sanjay, the comma operator is discouraged in the kernel. For this part I'm
fully on the Maxwell's side. As for if-else versus ternary it depends on the
maintainer, but in general if-else is considered better. (For instance, I'm
judging on case-by-case basis, and in some cases ternary makes a lot of sense.)
So, in this case I have no strong opinion about sign assignment.

> > You can keep it simpler like:
> >
> > sign = (float32 & BIT(31)) ? -1 : 1;
> 
> See above.
> 
> > The IEEE 754 representation is already implicit from the bit manipulation,
> > so additional comment is probably unnecessary.

Since we don't do floats in the kernel (all arithmetics is integer-based)
some might find the comment useful. But here as well, no strong opinion.

-- 
With Best Regards,
Andy Shevchenko


