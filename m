Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488756;
	b=MCXoQWJLKHF1AKfxbdUvrKIOAflNfwgY+/Ossb28cUcNwyRT+6sJ7lxCwECposCmZHml
	 AdBDEcsvYTvIELjDu9v8fkCXCY5vbjLw7zPCXcZdOHerKdKtWz8oFUR90Z0cwQgquZDb9
	 9OTwPyd0XG6LdIP8N4Wa/FiSyCFrSfA7m5TjUVvznZIJSbDRWqqTm4VRet13SAp9UXxP9
	 k2EV/yRGqQVa+M4hp5qU/hDkMQmBW+aKO6GBnX28Yq53gIaxQqfDtglEfKGdAX5fUXfC7
	 VZR0UMURYWwmygkoOHfHKOt8PryeX+jR2u7UWLCJls0Ynwn8t0XMiws8BDXgk//oNLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488756;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=rIQLoOEKBXNrLzbv2XZ/zQysYmgcdHfBZRDwUOasa5E=;
	b=Xt/+NpoLyyk1quxkld9lxyEO2GjbmMuNu5KYeXzQYnV8NSCdS2c7WD1nAqO3LV2pejLa
	 AdWglSfezkLP0qCHj5nF4EqCPG5H4q52mQXCeEMb1S+iuh3Wx5SOhmHUqHkwrfgVI/uNh
	 sjT16+ol34L2AYv2YY0Bj+2tq7ihIWe7vGYcw17Eke379fYtP+1PTI+Ko9+Ave3HJ4Okv
	 34bO/SIA41+sEaw6uwOWA+VGO1eJdiiinL3h6w9b1QaJmOj4mY34FASA4lFDSWAR6b1lZ
	 cchhkVGqWuw+kRJWayEBsgBks2WD9sTRofppRrCi67Y1BlRyVlesPZBvB8Rrt34qU6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=noBcdUAG;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5316A606A321;
	Tue, 20 Oct 2026 09:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5316A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=noBcdUAG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792488755; x=1824024755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GvnUxFc6AVOlVYC4bxqQi9nf+KtfB9StUXlyMrnCr0A=;
  b=noBcdUAGmZcnS/jwKiDNolWIRz08vtLN2QRw5zB846UrG0jANOozTApa
   EfZeBLg25IbVmv6watu1XiacJFfGeljt6rVaj3ZJgqLa0iGCLosv+JvdW
   JZEBU6ZPD2jsTq+/cb1bUPl7N2wBFX1xFcKbaj5MK7EiCSoc1h/rqiEPT
   TwpHHBet6wtfokK4DYNJIi0xY4F3Bwo9CJ8JhXe0Qs/R2N8dEkaKJvozw
   FHd5L76e47dGArUnHlMkXN78UR9MjcjnyPix8xsZEf3+g89Vnz+dmgH0c
   eYvxUxMzahO7yUm7/ChI4SmZ2aYMKJdNzwtXuCtfAdeZC7/Q2HvQ4s0ql
   Q==;
X-CSE-ConnectionGUID: SXU99PIhR6at5afZyrXylg==
X-CSE-MsgGUID: HWGKybmlRWCU1XoQ1whw6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1081640"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1081640"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:32:35 -0700
X-CSE-ConnectionGUID: nZDl0sPmQESacK2cSQ3VCw==
X-CSE-MsgGUID: 96mjSo4SSl6n+yhfY06P+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3143100"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:32:32 -0700
Date: Tue, 20 Oct 2026 12:32:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <atc1LVsZzfVF4NI9@ashevche-desk.local>
References: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
 <20261013-topic-sm8x50-iio-max34417-adc-v3-3-d3604ae4a229@linaro.org>
 <20261020101312.47d2eaf0@pumpkin>
 <729d7100-56b5-4826-be86-358e96be2882@linaro.org>
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
In-Reply-To: <729d7100-56b5-4826-be86-358e96be2882@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 11:18:31AM +0200, Neil Armstrong wrote:
> On 10/20/26 11:13, David Laight wrote:
> > On Tue, 13 Oct 2026 16:07:13 +0200
> > Neil Armstrong <neil.armstrong@linaro.org> wrote:

...

> > I was thinking:
> > 	struct { u64 pad:8; val:56 } buf;
> > then using bswap64(buf.val) >> 8 on LE.
> > But why not just:
> > 	u64 buf;
> > and be64toh(buf) & (BITULL(56) - 1)
> 
> Right, I mean all this could work but I would like to keep using something
> simpler and get_unaligned_be56 matches all this.
> I don't think the need for performance is enough to use complex ways to get
> the value.

Also we need to be consistent with the existing implementations. If any of
those tricks will be needed, we better to apply to other cases (like e24/e48,
et cetera).

-- 
With Best Regards,
Andy Shevchenko


