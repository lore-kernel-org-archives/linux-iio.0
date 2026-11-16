Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820060;
	b=YrNxXxfvo/vGXT2aAQHEmNfoWfhV3t/W/NfjjjweQu2fYzaXN1F+8i1IbykTcE/lceiB
	 qxNfLB0Q0auTuK2+bcx78vxq3OJ6B4+Na25c3/SQv6uRu2nmw/7GT3Cd7J8VTK04vKv+J
	 plUlTQSdAP+RRqky5CC6zW1zG0s2LDxaazy0lQBOzSnpPdFgMejraspqrX/LBRo3Qy4VP
	 NUGWSK3OVaDAmBdSfRdZoS2HL1NVBsHGzvyVz+jALfzTLiCaw1ICtDzIgjJUqYFvbf/Rh
	 lBpWMCs20Ikkdy6IytnTuQk+YqG1J+YhA3nJ7CYVKyCCiKbhRL0mArH6u/3+jM1cbMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820060;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=bxxtrS888PptJpyJPlJITnDDBu4Lq5Nie5KzZh67HvM=;
	b=sCtmitrwQ8viDCidjDKXSwP40/DtaBWjDdEwTr511822hiC4x6WDx0lHebr1RJtNncwy
	 EfnETewdnioNgtPtJdHs7hTGvLA3oMSYEDMkJGXNaGsRE2sFny7BOi68rVfMnZz+Pd5lC
	 KJ1e67/m0yMKlurMmAf4M7807p/T14TTlgL9/fTEL2zrxRd20V3nPjzRrzZb/eZ4lUBjC
	 vEHrulc4OSZB72JduY5Z6sHIpBl0VTj7/1yx4F4r8lfd1WiHIDTE3XVWli8hcjl6SzFKA
	 +EA8ZRJ3YSk0tHqzWrjrFYXW6zS2nHnavro9hyhY7fcEyRCG8A9akb0yvwMBHZgsoqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="awiqtq/f";
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634FB606A32C;
	Mon, 16 Nov 2026 09:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 634FB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=awiqtq/f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794820061; x=1826356061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qPtvvw1mEttrPy0hpnL5cWSqWPDd7vpg95dVq2Lpjv8=;
  b=awiqtq/fkOj2aON0BZnGsTlg5k+6APLUZLzSknIZwGAwRiEnQbYzhAUb
   5SHKVCEGbVM7o0VYFXcMm2VwXkfJx6SLOuIjsZ5PkEB7y6hATuV7uRpt2
   /V6OdZdUVpe/JHca8Yi+Z2cFsL6Sq3Usxj/PQOuz0s6C4fJ++WmBt7A3s
   0s01XBt4YmTmw5LNdEi7xEcHwXvfPFmtpiHSzrPNT7yUJzcIPeD88WCWU
   HTyut7bXsZDZK7Wy4d9pJCYvKGNqz5mH8Yk+iprTGDWEmcTfHFPXuIWoe
   AQwoaCvOlbajtEvizMXGI0U3Fjc/+Uw2lLPbYZMSv7Ef7ufiNLrd7PBG7
   A==;
X-CSE-ConnectionGUID: 51AIoBkkRsmGgnnBeLpS1g==
X-CSE-MsgGUID: Id/iPFFTRfKVe/iRbNcZOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3558425"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3558425"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:07:40 -0800
X-CSE-ConnectionGUID: VIddGgbJSOaSIdGqwOHo9A==
X-CSE-MsgGUID: ghIPgI/vRO29QAjJjhGFkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9387797"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:07:37 -0800
Date: Mon, 16 Nov 2026 11:07:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: chemical: sgp40: Replace manual locking with
 guard()
Message-ID: <avrH16ORPweOpbgP@ashevche-desk.local>
References: <20261102091258.247402-1-jmatko@utu.fi>
 <20261102091258.247402-3-jmatko@utu.fi>
 <20261102111020.00000194@gmail.com>
 <DMWI8DZPNBKM.2GHPISPEOA7G5@utu.fi>
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
In-Reply-To: <DMWI8DZPNBKM.2GHPISPEOA7G5@utu.fi>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 10:49:51AM +0200, Jaakko Koivisto wrote:
> On Mon Nov 2, 2026 at 12:10 PM EET, Joshua Crofts wrote:
> > On Mon, 2 Nov 2026 11:12:55 +0200
> > Jaakko Koivisto <jmatko@utu.fi> wrote:

...

> >>  	/* we calculate as a multiple of 16384 (2^14) */

And this comment should be placed not for guard()() obviously.

> >> -	mutex_lock(&data->lock);
> >> +	guard(mutex)(&data->lock);
> >
> > Blank lines around any guard() statement. You want to emphasize the fact
> > that guard is being utilized.
> 
> Should this be applied also for guard() inside switch-case -blocks?
> The extra blank lines makes them look strange.

In scoped cases the blank line is needed only after the guard()() assuming it's
the first operator after the scope is opened.

> >>  	x = ((int)resistance_raw - data->res_calibbias) * 106;
> >> -	mutex_unlock(&data->lock);

-- 
With Best Regards,
Andy Shevchenko


