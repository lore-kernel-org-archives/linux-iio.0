Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04231619C;
	Sat, 18 Jul 2026 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784363677; cv=none; b=LzMVsOM9+PNuzYdfoojybw/Qc7y2tk4zKoIFsmwUUc1YWNNu3SYcRWG34I7krj8SaiLnMQGt0IcW2TdBY0YQrTTPZ9VW6ZjDyjaIsRKujcw3b7FYue9xL4SUkFoM6LZ3HAom6BzitmZI4vaeC0KRUa8pjaH3339P0TiYWJiW9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784363677; c=relaxed/simple;
	bh=+t9hJ3SeVwth3bb5l/7BziN9IqcC3EuPIi9wluL5ng8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR+SbywsjIFgMm0oXgb5ylTaqbzfzQME2EYHQl9yQCcqH5W+RWXJi7oVtRoDsHM5yjEeYxAQAo0ffq9G/lkrO3JRJWRtL0pUtaNBYt64gYjcNThT15wUCSrZCjSG7czd+xRgsYsLjiXWbxVu3ATTWfoAXZwBD+jTOqMp83q3El8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cr3N5OGX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cr3N5OGX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784363675; x=1815899675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+t9hJ3SeVwth3bb5l/7BziN9IqcC3EuPIi9wluL5ng8=;
  b=Cr3N5OGXnTdUjkb/9MF8DWQtto/C/FBQwsLAix80YxtcXjiciUrCVni6
   CUXUNZRXIPaqKM9XC8PRvV5owNRzBm3ijNxwwVmh8N6Tqg5mQF1Tbv4qB
   rix/wP97TuDJeTZzvl/eLr7J3MpwQHRjqrA4hojW5UHpA9DBykAmQ4TN7
   4y/KNFjCKEBAU48wq4wivEuc3EyGRWs4gfh7lIgd5/NkKUx3zfHLzySTG
   dp2xkQ1fLMBYufcB3XfyyCf37usnytr+Zzf0i9n3GPc2bwjaOwgcoG+Pd
   L7tHdg1ViNYd+ixFnqg4M6Y22mHExSU/xDsxoW/ec/nw3MtKfSZcSDJTn
   g==;
X-CSE-ConnectionGUID: bPJwY9STQ8+m6eVC0Ke1lQ==
X-CSE-MsgGUID: o5di74MnRRC0uG+L3T26mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="107808149"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="107808149"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 01:34:34 -0700
X-CSE-ConnectionGUID: +8yTo9QNTcqZvoeRXjeuuA==
X-CSE-MsgGUID: DqDvPBIRQ4e1bI7H34xusQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="256421262"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 01:34:32 -0700
Date: Sat, 18 Jul 2026 11:34:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: ad3552r-hs: use sysfs_emit_at() in data
 source avail show
Message-ID: <als6lRi-H4DM7ra6@ashevche-desk.local>
References: <20260718044244.7-1-bbnpreetsingh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718044244.7-1-bbnpreetsingh@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 18, 2026 at 04:42:44AM +0000, Babanpreet Singh wrote:
> ad3552r_hs_show_data_source_avail() formats the available data source
> names into a 128-byte stack buffer, but bounds each scnprintf() with
> PAGE_SIZE instead of the buffer size, so the bound does not protect
> the destination at all.
> 
> This cannot overflow today - dbgfs_attr_source[] has two entries,
> "normal" and "ramp-16bit", 18 bytes formatted - but the bound stops
> protecting the stack the day the table grows.
> 
> Found by smatch:
> 
>   drivers/iio/dac/ad3552r-hs.c:593 ad3552r_hs_show_data_source_avail()
>   error: scnprintf() 'buf[len]' too small (128 vs 4096)

> Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

This whole thing is not what I suggested, I only had an idea of using
sysfs_emit_at(). BUT...

...

> static ssize_t ad3552r_hs_show_data_source_avail(struct file *f,
>  						 char __user *userbuf,

...I haven't paid attention that this is not sysfs attribute handling
in the default way, this is customized one and the passed buffer is
in user space.

>  						 size_t count, loff_t *ppos)

Hence the correct fix is just replace PAGE_SIZE with sizeof(buf) as it was
I suppose in v1. Sorry for my mistake.

-- 
With Best Regards,
Andy Shevchenko


