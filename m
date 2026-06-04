Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186538D3E3;
	Thu,  4 Jun 2026 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558713; cv=none; b=R9huucnh5PVLOf7Kuqb8KUERt72xD2zvxSBT/RXoxtPLLe0QSPLrdyA7NtzJNooBGbWSa+ChLaPJ5MKZ67eZDizyomsPctRWqR+m9fvJXRhH10r1OvvFH2aOG02QpgOAu162tPA1bus7saH8RoiFg9It1VNuoiPrw+hzm7dwy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558713; c=relaxed/simple;
	bh=V1Aala8etxd0GSdirjOaW43EnHDyJ03qqCDUSzAkxh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSWcX8wJj4RlUyia4cO1alRLE0xgugN/VsnhZAJD3WsVuVDNQ8Ufc0l7xAJRQ5fo55WITTkDeG4tkJUdF19XDjVZ5XwkxgvtUntARUXV7mVk3BcZDL4H1lWN9kbYXtqiyv7SGNobEIOeaQnN4NvgvC94NoAh+uphjKLIwQVguwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GP5YN/Qp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GP5YN/Qp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780558712; x=1812094712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=V1Aala8etxd0GSdirjOaW43EnHDyJ03qqCDUSzAkxh8=;
  b=GP5YN/QppzjCgOiKnP7ULCBJroif0tsUcITVkifVIuaxTOwrQ1QMjOTG
   ShzHNL7IKzHec/83/1jUbSmiydAZTmPmyyvMLPyUSZmmYwQr4Fx69DZSS
   OJUU1VYmYVn4xts3tkSuzmlQtunjF3yCVfm+DVH9syBgpMePV9ciabyZv
   i0rIsUXwU5/KGAvfu3sn1bF71sX5qrRjjTj5dD84+gJWUmUu/CI4Sc7lw
   8JoBf5fpAJYFSRHGkiG9s36DLbM5ykZXeFyeHQRr2U+24RuvjjRkxlXUp
   z3W+pRpmwOe58hT4zfUh4yM285C933K8GWRs5RjCYXA7Hon3SXrTqQ+Ht
   w==;
X-CSE-ConnectionGUID: rNvi/oXDRletyA9VGMd9kw==
X-CSE-MsgGUID: zXuf5+QnT1e9iYrhLbioAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="68916665"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="68916665"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:38:18 -0700
X-CSE-ConnectionGUID: pa87SgoLSjWlbJfvccyCGQ==
X-CSE-MsgGUID: Ihqw813UQu6WgXZ9tXSmYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="244320924"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:38:15 -0700
Date: Thu, 4 Jun 2026 10:38:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Maxwell Doose <m32285159@gmail.com>, Dan Carpenter <error27@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aiErZORXCEwxXYaU@ashevche-desk.local>
References: <ahP3O2tQdu4dNx_c@stanley.mountain>
 <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
 <20260526191946.409160c8@jic23-huawei>
 <aiEpmqKwFuIMRfdl@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiEpmqKwFuIMRfdl@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 10:30:40AM +0300, Andy Shevchenko wrote:
> On Tue, May 26, 2026 at 07:19:46PM +0100, Jonathan Cameron wrote:
> > On Mon, 25 May 2026 08:20:31 -0500
> > Maxwell Doose <m32285159@gmail.com> wrote:
> > > On Mon, May 25, 2026 at 2:17 AM Dan Carpenter <error27@gmail.com> wrote:
> > > >
> > > > If the *ppos value is non-zero then simple_write_to_buffer() will not
> > > > initialize the start of the buf[] buffer.  Non-zero ppos values aren't
> > > > going to work at all.  Check for that at the start of the function and
> > > > return -EINVAL.
> > > 
> > > Commit message is incorrect, it looks like you're returning -ENOSPC here...
> > Tweaked and applied to the fixes-togreg branch of iio.git + marked for stable.
> 
> I was stumbled over these patches by Dan. Since the file_operations for the code
> in question do not define .llseek, the seek is not supported and will return
> -ESPIPE. I'm not sure why we have these patches to begin with. Dan, can you
> elaborate on the case where the *ppos is not 0, please?

FWIW, I also left a comment in that blog post.

-- 
With Best Regards,
Andy Shevchenko


