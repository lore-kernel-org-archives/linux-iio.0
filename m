Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008201;
	b=vESRWF27OvL8Te5nejjPKYZJiFtl14+b6UHx1UALKdheLi4GjZxOSVtSHAbUZFfb3A4r
	 q+MPMi8A+BaQs014cjRdO/t3BwV/tYFxVQrihOcR7tT7eYePKEaCeKuvdbBtWTJN8DaII
	 WstsuGPihgEUENw4CVWRxGpgOqZzx5sBc+eia3NTWEulHNu6DE/4sXVjYu2J9IT++RfIc
	 S8HY70z0RcCc/RZTl1ozpBMsxsucAe2m/d43Ji1QvCeRCI2hQzV11LrlaCzB1rONOD7oj
	 5oA1qB/ZGFKChvfmWHz+fgJ4IiFjfPgAzpuufhU/0W37DB6OF6uvh8Cc37Df4YG/wHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008201;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Q9f2uGWeWP2/426R1+gQS6saQbeRCspCMELW+WPFZWA=;
	b=BIGiyjBLAUrjhFrKjZC0c3RMqGe1Xjhq5BjmrwBGuCk7BxY5ofi6myYSdb7+b2ksXBSY
	 022N6NVrXk2Hce2ptLyI8wxlOvP8B44cBYeW1Ipofeowdszjf/6qlNALm6rO877LoBKU1
	 wGvb5wn3LspTWnmk2xQv53sFQA2DZXbq9l5IiHiTD/hoEwww6/et1V1SrsCQlRGf/AkIn
	 av52L1/rwEpkMjRYRM4ltwPtFEv444pIpOStLPiArDAT1UD1Muv0NPL/6spZbja5GiNsP
	 NyFIHZowxlWRD2UWlByJCUhSAy6gObyVVXv0x8ZUKHPtxn8EEpIwbA2XAzhtgNGhQ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bKItXg7O;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853C606A323;
	Mon, 26 Oct 2026 09:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E853C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bKItXg7O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793008200; x=1824544200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0CPUBaoIM/gu62Y/pBUcQ6kvFd6fpUVAmPDb4OpbuQ8=;
  b=bKItXg7OD5KzLKtGRSIH1Eg4usyWsqk35woOMgeX3KNudoOywyjIaInP
   KGOmrKFNPxaFaSN2txwYptOrQHgxzaQy/rML3l8/bz5qNUKwkEA27aSI5
   NUh0ZN0wrIhNylT0/bGoDhxY12n6YPdiZsvEPLAOAqFdwckVXpuE0Ms4e
   sXNR9jpOq0RJl/lF44MfEfJShSANSKaxKi47yV6h+4/4mMbry5N4UFt64
   Kjssc2SEcoM2E1BnMrAdS0vwUMg37K4znT+FkU9elZk/zES1Yye2JWvZ6
   DRdTELN7inYxIk4WCcDhJ+dzeGmoktA+p2Q7cuvsr5w3aeC5B7jne14Ah
   g==;
X-CSE-ConnectionGUID: WfArfJQFRJuEWnAttmtOsg==
X-CSE-MsgGUID: uqM2JVCUSpul1zop77aNmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1570726"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1570726"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:50:00 -0700
X-CSE-ConnectionGUID: 0syt+QF6SOujdi1UOBKF6g==
X-CSE-MsgGUID: QE/bqolnQ8exEHLapGXJsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4569812"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:49:57 -0700
Date: Mon, 26 Oct 2026 11:49:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nithishvelan M <mnithishvelan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: impedance-analyzer: ad5933: use
 guard(mutex) in ad5933_show()
Message-ID: <at8iQhUDfDpkRxI6@ashevche-desk.local>
References: <20261026082828.652-1-mnithishvelan@gmail.com>
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
In-Reply-To: <20261026082828.652-1-mnithishvelan@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 08:28:28AM +0000, Nithishvelan M wrote:
> Use guard(mutex) to automatically manage the state lock in
> ad5933_show(). This simplifies the function by allowing direct returns
> from each switch case, eliminating the mutable return variables and
> manual mutex_unlock() calls.

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


