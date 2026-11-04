Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790167;
	b=nKH6HK8hAdZASbNVFN+XU2F6eI1SR0Ns/wofowwVWtk2gb8T8cDct1qz0KqBoCXMFHTD
	 v0d8S5vNzcxFpdDQlhcsdNkCvAKqfG95ewSyFknJd8X3ApXR9jFElOaKFP2x7usKFaVvJ
	 28rVPx6PX8vdVShaaa7tS1Xbu12vyxZcRMFhJIiBa4oE1Qm2LG/ni/Lqd4pwElxbbxea3
	 lq05ZCHkMKmOQnn6O0Ou0stEfwKxzFRWDqELoVFFAynHZLIfG28KbQlxRtHJHzIS4vAFt
	 O9x3gkG4hlTwnEID5MAda5K2imoPQsTwvKuD5twC6W6zxN4mokyca7/4j/zt74lmG2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790167;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=9cD4qfoU6LBVHg/5S3qTn5JTNL40hzZ6wdajULDlQjw=;
	b=W26bQPdS088DJxa6SF0emANCaRfakautl/y1b/xElrLRY7qO3GwEgcYp//ft9oaRyE9M
	 D6fyAcUh+mjvcYwX4Nkjq2f2JK/hlPLCnJwveaVzJ+b+yY9f1msw8RPd4IzTQjpfRijU2
	 B1j3UdL2CsQZepKa6lxOfFTeC8zqSNEaSGNvJ7k2oPFpz7kDHTdRsC2WzbcU1Rx176TcP
	 eFu7Onp3FmtbYofjYIu0z9W3MTlUhb6mujTwnIbEK4NOIIuM5xzwfN4PubntIxO7bWPSV
	 bH3GY89L3JSUZF4xigoKj3XKPL+ms6A5bST+kKDFn1O7bCXCZfiwNgziWniSGQ0FIOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z96l4DJd;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006F0606A326;
	Wed,  4 Nov 2026 11:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 006F0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z96l4DJd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793790166; x=1825326166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Du1tcg+nphT81iRUW/plUJruUtzirvkFSCKp+3aelt0=;
  b=Z96l4DJdmgscCCcNRsCgQ4bf4tn6UwLCmIajb4E2Ov5iUNkewrk3sKNM
   xxdTGVLkDcnRzMM6YyGAJLJNEpySrz+8aJmPVK04AVd53gWTa0aucFPCo
   5jtxe/4KdyU3uvKnnVq9rqHX3kG+cRcm8l3isvTDVgU8KvegeFXQf3GtK
   6jUkIdrh8GvEkmzJZCSoaiCE2BoR9VcvfMQOqtw5+mqFgNxAaEBPS1k4g
   o8szwsXlxz0UoI+oCETAgSbdjw5UFE1FjNqKXaRarQKH+Wzpt4uCtrVGW
   uqE2FwrPfJ1VhXLwwL0E0s1AbVmGHNYonxNoiQD4HiMP69QJh99HXKf8h
   Q==;
X-CSE-ConnectionGUID: p5EENa0ER4KRLcMYE7kWCg==
X-CSE-MsgGUID: q8ibSiPSS8aG1yJ4eHQ+vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2546472"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2546472"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:02:46 -0800
X-CSE-ConnectionGUID: wsoVHUWqRh6Z1IVJtqF4+w==
X-CSE-MsgGUID: ekYH5R+0T8mGMzitKu1Npw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6823677"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:02:43 -0800
Date: Wed, 4 Nov 2026 13:02:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4134: Fix duplicate data_read mux state
 request
Message-ID: <ausQ0FgPHR3g_joo@ashevche-desk.local>
References: <20261104044719.4120078-1-nichen@iscas.ac.cn>
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
In-Reply-To: <20261104044719.4120078-1-nichen@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 12:47:19PM +0800, Chen Ni wrote:
> devm_mux_state_get(dev, "data_read") is called twice in a row. The
> second call's result is stored directly into
> st->mux_st[AD4134_DOUT0_INPUT] without error checking, and then
> immediately overwritten by the first call's result.
> 
> Remove the duplicate call and check the return value before saving the
> state.

Make the line lengths more balanced. Refer to the functions
as simply as func().

  devm_mux_state_get() is called twice in a row. The second call's result
  is stored directly into st->mux_st[AD4134_DOUT0_INPUT] without error
  checking, and then immediately overwritten by the first call's result.

  Remove the duplicate call and check the return value before saving the
  state.

Otherwise it looks like a rebase error which went unnoticed as
the mux state is stored after the check.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


