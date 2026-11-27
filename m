Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800167;
	b=fPOdtfYA1ZcyzwguP9clPkoNI3MME8b9//43iI1OgmxkeNXKFUN9jxjAvCS3e2T+UDxE
	 BHn2Jn+zzPTcfch8NmUztG1bsamGe/1UOSYprMVClFgvBqpFyxakX30dogcN5jCwHvYfE
	 k8mgWbsCgnyzbxD1lM693FVurBG1vjMCphbQDg9SQClxgPra7EyjSwOo5PyuoQX2/vG78
	 BGHN8qKAAQWuKCBHa5bix21zciC0Nd9F/EqAOY8eUz5FHLhLzAmjLz9S7eZo2+0tPsQKW
	 c77cPl7k7lezLrA/yhV13L/P7MZIdsXLECnbltyUze3qmuStjIk/BuuDS+hm3WB/lig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800167;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ZB0huookkqFtU8IQ9OvFbub1IK3hO3sjsIWoGRsm90Q=;
	b=pX1p4wzELtooQI383sndBXf+kAMQAwi0UgD89mwMnpgZVIE0k1hBZdT2U4fpksDySUQX
	 7IS/NgVlCxyfq22vBbjhW1GmlElqsQ5FhVITIS8PGGrHggjbcznnxhuwY0zraXcS2rL9w
	 QcRa8HyLFdfWY+K7veFbvT22uUyiaRJqQsS2qN9GfPF7lSoSKqY1EefLRPnmJSkuPMuRL
	 E+Y5suoMwBIa9veVsu2Wse5Qrkm9RSyuH3puj5rRL+vbkt5eBcxN9CyG3TnBk94ZdyzLx
	 BPg3fFh0gen65xAK+A75VX09hPdp8hj3AlvUji6Vs4/KyTXhq3ro4xQeeqJBfjn3giQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mdYKzgvd;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14B606A31C;
	Fri, 27 Nov 2026 17:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A14B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mdYKzgvd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795800167; x=1827336167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fp++l3/CeK8tHihrxjxNvBJ+hbolrjiQB0GXCwSoWsk=;
  b=mdYKzgvdcYXGgDhSkSfgWLQO8QDaJeDvWlUz6vZYUXwLLZDaQ9YJvwai
   x3JrPvsShFnfaynRZ8+l0d5b8bBzjj2r4nh+61bmcgo1jn0MnaUacVMwY
   YzD9VMNV2g0TZVOyfNbRRfSMRb3HAVdSSH3WJhyGwagtLuaJseKWGAW5B
   quFWkSiv34r9kJ9DOn9aqk3ux4QLuKwb2CYJf4a5CnAXVpExkv7l1xorZ
   OTymV61vsNxRPPWL2LW5DgQnI4xsVqQGxEJOei81yDUrhHGejo1cpP4U+
   BwTaIXnMQfv6avzaucksaJ6DbLIRe3LSWMlCsIfp7REQNeE7WaywNqjZC
   g==;
X-CSE-ConnectionGUID: d93ZPvh2SkC9FmxJAYZNSA==
X-CSE-MsgGUID: fJ5kZI3zTpqVgAi13xxAUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4605734"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4605734"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 09:22:46 -0800
X-CSE-ConnectionGUID: mgppOoc+RrajNJugDABCVQ==
X-CSE-MsgGUID: nuPNAO8JSQ6va+BQYvWPlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="12223397"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 09:22:44 -0800
Date: Fri, 27 Nov 2026 19:22:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: iasnezhkov@gmail.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Arnav Kapoor <kapoorarnav43@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: inkern: guard fwnode_xlate with info_exist_lock
Message-ID: <awm8YUHxLFda3jbv@ashevche-desk.local>
References: <20261127031038.12685-1-iasnezhkov@gmail.com>
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
In-Reply-To: <20261127031038.12685-1-iasnezhkov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 03:10:38AM +0000, Ilia Snezhkov via B4 Relay wrote:
> 
> __fwnode_iio_channel_get() dereferences indio_dev->info->fwnode_xlate
> and invokes it without holding info_exist_lock. Concurrent
> iio_device_unregister() clears indio_dev->info under info_exist_lock,
> allowing a NULL dereference or callback execution during provider
> teardown.
> 
> Hold iio_dev_opaque->info_exist_lock with scoped_guard(mutex, ...)
> matching the rest of inkern.c, and return -EPROBE_DEFER if
> indio_dev->info is NULL. Since iio_device_unregister() calls
> cdev_device_del() before clearing indio_dev->info, seeing a NULL info
> pointer corresponds to racing right before device removal from
> iio_bus_type, where !idev already returns -EPROBE_DEFER. Using
> -EPROBE_DEFER also avoids colliding with the -ENODEV sentinel used by
> callers to continue parent or map-list lookups and avoids the named
> lookup -EINVAL fallback in __fwnode_iio_channel_get_by_name().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


