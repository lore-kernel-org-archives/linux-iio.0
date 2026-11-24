Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516042;
	b=aS+nddnN2Hav3PxGEGpnFuDACfJBvlebUiHfUX0pakdAHThl1ydeHJjrmSx2fe3dH6XI
	 O6GPHehkt1marmB4OoANXfNjFtlUKUrN5080NlmhrJTlU/bnWitOUjcC3hmm25mM7XQAX
	 7j2XD1WS+moPssDlhxVtzcpUzhD0V/kzCVIGBVJIKF345US8RDvSacK/7pRFssqvUEe0a
	 LwKTQmKew2nXrzLPs/+oQ8vL0eYtHenny94CboqniVj7zxioMAjj5ooS2V9j29WbsxSI/
	 ZbJmJsoeEhTNxRrKlN9t161o8uLltp7RpcLt8GZKU5qJavYiHkvr2bw1i+Z45X4p8Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516042;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=bv3MYp50cO6JG3wyY7QdIPoIXH9KstB0wwFIT4JfjgA=;
	b=KoOLgeid/V2V/xA9K3KpeDkp/6ez6d17ZxZayy8C8pBh76qFr6iEIpqCiGKvHjiH4sn5
	 i3YhPj0MREHz0OVS1F8ma15vVuDcCNJfidcLsND3Ws5JMFpXoRZC+56hxAsDf8VAjpN35
	 m9kj+KN/vb1bUcw809zxe8HqC+fGfYZ12XKzegWizyB5ht6ykliBl13zcEHVz+uBObFkd
	 KKFH4h2f6tTmNzA+B0E2MIrqUy40wZZOu59q3L/Tqbw8vj9c0/biB+bhhHQ0m6zq3wydh
	 tfHebHy0mqy2Zh+dhpH5qL+7exn/Ic4o9ofcP3sNvvpjgnn6wF2I5I4Vu6gMFDbb2hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b9ixxqam;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F164606A31E;
	Tue, 24 Nov 2026 10:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F164606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b9ixxqam
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795516042; x=1827052042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TnAVW8znwYMhZ6U0JVzDhzcJhGdWbZqAFm6lyt6LM5I=;
  b=b9ixxqamrN7xhW/FyBIrUAjL/bWFTeuBBAHaYtJQjZRGWDrlOORICYd+
   F3tj+DMi/FTCCxrhotdjRY8p/3u7d4+8ZsdZPpesRB/RbNQng22wYyL9c
   28HfJcBqjSdwv5Rc85en7ubm2wb4YHI2ETk2j3rE3ohdZaC0adDjjR2xL
   Bh6YyIB385bbkAfAVb3c8Qq8vGTBATGSzHXlyRmFXqXIvR0iSKCCABcZl
   yE/yPblRDWPl1Uyyqs6R1xoCp6LDpLQ6LOa1L/QegKi5mnulyUFeelwWy
   jumZAb/A5f4GNV9nLgQIbhAktF68p9x9jzmsv67CiPurOqtlCaazveYTM
   g==;
X-CSE-ConnectionGUID: ynme8IBOR1ye5GknncrsHQ==
X-CSE-MsgGUID: 4MQiwO2CRayvHOqkgWe0Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4364343"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4364343"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 02:22:57 -0800
X-CSE-ConnectionGUID: YxJJb1eYTLaL61vC8MchUA==
X-CSE-MsgGUID: Gz0SA2SJTM2R4qiA71kRAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11442732"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 02:22:53 -0800
Date: Tue, 24 Nov 2026 12:22:51 +0200
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
Subject: Re: [PATCH v5 3/4] iio: magnetometer: mmc5633: Enable the VDD supply
Message-ID: <awVle8CFVrYHkih1@ashevche-desk.local>
References: <20261124094632.8879-1-gerard@teslabs.com>
 <20261124094632.8879-4-gerard@teslabs.com>
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
In-Reply-To: <20261124094632.8879-4-gerard@teslabs.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 10:46:31AM +0100, Gerard Marull-Paretas wrote:
> Boards may switch the supply of the sensor, so get and enable it before
> initialising the chip, and wait the 5 ms both parts need after VDD is
> valid before they can be operated.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


