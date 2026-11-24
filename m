Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507441;
	b=BWSa8vKAbYxCs498LJtvb/xcxCHMCpvK6TwkdkyvL3CSjpwPXbfF5o0GJTRq0ybR4IvN
	 Csv4SkqGQnQdY/Dfe/zbD8xsTUyELszlQ54O7bGt1UP+cfOuyBJYd3vD3ykpfLFj1tR6w
	 0qi50BRCpm4v/O1JllMP4+5X2KV0Gu5XORYyreVBwrhpKJpMojdlBv1xll3bB5/sIKj2I
	 BzD0w0MQMUy+BeUHLxm32fDozh0EbBDtIJ8pdPWPHqAU6dUUwYjmM8SJARnHbaBMEJhBG
	 5FryOJebDSSiX/4yUeFABy9WNnyjMUzFERu3+nIzQ+UMeQg0HyruuFLP1ydieVrUhPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507441;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ty5cqjNyK85YYJMHAIHN7yEchHLHhVB7ktGsNKA60TE=;
	b=b9L/49MJkOelWQJj4DP27vgC+oqd2XIow51bRTv6SmXuZwdXapNPWs4TRTLgSuRAkv0Z
	 Hx1KQzx8S8msDnOLBD3HPG48SJW8K+rXh5uvFDIPxYOPJ5lr728kYRn9cAA4dztV4kNnk
	 bVjfqjjsEOTVPYJ7oxnepQG74t+D5pPuuz3LSYr3mWdHTfL8Vxvq+A1dmOANwPMbk6qan
	 Ku36uMt8x0IplGq6qMjSIUT3zbfIkSOilyxIl4L28lx4zxVq3iU5imGPSnmuo8n6zxgd4
	 hs6+j1TjRU75vvgKfX+5BMG03AGtESda4mn18RCcn4HgIQ2vXDVvMiF9Mu1xxaBjY+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="G1og/NtT";
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DFA606A31E;
	Tue, 24 Nov 2026 08:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3DFA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G1og/NtT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795507441; x=1827043441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E5dgahambSGUcoN2iRad+Hmh4wYWLOf4NK+W8gtw7iA=;
  b=G1og/NtTcFNlVXL+6KGE9HxJdQlPMuonYNj7ZRXdKMTBcEs3iLFwQvTH
   3agVLZkTViTnXcvZLei9uxcbRntwuf/oMS6auTk5dTCGICdPOFFnRkKMA
   OxLdAxJPWz4plXKA+wsq/EdjmW2O1eZRkNYTcjpnNze6Gb4Dp768to0Dl
   Q8BYMkUSIGbjJguAHBN+OzC5IglRRusUEBiviOWADwtLteBVQLy9UfXko
   VwyTKHtgLlGTblSHMm1+a+qo2TOzQfmrhVaUL1CMHyrcWyeHAV9VZpn8c
   uHzkQu1oX6j4SA7hgO0znP+wAOIiiBvcpYuJAJcmKO9DfNb1+63hT9sWY
   A==;
X-CSE-ConnectionGUID: xy7FLl10TWGM7pMCvwbfHA==
X-CSE-MsgGUID: x4tcaFTrT6Oj8loXSAHWRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4318309"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4318309"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:04:00 -0800
X-CSE-ConnectionGUID: RGB8bA6GQIuyRMqK9wnJwA==
X-CSE-MsgGUID: km51ox+9RkuhmelZ2iaWvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11818785"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:03:57 -0800
Date: Tue, 24 Nov 2026 10:03:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gerard Marull-Paretas <gerard@teslabs.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: magnetometer: mmc5633: Reference the
 datasheet for the SET/RESET wait
Message-ID: <awVE6simCJqi52Dg@ashevche-desk.local>
References: <20261123202616.17334-1-gerard@teslabs.com>
 <20261123202616.17334-3-gerard@teslabs.com>
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
In-Reply-To: <20261123202616.17334-3-gerard@teslabs.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 09:26:13PM +0100, Gerard Marull-Paretas wrote:
> The 1 ms wait after a SET or RESET is tSR in the Operating Timing Diagram
> section of both datasheets. Describe it where it is defined, with the
> revision and page of each datasheet, in place of the comment at its use
> that pointed at the datasheet without either.

...

> +/*
> + * tSR, minimum time between SET or RESET and other operations, per MMC5603NJ
> + * datasheet (Rev. B, page 15) and MMC5633NJL datasheet (Rev. A, page 23),
> + * Operating Timing Diagram section.
> + */

Thanks, much better, but I would amend a formatting style a bit

/*
 * tSR, minimum time between SET or RESET and other operations, per
 * Operating Timing Diagram section in
 * - MMC5603NJ datasheet (Rev. B, page 15)
 * - MMC5633NJL datasheet (Rev. A, page 23)
 */

With that,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


