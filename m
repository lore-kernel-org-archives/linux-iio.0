Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B73033CB;
	Mon, 17 Aug 2026 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951154; cv=none; b=ZUFRkgjjgmWlqsJz/F4lu2IhGggow17V3c0cBxB3M3f0eu+DO/x3exfc92c2T+TOgHLEswbEgXlux2aD3aR98mzvsxtkmc+kTFUl+ifmvSZeQsIV2qPyqeZctKcByj1IVTViITfBM28Pe03Vqoj3BPIQXsL6dcjqemf0eIeCQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951154; c=relaxed/simple;
	bh=H53IYagsW1JiGAPp1YwqOhPt7vIgkoByM2qt5pPHxNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5078j6rpYPWQ43LYodgal/jAtPzBEeL4OjoDgN6No0zVRC98SEMTAtNzhpvZYZ5DCVuUlvi06lgJrPatLV6duDoV1z28fO1758cluNsoSRCg82/vuLj8UWvX7NM+5FRzMT4s/uAUvZw39jAvts3sFEaDr5qOHUmhR3Z0nI7KuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7SBn+ED; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7SBn+ED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786951152; x=1818487152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H53IYagsW1JiGAPp1YwqOhPt7vIgkoByM2qt5pPHxNc=;
  b=L7SBn+ED1CHfnJB0xPczNtS1BiW+DKmL2mz3Lz28Z8ymGF/t5dSStQSp
   dviRn25fJyqSKMqjs178oYvgM2eKugdJ6L2N1wN98hIV16pmWZCIHBjaw
   18aGNnkeQyN0fH0CNmpr+OFFRU+FMEMFKyorS50Ejfwjd6UMYoPpQWfIn
   wLVTYM5qbT74ukK0dfDiJOpjnevI/JVHjlfWA3++rD9t4VKdJt6sinFDH
   RYvoEzrz6mW2a6Hbza//keCCYuzXJTE6v8sBTL/Dc+dFaQLw+PYakYMOP
   G9b/4daZ6refOYR0d5Ac1iyfU2W8nxXJOJvBjdrV+eca8Z+s2MiPnO5Pw
   g==;
X-CSE-ConnectionGUID: edeKfqMuTj6ipSNlBeKXOQ==
X-CSE-MsgGUID: CmW6a00VQ32LacT4FxxKEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87295145"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87295145"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:19:11 -0700
X-CSE-ConnectionGUID: /6whaVBTSvurqf0x8Pz5LA==
X-CSE-MsgGUID: 73lYhhDXQaOrcRZGIzNTow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="263070028"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:19:07 -0700
Date: Mon, 17 Aug 2026 10:19:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Grimler <henrik.grimler@axis.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2 0/3] Add driver for Invensense ICM42370P accelerometer
Message-ID: <aoK16fva9ps8XNwb@ashevche-desk.local>
References: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 02:26:09PM +0200, Kanak Shilledar wrote:
> Invensense ICM42370P is a high performance MEMS MotionTracking 3-axis
> accelerometer. It supports I2C, I3C and SPI protocols. It has a 2.25kB
> FIFO and two programmable interrupts with support for ultra-low-power
> wake-on-motion support. It has a built-in temperature sensor. This
> patch series adds basic support for the sensor with functionality of
> performing raw reads and writes along with buffered reads via the I2C
> interface.
> 
> This device contains 4 register banks for configuring the device called
> MREG0, MREG1, MREG2 and MREG3. Unlike other devices from the same
> vendor, this contains a very different way of accessing the register
> banks apart from the default user bank 0 (MREG0). The register bank access
> procedure is mentioned in the datasheet [1] Section 13. Due to this
> specific reason and that it doesn't have a gyro sensor, it is implemented
> as a standalone driver.
> 
> This device has 3 formats for the FIFO structure (datasheet [1] Section
> 6), currently only FIFO packet format 1 is supported, others
> formats can be added as part of future work.
> 
> The device supports EDGE and LEVEL triggered interrupts, refer the dt-binding
> for example of how the devicetree should be setup.
> 
> The driver is inspired from iio/imu/inv_icm42600.
> 
> Thanks to the reviewers for all the time you spent going through the
> code and the comments. The changes for v2 are quite a lot and I hope
> that every important change is documented in the changelog. After
> implementing the suggested changes, the driver is in a far better state
> than v1.

> [1] https://uat.invensense.com/en-us/products/3-axis/icm-42370-p

Can be added as a Datasheet tag here (and be spread by `b4` to all patches in
the series, which I think is fine).

Can you split the first patch to be based on the features implemented?
Something like

- patch 0: DT binding
- patch 1: very basic (but working) driver
- patch 2...n: Features 1...(n-1)

-- 
With Best Regards,
Andy Shevchenko


