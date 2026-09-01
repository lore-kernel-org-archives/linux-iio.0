Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7CD46D577;
	Tue,  1 Sep 2026 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248887; cv=none; b=Ca2QxoO5vk2i3q5htxnVrNoySMahfja2+wjw+xW+5xkOmV58JfhgxtK8TTpbjRT9Ct2V2u7N7iDvoHS7Sb4gYpRVkxlINCbcfnzZ9+16VyjJS2jsucn34Gqq7BrcBoh7T0707+89vXSAbv5nESNm2RhcCWExljcEsmGtLI5mnYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248887; c=relaxed/simple;
	bh=/1+KnC6kom6C1yqjapJkcF6QnEJCLghIc8zg6WD52QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ja1BId0kmEqi3jg4KJuvZHb33+KWe6c/d5dRUV6hPbWWo4yz8rJQvDT9cYVMJGFTscUeKwvL9H45Wj/6XbNgmwRbsUFbyrQnsGbMxdUvV10eRon/0lepPOVhpQ8zOyC57zt+TIXi5s5d3j0RveV7ypzYr0nTqTDHHB6Znp49af0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RU6CC2Gi; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RU6CC2Gi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788248886; x=1819784886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/1+KnC6kom6C1yqjapJkcF6QnEJCLghIc8zg6WD52QA=;
  b=RU6CC2GiCwKWIIvcbvPjyDq+sm+STfYkBXleVoxAs1v+UDVu5nSg+wWf
   81JMq3sjz9VULse379FgKfdkIHGJazwFTynIBZnu/qfIBxlY77rqPA0u5
   CN72dxwvGPTLWjXnvfoqLxbQDiXyT46nZGkFCZF+8KaZ0iaKevnNN7kpe
   shuOaySqIZs9G3bAb4aFWYtO9I95IKDHweb2IP/LO+mrDHRNT/wY+ARQP
   o6E+xR7agsOpk7SUaB4xFmA3rXpUhhnB/mHApHq+eL08TSaUmC00YYgKI
   QpSTHPhJYQhGaSyY5I67bD1e8c90xNZL5fNu1mAE+8n+xfW2RFZ9uBAyb
   Q==;
X-CSE-ConnectionGUID: TPb3rvRFQJ+I+hzmZGRhSw==
X-CSE-MsgGUID: 3S20JqhTS9S+x3YpcsP/7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88429049"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88429049"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:48:05 -0700
X-CSE-ConnectionGUID: WYfYocJLS6O3hEFL7Tzpew==
X-CSE-MsgGUID: gkTdQJ1eSHWzsP38YqkuZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="269602282"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:48:01 -0700
Date: Tue, 1 Sep 2026 10:47:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Gustavo Silva <gustavograzs@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: imu: bmi270: Use in_range_inclusive() in
 bmi270_write_event_value()
Message-ID: <apaDLzXEvNU7APss@ashevche-desk.local>
References: <20260831-minmax-in-range-incl-v3-0-30444a2fd2a5@gurudas.dev>
 <20260831-minmax-in-range-incl-v3-3-30444a2fd2a5@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-minmax-in-range-incl-v3-3-30444a2fd2a5@gurudas.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 09:26:30AM -0700, Guru Das Srinagesh wrote:
> Replace the three "in_range(val, 0, MAX + 1)" checks with the new
> in_range_inclusive() helper, expressing each as the inclusive [0, MAX]
> range it actually validates.
> 
> No functional changes are introduced by this change because @min <= @max
> in the inclusive range in both signed and unsigned readings and hence
> the check correctly continues to hold and is unchanged in behaviour.

Yes, this change makes code better (not only shorter, it makes it robust
against theoretical wrap-around).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


