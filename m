Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174527;
	b=OIda35IoyfBZDaUIKFgphiHOM+xWWzfs7F8vqfWVlT2NpqM94NCBQtwDqxdTU1GrqhBe
	 X3MAnLL6ODb1pUwL00rGFDZLNuzE5/k+cY+I9K4YFmZkVBq3SkKUF/IoAaJb7RIPbEjfx
	 PwLT1G4/m3J090dtNnGuzRt/3wmKwnOvDjBoUl8RCr4TuTYDHy8VoMLG5w2NsZuN8UWxQ
	 c6MJEel4d+laG1zKgJFcclrte1FcrSdjvSZffKFDTBwcZHxNZd/QpoWY7Qgy1jXSUyb8D
	 6ciCUc6VDZhtWcvqldWags5PhaRv507g8oT3Sxb3BZKbPVW9W7wbihZxiUooShcXwFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174527;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=d+hgfVdursC5BkNN1WVdsSZpLzmJ5l76P4zcjf+x04M=;
	b=t2p72V0Doxye3TjJksrjF1kp6kiVbkAd64AQAOKnIT5zBm/OgbYIQxdiU2wh8MI90OGT
	 RzdlH5Gau/2DP0SJFG7M0vochljlVBU6iPQUSYO/egczUtc10zAaRP6gklr5vD/mIE/1g
	 AjNo6m5wjm3C+NrCeuk3TcRorwB99eSlm4G/sEpFuKlp71An6ok13KpQ1eQHX8J5b1pEs
	 rpzbwNo+omSlSRoEqXjjkkRvc7QOOxqu61sSdpMavpLoHlIZ9VYLa4fPSvzP8PAF37fpk
	 KxOUlUNwcqDyyIt7uIm3I/Kyia7YwViy6diPpPB8Uv4XzyzivC3M32HJ+OTc3Zj76sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N0v6B1X9;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A15606A332;
	Sun,  8 Nov 2026 21:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3A15606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N0v6B1X9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794174525; x=1825710525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lyC/gc2As/slOIQA1S8PUGv8GKu8g5O/yBmvasqYDQs=;
  b=N0v6B1X9zoHZ73972uO4exYw0EJTdWhJlqfA6ezO/HYwV83GGWoigY+H
   /kJIW0cwvUA1j5RnqAzxEo9/hhYCkQPbVmS9ebMeaFO9OrZDJxsYvN2As
   ftKK9uH1BYIsgJ7wenrbpXkhKTsVmUUYJfI0l3+75+tTnQylzH+QmKfEk
   K0XE3/cMA6/WfZbLw6AR8QP/M4FUyJrQva69bp2LFWzX86pZYYLy6/6Jk
   CyQ7FM+dg7EsGI1sdEqV7sta9JuT/CKn6MiML49+cr5ivPOM9L/A6oTli
   8ez1A+WvW+u1Y0cYjHJMbO3XRw30Pt9iPzPq714Snu4ICMFWALDDyb0YU
   g==;
X-CSE-ConnectionGUID: L5RqnJglQjSkWexB0U4pSw==
X-CSE-MsgGUID: A5bORk13TkWiBhr8JFlZWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2803098"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2803098"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 13:48:45 -0800
X-CSE-ConnectionGUID: gCsiQnFUR5yxqBbKMgnRAw==
X-CSE-MsgGUID: xTO+LEHbT3Cze3JGHLwMMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="7727084"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 Nov 2026 13:48:41 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQAkf-00000000tRx-21Y3;
	Sun, 08 Nov 2026 21:48:37 +0000
Date: Mon, 9 Nov 2026 05:48:09 +0800
From: kernel test robot <lkp@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
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
	Nikita Travkin <nikita@trvn.ru>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: light: ltr501: Add support for the
 LTR-659PS-01 proximity sensor
Message-ID: <202611090518.mm6yt2nO-lkp@intel.com>
References: <20261108094253.83899-5-clamor95@gmail.com>
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
In-Reply-To: <20261108094253.83899-5-clamor95@gmail.com>

Hi Svyatoslav,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v7.4-rc1]
[cannot apply to jic23-iio/togreg next-20261105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/iio-light-ltr501-Switch-to-read_avail-op-from-manual-attribute-registration/20261108-114250
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20261108094253.83899-5-clamor95%40gmail.com
patch subject: [PATCH v3 4/4] iio: light: ltr501: Add support for the LTR-659PS-01 proximity sensor
config: xtensa-randconfig-1000-20261108 (https://download.01.org/0day-ci/archive/20261109/202611090518.mm6yt2nO-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261109/202611090518.mm6yt2nO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611090518.mm6yt2nO-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: trace_initcall_level+0x28 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: __arch_xprod_64+0xac (section: .text.unlikely) -> initcall_level_names (section: .init.data)
>> ERROR: modpost: drivers/iio/light/ltr501.ko: symbol 'iio_find_channel_from_si' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
