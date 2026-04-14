Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4873E0239;
	Tue, 14 Apr 2026 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170039; cv=none; b=ipjamJhDHw7sZWyQHgrxpqBczjoaIxbUXBD/y6UQHmmnCBTPlruLPjsanyiTquMPRXkXjtsNBb08+xKcoNhMvp0iQOxwmCagnyzGRA+9qJEuV1D7u5C+vT8bbRpXt3lhKgM2zaE304ku/ZNskR/1qYHKuFVmdLJGQrqwTT+tTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170039; c=relaxed/simple;
	bh=7Jkk0AHXMKH2J8HGGASY5sfXj2YOhYqRVNVcDEqE9Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPAzxhAbWb6yihIk2B/7hB9drizBrtRqK9N5qHIUk+do3T7FvS4S5QYfRNKdiJOKtfq+H1mSZTfC5eGWsJtG74LZx5w4MDPmZLTZ+HN9QJgnmOleP6QK2f58Zgv+1Xdjgo4cfEWR25gjRY1/qWGo3xyGG7PjQrFZARgwUqJrdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HW/MIZhA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HW/MIZhA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776170038; x=1807706038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Jkk0AHXMKH2J8HGGASY5sfXj2YOhYqRVNVcDEqE9Js=;
  b=HW/MIZhAILw1nfRus6ktLRNa08ZmvadmGTEws1bSG3VLCqiIrDkSTdvj
   JD9MjxliXyWUxAlrUY4abve5vAwZebKwxyfYKYOJy1aMQtVH/iiCc4hnZ
   VclU27rjXdm8Uk/lHCIL9YSSlY9Rdg5EoZ7iJFBof9wwvVcSnOwOq+SXB
   N+lk9SObe82hn8+vdNYm04cuBGRkKNJONqausb/ODUw0ZYnLCQsKNUfoU
   Tmc3XtWtzeSv06AX5n72gpc7IgMWs09vZl0857rKaZWyeOe66SiDXhTJc
   ZMMenP4+mFSwcy9gBNXt5+DxvnTHAiBUuN+TuEnY7LWsiPn/S0V+8NZd8
   g==;
X-CSE-ConnectionGUID: U1V15tEqSAKINcI/8X0vdw==
X-CSE-MsgGUID: 4QevQj2UT9+BpAWrZeZgaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="87828207"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87828207"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:33:58 -0700
X-CSE-ConnectionGUID: N8DydwYRQdupRvGKCCF9aw==
X-CSE-MsgGUID: uMz4jO9BQieyaFHSgeMisA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234484672"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:33:55 -0700
Date: Tue, 14 Apr 2026 15:33:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: frequency: ad9832: simplify bitwise math
Message-ID: <ad40MI2oyvDeu4Gh@ashevche-desk.local>
References: <CALoEA-wfx3=eVq=omiNmDeSaZpNP85KZd32A=GBiU-DVZ6btAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-wfx3=eVq=omiNmDeSaZpNP85KZd32A=GBiU-DVZ6btAQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 12:45:31PM +0200, Joshua Crofts wrote:
> On Tue, 14 Apr 2026 at 11:57, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > It's up to you. (u64) casting here is not bad per se. And it's more robust
> > against changes in the second operand the type of which is hidden currently.
> > (Reading again what I just wrote, it seems I objecting my own suggestion!)

> If I'm not mistaken, the compiler would always do a type promotion of the
> "smaller" operand (in this case fout). By casting at this point we're just doing
> the work for it, so I guess it doesn't matter.

Yes, and the problem here that BIT_ULL() is (semi)hidden on what it returns for
smaller values. Explicit casting helps with that (while not needed). The problem
that might appear in the future if on some circumstances the both operands become
of 32-bit types... You won't get 64-bit value out of that without casting.

-- 
With Best Regards,
Andy Shevchenko


