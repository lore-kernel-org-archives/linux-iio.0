Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254667;
	b=42mpInVGN3BuNoB8fDbzkMteYSy8auuCoubU13r4C/veAbAmEVNpn6Eb42d0bv3CDdxc
	 Na5BP2ngzNHwg6V0yHRm+np25/xowMNs7V5k3U37LgwRnAxBokQlFDiwxy0fXRUi4JyUB
	 2/QZyEr6tgXjs/r95nnjNd+iJbrJeEv7i7ddqV94wUsYr7K6V8uaqKhims+afohKtF+ef
	 fd2g5eypXzlwnfYB47dmWpw0K47OlbqG/AEWDqMLfqtuABi3u71Os0hY24LosepK4LBvQ
	 LX031Weh99BzZtv4Y7OcvSW/jmasHeNDNGlkHIpICxPxdWY7KU7vZMsu2g9J3Y70c/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254667;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Vc+dZRhEnWsVxPlrVW5h2JVBBuMyg6wqhQAZPv+Cc00=;
	b=cK+K3BZPBzxWZbkS3mtbr8NYGMvr9VWjrctT8jjHQWqFQkvIdG56gwQIU5f3B2pyo8hI
	 m6/yLbNhNUL/qraubIE8naUkqZxYxc/d5hL/IwdfglhHHwgg5+R3l32A4RgwIE71UbuNy
	 BMF4jPqJza5/Lo82e45HtewYr6Q5qVbasED7J8brTZVBT13MxnLIM+0x+m4q3WgBLgRMQ
	 A91GwEa7/7c2hrY36OZUn5b2YbU+iH9TN0uqZY2Jh9U/4+93uS0W7KOEg/OkWEnZ1lQ6F
	 gKoeEJ4p/J6KXEWLZOF9yBk2YZUZ3w8BfKg0iygaoz4CZIRM6kmXX3kYHy7W+1RlxOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lccmq6Mv;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93745606A325;
	Mon,  9 Nov 2026 20:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93745606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lccmq6Mv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794254666; x=1825790666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g4Nda6C5LTbhP3/hHBb5kb6b+JW0Lu9VYvlI8h5XX1o=;
  b=Lccmq6Mv3nNnNIqTVVfG/ygjEnUKoW/2+UHW/YL+ZPSoEnv5AYcKBV17
   f3hRkg6gXySwTByZjlqFT1yj0c+zJdMydR1LOZ68U79Q6DMKnFDXXj3rC
   3+8TiykYS1ja+lgx37X1o7yd5sdf8IRk8gfYDDlUAdsK5Iq0BkkoI4kv+
   2UVTLEYZNghJJoOzWSqPo7fnYGFIcPqnHDicNfKAeKjJzsNn9b30tsCuX
   qMKmxMK+iG+ynjvVrCkRTEm63a+09cfYMwU9TJ3i8AlcpD9GGEJtMhJ3U
   I3H72KAO0JC3zjVohxCchi3TozVz4aTmXIgCvdaCNoKkJSeEvdK9sPjKn
   Q==;
X-CSE-ConnectionGUID: vbvmcA4jR0yxVFOPtOORqQ==
X-CSE-MsgGUID: PbcrAaDRQuCD9iIt8OzeOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3028594"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3028594"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 12:04:26 -0800
X-CSE-ConnectionGUID: mK6i+P+TRwGQxeuUhAfjyQ==
X-CSE-MsgGUID: FaCxj2x2RbiWni+54uojhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9814465"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 12:04:21 -0800
Date: Mon, 9 Nov 2026 22:04:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: light: ltr501: Add support for the
 LTR-659PS-01 proximity sensor
Message-ID: <avInQ08dVrsc-Rbo@ashevche-desk.local>
References: <20261108094253.83899-5-clamor95@gmail.com>
 <202611090518.mm6yt2nO-lkp@intel.com>
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
In-Reply-To: <202611090518.mm6yt2nO-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 05:48:09AM +0800, kernel test robot wrote:
> 
> kernel test robot noticed the following build errors:

...

> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> WARNING: modpost: vmlinux: section mismatch in reference: trace_initcall_level+0x28 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
> WARNING: modpost: vmlinux: section mismatch in reference: __arch_xprod_64+0xac (section: .text.unlikely) -> initcall_level_names (section: .init.data)
> >> ERROR: modpost: drivers/iio/light/ltr501.ko: symbol 'iio_find_channel_from_si' undefined!

Forgot to import namespace?

-- 
With Best Regards,
Andy Shevchenko


