Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E93126B2;
	Thu, 16 Apr 2026 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776328487; cv=none; b=S0/uKBNJ+bFbVn2jh6IhKXc1lPgl/OerErRxhf9JZmkPobPYzQ7UX9LvKrn9sbGeIqv1Qpap2bNt8ekoX4j1XZpKNHLdzIKd6AcIViLUc3OLlEa6pFzQW6dE64BOL0N6zufwjFhMiE1gK9+70KlE/sHu1eEzYn/TGHu1iOYTV8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776328487; c=relaxed/simple;
	bh=ojrqEbi5UsLeGgCE12uyFptHGdrFvG4pdL8Y1JJaA5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjepLwqtD/SvXP8w/hXxTt1l2/GulYSxx2h6h7NDfLYgfTklXPw0uf0h9EJ2pa/V+USbd6KEc5eKQxeXWkG5Yj/OA+eg1TxJpbxMPselhZqRx4CP7eVE/IZGlKHiJaaqgE+kNByl5uzXYAqycdQ9h4jejcIWCeHMPZKoedqRSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZaIwi0x7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZaIwi0x7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776328486; x=1807864486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ojrqEbi5UsLeGgCE12uyFptHGdrFvG4pdL8Y1JJaA5M=;
  b=ZaIwi0x73VhCgGTXALuApYGJda6DIZiKiDQe7FpC9sEU/QFf+4bPP50U
   /o844RgdyYdD8C0WfjE3dR/pV3aibik+RY4k10nZnZdGia0lhoj/Q0ik8
   wFpGrGtMTCigXliRhuGITAWOB5YmQvf+9sAiE3047PHmpWsBantST1fJ9
   IZ3TosYtdPb4+uHgBUHa+Ict1YNibkkJ4VWh+6odFXovXg7kBmbrJtwhw
   vZp/yzXSVBRPQMdplBWtD18Xo13MnKCea6AJ4azA4fw1q1kkt8cEcm1Bf
   zA8ogxHD9+MK3QO8bcpMUL1P/MwINe24+dH1SoQZfn/42GBd6V1QQYzEN
   g==;
X-CSE-ConnectionGUID: WQrqIZJWRUKo9td6AlYlDQ==
X-CSE-MsgGUID: OIqyX9YWR0GaeATvwXypEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="81202905"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="81202905"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:34:45 -0700
X-CSE-ConnectionGUID: CZwfF5zYQpmUB3mVtEApzQ==
X-CSE-MsgGUID: a9K9YDzhQ4OtgTv4TLjoaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="225951802"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.173])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:34:42 -0700
Date: Thu, 16 Apr 2026 11:34:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: frequency: ad9832: simplify bitwise math
Message-ID: <aeCfICB1SEMQvSBJ@ashevche-desk.local>
References: <20260416065118.1299-1-joshua.crofts1@gmail.com>
 <20260416065118.1299-3-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416065118.1299-3-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 16, 2026 at 06:51:18AM +0000, Joshua Crofts wrote:
> Refactor the ad9832_calc_freqreg by adding a BIT_ULL()
> macro instead of manual bit shifting for better
> readability.

Code is okay, just make lines wider in the commit message (~72 characters).

-- 
With Best Regards,
Andy Shevchenko


