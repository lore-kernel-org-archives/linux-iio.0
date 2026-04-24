Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5234A783
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020748; cv=none; b=Cy2c1+tS44/SrnEP3MQGh1joFdJWB2ItpZrHVANY5cPC5JEog767HjA8azy/SPkvGhZt3GUhHKXyfLPJ84yLnVY7izAis8hdZGTTSwsgfuakSoGsQvfWcLU2r4xA//FYGiXwD3XgKO/ijNsd+yDmgJpjwLAxxy7eG4Yy1djgRNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020748; c=relaxed/simple;
	bh=N+KfTswMsykQwblz1SvP+iese6DJD8cgBELkiH+wWnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zsrk13G5fwh6J8oeMtB7SQJEEGpAdKGlAVf5MkiKgqZTeZgD9vCkujYOgM6OzVdqKyOwoI9+/h4EHB2GTDSKNyoZnp3SXOUwDJrFOXsOAvn1rr8M3/Iuzx182vH06XY3/xG2eXtDgwic7hyDS90b+KThiTVULG9UoVi6wJ+TTkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SThqkZyP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SThqkZyP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777020747; x=1808556747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N+KfTswMsykQwblz1SvP+iese6DJD8cgBELkiH+wWnc=;
  b=SThqkZyPoIQqeW+SxWGgEnEVpuDkVAPkUNkKS+gBC+lH3URbIi18taj8
   AdoaEiqncWDK6nU4ATlp9k4j+vRXKTbVaozqT4mxiaFlIwm7MCx82XDLQ
   x7x6iupvieB4gIERJhqsIuJLIvh2GvzwL17ksoThsuPquzCsRqy3NoNUr
   mg2aTPzJqD4YbPUsUV5DT5bxWvSGM0OG5PbCFAzu78Cn5COgfal9VpbAD
   YdoKQtD0Zs64nbVo8lQ+lP+jN75I3CNvmBD6mS3knzD6VqxEHnHpOS+ci
   OccQDnV+mroXCTTgRsNIyxJ+k+2l5mR+o1Ga+y4uZL1XWuHF+r+EduZb2
   A==;
X-CSE-ConnectionGUID: K/T4Z4waT5G4Bu+HNpbBww==
X-CSE-MsgGUID: ZzUUad/jT+iP3QmSfskWIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="88696782"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="88696782"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:52:26 -0700
X-CSE-ConnectionGUID: 71GR94+BRvm8mU9hB7c9bA==
X-CSE-MsgGUID: C8TcqQrBTiOaau5f7zlEIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="230242554"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:52:20 -0700
Date: Fri, 24 Apr 2026 11:52:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Machado Lage <marcelomlage@usp.br>
Cc: Jonathan Cameron <jic23@kernel.org>, andy@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	Vinicius Lira <vinilira@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: adc: mcp3422: rewrite mask macros using
 bits.h macros
Message-ID: <aesvPuRfJk2tE6Ro@ashevche-desk.local>
References: <20260420191455.529923-1-marcelomlage@usp.br>
 <20260420191455.529923-2-marcelomlage@usp.br>
 <20260421165452.76df9b7c@jic23-huawei>
 <CAO=vGZrJjwsPtFeo+Nj1k8rKpHehsVUhwFCxzeTAeJinTL_ssw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO=vGZrJjwsPtFeo+Nj1k8rKpHehsVUhwFCxzeTAeJinTL_ssw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 23, 2026 at 04:15:54PM -0300, Marcelo Machado Lage wrote:

Please, stop top-posting! It's not how we do in Linux kernel mailing lists.


> Thank you for your comments. We will correct the mistake in the commit
> message in the next version of the patch.
> Regarding the comments at
> https://sashiko.dev/#/patchset/20260420191455.529923-1-marcelomlage%40usp.br,
> we appreciate the opportunity to learn about this resource. However,
> after going through the content there, we do not feel confident to
> address other pre-existing issues in the code at the moment.

Also drop the second 'macros' in the Subject or rephrase it.
Exempli gratia: 'rewrite mask macros with help of bits.h APIs'.

> Em ter., 21 de abr. de 2026 às 12:55, Jonathan Cameron
> <jic23@kernel.org> escreveu:
> >
> > On Mon, 20 Apr 2026 16:14:54 -0300
> > Marcelo Machado Lage <marcelomlage@usp.br> wrote:
> >
> > > Rewrite MCP3422_CHANNEL_MASK, MCP3422_PGA_MASK, MCP3422_PGA_MASK
> > > and MCP3422_CONT_SAMPLING using GENMASK() and BIT() macros from
> > > bits.h.
> > https://sashiko.dev/#/patchset/20260420191455.529923-1-marcelomlage%40usp.br
> > pointed out repetition of PGA_MASK.
> >
> > The other comments are a mixed bag but it's worth taking a look to see
> > if you think any of them matter.  They are all really about the existin
> > code.

> > > The other macros MCP3422_SRATE_{240, 60, 15, 3} were not changed
> > > because they are also used as array indices.

-- 
With Best Regards,
Andy Shevchenko


