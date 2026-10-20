Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486422;
	b=TeQAaV8lebGFXro2q3JFFSCsKBbCtgNbPobyNQ+P4IZSJVZyliYU6Lh/8v6p8khICc6D
	 SREaDwK9xN4a2+RH49MxOVVloNMZJ5EiRADbWIARcoG+RbLuCxcQPi/lvBRpPnxbuf2L2
	 +/7Xh9zZwjLpLaBDO3b6CqQJ6kNMKr4KybGw7qPQbE99k3QZBOrLE+uJEAqPIjffOBDtA
	 9g6zzlmctwmU07UnDN5tUetSYFjl1jEdvq2TLF7urAaWEA9J55CdbZB88e05Az2EDeVh9
	 tBb+NvqCXGlR0z/eiGyD0Gb+Eq6J3NcQ5u7lDoEqt8UMbjT/4OsEBBaodPqyeJGVyEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486422;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=c3gW8vlxFRuwtLEYEFt3k12PKqTy0iNqFuQQwZ4eiPI=;
	b=Q7sqbwaEUhyFy8w1Zamk1wqaJYdiRZu2BdXvjLOekhV+yOuAGXjaifzHcnmfh5NadHoZ
	 upfqtSsNrVZXw6AF39KtBTNI7thJw7raixQ7HhBUB+k78787aPRoEYSu7dmQmJaCZNYP7
	 W8sF/wXTPl8EOGiG/jSBwbzpkeYa2Jkbb4ow0eDbPoBwwuZhuGH5s1syIQyIRmoCsHjJQ
	 KT14WehK4qL4LRNf84hr6hpdAm5wupXZusuRKRTcbT3X+E/VVaePK9EivMQcgOkLr3gZX
	 pCAfHj3jkffzvNv5JC2p6K+t6dlUHT2IuHrZgwOwPFBiQg0jRtDdOC7GNonLRejsEsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=llcxBOhc;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397DA606A31B;
	Tue, 20 Oct 2026 08:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 397DA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=llcxBOhc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792486422; x=1824022422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qx7rYZ++L0cM+z/hd/u0+GRBOenjR3UIMqzBasDLmYI=;
  b=llcxBOhc3oaT/yl97HJ06lJ1mnDNNLQu9T7VsRzpoCR3c/PcXMwbfWDK
   ht1H5rDXAxGRm2mcH2PQ9isKTTU7Nhu4t65GIYB4g80zDeihu6AYE4Gds
   X6fFBBv8mKp6/O44aalkx0AlFHFPkHSqSw7bDdBcqOJ+m27zQQJMC71mb
   1npuqY0IvFNetkWcWCtRfbrdlpDPQ7YkScMo9qkD2bTJGzTKbQgl4CtEr
   On9jsKfRbPoBdPXfECN+zqtku+oi2GWLPc4H3Ee9ehmBV3mgOw8VVNRsg
   bXxV2Z6NGDVwxD1AWzDQPBnrJ5TIeDUhutRbp1qwGt/tDJi9bIiKRRqzA
   g==;
X-CSE-ConnectionGUID: sjJjt4JRQNmsmAZ90wE29A==
X-CSE-MsgGUID: ORcxIeePQZ+o4/jq6ECoRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1067127"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1067127"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:53:41 -0700
X-CSE-ConnectionGUID: gs+cmVpKQlGEHz6caynzsA==
X-CSE-MsgGUID: 6LqGF2W0TYaC/hCwPOL+Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3178325"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 01:53:38 -0700
Date: Tue, 20 Oct 2026 11:53:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: update gyro start and stop delay
Message-ID: <atcsENHqXSRvn7SU@ashevche-desk.local>
References: <20261020-iio-imu-inv-icm42600-update-gyro-start-stop-delay-v1-1-ed52290a4ca4@tdk.com>
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
In-Reply-To: <20261020-iio-imu-inv-icm42600-update-gyro-start-stop-delay-v1-1-ed52290a4ca4@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 10:42:30AM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> Following datasheet gyroscope specifications, the maximum start time

What datasheet? What specifications? Please, be more precise to refer the
Datasheet name, version, chapter, section, et cetera.

> for gyroscope is 45ms. Stop time is required for letting gyroscope
> mechanical structure settle down before enabling it back. 50ms is a
> sufficient value for that.
> 
> Update values to these numbers.

Do we need a Fixes tag?

-- 
With Best Regards,
Andy Shevchenko


