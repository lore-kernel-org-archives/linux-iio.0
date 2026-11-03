Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699736;
	b=rmIArrVUjSlmjbWutXiA+Glktn5l4r4X9D6diyoPD/WKojjBihd6D+JDBMqjA5z+tSis
	 remZQEIeMFQ3qplZpfO8EnjexjVvGSwAL0qAn+vKMxb3FfO6axXDFzUqM8xdzzuYQk0mp
	 OSDIfJZCOl7XcbarAMtoDBQ9sB6eF9hs6Qvqo/TBqlgF0j1vo/qykL/aGsIqzAUQ/0TQI
	 k0MObvw2Kpy9mGFSUGTNM9YBkDuo/CRfIeQ3yuMPGvQIkt7ULeDU7QocX08i9q8PNEeXr
	 L7v/CbwZ4OZxUlmjg4Ap4cexPAc8wNO8nLKBkVdi9ZBMlplWZIiCVikNMiIPXluAb/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699736;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=BeQGUCOl1k+ajaLkli3SGFUKxG/MbdebyYfebJs1qjY=;
	b=32cG/VyanLqV0WiCdGR2STENJo/LqmR+wq5bmVBdO9K9bhKLDF0owUQdM2xfIVTn+9C7
	 w45JV83hiejtMkr5WydX8I+fUod3k/+mDViS+aLPXHy4G3U7+PBzL4SyYB+W52e159AzW
	 pM+j5VXfcs9g24cLAlryMj01iqZc+UcO2M3lVz/wZ0H88Eyb/Gc/u7YfUVO78kTpopGPn
	 7/m/wbqu8Cy5IY3uwJ81palSc1VyDBK4QGvo1ki5NjpbX7PbGc27fCSG9A+xPmJJHlueA
	 M4wg4vCgfj1SEhF3g+buO/xT0JqWYbK45/O3xrjDH3R0A13PUIO/qN0Z+Ad85Ws84/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="lB/78FF9";
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80CD60A6F6C;
	Tue,  3 Nov 2026 09:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E80CD60A6F6C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lB/78FF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793699735; x=1825235735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0UZauren3FKcX2qFQSrZTnrqyYVdkjbCTu/nrHaJWM4=;
  b=lB/78FF9SfGF3XuUMS4v3Taq1uW+GjkRtqt+rIEzLAMw6p/G49Oy9HgK
   MN6EDznTCZwhdlXRuqF1d2jcWLPiSTa9aw50Cd2GeoB4jJSdCm7bMHi/d
   AJ3WEqHBSks+wy7ICd9l1btwGbYAVH7W+4izl9orK1DOwc/u7TognEFiQ
   cZXDwx1tNxi+bv5uc/afwOzQyc9yi+nBxF3WZVpG2+d4MWj3U5BDtcgC8
   6/4UHH8ocIaCPBwAddPQFu8pTIAYjRa8qQ5zLYeEVzHOQcNKVW2+1uXWO
   Qu2JC8/2+3VzyCZlzguaZkZmPvkv7+AQfwe7E9COwPrGqqOnzlzJyXMmi
   Q==;
X-CSE-ConnectionGUID: nGplRYa2RfSa4ZSX8AU5DA==
X-CSE-MsgGUID: p//tAmR7RuaM9mEX+bPZeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2306693"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2306693"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 01:55:35 -0800
X-CSE-ConnectionGUID: c9SjTP9tRECL/nhQYcKZXw==
X-CSE-MsgGUID: U4AhdxKWR/+2AadWm0Giyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8223937"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 01:55:32 -0800
Date: Tue, 3 Nov 2026 11:55:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] staging: iio: addac: adt7316: replace kernel.h
 with explicit headers
Message-ID: <aumvkSfdGIoJHtmn@ashevche-desk.local>
References: <20261102094236.57757-1-abdelnasserhussein11@gmail.com>
 <20261102094236.57757-3-abdelnasserhussein11@gmail.com>
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
In-Reply-To: <20261102094236.57757-3-abdelnasserhussein11@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 11:42:36AM +0200, Abdelnasser Hussein wrote:
> Drop the proxy header <linux/kernel.h> and replace it with direct
> inclusions per the Include What You Use (IWYU) principle. Also remove
> unused headers and keep the list alphabetically sorted.

> Explicitly add:
> - <linux/bits.h> for BIT()
> - <linux/err.h> for IS_ERR() and PTR_ERR()
> - <linux/errno.h> for error codes (-EIO, -EPERM, -EINVAL, -ENOMEM,
>   -ENODEV)
> - <linux/kstrtox.h> for kstrtou8(), kstrtou16(), and kstrtoint()
> - <linux/pm.h> for EXPORT_GPL_SIMPLE_DEV_PM_OPS()
> - <linux/string.h> for memcmp()
> - <linux/types.h> for fixed-width and standard types (u8, u16, bool, s64)
> 
> Drop unused headers:
> - <linux/i2c.h> (no I2C symbols used in core driver)
> - <linux/kernel.h> (proxy header)
> - <linux/list.h> (no linked list symbols used)
> - <linux/rtc.h> (no RTC symbols used)
> - <linux/slab.h> (no kmalloc/kfree symbols used)
> - <linux/workqueue.h> (no workqueue symbols used)

This is too much for this type of change. Please, move it to the changelog and
comment block (after '---' line).

> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>

-- 
With Best Regards,
Andy Shevchenko


