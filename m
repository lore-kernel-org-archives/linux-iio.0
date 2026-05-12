Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629FD368D67;
	Tue, 12 May 2026 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585257; cv=none; b=WDkTmsXwu7WI8zq4YsHYmbFF3kybq8hRCGwxMquVJWRnCRNnZ9eiN8gbXBYKHhTy49cz0on77zODJFsqXIQshpCLUN5EEMEGAzTpK/1epSkyeGr+kVHgyHsOzFuFtmACkWgF3E7Iy0mWdrw5X/XyCiWy3mn/ibQ+8x6WBU2H7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585257; c=relaxed/simple;
	bh=n37BrBilI0bouM8C6ddhn7GgtGL+wsJ5cIp1h3qCY6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laVeeUG410w7/m6JgPB1ZaMDb0TaLZT32fOAj6eizFVi6FpYw0V3lKgGDO/Rvs/KvLnQUnhP8rbGqrLllx+YGxvbqafoUu9p60yDNmqAtB5CGwWoDvju9AOyH4qGHAUOIelJG3P0HfE1Ft6CcsXOi/LdaV/T0bUL2oR0n3Fwu/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4HtiRbr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4HtiRbr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778585256; x=1810121256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n37BrBilI0bouM8C6ddhn7GgtGL+wsJ5cIp1h3qCY6o=;
  b=N4HtiRbrIL1SLFfgJT58TMt0Qptw80JMNpf4/m9LYHDoS6BDPzb5lcp/
   NArJTakJY3R3fcEtyHXvK3B6lenVVBLst5jiGhIs6F0TlOa50IxbRXPk6
   QE9JXaBvjowUktXVZIdhEblQUQH4cfheKkIMW6RbCcNKcUbzcBhv/PNB2
   WaED6Mb8040XKuxfanNGZAmepg4T3ZnGHkNMkn1ofH3XHNV+79UMsWmWg
   hOAFkahihld/Vn4ItuwdTopbQYCWlXMO88vr1na0zNgKnbTpE8vnyR5jW
   gIktnW+WzHLJdl0IirdBYAGdBdOW7qCWCZdNTHYCLIY3jXIO+pofdeTqg
   A==;
X-CSE-ConnectionGUID: WbouSwFaQ2yCecFH7h1pRA==
X-CSE-MsgGUID: BIzLI6FUTd+GNy8x/urrtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83363440"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83363440"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:27:36 -0700
X-CSE-ConnectionGUID: /apAEaLpQLu0syQPtGKQwA==
X-CSE-MsgGUID: pTKrIx9IRZ2f+gu7ArpYBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="268089568"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:27:34 -0700
Date: Tue, 12 May 2026 14:27:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexander Koch <mail@alexanderkoch.net>,
	Michael Hornung <mhornung.linux@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] iio: light: opt3001: use local struct device
 and i2c_client variables
Message-ID: <agMOo8pitLjMk_Yb@ashevche-desk.local>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
 <20260512-opt3001-cleanup-v2-4-8018cf3a8a0a@gmail.com>
 <agMKd0GVvDxqs7Xh@ashevche-desk.local>
 <CALoEA-wtBazysBZb7o=MEw_CfY_t9uDZrvKd7jX1xaPD-sHVjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-wtBazysBZb7o=MEw_CfY_t9uDZrvKd7jX1xaPD-sHVjA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 01:13:32PM +0200, Joshua Crofts wrote:
> On Tue, 12 May 2026 at 13:09, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, May 12, 2026 at 12:57:24PM +0200, Joshua Crofts via B4 Relay wrote:
> >
> > > Switch the driver to use local variables for struct device and struct
> > > i2c_client to improve code style.
> > >
> > > While at it, ensure that parentheses alignment is correct in functions
> > > that were changed in this patch.
> >
> > > No functional change.
> >
> > Right, but what I meant is to drop dev member from struct opt3001 completely
> > and derive it from client. Maybe it's done in the following patches? Haven't
> 
> Ohhh, now I understand. Unfortunately you'll be disappointed, my patches don't
> deal with this...

No problem, you can do it in a followup (or next version, let's see how review
will go).

-- 
With Best Regards,
Andy Shevchenko


