Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176699;
	b=RJdAPx5k3KRYJRlBa6vbVeW6lGkCJbnvdeu/cZlw6LrE03aLM5xwbjcvXZC9dGtUDni0
	 owIZBVKon5ONMn3tuooy/xILrHNtZwh9K5TVNagJv0LRCEFPtdbuPubYtjfI+whnWhLPc
	 f1DiVTINC2XpGFvY8RKUpsyOQQUPCH5CYyN46HQHeT7tJVvrvat4tzMl1n5jQbfi1HM/k
	 Ontdix5Y9pg/MkR0M+5ZpvIBWgVWBzp3Ayp1IavaMjE4A8Fti2QPoN1VpwQ7x1muVGZjB
	 rj55Etapp/7ChL+g8auXMDFAM/uVIeZyMVoVAcEYAjJKNwxh8cTHT7bYbOFYVeNMDqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176699;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=T7+9Nyh8AGEOqh2hRpYDikW/Vv84tGorr4ndDTloZeM=;
	b=elxcJVVOWb/jlPHjWdVNG0PSci99J6dC2Om8RFyaU6CxjkOEgXghmje853jP43p6KENd
	 IcSIvj8SacNxjg0xQq6v9L2Uz6BbH0taPWY8xHgAD6EAwDdSN0Nl9OHlfVOSNbk3pUl2v
	 6Ej043C5fYB9eszpSnoqaOKbTBznzrWsXDid1Nzp+RqYgKV47SDg4ahiChTKC+LEH1P/9
	 HuQC3uNxbhfnAB1mdbaJP9Z9UV3CkbhQGN+2WKt5/bHtcj7elHnUVCd2bPat15C5CqhBo
	 P409I540yYYuq68etnN4Ualul1N9swUd+pMQk1P5Jw+xyLkC7pHfXam2lnq3VKk2aDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="J/MeVJK0";
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD4606A325
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 12:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29CD4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J/MeVJK0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795176699; x=1826712699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FypGpLQlFtTL3iAtQo8Y6Xrx2UWODL9Mzi/zJcK0Zvc=;
  b=J/MeVJK0aqMz2n4wEjQCu58Qv8wglJAog7Gz6C7/N5jPF8dlf8sPkv61
   GK4JZOMVct8CbZGzaqw3/+5DcDceUXfspnmE9acWFYSpPD+A7KI4BrswD
   iQs6Hgkg5YdXwlbuObiMrkdTVo0TXPhms3keh2q7puyjvuwuPA2UMQiKB
   0vCD/SMAerOTRnpIpF2AI6KxKVBvVAwGDpXTKSt3UFv1cUhwqjBJPnZhP
   3V//wms7sFvfvVWB71LpM2e3YgYycSvRwTwjmdn9Wd59Smqg/Pu1/C9wg
   eecHJCfyyNiU+L6msimMf0e3HUfZ9yQrvAcTZVnDN83LupdvokoiOUyIk
   Q==;
X-CSE-ConnectionGUID: IrwLm0CiTIeOCd3ksA0WXA==
X-CSE-MsgGUID: 9jaoQH3ZTn2J7s5tj7SkKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4041363"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4041363"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:11:38 -0800
X-CSE-ConnectionGUID: iczoZmsTTxOtP0+GIquGpQ==
X-CSE-MsgGUID: wDwpitwjSLaj5a8Ra36+Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10586779"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:11:37 -0800
Date: Fri, 20 Nov 2026 14:11:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Song Qiang <songqiang1304521@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: rm3100: check TMRC in
 rm3100_get_samp_freq()
Message-ID: <awA49qGkg-F2m3HJ@ashevche-desk.local>
References: <20261120102848.3198371-1-maoyixie.tju@gmail.com>
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
In-Reply-To: <20261120102848.3198371-1-maoyixie.tju@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 06:28:48PM +0800, Maoyi Xie wrote:
> rm3100_get_samp_freq() reads TMRC from the sensor and uses the value
> minus RM3100_TMRC_OFFSET as an index into rm3100_samp_rates[] without a
> check. A value outside 0x92 to 0x9f reads outside the table. The driver
> only writes values in that range, so this needs a chip or bus that
> misbehaves after probe.
> 
> Commit 792595bab492 ("iio: magnetometer: rm3100: add boundary check for
> the value read from RM3100_REG_TMRC") added the check to
> rm3100_common_probe() after a crash on failing hardware. Check the
> value here as well and return -ERANGE.

> Found with a CodeQL-based static analysis tool that we are developing.
> Reproduced in a userspace harness under ASan and UBSan, which report
> nothing with this patch. Not tested on hardware, only compile-tested
> with W=1 on next-20261116.

This paragraph should go after '---' line below.

> Fixes: 121354b2eceb ("iio: magnetometer: Add driver support for PNI RM3100")

Not sure. It sounds like hardening against malicious / broken HW.

...

Code wise looks good now.

-- 
With Best Regards,
Andy Shevchenko


