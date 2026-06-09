Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F23672A3;
	Tue,  9 Jun 2026 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018735; cv=none; b=hSuPSjOXbc1TsRrfgQ6i8Pj1KLyP3yqGRVXMvn+IlvGECrL2tYrZ6FUUWcQMf389DwBKchl7lHu7FnWDT9/dKqpnKdKWrwrAJWS7a4gWlczsfGd2DjczGMAk+Wk7zd14zG9XR33w/Zm7q2MgY24VZOQI7wnIoY8F2S42y91A5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018735; c=relaxed/simple;
	bh=THbBZ8kERecPRcWPrvdkOFUbeGAfm2VJQxXbg6YGakM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6vkNL4QnoYuPTgWrfJ0CubkjP/NhOXBrAUKkks8RXQTkDZ5XfF0TJhrUzdmzsj947u8lVts1a6f7pVjOQzapdbqv0J7IP3+an++TLKZDLnrsx/8Pu3B08R4QI5alQ7pJSFMLzUPaXk5nXqS7KayE3mo6lreCllImj+Wlrm2Meo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNNmwcxc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNNmwcxc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781018734; x=1812554734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=THbBZ8kERecPRcWPrvdkOFUbeGAfm2VJQxXbg6YGakM=;
  b=XNNmwcxcUU6kqdCS3vVIm6HcSERUOosJd3peegggGCJWHiLIkVqP2Afe
   MMld8rERMBwjusrKIVROFxh5lqnL/teMxi50V7SZNwCisYhMDV6iqFISH
   FnAJ/y4nbRX6h5Zxcr20NuYJOiaI1gxLrNkQ14Tl6394kaGU6U1qV7HGR
   sHaWyWlw1PSqOOqOEZmwKbtn+QdiE4vgexzrtmquZgexc66t6E3gclJxw
   N71+lV5DhWRg1NGzoWB3vFgdePr+rNZefcoTJqbeYV1n1TzjKHabesQis
   1lbARVxhLwwn6FCfqilhMe+Go5YDLwO/S22yhoXX0ONuk28LuPKhCOnf9
   w==;
X-CSE-ConnectionGUID: NSg79JrfRZ+ed9uEVU0wEw==
X-CSE-MsgGUID: Url4n1e1TCii1kDV4PpVug==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92347558"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="92347558"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 08:25:33 -0700
X-CSE-ConnectionGUID: SP5D+CM0TGOPpa0Ad8d10A==
X-CSE-MsgGUID: DLKn5CI/RDOwrDQYr3M9BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245929203"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 08:25:32 -0700
Date: Tue, 9 Jun 2026 18:25:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: magnetometer: bmc150: use FIELD_PREP and
 FIELD_GET helpers
Message-ID: <aigwaLHACg_nQUvl@ashevche-desk.local>
References: <20260609020116.88462-1-dennylin0707@gmail.com>
 <aigmtZixUUgv0Y0Q@ashevche-desk.local>
 <CAGEkeHf9c5dOMJbryGF7VW-TaJRXOrkLRs5oeRH21fv5ybCGcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEkeHf9c5dOMJbryGF7VW-TaJRXOrkLRs5oeRH21fv5ybCGcg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 08:12:30AM -0700, Hungyu Lin wrote:
> > You need to slow down. The comment I gave from the previous round still
> > applies. Now even more, id est the location of new header is chosen in
> > suboptimal way. Always try to keep as much as possible headers sorted.
> 
> Thanks for the review.
> 
> I'll remove the blank line.
> 
> Could you suggest the preferred placement
> for <linux/bitfield.h> in this include list?

As I said, create an additional (prerequisite) patch that sorts them first.

-- 
With Best Regards,
Andy Shevchenko


