Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408234;
	b=Kr0vG0uSar4Dv+kjl8JYvElYDZtXwx9AHGg/0j3v6VjbcaAdFunAzDsEcUkVXIaDLRxq
	 /aNEAit3Km00GL+Sj0f6QXO31dFzQRBQy1O4WO5VByVzS5KZ3tSu0d2Q6XHxFhyazPKSZ
	 Xz0LBeFktvNmcp8OuWjfPDAvVrr4d59Pl4g/g/j9T+Avsviz6asRoaXwwAheuCgJizmNk
	 13KM5EkU2fekoSTkoCBR4HFduSHrGkAKEgeLxKogzesKE4cuv36bbB+xDah/sADQ8mj6m
	 K4qyIVnykFH3X/NWTXH2UUWirb/GCYj6/b3rXvtUjTdo1vDdTeJ4fvLxnzS64rEbm0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408234;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=VfEZB8j8bkMERApncYu1zQYS7sw7JiyI/872uoUspYk=;
	b=LikVx8I6rX13oOk8ML7AL2yKJOVwYSZz9hIq1xXVRRhbh7K1UhL8o1kEPdQ0FAkLzCCl
	 WZBzBHnqj6jmEKEZ4KVeLkyVsMV07LSqfmcpz+BxlfYDafI4x+Wnq1pyDVy8wuwWCF26U
	 ++DrJPZIhcPZGLJNvOcrOMI5ohaug05Ew32XMwRZ52t9gaBVIVoTibEoya2SFjGxVW7en
	 cWEYvP142dx3VbqKBjg9A31/lHG4zlZAv9xi/XPL/hjP3jEDLa7ESxEinTZGkUigh/9SE
	 /Ijg6TTx20jcyo5ojRhzesfye0RDMY9eTHubRVkqvfAlhQThg/4DxPBL1NuCCIhi2Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NCIYHB78;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E18606A321;
	Wed, 11 Nov 2026 14:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8E18606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NCIYHB78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794408234; x=1825944234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=akf4/enqiVg4o2y/PAU+5Jukc9jXIoyYlqCERksn+nM=;
  b=NCIYHB78fHFIcEfJhjbezebvSkVdKpxKQ+ctCFxlufOqqjshOBYON7k3
   hJmVuK1vQTd9K9Gv4xFSYlklIf3Fa+mYRwMkxaMpxqfQuKLD2FYPYu/fN
   wQJlhjkphVCCADwsstTZ+ZgKzfH1jvdQnJh7psGywVBCNILiwzuOnXEJY
   XfCbZ76T3+y+Vi2DeTWtTEE0qljKLcLNh/LUNdIPdwJP+oLk0GNdxdfP3
   5n8i3vOvd8cbh0MrSDUF/yAQ6KrpGZI/wsk80zwtA8NEU0hxguvpTEQ1x
   HRKaSGpAySjUKpt8gnNMoS3Ld91EFn2/3xLyNpm8+cSUsooNtLhootwTd
   g==;
X-CSE-ConnectionGUID: 0xPKjpoTQC+FA1msM7OHng==
X-CSE-MsgGUID: o/S/n7VHRQuDSOCEFGyI6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3051798"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3051798"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:43:54 -0800
X-CSE-ConnectionGUID: j2+1Ks4TRB6dawDUo5AU/g==
X-CSE-MsgGUID: fIBU1n2UQwGhUQKDG94xnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8587822"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:43:50 -0800
Date: Wed, 11 Nov 2026 16:43:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	crofts@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: mcp9600: Bound thresholds before
 scaling
Message-ID: <avR_JbeX1UtWpA4Y@ashevche-desk.local>
References: <20261111034224.12709-1-zhujun2@cmss.chinamobile.com>
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
In-Reply-To: <20261111034224.12709-1-zhujun2@cmss.chinamobile.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 11, 2026 at 11:42:24AM +0800, Zhu Jun wrote:
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


