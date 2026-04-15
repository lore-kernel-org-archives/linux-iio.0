Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E551344D8E;
	Wed, 15 Apr 2026 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247638; cv=none; b=uqugcENixDr9sR8pODMMuSEqthkHNZBIftxuhAm9wkMyP9XL/OmC629bk9KwHQg0Rx8eRXPwngQkO0qGeGRsyT967I/3icDPArLMh1G01uUVGge2/YOwmnZbaNpaXB7JXFbGu4kuNRJ5ad0uIQr5XCMrukUrQw6xboXJcxSq+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247638; c=relaxed/simple;
	bh=hI9biBN1+4c9dvL0jNvxP05iY8sH994RHYY9ojKc10M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLgViZ5QleKXOyiitxSpFl0bZzB5ZVRbDQD1favhGfjdEPPWASh7PnyTnFbnlIwLzZ3PgvYX62cxg5sacNmLvnUMfXSSjyOxdwZPawIOx/LAtyoKTYGLHGUqJrMT7TsUCWs4iBrvDjM66CVurmU9f6qWO9Ut8LnODDNQrjwPT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWVNGLyt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWVNGLyt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776247636; x=1807783636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hI9biBN1+4c9dvL0jNvxP05iY8sH994RHYY9ojKc10M=;
  b=dWVNGLyt9lQN2FrH5P67/69vqfMDqOuFfOhHSJbwwo04l+LEhDGidU9L
   TcELVcDOTfFU0UfN9rEv9vOLZ4qZyW8kt4GuB+lrPxXC6wnL+Fp5l0God
   X3GaA1EFBg98iUeb2MR09iD6cah96Mh0zZF8G/eTQWmKnV6o+cqB9IYAO
   xFaqsAhdm7TYd5bz5v+sGL4r1L89e400Ng+zjSm/1lbuhSUSWDdT6ZQyT
   pro4aMJzv7yAVKR0pegE6gDSS8a7CZP3DYG1PcBdVY77ilTcaB+/tAdbg
   xIsnRJNBbcmz+1aPKZtZ4ZcWqORCS6EnoMsjOqZFzx/nbG0NZxYfXMmW9
   g==;
X-CSE-ConnectionGUID: +UK1GgtwSnag6WWlHeQPCg==
X-CSE-MsgGUID: oMoLEPyJTqy2zQEiJUkPjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="87923422"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87923422"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 03:07:16 -0700
X-CSE-ConnectionGUID: X39LUaE3QKqNk2TZUHymgg==
X-CSE-MsgGUID: XNrTyfgjTy6IpCoR9uLmjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230233898"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 03:07:13 -0700
Date: Wed, 15 Apr 2026 13:07:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: frequency: ad9832: remove kernel.h proxy
 header.
Message-ID: <ad9jThxf6PINFFmo@ashevche-desk.local>
References: <20260415080812.1284-1-joshua.crofts1@gmail.com>
 <20260415080812.1284-2-joshua.crofts1@gmail.com>
 <ad9SzwJDwRNldv_z@ashevche-desk.local>
 <CALoEA-xy6WApV+ZUavnEipTKiAezYkXMwiE++TjtHuxkVdR1mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-xy6WApV+ZUavnEipTKiAezYkXMwiE++TjtHuxkVdR1mw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 11:53:44AM +0200, Joshua Crofts wrote:
> On Wed, 15 Apr 2026 at 10:56, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > > Checked with IWYU.
> >
> > We have a (recently new) tag: Assisted-by or so. Can we use it here?

> BTW, I thought that the Assisted-by tag only applied to AI coding assistants,
> per the documentation.

Mainly for that, but it's not limited to. Coccinelle is not an AI tool, yet
you may found it in the tag. Ex.: 8aa9fd0350b8 ("parisc: update outdated
comments for renamed ccio_alloc_consistent()").

-- 
With Best Regards,
Andy Shevchenko


