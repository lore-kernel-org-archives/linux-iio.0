Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795167624;
	b=guvPvtvKJRm4NXBXWfkokQaluPUBrDQRCF+wFeoqx7VZAAcBViWqWCdzVlYejX4l0K98
	 Bc2mN0uGXWz2FyR5pdVIbeeJeZj1+YWmahO0oKHWduTRBdnqVyHbhzTAMNaTcIxYgQNQx
	 djSozkFNdU6Qirx7lw/ObFkyRCSCTB++fwe00TeRe4qUxU3btZMJtwrd9FpKTM0VmaGEf
	 QVLubp/LaGQYrT0nndVxHBtjtWd/A71Ze1C0TpGw5lg4UyzlQCoi3d9M5buqZSm2pVsvw
	 BGYqcqQz919bt8KAEcECYkzZtltnAia1NJcOkUSNB5XtnnBD1jXMU3gAUwTxSQ+1rsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167624;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=2sNa5BZGVXTN44VMJ050+mfo9qMeWt88TalXiuyE8OE=;
	b=gxlZIyS3t3UpdYMlNu5K8mQ0vcfApDtUenadDSaJJyzxZfKNyNkniZobOMrPACizfEBR
	 2r7cgH9NF3c98KVPQmyADagp/y/6UwO+PxTerGwLw9mfm5uowDtzN4s0wyI97dZnpk64S
	 Tq2NGZKol5bXXhN1F2u3U+MjMBsW3xL0ipD0FhKLkYbhevPtpNHC3A8kgtgIr+K6AKN2D
	 MSWD0o9sfehHSEFpZ6Q1nJSnvIpEBuHdIK+b27ELzDoQmwTJpXfiycXQxOMUOZV6eL7Vf
	 5M6lizYGVb9BK3DF/jzRlZgc1Wz9WDKzM/inSYJWenPh1uXiFgyop93u0yFhC4iGA5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ADGFsH/d";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A011606A326;
	Fri, 20 Nov 2026 09:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A011606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ADGFsH/d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795167625; x=1826703625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cwyenATNu+jTqryMD5/VO6GBmpbhEkjNvFMpSUYiGiM=;
  b=ADGFsH/dNMS8NfR7D4FN7AabxNzoJFSivQElXHt+RGQiuLs1jBN079M6
   /0fTjmUxFY5urJ0vYLGFnpOeOLUWYiWtSqZxZKrOF+yB+wC9nLnnN70kE
   BtgtIcb6W8+bGkwGhowc7BRDSZuXZcsLbaj1PogveLCcsa99MxPWy1tMs
   dT4YKpSleN4UdDxKowYe4GdWsMFs+YLP3w643UPYI+MAbdfJEG3g98CHS
   nP6J7h1V/8vZRv6O5ypxe93enQ6x9zWQdGKJxeDFpsJfh4KseQEqfUquY
   LIgP2Z+JMz+I4SFFPpEkKH9RNsynQoGavYX5lymNEReGnUvOrW+Mjehq8
   Q==;
X-CSE-ConnectionGUID: Oh+TE63HRcKL/RYhaN6DXQ==
X-CSE-MsgGUID: xcg42iHMTjOSVxnEGCAdJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4144077"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4144077"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:40:24 -0800
X-CSE-ConnectionGUID: NiO697zUSCSQpXmNTVLX7Q==
X-CSE-MsgGUID: Uvfu0pT3SDGt6bzok1WTcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10552600"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:40:21 -0800
Date: Fri, 20 Nov 2026 11:40:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siqi Chen <chensiqi@uniontech.com>
Cc: nish.malpani25@gmail.com, jic23@kernel.org, crofts@kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: adxrs290: propagate chip ID read errors
Message-ID: <awAVgtU29mPK_10d@ashevche-desk.local>
References: <20261120025754.4075038-1-chensiqi@uniontech.com>
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
In-Reply-To: <20261120025754.4075038-1-chensiqi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 10:57:54AM +0800, Siqi Chen wrote:
> spi_w8r8() returns either an unsigned 8-bit value or a negative error.
> The probe function stores its return value in a u8, truncating errors and
> treating them as unexpected chip IDs. Consequently, an SPI transfer failure
> is reported as -ENODEV instead of the actual error.
> 
> Store each result in an int and return negative errors before validating
> the chip IDs.

...

> - Move the OpenCode disclosure and testing information below the
>   separator.

It's interesting that the other patch without this amendment was sent just
a half an hour before this one. If you get a comment against one, check all
the rest (at least for the same subsystem). Always.

-- 
With Best Regards,
Andy Shevchenko


