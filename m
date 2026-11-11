Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408169;
	b=5aTOIq+BdSimelGkLw+iSdULN0JgabxmCY9O/+BgvoVkZtfG2RMmhysL1+dMhydkfX7G
	 gwRZfsOr6DP2uJuT96ixwMweUP59ZtIKX5KeEqee4pZ96dE4y5GpU0Fa6MuftGhSdaiba
	 XxIm4Y4CwLCXKvhYYsdpMVJpilaqFChRJg+U/sdAgINeZASODfMdpdQ0t8gHspAwK18mE
	 Pa1vvPlB3mDDnrS0IeeIu12HdtebMXXfXlY3Ok185rW1y2wMvDPxR+hnYj5/A0GJW2Jvq
	 lEG4UtSbY7+7dA9fK99q0mbDRU03d5mYhJOfw0FPC0owkfhbqoAgBhOqcCfW8jQLVjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408169;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6tjmltYVQMwKRzhKorT3QY4wRHxrjP68gO+DVLDAJDQ=;
	b=124GZQTh8JR4FKR9BFFVf0i1GQRKSmCQuRc4bKmLa9GFW5k03eym/TcjfA6tpF7g/aBc
	 iD6nB/1IZM0lOnrULIotxRK0JYrxdS5m2B2T9U+Zy+3OaEkDjs3RsQ9KqzdJU/9TPhSpA
	 cHip6vbg1NI/6yE1AiMrxM4MztNoPV41aumIf7JUzosN4GTygRtgJyXW4QBIrcEwuS/I8
	 qPMxj7UblDHhKML3XJKiAnnntPv9t2TdeAVvPCzF9kzTqGso1eXCQMy6Uxx8TxpwiRa9p
	 y+gbJAS0+ilhjeVOdW6PFI5cBDGjm8RTWISoR01wjzmGN1PMCoXExzSC2bXoeQhrsZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Q3/Sf2VZ";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD92606A326;
	Wed, 11 Nov 2026 14:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CD92606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q3/Sf2VZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794408170; x=1825944170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LTRtbYUSvuOvDrINHce2yN9Y3VQGYk6txmPnyABK2p4=;
  b=Q3/Sf2VZ8VAuXBZlpm2niP+YfEwB1N2bT9CP7XXFil0NimkS9NJPSO4R
   zBvLqUzrTVeybDyhgmcrDBrjBbN2LbelLWXvBuPXEX2wcLq+AgSu2jsR1
   e61kqEgxwV3XcUiWWCSCx6g+fDPHafPkhvbBLCuWJIefuIV+SRvZk5Srz
   sW1XTuD3WHU8FiDV7nYqACLVXL1UKnK01dQAP5b2TYlpkvtbP5l4lAWRQ
   ASkSzJQtyIVR2WNo2ZPTUJvEyyEQTJLhNYtdjpC/Vp0zvymosWzwzy28a
   plQVVfq3/5iWDrNQGqf/eFLn6Cu0DF8ofw47zPYjzFeMAAlXIKTKoPDWW
   A==;
X-CSE-ConnectionGUID: fa1egDfnQOOwgsZgzlygtA==
X-CSE-MsgGUID: v8nPib2mQIWP9hShtt8sJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3276454"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3276454"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:42:49 -0800
X-CSE-ConnectionGUID: Q6tdEbuDRv2QuCSnLFA5Gw==
X-CSE-MsgGUID: q343t+bPQzisM5Ry5UfRMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8322463"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:42:46 -0800
Date: Wed, 11 Nov 2026 16:42:44 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	crofts@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: mcp9600: Bound thresholds before
 scaling
Message-ID: <avR-5DNJ7_xfyH61@ashevche-desk.local>
References: <20261111030538.10565-1-zhujun2@cmss.chinamobile.com>
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
In-Reply-To: <20261111030538.10565-1-zhujun2@cmss.chinamobile.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 11, 2026 at 11:05:38AM +0800, Zhu Jun wrote:
> mcp9600_write_thresh() multiplies the integer part by 1000000 before
> clamping to the supported temperature range. The multiplication can
> overflow int, so a request such as 3000 degrees can select the lower
> threshold instead of the upper threshold.
> 
> Clamp the integer part to the hot-junction range before scaling. Keep
> the existing final clamp for fractional values and the narrower cold-
> junction range.

...

> +		val = clamp_val(val, MCP9600_MIN_TEMP_HOT_JUNCTION_MICRO / (int)MICRO,

Btw, why do we need to use _val() variant of clamp*()?

> +				MCP9600_MAX_TEMP_HOT_JUNCTION_MICRO / (int)MICRO);

-- 
With Best Regards,
Andy Shevchenko


