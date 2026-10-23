Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747055;
	b=LTTwr6/+SXsafiAO9OhA4ZTg22dYnzEU2CzbGcoKJw5hqPNPp381qbVfx7m7nXSs8qkk
	 cIe0Lrg8npZD9hkRP92KMthZCPaFvoBbiX4KFjN9Ta7KsnXMCVnmpD/vtLsscNVQl1dM5
	 EMMq/ba8EwmDsFHNq7NJMnwHbkUKu7/woSlVpPyjRXlgH18cHfBf5KUFC/SzJE7UuAUcv
	 gOVhmzDgo5ZfOnOYdG8Vi0Nhr14ZwsOcts89pzzXu7O9m9u2u6awTsX+GI/OjLVyx/+UJ
	 nJsEjIfQ38WiQMBhTeRKOwtmlVvPHgUC86GOnyr3tcEqsaJZxUA16HX3Otjte4VIEvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747055;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=W6Dqe40TF9G9HwbVvZOqNjcj55Y+RW+4s3fXUCy/gPk=;
	b=MvkOHM1IGI1jWTP/3QWUyvJhbkcuaAKdqZUnSTk2v8Qw0UYd1Gc0wSisylFZw9X+Y0Kh
	 REd1WQJ+urXxqkvHwE7bF2iJYatIRah2j19SPfxyRYnuEVCVAlsbRBWM2J4G3I7kVW7pN
	 8p1ne2BQN44wLxFt+YaAKxeSKFiLSnSmFHLK9bBtoAflhnxSUbvl6JjhgZ/FpG2p/wX/C
	 r4DhSxn4ZzDmOgSecgW77a+v4OMvntXHH4eU9GEtD2j413pRIcul5O83erzyj+yRt0+4j
	 i6u+7WUwq+BSovGRAHTUTGAAv0UsTPwXq46S9EZxjYxTyYZttU4icbq6cp1YN5/H8RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XnOKE7IF;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D76606A31A;
	Fri, 23 Oct 2026 09:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98D76606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XnOKE7IF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792747054; x=1824283054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ogSESg8d+AQ/8m1inPCVKjuc5x0JyAFn0zrW4tVebuk=;
  b=XnOKE7IFsL5OgkeqpEY3EEjCpCURc+w8ebDujhDEc3fgTZjNaLcCE4WQ
   /qMSKhw8/mQyHdUrnwC8T5zRo4VfSGgzhNLM5vi2y4LM6KfU/Wz2SrUQh
   KV8fWSY4jz+vFPJ5LuGMI2LCW1oYClUQ12v5HIVtZacNtBBGDu2zh/bVV
   2piQf78c0MzWhkWBqnkoG+B+IoPtCBZBBjmJQzdtd/2N8U0huN65Vcj6g
   Gp8OGn99LANteJIHEgoOxBXzR1DObVm1enTc7efENmcTWJSdcQtpT7GLt
   auaWM+s2ncYVNJODSxzSvvP8NWSr62VzqeY6EonKgV3qY3T8Ykfhm5HLY
   A==;
X-CSE-ConnectionGUID: BV72pTdfQ3KG5LpvPqL9+g==
X-CSE-MsgGUID: qm58k5PfS4KP7I510ChL/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1495200"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1495200"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:17:34 -0700
X-CSE-ConnectionGUID: DRL5n1gAR/OzIF3PX3dWqw==
X-CSE-MsgGUID: E1nxLauySKi8bqqTfeRBeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3937545"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:17:31 -0700
Date: Fri, 23 Oct 2026 12:17:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH 0/3] This series adds support for Texas Instruments
 OPT4041 Ambient light sensor
Message-ID: <atsmKZjpr-NQLKBD@ashevche-desk.local>
References: <20261023-opt4041-v1-0-45227f82d05c@axis.com>
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
In-Reply-To: <20261023-opt4041-v1-0-45227f82d05c@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 09:48:12AM +0200, Jesper X Nilsson wrote:
> Extend the opt4001 driver to support OPT4041, since it is so similar to
> OPT4001. The OPT4041 adds a second channel, a wide band channel ranging
> from 380nm to 1000nm. The register map is almost the same for both
> devices. OPT4001 has an internal fifo of size four, OPT4041 has two
> fifos of size two, one for each channel.
> 
> Since OPT4041 has two channels it has one bit in register 0Bh to select
> which channel is compared to the threshold register. The driver does not
> support setting the threshold registers, so no new support has been
> added for this.
> 
> The OPT4041 is pin compatible and has the same package as
> opt4001-sot-5x3. Although the device id is different, I added a new
> compatible string since the driver already had different compatible
> strings to differentiate between the two OPT4001.

Overall very good small series, I have a few comments, but they like 15 minutes
to address, id est mostly style related. I'll give my tag if you send a v2 with
the changes as suggested.

> Datasheet: https://www.ti.com/lit/gpn/opt4041

> 

No blank lines in the tag block :-)

> Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>

-- 
With Best Regards,
Andy Shevchenko


