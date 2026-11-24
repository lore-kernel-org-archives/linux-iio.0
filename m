Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511080;
	b=NjBXoPmQbgFc3wZq/ZvqOEzi/ZVVG0B7B1aAX723mJSp/Dgye23bXBRemoOov5IX1VKE
	 fv4rmBl+7KnQ3dk7P52My5l2bx4qwcpsv+GZhBtJa2q1qJjH8757D1U25EU5JhOo3WnqL
	 xfM0OFK3QuaBQE/oy2MOXUZYqsD1Z6YqTUn8z1NxNiRPaFMWTw86zpj73Y+frlV2ZXj2Q
	 e9nyK14yzo6QGZNdGvF1tyUAZXNL5Ud2yGEjwlHHWHO1tdcXAeLyPIERkqS9Int7F8gd+
	 3qMAR7fiYJ1RJDuQx4UD6tjV8Kezoh10kCniw3BNXfgE3RVLqLZDvd6malPP9QTWCIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511080;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=9mk3gNLVEkmU4DWyjooeSmgHfnqPfqs+ORX05bgSago=;
	b=nFrgx7aJzI6RSEEa2bOWCrdS5ycS2QJux7okslkMChiiYyksRv4ioTLc6/z6k8xiQ+kk
	 dsqiOa1M70zpAnXLyqNn00SWszgPq5cM852lwwEEQmd0UY79Zhcwz07ey1TiQbNcFNg8j
	 K1OnanenwOSP1x4boO8wpTqieiAa4X690X/wxPuGPDvJudLgSuAhdhjkFQYO5/QV4ZCTS
	 N+H41j5EEuapoGmNl6K42Yvqr90J93YvEEW18K17YRnH9xcUyvqdTdwURH/7n3GWupoki
	 i4K+AO7TEzxSnu5S0R66SUQQSv9Z9gfQPng8pNv9WJRnKUmJNqk6muHutl7gw4Jb18w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kC2zqSiF;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072DE606A326;
	Tue, 24 Nov 2026 09:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 072DE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kC2zqSiF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795511081; x=1827047081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8jVeRm/EySvKKQCmG6DDh9Db4PXbuccsC2DH8Exg2/8=;
  b=kC2zqSiFw54h9Ne4eWTMoIH4Wg7bGZ7ypBHeHaueksCxwq7tKjNUds4I
   vhsgZgn1EX2BvBZPe3/N9bn2vkBlH2KHgr6Y/TsEWQRGJsqIvrmFTID8m
   0ogeNO3W/HpAMbErweD+VuSHk4QwKgx0NvCgW0vvUWV8810+KwEw0D8q7
   rw+PqawmCUVpi4Dwe1+3w21za31yQtIniwXBndX2CUCs2394TZOfapI8J
   26t8zhpJukBzEFTfTThxxHp7amRxhg0HMDadLybBDCwN/sHWZUljSZ8KY
   mVhYpBh8ZypW/4p5iiI342IGxbArJW0qRnGHDricldAlIAW6U/8UsF2F5
   Q==;
X-CSE-ConnectionGUID: 5ea1r8J5QWSMwCvxvgmUAA==
X-CSE-MsgGUID: 60lF0dHDSl23qZVgMsAXHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4253950"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4253950"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 01:02:25 -0800
X-CSE-ConnectionGUID: 3k7KnAeLR8GDZ4dutIEt/w==
X-CSE-MsgGUID: DNAuWG6LRN+3OVRuKsVIYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11844040"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 01:02:20 -0800
Date: Tue, 24 Nov 2026 11:02:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ilyas NHASSE <ilyas.nhasse@skf.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	"linux@analog.com" <linux@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ad_sigma_delta: support devices without
 RDY interrupt
Message-ID: <awVSmqLqQHwT3HGn@ashevche-desk.local>
References: <20261120-ad7124-no-irq-v1-0-7826c5c3fd25@skf.com>
 <20261120-ad7124-no-irq-v1-2-7826c5c3fd25@skf.com>
 <awA769JyWRvSG8PY@ashevche-desk.local>
 <BR0PR09MB4414408680F908802B0A1A358C89442@BR0PR09MB441440.eurprd09.prod.outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BR0PR09MB4414408680F908802B0A1A358C89442@BR0PR09MB441440.eurprd09.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 08:53:14AM +0000, Ilyas NHASSE wrote:
> On Fri, Nov 20, 2026, Andy Shevchenko wrote:
> > On Fri, Nov 20, 2026 at 12:26:48PM +0100, ILYAS NHASSE via B4 Relay wrote:

...

> The information contained in this email is intended solely for the use of the individual or entity to whom it is addressed and may contain information that is confidential. Please delete and notify the sender if received in error. SKF does not accept liability for any damage arising from this email.
> 
> For information on SKF’s processing of your personal data, please visit SKF’s Privacy Policy available via www.skf.com<https://www.skf.com/privacy>.

You have a problem here. You need to get rid of this footer in order to
communicate in Linux kernel related mailing lists (and in OSS projects in
general). Consult with your corporate lawyers on this.

-- 
With Best Regards,
Andy Shevchenko


