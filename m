Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87035382388;
	Tue, 14 Apr 2026 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776152958; cv=none; b=JK7LrK1egxqhkKG0/MmbwkWtXuo9VfP/1OX7V+1d5DOITwGrtPaUDm6NRZjzeiq6Q0+44Cp8k/paAQ+qRPfzdXdpXanofevagqMSNLENhmZVNuyv2bgpjonOTKdOvAfX35wTa3uweA0voWZGp89C8spC6moetoJ76x9sccyaWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776152958; c=relaxed/simple;
	bh=MKuHVxrPF8dtGDV/naHv6QawM3n4QlmcIcVNt2I4WMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRcCprLnDCkuDDv5DTURPp9b0U2UFbQ+Tu4jESDR5nWIwKfavSlBOOMDE1SeTaki5oK0tZHIrSzJ6fJQjK3201B6XIBLLN7lCYebQhM4pQVLJEWcgJ9Y6ydYzGMgTuIgIrdjv+nGKM5CqVIWd4LPYSY/AG5sWQ1WPmwatgzWDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcj6yIV+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcj6yIV+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776152956; x=1807688956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MKuHVxrPF8dtGDV/naHv6QawM3n4QlmcIcVNt2I4WMM=;
  b=fcj6yIV+B/krLSNUNmT/6fVcJ3RUk05yhwGTSqd0gboAhG0X8AQCEQY8
   o9/m5jNsslb/3bkyRjzqAfOTQZpuG9LnYQVHqD4mLrPT5Aumcxqht9Qv5
   EH+a6h4iDv7rwCt8c5B5ZJdxJitD8l63WC/MF0iRVb8tv9YgZOawIO3Zy
   zk3VGwvsX+bNu3aQLS1DC44lXMCOtBCauT2yG2i6fCpbUS3KZDupYLz3M
   JaVW36PJLygZ+00BrOuuCUZW1c2rDgYhMG/8xjOXjudN9hYvOI+m00wtu
   1uL7Xmt/fODaEWcA9M1TcrDDLeSKAXZ05VoGfwYpmbHXkiyxo6sNlFyrd
   w==;
X-CSE-ConnectionGUID: Y7V2fvvLRb2AEGOSKvEODw==
X-CSE-MsgGUID: sYIFdml1SYilGbbB++beBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76979425"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76979425"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:48:26 -0700
X-CSE-ConnectionGUID: tK5m3I0qSk2WsuZwT2/XcA==
X-CSE-MsgGUID: /+UWcmQDTdq+m+LAtapxnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229954370"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:48:23 -0700
Date: Tue, 14 Apr 2026 10:48:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Dan Carpenter <error27@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/2] iio: frequency: ad9832: simplify bitwise
 math
Message-ID: <ad3xRJg7LFL0Luil@ashevche-desk.local>
References: <20260411085848.75381-1-joshua.crofts1@gmail.com>
 <20260411085848.75381-3-joshua.crofts1@gmail.com>
 <adokoNfP-Ueg4yQ7@stanley.mountain>
 <CALoEA-z0hkOw35D9suEKi61x12fNSSzYem5pecCFj0w_EwLHvA@mail.gmail.com>
 <ad3sckiwifI5ZQYU@ashevche-desk.local>
 <CALoEA-y4Uf+LbM8w+bMA7DdW0Pcpv7AVcbdOD9GknVu5R7TKUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-y4Uf+LbM8w+bMA7DdW0Pcpv7AVcbdOD9GknVu5R7TKUw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 09:39:04AM +0200, Joshua Crofts wrote:
> On Tue, 14 Apr 2026 at 09:27, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > Yes, please slow down as you also missed a tag.
> 
> Yes, I've realized that it was stupid not to wait. What is the proper
> etiquette here if the
> v3 patch doesn't have the reviewed-by tag? Should I do a RESEND PATCH or a v4?
> I've attached the tag in a reply to the v3 cover letter but not sure
> if that will do something.

In this case it was fine what you have done with attaching the missed tag,
but be careful in the future.

-- 
With Best Regards,
Andy Shevchenko


