Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508777;
	b=bJvbz47/JF7CtNbD7RWwgnbKJKDjsQN9EtRFIZPsrFnINMfc0gmVPb46LmMb+uxVLaf6
	 Zl1yrF58uLVKIV0Szv4UDb6uC8KnEST+dFCyUfNcvAyQsLqVDhlgCK+VMFCLfFVc9AhnO
	 l2TmR9+1LaRewVGw0TtGBrz/TngdQfclaq3c0k5Wgf7AEck92rHr5VQDD61tsZ5yGWm56
	 F99gPbfwDHqpIxhycEqm/UMD+HzSNpMRaUFKcmbxL/CLPV2GvmSOtmKekQi5cxEPKs/wQ
	 Al9UGxRWziaUzCWNmEkhFQgSy6UafwyNIIiUxD2tMDRtfykQbj3dnu3b5ibAK4beC4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508777;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=KsO2AJlVyuTp9xr1EiYJZ663XVDpxa+BNdu+wlV46l0=;
	b=y5mWcN413vvBok0PQDqgnXOCzphK4C0lNn9PUCzk3w+/j5NWqIa0cQwyI6dTT//NbCAr
	 x/v+Qg08Mj8Nz4eZqyX9h0Xn0EPfDX8BuGNMwyMIdxuz8vmUdW03eIxxSa6jdCunGqEBF
	 JaKuowd9V92rfj59lWxcfZ1UlgD+YmGis7l0XhrYy+6yQAXNZ41t0iNKhRN+P2KniEUbw
	 aWkSt6noARMM10lT2V/wO2S5pjsRc10MTfqB81vcJioX7y6KaZB/0bPWhZ17+cE48YjtH
	 IWS4iJALKPm0Z8RC1hSSmtAxsdNL3isWQ7z5pEJxNb2Nhf8qsLCuHHMEaYof70w2xvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sldjx5Z0;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D4606A31E;
	Tue, 24 Nov 2026 08:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F0D4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sldjx5Z0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795508778; x=1827044778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iuSZMy+UdIgP5wUvX05xZu6HFUhgPdhYD7kCzj+Ee9w=;
  b=Sldjx5Z0L+LrI9ALfXyXdPOLHjtjSP1W6Fe533pbcJEhSGqOaxKMv1ZI
   cz/Ife6uY4KYb6bCC/jxHI4BD2NdUhnAnIi74P4M1Li1Oz38ofTbqm71q
   vHX/pkbtMZpVmtTG/dbXisev59sz1sT2nUIAmX3Subvhs+MeF7w6RqXgF
   kJZ7Oq2xPb8Rv08W8fnE1jB7qyEi9MR0RbNpYKAYJOKyaQQZo4tH9PztE
   wf8m0OrhwOuGZHhS49AYTaIjpPm0yrmH599X2oJRUx1g21lB7UYNpiUfC
   MQNld6IVhCBdptxAcs9SulKk+PngDahz1zzWuXWXvs4TkG7sPiCf7BHFJ
   w==;
X-CSE-ConnectionGUID: F0JP0PPRQHiYIOA9Mah+Lg==
X-CSE-MsgGUID: L625aupUTS2GjZNInadUMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4190529"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4190529"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:26:17 -0800
X-CSE-ConnectionGUID: 42+ni5HER4KH2tpo5jCuNg==
X-CSE-MsgGUID: K2gEYeSjTemEa9TwVxvTmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11628913"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:26:15 -0800
Date: Tue, 24 Nov 2026 10:26:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] iio: pressure: dps310: use KILO for the Pa to kPa
 conversion
Message-ID: <awVKJPKX5ssiBi6H@ashevche-desk.local>
References: <20261123220649.36887-1-zoone.rupert@gmail.com>
 <20261123220649.36887-5-zoone.rupert@gmail.com>
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
In-Reply-To: <20261123220649.36887-5-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 12:06:46AM +0200, Rupesh Majhi wrote:
> Spell the Pa to kPa divisor as KILO from units.h, in both places.

Yes, looks good.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


