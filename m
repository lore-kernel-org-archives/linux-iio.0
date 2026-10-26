Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045838;
	b=yUxWqlr/tbrYxwM1nElqmZkahwSHAy4Y7lENeUfAaXbQ4vl+3NKYKlxyWITqFGMwU7AR
	 Btao6iyGCZP8EjRVefwkd6LmD5cpVN6C+QpxK5LYS1mC8VeogIW7u7WF2YGBD4wO5CrfL
	 ictAa5ZELQFUNjkh8raAinsWZ/j6YUx15Z7Z/AV91yF03na3UPDWOAbrjUGzUdIcIhUxl
	 Mq3LR0nEgtdL7XVEW2vmM4w+XQPelC0WAcLpTymJMlYrscnu/CmmWGCsMCMw2zBfGTy+m
	 Z0nBkIbwwa+EeNqT5l5JeGVNECz5rgn82pNmY7Tt8RT5Ips0vJ93PtZlWV2XxsqGnnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045838;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=J0N9NmVqOkZJBbEdvHDt17avMBsn3Sr2xkgzJhmnDaw=;
	b=jDx2gfQtN6fPkFnAkeBkPi9Q5clF8P9MfQP6lDIngd8hgcTRPJ+nUZ6fVi6hnl1ooJxk
	 GTXgD5CPsdPel0dul/hp4fyz0GegN1mWv/r1RqzrxdpHMhYgxo5KYf4+amtNZ4yilKInA
	 PnUWLERW7PE+PWkkGm/VK6DdLZxLSJEOfU0f9PVYmHZjvbu453FZMnWOgFFqQk03/ID/n
	 x+MUc/StVhwFgzJxgI4fu1hJuymK9f77mG79XReDE2qtRrUl9LThsLStg5K6jh9TgiHOI
	 CIpEXST8Jw+h3qY/0AuTWAJNEnCJmKaYEc/A1v4qxkVvUOhYSUZkep/VfN8FzY8jF/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PkxjSuMw;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C47D606A31B;
	Mon, 26 Oct 2026 20:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C47D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PkxjSuMw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793045838; x=1824581838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T1VoGZ2A9VThoWAioNExjXzltcbVbIW5zOl8ZXpGbew=;
  b=PkxjSuMwBfWmRz+jbCxiKsnB4ccLWD9ZBiVaHPjNsrnMFgVpseg+2u7+
   SiQgFI4VFbwr8pLBbwkjk2cOW9TMU9dZlBPUa9HO5Gd55Sh7Q0d+7fjih
   OEVrTJas6VkKvEV1sICAH4zUq97wbhl0zUmANYYip8EJoNT8xyy80FvB4
   y0Hpp7ZAUxWqPSNZLhM/kBpWPaF2BP5zeoj18k5fi5KZD5gFlNPyUOZDH
   qboaVZkXUDeLHoCnq9ghY3J7TghDCRZXUeJZuIMKb8NqUcJbBGeh2ar1w
   Ot1NK2t3MLRxKrowv6vSn152jyMGIgGlJxuKmGQMY0xqQAQfcVMG5a2JE
   w==;
X-CSE-ConnectionGUID: Qgx+SGbPRTuzkYfJLDWp9A==
X-CSE-MsgGUID: ECjlqMu1SHmFAiY9LnnONQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1605780"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1605780"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 13:17:17 -0700
X-CSE-ConnectionGUID: lo8dlkFWTdioD/qd/zxOlw==
X-CSE-MsgGUID: iyHpbceWQ46Y0X9njCZutw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4427416"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 13:17:15 -0700
Date: Mon, 26 Oct 2026 22:17:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: prepare iio_format_value to handle
 higher-precision IIO_VAL_DECIMAL64_* formats
Message-ID: <at-1SGe6xnObPqPG@ashevche-desk.local>
References: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
 <SN1PR12MB2528906BE220765FAF201080A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB2528906BE220765FAF201080A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 11:51:11AM -0500, Victor Chernyakin wrote:
> Prepare iio_format_value for an upcoming patch that adds formats up
> to IIO_VAL_DECIMAL64_YOCTO (a scale of 24 digits) by avoiding
> computing 10^scale when doing so would overflow, and by avoiding
> undefined behavior due to abs(LLONG_MIN) (which couldn't happen
> previously).

...

> +#define GREATEST_POWER_OF_10_THAT_FITS_IN_S64 18

It's an interesting name for log10(2^63).

This, along with log10(2^64 - 1) should be added as definitions at least
IIO-wide. There is a series that wanted similar for u64.

-- 
With Best Regards,
Andy Shevchenko


