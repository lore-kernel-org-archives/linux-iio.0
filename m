Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A17D433059;
	Fri, 14 Aug 2026 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694859; cv=none; b=lQIrrfkXYIz37UkI5yL82DwNsIwldBUJC8T5kSgMDqkHOB0rkGscdrnqZuc2hJc19i0XqmPakYAOhOcZJc0oK8bWwcQEIH1eI+63IuB/m1L8DNp/oKfTVJehbvxd01qxMVKKQ5u29wTu2brjjzzUo5yXo/LQ33zSdydIh0+rPZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694859; c=relaxed/simple;
	bh=Y3IPqi5J7DzGSS5yQkD/LpxCawEONS/A1Vg7M2K1g34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBh3xgf7WCBke3A03OKYsVFB89+y1IjqlLKLfTVVLB2SFhcD81E1Hz7gzjv9iagMxK9KTk+0jIORqUDx35nDPV4D9YRHLmvnpPkklVKKp/DSVM4tH+G1Fp5qUvaWJPIlicXqr34eS/kN8Q+MQh7k9Ct2ox7zATnvzKBj/Brh26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+FltGp4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+FltGp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786694857; x=1818230857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y3IPqi5J7DzGSS5yQkD/LpxCawEONS/A1Vg7M2K1g34=;
  b=T+FltGp49mon2kRr6pq3lbZevYzi7Cwtb+JFDDoUq5qjJPDEFHfxehPQ
   D+pk+xEW+oYePmBzpC1HDSDDC7p6gdsblMvpjBBBZrC7GXO0xr33YC8h7
   zkSWVNZ7PGt5ylm8Wx6L2FB1nNtAlLanzabCJHmjkCfXmb+WoltKEdaBe
   sO0TDlEKbu9MOrViII6suEncHwkw246RJuDwNrUPOkNbOTZvCY8qiuisZ
   21VfBvz3TbiFmbmUCkl80LLd0uOCfXJOtxLiXUIIicTRhxcK1Z1rkK+EW
   YWGBkyLmw1L/WEoIGpvo8fu7hvMknOVDxK4EdlTrym6qk3z2g3LhbJcnB
   A==;
X-CSE-ConnectionGUID: kHS5grcdRTyqVywSP0GdSA==
X-CSE-MsgGUID: jEPps5fqSD6SFw0TUInqVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="112817786"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="112817786"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:07:36 -0700
X-CSE-ConnectionGUID: nRLLGqwuQmWjd7ihmeTVmQ==
X-CSE-MsgGUID: HCHhpEw+RWWOse7spjI9bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="262412418"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:07:32 -0700
Date: Fri, 14 Aug 2026 11:07:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] iio: accel: mma8452: Reuse existing dev pointer
 in mma8452_probe()
Message-ID: <an7MwteTa-b5x_mE@ashevche-desk.local>
References: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
 <20260812-mma8452-open-drain-v4-6-bfca15d02b59@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-mma8452-open-drain-v4-6-bfca15d02b59@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 04:30:37PM +0200, Esben Haabendal wrote:
> In commit 32a5c04d4575 ("iio: accel: mma8452: Use dev_err_probe()") the
> struct device * pointer was assigned to local variable dev, so we can just
> as well reuse that throughout the function for sligthly more readable code.

...

> -		return dev_err_probe(&client->dev, -ENODEV,
> +		return dev_err_probe(dev, -ENODEV,
>  				     "unknown device model\n");

		return dev_err_probe(dev, -ENODEV, "unknown device model\n");

Now a single line.

-- 
With Best Regards,
Andy Shevchenko


