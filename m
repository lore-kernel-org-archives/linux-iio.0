Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22928222597;
	Mon, 17 Aug 2026 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980916; cv=none; b=LhvdqmCovYc8dfC770rvdwU0/aSE24imcQl140Fgu0VTCk4i4FSY/wwOn+F1nhaAxCtg0X8/biqQCeJOkTWfPY2JtsDTgNL6eLOn1xQ57U7zo++yfDGgh8MIspWKv6qpC1k5tKw/DxQJXf10RtgeoxiV9AGjLH8S37W/OD+cGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980916; c=relaxed/simple;
	bh=O4gLRXMnYrupFQ6/H6tN1ghaTnbl/iRpRxxKs1yc3q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twy3Rw94dqFocNrGV1EfJ/jpJmAAUXyqoZu1UnHKl6PFVw4T7rI7PMESgO3pc54RFE093oPmlDKf/0t9C4kpYNZ628X/3z3CHEEL1B7fLOsp47yf7b9eFanK/eLPlFfxq36iqVeCHhPUFvVkAFotq1X5UCo5ap3nlIwehAL4pD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jf9H/7EE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jf9H/7EE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786980915; x=1818516915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O4gLRXMnYrupFQ6/H6tN1ghaTnbl/iRpRxxKs1yc3q8=;
  b=jf9H/7EEXb6aRI2Sz53f3RVtUoBPh+bds3UDvxC0FNUwXre1ytenOrIq
   qEGkGBBvbzajcepz9j17bbSXy+3aIYklpic35rOcStFsVdSQkKhoGFys3
   m3LUXoPefkjc4uG10vPk5V1VLXd2Zr+vXu/hnWVIXeYUHGn8/cZxxg/3+
   TWmQkapgwDTcsEwN6oqdMwSZWPhcM5IBlcEYUG8gnAHJ9AIhbvpeyi5f7
   iuKJ2R7ctN9n0hIJAEKQmsrye9edLUnfXYomPA7JK4op4DziSh0NqDLGq
   9KE7SzSs5jvn46ekLQdfbxpWLEGu4EAqRAAIFpD/pKb+HVsc79EanhtyA
   A==;
X-CSE-ConnectionGUID: kxrWeyBcQqCs1gDOGqdsEw==
X-CSE-MsgGUID: OfZzFhYdTzKNKnM57v2o0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="104841194"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="104841194"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 08:35:15 -0700
X-CSE-ConnectionGUID: OxfkxTAUR3KAlafKgpAu5g==
X-CSE-MsgGUID: HwgmHnMaSiO95/h5KSyHPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="265568776"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 08:35:13 -0700
Date: Mon, 17 Aug 2026 18:35:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gabriel Rondon <grondon@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	Yash Suthar <yashsuthar983@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: accel: bmc150: sort header inclusions
 alphabetically
Message-ID: <aoMqLV8XxT6EwgqF@ashevche-desk.local>
References: <20260816234231.14168-1-grondon@gmail.com>
 <20260816234231.14168-2-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816234231.14168-2-grondon@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 12:42:29AM +0100, Gabriel Rondon wrote:
> Sort the header inclusions alphabetically. This eases maintenance and
> prepares the file for adding a new include in a follow-up patch without
> introducing an out-of-order entry. No functional change.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


