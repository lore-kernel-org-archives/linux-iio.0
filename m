Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116735;
	b=211kSScS3FyMlVfyEWX92ls/IRBy4dDo7aGSijTlHcd3+O70wVfyMN132dNFi40cBNbP
	 6lmdMe8ez4fUDeZRAjQLCZokWHLqSVh2vZICHMkLZSyS02pha/BnrZI32FUqXpkLU49l4
	 z0JSR+2/QvOW+os6/AkoznMEPXxjLk/GENGVZ/ns2qEkvjlhi+blKT2gy24lUDJpNc23k
	 ejkHBQc6yNt5Hpt5QStePYEbj++zkh9BXoJ6BIldrO7BGhz3keDIl8z3WRMsOzrfewFP1
	 hJuEVEqnZDVi0HwLQvOhuVS7NMQXAP9cGNCB6p85ir9PsM8YzeUBuye9KIghEHmWBRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116735;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=mcuXWAw0ity6EpACOfqTNuF5T/ZuW5Dau0BPkGdfY8E=;
	b=LsM5mYkAKH9jxu2psIWDl0upfoPEdjSAN7oT55eKuwhMIqZ/uBUo6b49sZeZM8eGZBCo
	 TMbChEAAr10o+vnc2RhqyZ9hzo5d4FETKuFgXC8Yz7KJkVRduRNG1xx4y1ccY7fuTa+cM
	 E+Ufmn1Lu43K+GbiL1OTPBlDZ5nB3vvKfgzvjEmuR3rlmWhUMduujl0K5L9kq0RGuwhoH
	 1bA3D4FCvdWizChz67qUUEqa3tMxhJ8KvwtGb7vfAXRwfpNOCtL2WA+kQq/Xz/uMx7XId
	 iaOrGqexQRSPNl2/uVgaH5Xjj6iaESwmz58usdKXWHVzC02jCJQpGZ5Q8EoSTRzHPLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T87yzCg3;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF5606A31A;
	Tue, 27 Oct 2026 15:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64AF5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T87yzCg3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793116735; x=1824652735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7zL7IHziZukGCQjz+/mkhEotA4eG1+cGAukYmGkB3e8=;
  b=T87yzCg31/+WfueWgP4+Xv5quTVQyoq2a0yqDqWFzIGU7+xouTzkSfXh
   D+8XkHBb/eaUbeEinIQzaet9mE2WAG7/kMTszIKBcymfMhzytt2wyzRqc
   VVBIXW0qv7NwtQRtfPWt7qbd9oRUEGq6Z4LX97mn4fSUofb0MlB1FMCBB
   e6JvGlyuxVsu0MGM71bVv+4Fez8vM7tfp4jScHwxXMIWVdPirmct01L5g
   Gr/nQkV9rbD4GjyCfZRVCWpjGmn3i8iULcn/On7G/npPYYrJNz5Z+ZNEh
   q7m/XbHY71yrNKyHxwZTYIIHaeFYnGtlyT2Lab0lvKqmYA0yyaWQ5lXp/
   A==;
X-CSE-ConnectionGUID: arMMwsDiRhuqwEIvKN7mmw==
X-CSE-MsgGUID: mwxKhur5Qyq1wpyTd7zVBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1727891"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1727891"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:58:54 -0700
X-CSE-ConnectionGUID: P9WGAFv1TgiMJNKfiTNyuQ==
X-CSE-MsgGUID: moJ58nc/TGaoyLq7I3+uEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4528449"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:58:51 -0700
Date: Tue, 27 Oct 2026 17:58:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: update email for Joshua Crofts
Message-ID: <auDKOA4Mz3-5Zwce@ashevche-desk.local>
References: <20261027124602.1533-1-crofts@kernel.org>
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
In-Reply-To: <20261027124602.1533-1-crofts@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 12:46:02PM +0000, Joshua Crofts wrote:
> I'd like to use my kernel.org email going forward.

Makes sense and no objection from my side
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
(and good to see .mailmap being updated)

-- 
With Best Regards,
Andy Shevchenko


