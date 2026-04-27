Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD536998C;
	Mon, 27 Apr 2026 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299566; cv=none; b=TL5WZNkk+w1KVcxMipHCQX1xRe4laDriZyEnhBbd7Xiraevl2G88qbR9DKXbyf8d0eZR0f1A3fxoKF10Ay+O/GSQmUFJJNKwOar4Gq1Nzdj40KiO4K/UNNoyq9mK/NLrhVpxxKoVeENqKT6Oer78mMRU0kV/+x2M2qfgr7eTpxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299566; c=relaxed/simple;
	bh=Zys1ExBQTwA98a4ZfwVfqsjhHuJ5NFVa6xCet15TvrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvRL3YBZB3O+6N5Z1ISgTd14nLvPdIGsI0s0sm/f/XuDhQAt5MKvrvUaXSC1q4bs6F1ABKRoGdX8t1T2O5PqjI8Y4eLfTMINMg1Z7VqFayYKt7MgrKb+VncsAwLM1BwiNZCiWpmrxD7pbsn7rC7jrI2BDSDVbrkwkssMSzWYz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mll/l2FI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mll/l2FI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777299565; x=1808835565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zys1ExBQTwA98a4ZfwVfqsjhHuJ5NFVa6xCet15TvrE=;
  b=Mll/l2FIBkuTb9dPQfmDjdcVJVLNd9taacnPDzbY1OORUXXg8ulzkHum
   S1i4oPE9r1uaWei6XFsDqAA52rtKElhO9TDhNrnJwk7oL++eSfLMghUHu
   lGp9WMtFfwGBEEE4+YPo3JCWcwMXOWF4rG1BPJGDET8xqL3tnaNZ7neZi
   UOatREl3O9E/nkvl8xjCiwtmqxMnBYZyqi4D19meClFEXDfL250tvBnX+
   Hs+ZDXy835N8A5q9Q62AKfNQPYrFiP8C6xchQtpLyG05QsERVJshiHIOY
   nz/XLxjBBwlspm6eRjq/jvMjLDogkmPKVwrFFkPUr8SRTgrGiK6fjGuJ1
   Q==;
X-CSE-ConnectionGUID: hNHHGRxwRCenuEXy/xN98g==
X-CSE-MsgGUID: ql6Gi4r+RyOpxwmybrntfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="103648812"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="103648812"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:19:25 -0700
X-CSE-ConnectionGUID: tG+yVrhsS8ey4M2J/EpbVA==
X-CSE-MsgGUID: dt3M7YoOTgah1rqDh82KqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="237612522"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:19:22 -0700
Date: Mon, 27 Apr 2026 17:19:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iio: adc: hx711: update Kconfig, module
 description and file header
Message-ID: <ae9wZ1LMw7gq_Pyn@ashevche-desk.local>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-4-piyushpatle228@gmail.com>
 <ae9rayYbr1UbYIQD@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae9rayYbr1UbYIQD@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 04:58:03PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 27, 2026 at 03:39:34PM +0530, Piyush Patle wrote:
> > Update the Kconfig entry to "AVIA HX711 and compatible ADCs" and list
> > supported chips one per line to make it easy to extend when new variants
> > are added. Change the module description and file header to match.
> > 
> > Add direct includes for linux/array_size.h and linux/types.h rather than
> > relying on transitive includes pulled in by other headers.
> 
> Obviously something went wrong. First of all, I have told that MODULE_*()
> changes doesn't belong to the refactoring patch. Second, I meant that the
> Kconfig help text to go to a separate patch.
> 
> Header inclusions should be taken care when it's required. It doesn't belong
> here.
> 
> Looking at this again, most of it probably should be folded into the new HW
> support patch where you add a new chip_info.

I checked again after browsing through the whole series. This patch basically
should be either folded to the patch 7, or immediately prepend that (without
being any between them).

- Kconfig + MODULE_*() + respective comments update
  // no patches in between!
- new HW support

-- 
With Best Regards,
Andy Shevchenko


