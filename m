Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42721498902;
	Fri,  2 Oct 2026 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947769; cv=none; b=ej9kyot0cz77utm1WfV9YqPtSjRRRXadJQ3YK1IztovtD6T7Dz3Dku+BQZ9oWV5d4AewnVlep3grDjICSQCGx5tznp2xeD5DuyPr2AX3P8dXb76KS0N9tb0FCsTURAcC7JsVHtDpfEtYfIN1Z4LyJtk5p7TMXj225C0EeinIC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947769; c=relaxed/simple;
	bh=kHNsvVqEx2jW/aJflmxgapTHJs1Kj6u3cp2fM/g+4vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kou5eRF4YSv1cm6dGYKf4R8qPO4SY+oquKfHknV9HtvwQV+Se8f6/cPc2yBpgcO/zCRs/Wfvpd5A6aOylicct/w1XVpU0/vARAqCXcF3qHV+5HzpkDVZ4OcHNL70vkry9MarZZh5Z6BlYbPWx1+kAOfvzS8ul73OwwEgORzXExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGGBOJFH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGGBOJFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790947768; x=1822483768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kHNsvVqEx2jW/aJflmxgapTHJs1Kj6u3cp2fM/g+4vI=;
  b=RGGBOJFHW8pQUyN2+SEfnAABiGtkzr8FFDBn22F9ZRRLTFo/L1luwEEI
   dhgpMo6L5Zp3yZED5LLBNZ4ilj32TXSKv/ipPQAWrAzCuASrEWJS+hiAl
   CNZ0T/Sfw0f6DgYLJoV4ezQm1lbQs9POKYEuTDfatstbQmZU94U9oSzli
   ZUxhTQ2U9Ks5Ys9CYxjW0dfOxBMjmFLD0KzbFfvSXxysUaP7gttmuZzQF
   Hm1PHUOemViS0rBO5iKbHpGhVRb3xBNRD0eFH+jH8U4y/VpWERcMd9ogr
   DUWdRBrYs7TMKLkujvDOo1BUftvgxzeX0+MaYczIQKYnmEaIfU8LEN4H0
   w==;
X-CSE-ConnectionGUID: phg0XlD+Qxmqw3IgW6KzzA==
X-CSE-MsgGUID: VGtV8Z7RTQ+lJB7FlNIoYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="103084818"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="103084818"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:29:27 -0700
X-CSE-ConnectionGUID: 5VAI8fTjQfauH5oTTRpunw==
X-CSE-MsgGUID: B7zUVA74TgS5TzSB2GA2wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="274053708"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:29:25 -0700
Date: Fri, 2 Oct 2026 16:29:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Liviu Stan <liviu.stan@analog.com>, Arnd Bergmann <arnd@arndb.de>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>, Shi Hao <i.shihao.999@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: ltc2983: avoid -Wstring-compare warning
Message-ID: <ar-xsv05s-D6a7Ri@ashevche-desk.local>
References: <20261002124902.3703019-1-arnd@kernel.org>
 <20261002150425.0000286a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002150425.0000286a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 03:04:25PM +0200, Joshua Crofts wrote:
> On Fri,  2 Oct 2026 14:48:51 +0200
> Arnd Bergmann <arnd@kernel.org> wrote:

...

> Makes sense.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

There is an ongoing discussion about this
https://lore.kernel.org/linux-iio/20260929-iio-ltc2983-fix-string-compare-v1-1-d67d612d6ddd@gmail.com/

-- 
With Best Regards,
Andy Shevchenko


