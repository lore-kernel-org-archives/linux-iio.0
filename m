Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088027EFEE
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841083; cv=none; b=IwQrN/fTRgxI4WqngUchhnXvp2QfvQgnF3kNHu5xW7VCd+W+/8Ouh74m3XDGLsePMhKP3anDdROW2VAgXyXh9Xiw9w7hNMTODz9cVUtsi/xHv3o1VfQuSww24PeJG/mS7RDXwOAoseOzMIErfPxY5QzCxn5z7VFejIhl7KWL7Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841083; c=relaxed/simple;
	bh=8QMzuchK4RtZtVT7RZx04Yg6zPYllKvcx+RiC4RoVjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBb/noqZbjxh5vRbFSrqvCo7lut88GYCKfIbT0NrfbrZu6YqOC7rsE8PTD2nM6G7KUG6bwKAdz0jaf4HUbxJLdCrA/OUa3RMt2FEJah41HKsQZlabbBsKqwKp5PXzUn/15LhU1SCkJ7n646rJDTnbT2a9gXgx58Cw5mJZRkKTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3j5pO9N; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3j5pO9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776841083; x=1808377083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8QMzuchK4RtZtVT7RZx04Yg6zPYllKvcx+RiC4RoVjY=;
  b=b3j5pO9NKZWiWKBgSzYs/X5jIB5h3MGY1XdctXra9fmg7L1Er7R0XNrT
   pM74DuTpBoak4yClvjXx2wiZkmOiD32Oy/IUmZsh5NOJa9GF0zMcCsOL0
   0Bko7ahyvNsu9XfGzgzRMVpH/xQMavusLmow5AgWjTOTdL11zQ0yxKKZD
   Kf7nDQCGkxQ9fMaNL2Iu3AM4J3zd4ZCkgG+ieBKK885Gd6DUp/WksA0Ls
   /zxUbLGAiHgctG8HXNnI1kMHsNcRXxZKTCW6lmyeYyMnYVBj/CBu2jH7J
   xbmv58JGIhDS0J1O8f4EzxLg/RW8fxi7JIl8E0wbn627VDKeFFRvwSUOn
   w==;
X-CSE-ConnectionGUID: ydDc6Ru7QvWtGtYKqxoqxw==
X-CSE-MsgGUID: TaYQ5Q1/T1CMiNdqr1iadA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77663032"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77663032"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:58:02 -0700
X-CSE-ConnectionGUID: W951W48dTEawFi0BflVaOQ==
X-CSE-MsgGUID: phdzJunwSzSbUQNokq2R3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="229102669"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:58:00 -0700
Date: Wed, 22 Apr 2026 09:57:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giovanna Luisa Hirata dos Anjos <giovannaluisahirata@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Naili Lucia Marques <naahmarque345@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: common: ms_sensors: use guard(mutex) helper
Message-ID: <aehxdS5MePTLkekJ@ashevche-desk.local>
References: <20260416032351.224072-1-giovannaluisahirata@usp.br>
 <aeHv0DEEc2bS4YB8@ashevche-desk.local>
 <CANhRbNwOtJo1BBj2gP7yYD=Tmy3EeGmwGET5ggeSSNBSLrb1gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANhRbNwOtJo1BBj2gP7yYD=Tmy3EeGmwGET5ggeSSNBSLrb1gg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 07:52:25PM -0300, Giovanna Luisa Hirata dos Anjos wrote:

Please, do not top-post!

> Thank you for the feedback.
> 
> Regarding the other changes, we believe there might be a
> misunderstanding, as this is our first submission to the list. We've
> checked lore and only found this specific thread:
> https://lore.kernel.org/all/?q=f%3Agiovanna+luisa+hirata
> 
> As newcomers, we appreciate the guidance and will follow your
> suggestion to slow down and refine our style before further
> submissions.
> 
> I have already reordered the includes alphabetically and will send a
> v2 once the current discussion settles.

So many patches lately with similar content... It may be I mixed yours with
somebody's else. The outcome of it is obvious lack of reviewing the code *by
newcomers* (by humans in other words). I am now starting thinking that newcomers
has to review at least 10 patches on the topic (subsystem) before submit their
first one. This will train more on the process, and other useful skills.


> Em sex., 17 de abr. de 2026 às 05:31, Andy Shevchenko
> <andriy.shevchenko@intel.com> escreveu:
> >
> > On Thu, Apr 16, 2026 at 12:23:45AM -0300, Giovanna Luisa Hirata dos Anjos wrote:
> > > The guard(mutex) macro helps to simplify the code by automatically
> > > releasing the mutex when the dev_data->lock variable goes out of scope.
> > > This reduces the risk of forgetting to call mutex_unlock in error paths.
> > >
> > > Refactor all functions in this driver to use this modern cleanup helper.
> >
> > Please, read my comments to your other changes. Slow down with the submissions
> > of a new one until we settle on the rest, you will develop the style that will
> > be accepted in the future without comments.

-- 
With Best Regards,
Andy Shevchenko


