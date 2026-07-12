Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB131FC101;
	Sun, 12 Jul 2026 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783868752; cv=none; b=CrYrAUYHjDPE5U4sDRreNMdDMVWG2/o1RgUNyAYGVpTeGob0wPTJmVizqY4hpLhhMQ0y9W7voNR3/nHEoiIfar1gfFA0mBsh4JzmA5zYGw+XsOtH6/DgMWXHATUfR0gW2CfTop/NM9QGBb9XBY/xlIlK6oJ6n20KZJAZaCG6w9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783868752; c=relaxed/simple;
	bh=zDF2A9L7LPEyJ4WCEOZ+dSPiuxqdjE9dorvQrvNDE1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ytaqd2MaNy3sbw6PBSwy3bAvzWDrXQUmtry76cbI2FX/bzq5mTyC8ibpFSIYEd3o2TfDBbNsVhuQwCZVtw155YB2E9CpoD9UCTaLS+bp8wgsZSdpp/nbNEHliyuPXVNwlIf7yrPqUcsVtp5/QB32zf+AkPrqeHZbaDKZo0PjO4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3yIpJ3j; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3yIpJ3j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783868749; x=1815404749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zDF2A9L7LPEyJ4WCEOZ+dSPiuxqdjE9dorvQrvNDE1I=;
  b=d3yIpJ3jXxDsEZoiDX4kbbB8SJm5QnQZV5CEjGGt+AL7Kg3vZ8sIQHaz
   cD760k0mst3DYeIrY7MyLO2UDkhOJ9dEjYCOgzt7Oc0HWdU7fKU9+NgRp
   uIlMTTdkkXFCx6+CcKYCQiCIkzCsH86QcdaDMlykvBgr7d6TVrvom2TKF
   oG8O9MDlUQ2li0nzuPhv7sV06Vb+7cv3kshvmcGntOH55ZSNBFKFlb3nu
   w7AY9ZXzrvc2SxsEVQYIK1Hapc/dHkRQSKXUr72X9voaQmcf08GY/8NS3
   +THIxKytcSjxRT4NDBJssVHmKb38OCY2JuG7B+vtd0LK2/PrARoHkcMUW
   Q==;
X-CSE-ConnectionGUID: 4vd6MWUYRY+aYjdrEXeiBg==
X-CSE-MsgGUID: zH3Hw1GnRbCiJr735B1c6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83477072"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83477072"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 08:05:48 -0700
X-CSE-ConnectionGUID: t+qI6cuWTMmckOngd4tSew==
X-CSE-MsgGUID: wfp2UfdVQZiz+owk+zizUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="285417404"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 08:05:45 -0700
Date: Sun, 12 Jul 2026 18:05:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: dylanliu050903 <dylanliu050903@protonmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dylan Liu <pxyforeverlove1314@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: =?utf-8?B?5Zue5aSN77yaIFJlOiBbUEFUQ0g=?= =?utf-8?Q?=5D?=
 Signed-off-by: Dylan Liu <dylanliu050903@protonmail.com>
Message-ID: <alOtR-zUc71PORuA@ashevche-desk.local>
References: <20260712141928.559844-1-dylanliu050903@protonmail.com>
 <2026071227-unspoiled-blatancy-0809@gregkh>
 <QNymfg8xEp8CU0BQxNJDcXKxDRN_xohHqySr8jzeakn2iJwHaezt4D2ks87ODGRh9227yPZ6dVpvcAa5OghRpS0htIaCUhCS7viUtr9aPgw=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <QNymfg8xEp8CU0BQxNJDcXKxDRN_xohHqySr8jzeakn2iJwHaezt4D2ks87ODGRh9227yPZ6dVpvcAa5OghRpS0htIaCUhCS7viUtr9aPgw=@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 12, 2026 at 02:56:40PM +0000, dylanliu050903 wrote:
> 使用 Proton Mail 安全邮箱发送。
> 2026年7月12日 星期日 下午 10:27，Greg Kroah-Hartman <gregkh@linuxfoundation.org> 来信：
> > You just changed the user/kernel api, right?  Are you sure this is ok to
> > do?
> 
> I apologize for the oversight; being new to this, I am still learning the
> ropes and appreciate your patience.
> 
> You are absolutely right. I acknowledge that changing the sysfs names
> directly impacts userspace and violates the "never break userspace" rule. I
> will take a step back and adopt a more conservative approach: I plan to keep
> the original attribute names as they are to ensure backward compatibility
> while introducing the new snake_case names as aliases.
> 
> Would this be an acceptable way to move forward, or would you prefer I handle
> this cleanup in a different way?

You also should stop sending HTML mails.

The driver is in staging and most likely more work is needed. As for this ABI
change, it's possible but it needs to be aligned with IIO maintainers and
reviewers first to understand why the original driver has it and what will be
needed to fulfil the same / similar if driver becomes part of IIO.

-- 
With Best Regards,
Andy Shevchenko


