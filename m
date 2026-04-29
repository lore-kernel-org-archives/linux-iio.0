Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52B383C81;
	Wed, 29 Apr 2026 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489957; cv=none; b=dLkd5AIMkPrQbVH8JvMH9co6hWryfcnX/fZTLX4c845+TVSpngxEEMOwhr3P+kscM4kXYLnUZ6nULjyHctBcI/sbaXXIp4gX6Iij8+eCxVQHZ1dhyG8Dfc8lQAl0QWOL2G676TrkYYuAI2NJXqK3ALHZbrAYnFLZ4OrdWSbRGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489957; c=relaxed/simple;
	bh=xn6B3p6nmB2PDYN/8p5nqhfOAxApFNRoNRU+H1+Bi1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0e2g0Ry/tu/KEfSGQ2aLmdOENDQ/N04qbLl1XIFfYLXRhIK/5n3rj/1z9r2aug8NuRe78rI9M3Ohag79QwpIvfbwnu3x68xp5wRpx39wAsjXVB/VWYrUDA3CCTMlbXFkHx8UlD9aKzA01F0HyBmcuh2yDIwuhiRl380bD1BoUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGJOWBTh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGJOWBTh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777489956; x=1809025956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xn6B3p6nmB2PDYN/8p5nqhfOAxApFNRoNRU+H1+Bi1o=;
  b=GGJOWBThOXDe0wNE0ual92jObvlq5ke9hju8aPkSGN3EUU90zjZJWl14
   EKYYUN30q46HogOf+fsQnbwLW8QHITXB8JWow0yEES2kum/8Itgq02J6Q
   k/R7uEkoiDBgM/rqSDXzvERd64K9Y9mSbZT/MwPHwzRpO+uEJ/Lzt/WjN
   7rpVf9xCAMCucv9K2GcJZqn4PSaQ3KawGs9AzWXHAnbuCul3lm7HDuN1I
   I2XIJ6Vyy+Ddb6iUKBV33sbretSYP85Y4slcuQ2nCQEiTxQlmM4WR2PFN
   WMEsgJqah08YPCO4RveIaLRVrDT3mV/EEihyQmheVStC+1j1QE+kY3ipI
   g==;
X-CSE-ConnectionGUID: thv4FI9CTXaQVK9k56kfdQ==
X-CSE-MsgGUID: n1qAS9w8TKCcxyuY4/eR2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="77456617"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="77456617"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:12:35 -0700
X-CSE-ConnectionGUID: yo5XokoFQGq+d1Sn3hoXeA==
X-CSE-MsgGUID: 5zNk1DhSRzuv/AP1FZ+BaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="233511708"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:12:32 -0700
Date: Wed, 29 Apr 2026 22:12:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, songqiang1304521@gmail.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
Message-ID: <afJYHTv7Sz4hJLNa@ashevche-desk.local>
References: <20260428222600.91322-1-m32285159@gmail.com>
 <20260429114154.290e588d@jic23-huawei>
 <CAKqfh0HnQADMZhxn0OEp0jV2BVGKP+wRyAMOS4g9OOm+QSv_6Q@mail.gmail.com>
 <afJNRnuQGnnQPA4w@ashevche-desk.local>
 <CAKqfh0EF-uBdsyS0K5E8=t0YB-LQ9DvNALmKPWBTVczM7OXBUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0EF-uBdsyS0K5E8=t0YB-LQ9DvNALmKPWBTVczM7OXBUg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 02:00:05PM -0500, Maxwell Doose wrote:
> On Wed, Apr 29, 2026 at 1:26 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > Won't fly. I am pretty sure most of the maintainers find that bad. The problem
> > is that the caller should be crystal clear to show what the critical section
> > is. Hiding that information behind macros drastically reduces understanding of
> > the code,
> 
> Was just a thought. Even if it were to be implemented, it certainly
> wouldn't be a macro.

Still the locking wrapper that takes function as a parameter doesn't smell good
to me. The reason is the same, hiding important details of critical section,
decreases readability. Also long term maintenance might suffer if one needs to
alter that piece of code.

-- 
With Best Regards,
Andy Shevchenko


