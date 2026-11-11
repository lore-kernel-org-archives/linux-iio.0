Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408738;
	b=nfOwovtXj7M79h4XMJfSdShezLgDzULUFcpZe80vvZLtk/pmFUQc7HYCWP/fv+c6xIvm
	 46dQ8UN4iL6IYAb9b8A2IcVSap2JKeEzk1XH4FvgmuaBVbK1N5/Y7t2m9gpsNR7NJ+Dk0
	 QOy8qQhq4VOEokJJlXlEsRcd2aSKPFacxhbKg2NpGHA8LClxvxli2fgTyaEe9hp320pwc
	 c2m0fFht6DxT5miq0MwHLwKDq9cGmRzJ3KKU/u1yv8GciiSpKD4vZCykrsAzZnqyIeJ8L
	 b/JoIg6dMrCAOzNigOVgrh9Y275s0lvOI/0YiBWipI2cOfIR1uO/0ow3Z72yPvwo+fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408738;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=nqADIuqNRZYw22r3brfxdIuwm4yg8ujKJyQiZmJj16g=;
	b=0CfaVd2Z2qJTPXiPKmWV3NU307VYfgo433E+Th2ljU3pVLyoKot4zjzzU6oSdLbfWX37
	 k8fwFdDfQ/ZsPQwcQ9ieknqizq9xLq53B6q4zaKkB2UeF9gjJkulUgeTWkaF75CGa/20f
	 S21HPQ5MjTANQYsbP0w3g8w2Zdd+n3vXj+pHIT+TpBBL1Cb+/AL2k9w5EXnNFrBgezWkq
	 kKkNOQtI8iS5poxfqQSBdat9D9BvitkGM4SRnxjXxg/nvadxkpFNCJqnDchwzJl6Fx04I
	 dfXPBZI6kQr9699U/XNrOLc/F01yr9iyiccfq2Pf9PvHm3rLp60f77AiLN67nNGfCKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NZNrhOpT;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B75606A321;
	Wed, 11 Nov 2026 14:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1B75606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NZNrhOpT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794408738; x=1825944738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ySmNsOxrDF0qaiQC6eG8qJaMbFlU1iXQ9aExxxEwh5I=;
  b=NZNrhOpTLSQVArAh2VJJFx6+j6irYSuvapKcg5vVLkVgp9u5n6ze9xSm
   SF1zuSjDpcdbzDgDPXMdZM/PIqXx0g9MS1FPrZaN2bTuhNAB3Eb+4jC/D
   tWWlZvQVbn0dsEH93bVsWqsxiqIq1wlaQ8mAX95/lxxs7Q6wx/jlhh7KS
   XnQme0fASsoksaOb4mNUS0/f1YiBOx1TaVW8IKjJCb2EmK1v7KkV9bRsI
   BtE85HeMV9hlb3cse0TFl4yl54e4bob/L59QtmDsar2ZA6y1R75we2wmb
   RhuKW5679H+mvbN/UhDMsPGU6kbzRiQo5eeSvTru/F6nBluWCBhR2Cxu8
   Q==;
X-CSE-ConnectionGUID: F0HlPxKVSS25WSOEvPaf+Q==
X-CSE-MsgGUID: e73WqCnQR56fyFITegn0Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3052733"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3052733"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:52:17 -0800
X-CSE-ConnectionGUID: KUXWktTdTyG694MZ2rQ/TA==
X-CSE-MsgGUID: XK4ue71IS6q1bQw2hhjAzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8594246"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:52:15 -0800
Date: Wed, 11 Nov 2026 16:52:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <avSBHTY3XJi7iV0a@ashevche-desk.local>
References: <MW2PR12MB25231C3FE75A17CEDACDB279A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
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
In-Reply-To: <MW2PR12MB25231C3FE75A17CEDACDB279A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 11, 2026 at 08:23:53AM -0600, Victor Chernyakin wrote:
> This series adds support for the FDC1004 4-channel I2C capacitive sensor.
> This sensor can report single-ended measurements of any one of its
> channels, as well as differential measurements between any pair
> of them. It has a measurement range of +-15 pF and a resolution of 0.5 fF.
> 
> Patch 1 prepares iio_format_value to handle IIO_VAL_DECIMAL64_* formats
> introduced in Patch 2.
> Patch 2 adds higher-precision IIO_VAL_DECIMAL64_* formats, used
> in the driver.
> Patch 3 adds the devicetree bindings.
> Patch 4 adds the driver itself.
> 
> Tested with the sensor connected over an i2c-tiny-usb adapter.

> ---
> Changes in v9:
> - Patch 4
>   - Added comment explaining why we set use_single_read = true
> 
> - Link to v8: https://lore.kernel.org/SN1PR12MB2528F139EE6C0B4576C3A0CCA5722@SN1PR12MB2528.namprd12.prod.outlook.com

I think I gave a tag, why it's not here, please?

-- 
With Best Regards,
Andy Shevchenko


