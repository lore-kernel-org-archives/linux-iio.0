Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643949;
	b=nacvdoZcxJOSfWNdFNElLCx+AZ3U/tM1p1MrADRnXZ4NX0CBBbJp9lCVzlfmivjtW3xl
	 BpzzN5faz1IUratmDLbwvHt0qfrZ50kClRJXJ8k/aAKE+odt0h1f00/UP3+BOxbACVw3c
	 HaA/Acobs/q8Pwl/3UZ3FLlZmYh4thXCdHCSHOU4eyootyUvX4+RGOHEcJN+0zmuPZPgK
	 2iPLBRQ0SoV6YB5Y5Rb8cKE+MbLFZSN83h+jJ9lcgIamB1CVYHKhZR3C+dRduW9KozZ+s
	 QUVI4qqIb4UBUl5QTF1+QC7ZP55jTTxo3iHkYQ6K6/oIoNENFJ/w6IKhln1oywgz7gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643949;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=MekkuUhmG39cS0ShE83hp5V8ZdomME0djhItWQOpeDw=;
	b=5WfrfLY9gw8OL27OZW4VwJPs44KqnaTWiEtGuCYNWbJczIkLpD7mbGvmNP5wrso6aVUr
	 /AD/vb1lpXUy/hTqlVrEGVVRb6SFqScAB2qdIIWcOGXz2IIg2aMNSD6NBUN/qPcYreJRN
	 tvbThXKgSJJ7K5twHBQHpRBSVz54y7ppXUkzSH3GblKObspQaaqRfwZXdQcv/ySqh2/At
	 1Hydw55GN5+UGAz0jJo54xjhVUqkDShUdjGQMgGDw0ObXh3xgwN+jrez/D4Yx0LIUMIQd
	 wByYpn/gKDr27hpCAruT4r7vV1zkJR54hpiULfFBj8JUCQn/+ivKW0JzXnZ8jduOU7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nWkCN3M7;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332B606A31E;
	Wed, 25 Nov 2026 21:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6332B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nWkCN3M7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795643950; x=1827179950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GBSEYPboq/LHR/uK6ECxZgUygngh+aAu1EoskgeSOGc=;
  b=nWkCN3M75i+SvQLL/oQg5MweTo7QW4jTrJzp9XVQf776XFqNRyOS+5VK
   FF/aI3H1Nlv/SzTxNuRc+uJZIQhqlg8XL7q7ATonpEzGp/itKyEnqyYyB
   2dD7W269RNjWhReI9F8pKkNcZGkZKkbtFC72130n4cb8QLAodbWjM9Av9
   pkL5KW8gJywlbDC7kxRky3v/0vX16iyuqbsMHg3JyiFIjmeVFPQckGFrx
   11NxOxpGtFW2Q3EYaRFaOQH1W07Ddep1FxdBOA8PaFkZPQx9L+N8YYbRW
   Aehi4VbgknxJJWXWm3R01YLmTH34JoX26fnOiHaWJrAZ5kiNBkC9FQ7rd
   A==;
X-CSE-ConnectionGUID: /GMXVsFtQKOHINO6VADgBQ==
X-CSE-MsgGUID: nNzDfvIpTuaaN+Pe7Hq9lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4430859"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4430859"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 13:59:09 -0800
X-CSE-ConnectionGUID: 0xKekuL8QS6ODvRVQrM/ew==
X-CSE-MsgGUID: ZOfzwOGdR4ilKgmjrxX+rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11848959"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 13:59:06 -0800
Date: Wed, 25 Nov 2026 23:59:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nishant Malpani <nish.malpani25@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] iio: gyro: header cleanups
Message-ID: <awdaKMPi1bcPv4TS@ashevche-desk.local>
References: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 08:24:01PM +0100, Joshua Crofts wrote:
> Remove any kernel.h occurences in gyro/ and update the headers in
> accordance with IWYU (at least loosely).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
for the whole series, thanks!

-- 
With Best Regards,
Andy Shevchenko


