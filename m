Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826398;
	b=xFu49GAAfF9OM8/07ReDdJ1oXmJrg0JdmupzYIb63uBlVIdT6NjBqcNt1nBwYzwhqnBG
	 RtLO9dYE4zcPfSE5CHalKcsB6omdZtlP/ut2HcAzbRnAQ3WMVF8VqggdS+eSDbwdu4rry
	 NPlbdk27y0ty1MxsQZbA202vhU89LzkPg6SBkK69nh682P2rYuF7j6lG7WtssePyQ+yi0
	 dNX3fu/30h995g6oXAwrJM/QK19twMXz61xp/nMdUFaNsD+03WZjElR1xtCJND4yKbaEa
	 2KnOasjN4w403e6m68nAWkwRCNES7CbcFN9dq0wyRijPmwr9dcI5E6Un5Zyglaof1bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826398;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=8JNO3jIP8ubuMUWYxInJDGmVrvGcsBEC3HKKFdaVcMs=;
	b=VL30cA3Rjcban1Z9unLZsY2jt+IkZaNPC2A7NllTNK3PKFl9oIGq38Ef+MBYlLpTQ0+l
	 0vR2CJgTSdeyyFzB5V5uWw7Z+Af0LGnh5tltAItIWwovr1M3lc8tU5oIbXRhZZEm0QTYH
	 80yB6o2fCKDduz4mUGUe4OD07H8xtvGD6Q6k79JGqmnzrgxGeExs5aODH3rdShDgoD+Cs
	 WZbavPKqHl2Tb7nDSNizRym3suJ/kF488ZlGyY+h1Twzkioagh0sbz7dExUhhBoJNcmXP
	 PUnTyFdKt4he/ZzBSAF9pE2ijPeYL9vaV4cmOgq/mZudev7ESZ4l0r0uMYl1thrBiMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EgXsrd0O;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE0606A338;
	Mon, 16 Nov 2026 10:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33EE0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EgXsrd0O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794826399; x=1826362399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=elMYf75p47axVkuHQr1fRg10imF3Fueinq9fdu1mc78=;
  b=EgXsrd0O3ggm1vAkK/abOg6govcbcNUHdSk+Li0/JW784eljta+hOVcv
   UzQoZP+9864M+bB7WIHUeHkj2DmtVXaPbP4ikcanwWT2mytW/xdEyU6bh
   yKMdKeem0DhmCLcCFIjb+HmTo47XLzEqX/FwX6KpN2tbpad4z/sI5R/HX
   /4VhEVB4AwRv/7DqzfS/q6MW8Nnp9Ua+sgqOJff6UiICuM6TOxj8b1hJS
   5BkpPGcm2PEnDt4AeZcE/nPZxSlcun1LCL3eZkpyfsJ/6H5ddp0bIoqTL
   gh44RU/iXnjXi4JhEhRPbq2/mcNN8IRqrUU6lPV50WakusZmuNKLhh/vk
   g==;
X-CSE-ConnectionGUID: JU0Me+cdTDqGKdCQGgLgtA==
X-CSE-MsgGUID: 7v6uT3MKSf+8aavIvYwryA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3546162"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3546162"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 02:53:18 -0800
X-CSE-ConnectionGUID: 80Oi81awQ/WfXfRCSSBQEg==
X-CSE-MsgGUID: U8+P76kGQGO3qpIEOOZsdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9356809"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 02:53:15 -0800
Date: Mon, 16 Nov 2026 12:53:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Adil =?iso-8859-1?Q?H=FCsrev?= Tepe <tadilhusrev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: proximity: add Imagis ISG5320A SAR sensor
 driver
Message-ID: <avrgmAFpY7hvuwNh@ashevche-desk.local>
References: <20261116074013.355363-1-tadilhusrev@gmail.com>
 <20261116074013.355363-3-tadilhusrev@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261116074013.355363-3-tadilhusrev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 10:40:13AM +0300, Adil Hüsrev Tepe wrote:
> Add an IIO driver for the Imagis ISG5320A capacitive SAR/grip sensor
> (I2C), as fitted on the Samsung Galaxy XCover5. It exposes one
> IIO_PROXIMITY channel (the B-channel signal minus its baseline) and a
> rising/falling threshold proximity event.
> 
> The driver was derived from the Samsung vendor driver during XCover5
> mainline bring-up with the help of an AI coding assistant (Claude Code,
> Anthropic), which drafted the mainline IIO driver; I reviewed every line
> and tested it on hardware.

...

> +config ISG5320A
> +	tristate "Imagis ISG5320A SAR proximity sensor"

Make sure this, top level comment and MODULE_DESCRIPTION() have the same or
quite similar text.


> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y here to build a driver for the Imagis ISG5320A capacitive
> +	  SAR/grip proximity sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called isg5320a.

...

> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>

> +#include <linux/kernel.h>

Definitely no.
Also, please follow IWYU principle.

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm_wakeup.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

...

Also, take in use *ACQUIRE*() macros, in particular for runtime PM where it
makes sense.

...

I stopped here. You can now go via mailing list archive (linux-iio@) and check
what are the usual comments against new drier. You have many small things to
improve, I believe.

-- 
With Best Regards,
Andy Shevchenko


