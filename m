Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239F73B7760;
	Tue, 14 Apr 2026 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160059; cv=none; b=XQ2bpdPwM/qlrQTJAsRljyGsO2uqJ3LVqmh4/eNfNE0Pl+f+/49xzbv5FeQHFZ2CLCaZjF+dEme7/laUF8qEVE3YPW0ewhRCcmNBSQfmDI1i9iQigXk1ESjo7+h8V+MfisPy8DU6ZZ5wFCdHRcPbBWIffoFFb+ISY1PwYpTtlrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160059; c=relaxed/simple;
	bh=S6nCurOQ/aSSm/hzQvBR3TEYFOv+6J6EAIHgqFXPsSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsS6/skWWwqV85toOkz2zW5sgomrzYZ9mLeyFjz9ssI8yeT65fjulbMh12JP77rcAJpLT6TenEqRlyV1vEgS4DFaAuO0t9oyDO7LdjjCqNHcVjG+7X4XIVug9wJw/DUTVZksbUgbGLnTGIIU7ZK3MeNdmxIy2G2ADgRItFs7Uvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNq92tv6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNq92tv6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776160058; x=1807696058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S6nCurOQ/aSSm/hzQvBR3TEYFOv+6J6EAIHgqFXPsSg=;
  b=WNq92tv6MuERfasmw0TRy+veoa4ZvwLTzEwsnusU0hW1u5qURtHQysjH
   evGeDq48FrE1ww4WBWDoNchvLK04Px1LbfS3zOB1NsliJDYNO1hJ4xpJT
   t7qMndcrk8n5GLPK5gxgXIgMS16FMLuwrBtT8k/0Lbiqo8kTVYtVn9pQf
   sWDIi6k25/v/tHTUXJF4etlDhi3iC2sFLy1ZCtWZK2ZtIdp4//kmGtzIZ
   YaGeH4YvkHfJ+ktOn2sEOM5OzXnKYXSTkYRQFDQqgGD3xtFIuORd/8Ie1
   bFdLVgB08IL6O2J7WScGfM2SeRTFBqERRFJl9G0qWggt5UVBR5XaQPEkA
   g==;
X-CSE-ConnectionGUID: zFwZa4PuSSavBlpfJZ7x9Q==
X-CSE-MsgGUID: TqSrfwwvTU6m3ITF5i8a5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="80975304"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="80975304"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:47:38 -0700
X-CSE-ConnectionGUID: JnsxHiXhStm4l/sMUbWCJw==
X-CSE-MsgGUID: pQLRpibpRkSY/uG2O+TQrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229983802"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:47:35 -0700
Date: Tue, 14 Apr 2026 12:47:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: frequency: ad9834: clean up includes
Message-ID: <ad4NNMV2uqUXjfJY@ashevche-desk.local>
References: <20260414091250.1295-1-joshua.crofts1@gmail.com>
 <20260414091250.1295-2-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414091250.1295-2-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 09:12:48AM +0000, Joshua Crofts wrote:
> Clean up includes by removing proxy kernel.h header,
> add bitops.h header and order includes for better
> readability.

...

> +#include <asm/div64.h>

This should go after generic linux/*. In other words, it was originally placed
correctly.

> +#include <linux/bitops.h>
>  #include <linux/clk.h>
> -#include <linux/interrupt.h>
> -#include <linux/workqueue.h>

>  #include <linux/device.h>

Also check for usage of this one.

> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/list.h>
> -#include <linux/spi/spi.h>
> -#include <linux/regulator/consumer.h>
>  #include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
> -#include <asm/div64.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +#include <linux/workqueue.h>

-- 
With Best Regards,
Andy Shevchenko


