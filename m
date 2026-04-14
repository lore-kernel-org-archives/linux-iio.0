Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638213BAD89;
	Tue, 14 Apr 2026 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160627; cv=none; b=dhwH140NmeqA0KQ0+OloNEQDv0L82sfdqhFN7dxwz1hhXFee42n9RDkjM/Chgi3qDwmp+NTpmZhBkkN4ytqNurhg679wn82yxvlfcbLqXVLagrUK+F/vOMec+KexmUDArDNBKSUVeSXyY++PjUR8WhonMpUNkAOyl8//B+XL930=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160627; c=relaxed/simple;
	bh=/lODIGFErRqc14HEdpGS9fqazISGvImIA0CYwTqFe2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yvlbbn+HO59n6hP5cbXFt+cTfwwB7xlayV4Ou5bAx7bwDgrm03vShHhC7X0plICQWA8pD0z+r0x9EsbWyTde90DxhvwaUVkDsv4XsZfimX5s71gYnVYqbAALi1bII0N2Jc2AQk+h5mZzqFwk0jgfl9EkmKglAw6mXcnYcaI6/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moeihqC8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moeihqC8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776160626; x=1807696626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/lODIGFErRqc14HEdpGS9fqazISGvImIA0CYwTqFe2g=;
  b=moeihqC8F8tuExOSSXGlNhx7GLsegCbiqf6bfl6Rt+/s38N26GE0j5sN
   Qv19HmI+yjTQNYFDijSg8Xm89J2+xduFmsY4O81kfxtoNy5v2Q+tjbj+7
   HpgxzIzans5Xa+ztn400my3418CTT00g/Yuuyoa+X3T/QM1Pk5LtQjSQC
   EyxN7BYNXaKWokqD/LxIcK74d0Hucx34JoqFP9RGpOwd0/4SD1s7N+gky
   1cSg+h7Bq2A//MWdi9JSOI8MbOXelam8f6AkLXj5jUn6adQBPDdiSBjpm
   e39iTPgb7WuCyr5/eoj2NVsuWl3Nps9iJw+4ACRSj98DpyoZwT+zzHZYd
   A==;
X-CSE-ConnectionGUID: CjRRs1eqRZaIwwDnucwutw==
X-CSE-MsgGUID: KNoN4+23Tt+GL77BqZWX2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="77293796"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77293796"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:57:05 -0700
X-CSE-ConnectionGUID: MGN5058NTWSU4hlRwF965A==
X-CSE-MsgGUID: Jui7WWrgSDuUkwgayQOCnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234980474"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:57:02 -0700
Date: Tue, 14 Apr 2026 12:57:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: frequency: ad9832: simplify bitwise math
Message-ID: <ad4PbCcHUMgjGMlP@ashevche-desk.local>
References: <20260411123512.84739-1-joshua.crofts1@gmail.com>
 <20260411123512.84739-3-joshua.crofts1@gmail.com>
 <ad4MbnpAfBEXKDzm@ashevche-desk.local>
 <CALoEA-ye9aKD4DyciFNZBW2TSd=pw162DD28rdvRw8O2OJvcqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-ye9aKD4DyciFNZBW2TSd=pw162DD28rdvRw8O2OJvcqw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 11:51:03AM +0200, Joshua Crofts wrote:
> On Tue, 14 Apr 2026 at 11:44, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > It can even be just like this:
> >
> >         u64 freqreg = fout * BIT_ULL(AD9832_FREQ_BITS);
> >
> > if I understand the integer promotion for unsigned types here
> > and the * operator correctly.
> 
> Sure, at least I'll ensure that the reviewed-by tag is incorporated
> correctly.

It's up to you. (u64) casting here is not bad per se. And it's more robust
against changes in the second operand the type of which is hidden currently.
(Reading again what I just wrote, it seems I objecting my own suggestion!)

-- 
With Best Regards,
Andy Shevchenko


