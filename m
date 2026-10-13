Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151994A9D44
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926468; cv=none; b=E3W0GWq5o3xzoDT0rY8m85TbxAilcjcyXRVQAYKVGNqjieQOSA23xfUgyO3aXUYkPOVRG/XHRtbAX5s4PN5u35GbzbqmM9Vm/A18NkVQNtfK+fNU9dW2pNb1G8aaRzJS9uQO9gPJBWhQWyaLKNxfmxpbA7SlLJY92XWNTjWGFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926468; c=relaxed/simple;
	bh=rr/+hvnllnga5swJBMnJ9gzg5tizxu+S8zTcd61lqBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3JwJ1BLaNCtPl3L4n4cr9XPIn5bC4LiOq+tLD3qab6Hg+wKB3CnpiKOUSC0RlBcP0BJi+PXNqtqMiKtIfRSOb1w5AyHljt/RZZ69LGHRtaPAOm3thyRiN+EBLvZ71d4Tr/gq+6TPnlrkGg6k1ymCCMPqauLHa22uWE21FU8S2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7YNClul; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7YNClul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791926466; x=1823462466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rr/+hvnllnga5swJBMnJ9gzg5tizxu+S8zTcd61lqBI=;
  b=V7YNClulMsP8Hmj50p0rLymwxMc/ylMWGjLf5nDRxL7PE4i+JA4UnOjn
   8yRLgknct4zigzXP+enPCFZIpCC7EtH0DuNCcs2/wGM3aanJtOK8ggCnA
   CUlIoB+DGT1XJ7IQle29E1W5PNXQgnQODAk2Cr/iyiAiajCTlVvP38lTg
   lyOhek/6uWcfFwQwgmCA9ktbjU+GNXFNp5ToLXm3maRzMkP3iW679qh9M
   maK8YK7i5VS9STTwjZIfr4ps+V81fTiaMTuYpJ8mHoAFEa2TiaO0hlv4y
   Y2qj/JAz0CYdi7U8Ru6eNfCdh0VdQa04ycsqa/1yLpyytPLzmWm2ipYd5
   w==;
X-CSE-ConnectionGUID: a2aau/XkTJyxTtZpjtbZPg==
X-CSE-MsgGUID: XRHoLclSQ8qnkpxb85Z8EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="564305"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="564305"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:21:06 -0700
X-CSE-ConnectionGUID: PASbLdlQSc2tNCprwr5ffQ==
X-CSE-MsgGUID: hi5XT3rMTyCkcBWZMdhhEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1722531"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:21:03 -0700
Date: Wed, 14 Oct 2026 00:21:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zixin Wang <ywp1023456@foxmail.com>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v3] iio: light: cm32181: add support for the CM32183
Message-ID: <as6gvHhkgiudzDz4@ashevche-desk.local>
References: <tencent_850445458D21608E9C8821E6728457F31C0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_850445458D21608E9C8821E6728457F31C0A@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 11:07:30PM +0800, Zixin Wang wrote:
> From: Zixin Wang <ywp1023456@foxmail.com>
> Date: Sun, 11 Oct 2026 08:29:13 +0000
> Subject: [PATCH v3] iio: light: cm32181: add support for the CM32183
> 
> Add the device ID for the CM32183. The device has the same register
> layout as the CM32181. Found on the H3C MegaBook 14.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

However I dunno if the above email tags will be handled correctly by the tools
(usually we don't have double Date and Subject email headers).

-- 
With Best Regards,
Andy Shevchenko


