Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF3443C03;
	Fri,  2 Oct 2026 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937524; cv=none; b=FuOTOzp7MQmQeR+rywfYuju1tygmnLOJft3OiDXUxpqwWbThtcfwApjQ8ZZB3ORODpf3yxK7oomDNct/4VzPMbuxsOqwKWuquGCUl/RrtLC6i02HKqeYEfTaYkmQMBL9gX359CvsgWi8GrvxZZ1g/4A34LqfjqZLj/qSVYdeawM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937524; c=relaxed/simple;
	bh=I4Qxx5a6YA40o5Fjk2dWdK7ufH/s9Rp369XFg23yXqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLd9eFLWVrVIdhtSG+qCTNztcttUo3jpYnxCXleC4mIYTd/53IR425Bwu7aSV+yrm+QYWXUYMKVV5zshihpEi68OE0uhf1QDhcOPV6NRKmVm2GV+REsalSUp7/MmfOGPVh75qDkueIwpjuczmCY2OkwWK1erOM2kuWXiEHfWdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiK9FQpD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiK9FQpD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790937522; x=1822473522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I4Qxx5a6YA40o5Fjk2dWdK7ufH/s9Rp369XFg23yXqo=;
  b=NiK9FQpD0AiW+GKKOhUPvMDRm+NWFI/kz6SFzydmFlT8U/lE2XZUJrMh
   1d2icKzVpaUNzrVbxrC90caQcd6MJjy9Lh3Km1oyeNNh97o+0o6bk91BE
   FDhOPu4pMJouUzdydbKqhjeXYry00vDaSvwKkVi8f2ZsGDy+3RsnZMT6i
   ElBfyYnwKZtmJA7n12b0jnCShXGtUY7dkN2HpY0Mrieod+fhxBY5RvMah
   XgqVnM6VFf8mnJY7uAfL6tFXOTZ9PSFGicwx39Uj04rOyM/63s4k24DIM
   WMR5v6+CxzqJRXGG4tYafBRxGOqoaBMR/SOgSZt5Lx4P/nYSJbAauvCpE
   g==;
X-CSE-ConnectionGUID: xzeOGfgsQR+y83uBVqCoJA==
X-CSE-MsgGUID: PQSrJTC7TXOBai/cFh0qoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94414593"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="94414593"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:38:41 -0700
X-CSE-ConnectionGUID: h4zMDUN7RsmpdfD8hw7QVQ==
X-CSE-MsgGUID: iNsYPq3mTJCLZdROIRS2/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="314213939"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:38:38 -0700
Date: Fri, 2 Oct 2026 13:38:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: Add driver for the ADI ADIS16607
Message-ID: <ar-JrLr-JHDAT9U9@ashevche-desk.local>
References: <20261001-adis16607-v1-0-9c89cee35d56@analog.com>
 <20261001-adis16607-v1-2-9c89cee35d56@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261001-adis16607-v1-2-9c89cee35d56@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 12:11:50PM +0300, Radu Sabau via B4 Relay wrote:

> The ADIS16607 is a Precision MEMS IMU from Analog Devices featuring
> triaxial gyroscope, triaxial accelerometer, delta angle, delta velocity,
> and temperature channels. The device communicates over SPI Half-Duplex,
> requiring custom read and write ops that differ from the standard ADIS
> library protocol.
> 
> Three variants are supported:
>   - ADIS16607-1: ±125°/s gyroscope range
>   - ADIS16607-2: ±450°/s gyroscope range
>   - ADIS16607-3: ±2000°/s gyroscope range
> 
> All variants share a ±40g accelerometer range and an 8 kHz internal
> clock.
> 
> Data is acquired via 32-bit burst reads over a single held-low CS
> transfer, providing 24-bit real resolution for all inertial channels.
> 
> Supported features:
>   - Hardware FIFO mode with configurable watermark threshold
>   - External clock with direct and scaled synchronization modes
>   - Calibration bias for gyroscope and accelerometer axes
>   - Configurable data-ready interrupt pin (DIO1-4)
>   - Optional hardware reset via GPIO
>   - Sensor self-test on probe
>   - Sampling frequency control via decimation rate register
>   - DebugFS entries for serial number, device ID, firmware and revision IDs

Good, now split this to be a series of 5, for example.

-- 
With Best Regards,
Andy Shevchenko


