Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BB11EE01A;
	Sun, 10 May 2026 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778407661; cv=none; b=SQNBFsCsXimA0bTdgExM9vUqJRfI/bE8yNpd/V3IrhmRgaZE9MmYhcW/ySdsbGzatnjv6MUB/aHESvKHiFxhpms4Lwbf9kvt+EP2daiHEHoGriRpHUcRlTcKWCo1FpBujHyzsqLpYj/RKg2OZAPshJjTVmTk3Ov/m2Sq7R/49/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778407661; c=relaxed/simple;
	bh=4tph0zy3cNEHlCYe18lSKwujBZx0a7J4karvXTYGrE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC/T7N9DjmSFa82AJDWGx37woNF2idNGzf08n8wNe1Qb25gR+D8OrxWWHLZu1BJWsgRECMOYdrx6nqBpB9IK6UknECq1gpK5oCEudpMfiA5XMTc0835WD8JPEUnlIy2tiu5x++4irXHj3M50VxgaWlxopbOOE0IznZH+LIBdPYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5RMGs0+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5RMGs0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778407660; x=1809943660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4tph0zy3cNEHlCYe18lSKwujBZx0a7J4karvXTYGrE8=;
  b=e5RMGs0+3bWK6V26AckrwiGvF+WD6nLwLjsb6u/GM1YUY3h+MzHNQXzw
   +g3tynYEkccdbw8KJpxFakBwIyLnSqqmnejgMTUnpgR901woOITIUl4WI
   pc0E8PLmROjyJ2tHeKiMvyhJFAlP8ij0kmW8A8tru1JoEyHKC/bYr9XW1
   myWF6qNtLYvOevWCJ48Sm1wibI189iIZZWQyCaD1n0vYhERcztWR6InBC
   tOLYxu4PoT+BP+Jff2Qg0R9krdRQ0cWSK9SYk3H2ws9HjmoH1tYF1v6PG
   sZRHdBKxf/YVuZrEDthoWqt+miYU92m1DRQg22R5KaVwiox9dmFgdjaPK
   Q==;
X-CSE-ConnectionGUID: 84pCywhOQy2jWBRNQ6r/jw==
X-CSE-MsgGUID: /90UUjQRRc+bFVk7GCdgtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="96744709"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="96744709"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 03:07:39 -0700
X-CSE-ConnectionGUID: 3OnfRC1yQxiv9c42gUcypg==
X-CSE-MsgGUID: 5kbNoDiKSfi7LeB6WpsP1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237414075"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 03:07:35 -0700
Date: Sun, 10 May 2026 13:07:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 02/10] iio: core: support 64-bit register through
 debugfs
Message-ID: <agBY5K4qN3jda2up@ashevche-desk.local>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <20260508-ad9910-iio-driver-v4-2-d26bfd20ee3d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-ad9910-iio-driver-v4-2-d26bfd20ee3d@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 08, 2026 at 06:00:18PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Add debugfs_reg64_access function pointer field into iio_info and modify
> file operation callbacks to favor 64-bit variant when it is available.

To write a value with bit 63 set it will require negative number, right?
Isn't this  counter intuitive and may lead to rejection of the (correct)
values?


-- 
With Best Regards,
Andy Shevchenko


