Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED19373BEE;
	Thu, 23 Apr 2026 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946338; cv=none; b=IjS8K6Gu64eBDmbjlVmB9uOEsHENjKabyDew6NIpdkuZfdrPTNMXUo9KsyKvuhK7nft/wy6aFujVWGEO7VT+B/jkIr6Iyvo+qFQWIrejHmc3IhOA0RgIwjsqyom3MnfKgf+QzXtgL7O+zjHVtffvD6a0kbls48ojOIEFNq75gyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946338; c=relaxed/simple;
	bh=eP+WV0mCi30wddqd8WD6xy4pxzeMaFnty0G8JykG9ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyQEWzXmjDf8IRmh+G2J9IhsaxEQ1P2ifh5o3T6uwdakhUsCshppmmlmg8cyzUrAlxJKQjwUGT5RQ5RWinJcQEdsWeVU19JUUFXVAdzjgV9Pt1Uwz6hqtxODyTOXSYwT28C9zmDA7XLdoH8VDIzgVdA03tqT9gOeAjvCkefU6v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKiDXSc2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKiDXSc2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776946337; x=1808482337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eP+WV0mCi30wddqd8WD6xy4pxzeMaFnty0G8JykG9ws=;
  b=MKiDXSc2qmuKB0CTnSPaqmur6IscMyuLuT/KYQpM77rTHaC8kPIPUdO8
   rT3K2nbZrDY1h5pDDrLRQ+VHflczQE6P2NT79oqBm0FsE7KiqwsQ8hOmR
   vmAlVqmbpjLrdtxA498aEZxj+OkGN79vmmn28/2lVp+Ynuu3RgFXXOh1E
   Gu3OlXM4x83vEA6yBFvGru+YOitBXmnqdKvr8BaDLZzyP1Xh3Vel1YzIF
   rZ24rL1iiRzQ8UXupdNOfM/zxfH5PnacPMdW3T3kWpbsD3tNfUXUMZJXo
   3WsBIjH7lys0/FORqeWodvzlZIeGlCBj1uUCKuHlM2MUmo0b3cnZLo91g
   g==;
X-CSE-ConnectionGUID: pjXQukFlRHepVPs2/FgQ9w==
X-CSE-MsgGUID: 3vYu+V1pRbmunIKnshVDPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88609408"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="88609408"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 05:12:16 -0700
X-CSE-ConnectionGUID: ih5wr4XsQNytenE+3d5QVg==
X-CSE-MsgGUID: aQ0k+b2nQ+esZTLp5h3EZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="232551340"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 05:12:14 -0700
Date: Thu, 23 Apr 2026 15:12:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matheus Giarola <matheustpgiarola@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	matheusgiarola@usp.br, arthurpilone@usp.br,
	davidbtadokoro@ime.usp.br
Subject: Re: [PATCH v5] iio: adc: ad7280a: replace mutex_lock() with
 guard(mutex)
Message-ID: <aeoMmhNTFybLWirf@ashevche-desk.local>
References: <20260421190855.24132-1-matheusgiarola@usp.br>
 <aeh8Xu90pyUBBzj5@ashevche-desk.local>
 <aeh8wfWGGkWppTe-@ashevche-desk.local>
 <CABGH8=a77fmjW01gsmBZnKz1bSkQHA4MrVu-_9snpm-Zv3z54g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABGH8=a77fmjW01gsmBZnKz1bSkQHA4MrVu-_9snpm-Zv3z54g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 08:03:43PM -0300, Matheus Giarola wrote:

First of all, do not top-post!

> Thanks for the review. I noticed that there's another student working on the
> same change, so we decided to join efforts and continue on his patch,
> dropping this one.
> 
> The other patch can be found at:
> https://lore.kernel.org/linux-iio/20260417131029.12568-1-lucas@ciziks.com/

Make sure that student sees my review that I gave against your contribution.
It will save my time when reviewing that one.

> On Wed, Apr 22, 2026 at 4:46 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Wed, Apr 22, 2026 at 10:44:36AM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 21, 2026 at 04:08:55PM -0300, Matheus Giarola wrote:
> >
> > ...
> >
> > > > static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
> > >
> > > >     unsigned int msecs;
> > > >     int ret;
> > > >
> > > > -   mutex_lock(&st->lock);
> > > > -   ret = ad7280_read_reg(st, chan->address >> 8,
> > > > +   scoped_guard(mutex, &st->lock) {
> > > > +           ret = ad7280_read_reg(st, chan->address >> 8,
> > > >                           (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
> > > > -   mutex_unlock(&st->lock);
> > > > +   }
> > >
> > > Not sure if we need {} here (as it's one statement body), but the indentation
> > > now got broken of the second line there.
> > >
> > > What about
> > >
> > >       u8 devaddr = chan->address >> 8;
> > >       u8 addr = chan->address;
> >
> > Just checked the second one s/addr/ch/ as per ad7280_store_balance_sw()
> > implementation.
> >
> > >       // ...or use existing names in the driver for the same things
> > >
> > >       scoped_guard(mutex, &st->lock)
> > >               ret = ad7280_read_reg(st, devaddr, addr + AD7280A_CB1_TIMER_REG);
> > >
> > > ?

-- 
With Best Regards,
Andy Shevchenko


