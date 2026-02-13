Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD223EA88;
	Fri, 13 Feb 2026 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000763; cv=none; b=qAa/FCV4RAu631lY1MtiQsbnoCISvOfDRC+oYrI8YBTtKoYJV9pYYZBHW9EVsIdliZrpt85bKwDYhme3VbyTCaV4fHYP1mKwvMU5lhMyAMrPOQTbcUT4rRVv83hxI04YXLp4Ps1rQq+6yBFBoErOfkEdlZyK5Z62vgZVZzYnIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000763; c=relaxed/simple;
	bh=z0qyxKtgoWoJjKhSIDi1PP1+nySfwjWL6aal+Ywekeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnhoI5WCi2TThS6XEDnc/K37xa5kmnOrAVaGfPehussYc/mJwQk0fRlG7ASVGSgvL2jsj4zuC+l9t676/RAQHUkwrJYghM3+NXK0Bs6BUQ8cDtOjQBQVkit39B00+exPdwlNi3Y1jobjSKcItbwU8IhscaUpkWcJHeVQU11gmek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaK8ur8Y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaK8ur8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771000762; x=1802536762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0qyxKtgoWoJjKhSIDi1PP1+nySfwjWL6aal+Ywekeg=;
  b=QaK8ur8Y3XByV6VcABmJEjAFKK0iFtgG8PfQLGpqgtqjb7qIwcVgu7I7
   PaLUn7pcYl0/Oso604gwjyGNEcCH9uc3/Wi88Lu80MvVuAMUWsWxh2nEe
   M6Z5rq49OsZktnhwJedIDp9gm9GmOf8e5hYnBkbEk6vDCIj/5R7f1Jagg
   3bsrJdW/NddO7LhqSeO99hILWPyAT7pv3CSZoL85ThL4/fTJA1R0ahVM6
   zfdU4jUdacMr0lVbjvNWJqJigNg0aTUQAffCVbdrIYId2rdhRciAXPjDR
   K2INjvyTa4HhTfaadP+ZyuLTQY1NnXtsrh2YJYitMpOkDJXX6WHQhv/Zj
   g==;
X-CSE-ConnectionGUID: k2nAsavEQaOPkoIMucZumQ==
X-CSE-MsgGUID: BMQtpV8iTnmjG2kcVDj3kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="83288955"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="83288955"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 08:39:22 -0800
X-CSE-ConnectionGUID: kckEj3O+S5Wrd8EmHnr04A==
X-CSE-MsgGUID: eYH9eYKNRD+9exF0FAFkag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="212211295"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.242])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 08:39:19 -0800
Date: Fri, 13 Feb 2026 18:39:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iio: proximity: hx9023s: Protect against division
 by zero in set_samp_freq
Message-ID: <aY9TtJQoIyLVqqR-@smile.fi.intel.com>
References: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com>
 <20260213-upstream-20260219-v3-2-df9371d29f5c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213-upstream-20260219-v3-2-df9371d29f5c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 13, 2026 at 11:14:44PM +0800, Yasin Lee wrote:
> Avoid division by zero when sampling frequency is unspecified.

In case of agreement this is the desired behaviour you can add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


