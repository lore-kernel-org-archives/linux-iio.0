Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903045;
	b=pupj8ztdGsCIv7jAqOPkon8lr12NxkeGVSU/eBaFmUq/uxGxEjRV6tt3jBnyoQuZMtUg
	 hdA3mvAuyHHzHpgWecgAnNACfpyYAvz0W/7T90nAzLHuWcWSbA6ZKJvnOVqGjkV/yr5ZN
	 x53Ar8oYy2JvIhwt30CFJ8wVns9hhLbC8eYSvGfUr9PaWZiJjERHBHv0HSV4vUVa+/JAD
	 SLR4Ti4PUWEf+rBi5R6ow60HDx1VpW77Y8KhpeYzsw81rC7Y4mmiRynngpR0RDJyIo27S
	 CI9LiWwdHszjTrkhuYl0JsDjRJopU1PjsYw49smF6yKmefLPcIqRoj5l0QhGPAAw1gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903045;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=K6Yu3seYiE7iz3t0p0hXwFPGPdT23Px48dmMLAw1or0=;
	b=UQJQP3+rV3jvl6KV5QhzKV1rV1l0DgKc0lINHKip+cV6qtuH2HvbWILR5LKcU7G+j6Lo
	 VeA+6+ct43KxQopve8JYleel+CfidC/+ZRadlw/hfvpekE57VPKAWoDqz5cbphABgShMz
	 EXoNmOCVj4GyfayGPRs4G0BRe8HoAstxBxNa+2GYnSdWJT8tPXTbVXM6cIRvkMBQn6UTu
	 vSO8MRW8tztwcCVYn5/KT2IIIP1akc+SkJYeJuR1u1P7ZOTPOaCqRzRKiK97x1SJ0eSuS
	 LOd2+l2dAqksVTQ1FsNeSTfZFZ+EMK28XUsHw3LlJ2Oni1wh/ETnYIQgNDP6/9cS2qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f4lLhms9;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1E606A31C;
	Tue, 17 Nov 2026 08:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61F1E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f4lLhms9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794903044; x=1826439044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oD1gJAnB/Tm1n1+UWMpBS0qgoGoVCzu9Odra9ZKICSw=;
  b=f4lLhms9bR/ob+N8VrihjeH5dqLZurzn13YIL0TlQleTIxWiK9o+J3pK
   ikKTuoFGs35S0ms9auiGEcay0jjhl6AO5MXLENgxd/7t4b0zbWTeGBvmR
   beaNAbvqhz+1GHnmiDCyIK6R3J8+c5iQ7U6gGF6+fU5yMgyWNaiEo2FJV
   2y/6fWJLXa39KRqPrTfS+61vSDiU08hSeoq3HWR9SJTvt92R9JTH0xlFN
   82ZlT/FqcfvL4J+IIXIoonU0+2BjqlsOYlSR7URQfPZzMhQeMwkYtLfma
   mrmhy6qweCX535S497D8brA1UrQDjD/dwjWBOT9+ydFohWFWyLk4GQ9xc
   A==;
X-CSE-ConnectionGUID: uiiWjcfpRRWqGV4j4Blthg==
X-CSE-MsgGUID: yE4pGHLMRB623wIMTG0AzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3693466"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3693466"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 00:10:44 -0800
X-CSE-ConnectionGUID: 6SF4tKoZQa2OXl6Kvrl2Pg==
X-CSE-MsgGUID: dL5NAH4rSSWtIjaZcjqPGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9849884"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 00:10:41 -0800
Date: Tue, 17 Nov 2026 10:10:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joseph Telaak <joseph@telaak.dev>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: ABI: Move out_resistance_raw_available to
 sysfs-bus-iio
Message-ID: <avwL_iuTyEjaj0hs@ashevche-desk.local>
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
 <20261116-iio-ad5246-v1-1-ef6b7c06d4b0@telaak.dev>
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
In-Reply-To: <20261116-iio-ad5246-v1-1-ef6b7c06d4b0@telaak.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 05:59:50PM -0500, Joseph Telaak wrote:
> The available raw values of a resistance output were documented only
> for the mcp4531, without the channel index. ds1803, mcp4531, tpl0102
> and x9250 all report them, and indexed channels name the attribute
> out_resistanceY_raw_available. Document both forms with the other
> generic resistance attributes and drop the driver-specific file.

...

> +What:		/sys/bus/iio/devices/iio:deviceX/out_resistance_raw_available
> +What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceY_raw_available
> +KernelVersion:	4.9
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The range of available raw values, as the minimum value, the
> +		step and the maximum value, all enclosed in square brackets.
> +		Example: [0 1 256]

...

> -Date:		October 2016

This is missing in the copied case.

> -Contact:	Peter Rosin <peda@axentia.se>

This is also, but I think Contact for generic is the IIO as a whole
(maintainer level).

-- 
With Best Regards,
Andy Shevchenko


