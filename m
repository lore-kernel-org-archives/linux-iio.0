Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793875002;
	b=nuKMenJDS2I16hlnatqYwwB+LPue8xmKs5xYcQGpxtPUMTLMac61vfIjCKPyQ+5qpvz2
	 Tc++7R9N/i4rqtvsIMvB4sCchAVouz/skSAJT6vl2iKQgk4RzpxgoGf+D3q0hE/c4661V
	 WBjWxf0jPUSLsXk7ZqYTOUY/TQ50uETND8/LrbqHyVhOksh9ncvM1jr2M7/ccIjBuJK2q
	 KcVLOxtPoaHmk4g3r4TVBGM4OMsMSmLA3dRqTjLKxpCOHsFb/YHJY10KvdIt2Wh7bZ60x
	 8748eZDi+f+rNxpHuR7HEZ32UiOS0+gZSwURAmmKVG2K1Bw6gsO4lw9848jjc3CgCmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793875002;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=FFHUJ078aO9ZHzjnI3Ociyv8tx+IEg1uoiExptvwZUc=;
	b=m4ron0lCm0Sz4K5RPwXGvCPpaS5JvsqlMoCWAGELMFcAuIh2X27Jz59qBEJ7aaNvgUjj
	 IozsvPz7HIVBPWAt26QT3dnorIjL5JKG+QAdiuibYP5p1n//XqwLnDWsHbMp39cmUjPoE
	 fpENcX5ddxBU62WhQV6qpr8dq/9A3YbLn50eP/tztKUoGh30T24xScNhyPlUez7NCsrac
	 Wmv/zbT9KBbCePeRwsMdp6TwkP6UGKpXHXv/YQmO22+3p+GVhWzQwG91TKDgfuwl4X9aW
	 JpNB9oWKhqeVn/oJrz1qKST7Xj3cdXJ9gunl1DSBQ/VT3tss/SvS2M8JjIAp/S+7LxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="SYTw7o/6";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1841606A326;
	Thu,  5 Nov 2026 10:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1841606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SYTw7o/6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793875001; x=1825411001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J3PoczxBPQlWpy2dNqvW5nlKbIbtlLkL24BkPwn98KU=;
  b=SYTw7o/6NHqVKv+0T5QavfhkZ2P2eRIUYiSJON8TBGb5YIxegy1L26A2
   SBjNO8nuvGBCQmy+yxkwxWBMQdYD4YkhShM3quEsVU05uFMBCG56+wGSE
   m4kORYzWm7fqQ0bd4qN6X6nSKJ18koyR3CULKmtbfPQrSq8Dc6I2fLGGe
   I6HpGBXiLGBgUtRmvmAYi7mwsfoSJz8ddlHZ0P1WP3n3hDLIZyrIZb8Ul
   HJ+y7lkJdQIIMlXRkKiBK+vlSjYWDC1iWxLJ6/dvWAoSc3JdI6m6wGbL7
   4iE4/vQDwhcABndvByfkWzfIgT+4QULfgrG+9wZQIq5waZqiI5igryFEu
   g==;
X-CSE-ConnectionGUID: skvof/PuT2CWnJWK14uKpQ==
X-CSE-MsgGUID: A6WL55DFQD2JiwWkFy/TZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2534910"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2534910"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 02:36:40 -0800
X-CSE-ConnectionGUID: PgAj2Vu0S/ywjNdHkDbxyQ==
X-CSE-MsgGUID: opBPGcgTTi290Z3DQC5HnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6827487"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 02:36:38 -0800
Date: Thu, 5 Nov 2026 12:36:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] iio: accel: msa311: use regmap_reg_field_*
 functions
Message-ID: <auxcM5rKxI0Aigs1@ashevche-desk.local>
References: <SN1PR12MB2528754CEF9D8E5103ECAE28A5772@SN1PR12MB2528.namprd12.prod.outlook.com>
 <SN1PR12MB25282EC93A27F3577BB9B454A5772@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB25282EC93A27F3577BB9B454A5772@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 06:09:50PM -0600, Victor Chernyakin wrote:
> Simplify the driver by using the new regmap_reg_field_* functions.
> regmap_reg_field_FOO is equivalent to regmap_field_FOO, but takes
> a reg_field directly instead of a regmap_field.

I have just proposed REG_FIELD_GENMASK() macro, this change may rely on it
20261105103533.1426533-1-andriy.shevchenko@linux.intel.com if it comes through.

-- 
With Best Regards,
Andy Shevchenko


