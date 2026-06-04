Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6C3955CC;
	Thu,  4 Jun 2026 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558244; cv=none; b=KseTQ+nw5vXRjcJhdv3jRcxyCaQr3q+YI8tbT+BtVwUCiSKGkm5VryLMkG9vXqm74MRNT/Fj4mARvrcb7Pr9ekes6S3He8kVYHFTSiW0kA0NPJ4bjjSFqlhUjmXf0akEFgC5edyCVQgJJvqLVLMhfkZxVW6VcEjoEZqHBC0Nhw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558244; c=relaxed/simple;
	bh=pPOuJPpYNiRfIGXNLd/XnmFAZBJEHafJkry1i/pzDjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9koV20wE9RLG7bJACx3kJP/Ezbpa4nCHRQZhiGsK6Z6x8ePI2zU9/3olrZN1o4uQNfQGmcDE03V8eZpxAMrXDfYzs4oi9jRq5riTFPiJIh0HpkzcF7UAr8/bv/DFXmjfAbrJ1IRlOCxsDTUZ6hAu6UgvPIEBpSsfpjG3/8kFnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cywDNJ50; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cywDNJ50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780558241; x=1812094241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pPOuJPpYNiRfIGXNLd/XnmFAZBJEHafJkry1i/pzDjM=;
  b=cywDNJ50oZPj4CyvjozDHpIFqGnBo8bqbdVS0J9I4S06RMdzQhxEvheX
   3YFQ0sNj5k2vBlIoeEM4qJViwkTnH9jp2nqeA9Z19cIXAcx+15ln4v0od
   glFIuL6dI0EykkxZ+0E27g7tYHoWkhqJysWLIjDF21oyDveKXbhpsz1tj
   7hvC+JDHuiHhXSEghxFGZYRaJZy8Mfn8GdBENRx+uz8ImYiBmmM0koHya
   G8TmH2ljPLCK2RbcI8MgH/4fH3FIP01Cu0AL5ww/AO6hoN3ENnuOOYZBk
   tgzkEVL/aqJiCNC48Vr5YMWUWRNioKMfzo7O2/A3fTzQthuPNvyy84HiP
   Q==;
X-CSE-ConnectionGUID: s+lcO1fQQfa/qD8mIDX3nQ==
X-CSE-MsgGUID: /pISlxbaQFi3SVSLkb+KmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="68916183"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="68916183"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:30:40 -0700
X-CSE-ConnectionGUID: RAZt+Z18RLW3bEyPemPliw==
X-CSE-MsgGUID: /0/oslVPRHSkHEEPj1ltyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="282575477"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:30:38 -0700
Date: Thu, 4 Jun 2026 10:30:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Maxwell Doose <m32285159@gmail.com>, Dan Carpenter <error27@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aiEpmqKwFuIMRfdl@ashevche-desk.local>
References: <ahP3O2tQdu4dNx_c@stanley.mountain>
 <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
 <20260526191946.409160c8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526191946.409160c8@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 26, 2026 at 07:19:46PM +0100, Jonathan Cameron wrote:
> On Mon, 25 May 2026 08:20:31 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
> > On Mon, May 25, 2026 at 2:17 AM Dan Carpenter <error27@gmail.com> wrote:
> > >
> > > If the *ppos value is non-zero then simple_write_to_buffer() will not
> > > initialize the start of the buf[] buffer.  Non-zero ppos values aren't
> > > going to work at all.  Check for that at the start of the function and
> > > return -EINVAL.
> > 
> > Commit message is incorrect, it looks like you're returning -ENOSPC here...
> Tweaked and applied to the fixes-togreg branch of iio.git + marked for stable.

I was stumbled over these patches by Dan. Since the file_operations for the code
in question do not define .llseek, the seek is not supported and will return
-ESPIPE. I'm not sure why we have these patches to begin with. Dan, can you
elaborate on the case where the *ppos is not 0, please?

-- 
With Best Regards,
Andy Shevchenko


