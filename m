Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356BE43DA26;
	Tue,  8 Sep 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863796; cv=none; b=Xpr6QjFFnScpFJUXzX6x0juGLohRMfgkkB7O56vQSDrgZQikyp2yrAdOU32kJ8EScx/qWZvKGhzWlLshkS3JOYHQaB2i4uXEXOW83csBXUKOBrC0NF7I7rP2wTRgwlXym+QeZGGbyFiNOGV38+BBFRqtYsmQ+h4QGNWrl7fjBho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863796; c=relaxed/simple;
	bh=PxI5zvn+71UM5Yd+E1ab+n7WXUOO9kjov2qj2+d4q7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrpEF8V/Pt97sKAnMQWJ2DWc3ngaHggQUy6Bqv+FZieWXvFWtEBrei4OuVyqEexCPpiXi8jR33C6ChjOfo99oNaUwIJz/RCHRBYR2yCDw5i30xCz5BdmDVmFy5zNewVGFzNuRLhaw5UNy4WdYipaoeP4mti9QFsHdrUCzLSMuHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oyno4xHW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oyno4xHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788863794; x=1820399794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PxI5zvn+71UM5Yd+E1ab+n7WXUOO9kjov2qj2+d4q7U=;
  b=Oyno4xHW3aQSncldFXVD75JOQnKv5Nfwnw5TJQcpYyzNWwvkgWvDKx9l
   /qp78O486mtpEHks3HSAzwvjtkuaykvc6gaJIPpuM6fTi7zf44xtg/0pk
   qUpcnlP5eDz6XMvHX9eZYlSSD/cGTEQ9gfF7aHkKJtZ9MO1g23GU8UL37
   aLOrxDWH9IFGfhMwPIn3geRTIxMeRjgAsn8UUK5jZ5M5csUWfRu8Kzr+M
   gkPMiinsIufMDL82uYDor8FKphrNfQywlZslWDAoMkXSukntS68JdTRKH
   a7p7jgzHkbRUblxVtWGpLoW9au7bBwCiImoIBKF2vB6BQuUkjQ++RWdxD
   g==;
X-CSE-ConnectionGUID: Hs8pof4yShWQZYaRav9b9Q==
X-CSE-MsgGUID: ycQUOSRgQVWrPbBB5B5CEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="93126163"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="93126163"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:36:34 -0700
X-CSE-ConnectionGUID: TuvDnmkVSr+FB6eKcdh/cA==
X-CSE-MsgGUID: 0Nd3SmNYSrGBwMdfU4ycZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="275090326"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:36:31 -0700
Date: Tue, 8 Sep 2026 13:36:27 +0300
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
	Christoph Muellner <christoph.muellner@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/9] iio: accel: mma8452: Add comment block for struct
 mma8452_data
Message-ID: <ap_lK_0HR6BotZrG@ashevche-desk.local>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
 <20260907-mma8452-open-drain-v8-6-c17407e22118@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-mma8452-open-drain-v8-6-c17407e22118@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 07, 2026 at 04:51:01PM +0200, Esben Haabendal wrote:
> The struct mma8452_data is central for this driver, and it makes sense to
> have a description of the fields in it to make it easier to work with the
> driver.

...

> +/**
> + * struct mma8452_data - IIO device private data structure
> + * @client:			the I2C client object
> + * @lock:			mutex for synchronziation of register
> + *				read-modify-write and holding chip in STANDBY
> + *				mode while writing to registers
> + * @orientation:		mounting matrix, flipped axis etc
> + * @chip_info:			chip specific data
> + * @vdd_reg:			reference to VDD regulator
> + * @vddio_reg:			reference to VDDIO regulator
> + * @buffer:			triggered buffer
> + * @sleep_val:			time in ms to sleep while waiting for drdy
> + * @ctrl_reg1:			CTRL_REG1 register shadow value
> + * @data_cfg:			DATA_CFG register shadow value
> + * @open_drain:			true for irq pin in open-drain mode
> + */

Have you tried to generate *.html and *.pdf out of this? Does rendering look
okay in both cases?

-- 
With Best Regards,
Andy Shevchenko


