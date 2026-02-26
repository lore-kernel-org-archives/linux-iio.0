Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8C43D502;
	Thu, 26 Feb 2026 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121490; cv=none; b=Q6V5Eu4IPFcz0qqiy1wqJEZHzSfzJucpqraCwCYcnxrXaYoNO3p08TDrT60jBLj/wmsBnbTwPYPwy8vkB9qiJp+v2atVMjEGQjE+86Di02Q3pIxSvuJBTUyd+K66ZTFLjgSp32N7pskOCkxQBgsObObX/DW/obWlggoTiUKlwic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121490; c=relaxed/simple;
	bh=qTnEEXj9o+gw+ilRwY26kk7Wl+97u3gZBmJy04dNsMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jc/B8OOqX7Y15+14nMCDNin0LieVkz2oqoUr6eDgL07yOrI2FzRKE7jfvM5BqbdXd7M0GCd4h14SNT2Vvs6vmAHS2TkdUqn+uqTCA5LuknBi8TvkiRnBJXvev9CVR/3iQyw8x676yzHwyuTXJ/u5ZYQnHsZwx114sGYlb/NUtMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsrPOPUl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsrPOPUl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772121479; x=1803657479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qTnEEXj9o+gw+ilRwY26kk7Wl+97u3gZBmJy04dNsMo=;
  b=UsrPOPUlGOptrY9kBT4CBqJczhTdKxvXRG+B3fvHlyCp8wDgD64MQXv2
   GX/IA2Q7wxi/oGlvfZ67Xe5k09puR3Z5vHgZ1YoL+Pmr2lkt2TRAH3P0v
   JfzR78kHjaULtyEsazq3HiWBgR3+pR/ld96uCuZSW9LHMWGfGHf1lxj2O
   zH0If0BEGTErd3PqcnePwUTIeSrl5veNQCKh/1VzN9/w4kO79a1tcxK4J
   tJ7dy5IKoaaTUahhMqp96mdlnbropOTy6r85Kp6NuQDPThUxtRfxU5V/W
   3d7QcmMvUvd/LKrfpso9iuSWdt0xU+5QxPVM9cJFt9pIv9k8HksgXAL5V
   w==;
X-CSE-ConnectionGUID: j7UNamJlTL2taBBJqSmr8w==
X-CSE-MsgGUID: VcHUZnWJSl2faqqnjjgHFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73254491"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="73254491"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 07:57:58 -0800
X-CSE-ConnectionGUID: 05oGDFgbR82xiIj/lntWHQ==
X-CSE-MsgGUID: KOVgKt/wQcWHZl+rOiuvhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="216732225"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 07:57:56 -0800
Date: Thu, 26 Feb 2026 17:57:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] iio: ABI: Add custom data type
Message-ID: <aaBtgQsU0MP8WV_q@smile.fi.intel.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
 <20260225101806.2368391-1-flavra@baylibre.com>
 <aZ7gdO58NV6gjgWC@smile.fi.intel.com>
 <eeb28077-0886-42b4-b468-21f5c6a6444a@baylibre.com>
 <aaAQtJ5WTDtkxi08@smile.fi.intel.com>
 <f637d8075569613f97fbe7ff6219e6adde53646d.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f637d8075569613f97fbe7ff6219e6adde53646d.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 26, 2026 at 04:30:27PM +0100, Francesco Lavra wrote:
> On Thu, 2026-02-26 at 11:21 +0200, Andy Shevchenko wrote:
> > On Wed, Feb 25, 2026 at 03:27:55PM -0600, David Lechner wrote:

...

> > Not sure about the latter, but something explicit like
> > IIO_MOD_PARTIAL_QUATERNION sounds good to me.
> 
> Another option could be having a custom iio_modifier instead of a custom
> iio_chan_type. I think this would address the concern of drivers being just
> a proxy between hardware and userspace. A custom modifier would be used
> when the data representation for a given channel is too exotic to warrant a
> generic iio_modifier enum value (but would still need to be documented so
> that userspace can make use of it).
> I can imagine a generic userspace application that interfaces with (in this
> case) rotation sensors (i.e. looks for IIO_ROT channels) and can support
> not only "standard" rotation data types (yaw, pitch, roll, quaternion, etc)
> but also "manufacturer-specific" types.

And I am against this. It will provoke a vendor to escape the standards,
common libraries and other tools. If we need something which is too exotic,
the driver should convert it to the standard one. This way we will support
HW and won't require or allow some dirty tricks based on vendor-locked
approaches.

I'm talking from the experience on what vendors are doing or want to do
IRL in other areas. One of the infamous example, is Broadcom Bluetooth
used back in Nokia phones, the so called "driver" is useless completely
in the kernel as it's just a proxy for the HW <--> userspace link.

TL;DR: I'm in favour for anything that does not touch user space at all,
or has explicit meanings. NAK for CUSTOM, manufactirer-specific, et cetera
from me is warranted.

> We could even think about allowing more than one custom modifier (e.g.
> everything >= IIO_MOD_CUSTOM is a custom modifier) so that a sensor can
> have its "manufacturer-specific" data in multiple separate channels; and of
> course each such custom modifier would have to be described in a per-driver
> doc.

-- 
With Best Regards,
Andy Shevchenko


