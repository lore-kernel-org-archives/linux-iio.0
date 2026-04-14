Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731DD263F34;
	Tue, 14 Apr 2026 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192066; cv=none; b=K7leLOPQ56itybaYzmOvOvO8Y3H0A8AuI4Bk3+R5vxWWrz9KY9L4+SJLtLp73EOa2k9JE1AwhsR7EQBDJoWX9O5Y7N8KJqUdC+/KsTN8UUx0exQXbXHyz7KiGyaT11TAb3rlsXFx2kqBDUH3/0RGwTY/MaCNRZEd3t3tOGp7jT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192066; c=relaxed/simple;
	bh=dEC4yBKPgSFBrLYKKHiFkLCvJofnDrrJ5wkPJT0oXyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTyf2FG/y5nSL+BSUppl0DSDdBFE5Xlbjvc7wxgp8WD9ODa+K8qwaS1k3S/54aWsjSnZ+t1pixfhjX/qKH2iaPhnhgjweWLc1386Cy4m7RfaaR/4Sbzabpstp+s3wqPbFGBhnJ1gbnytaOJtLuUUdLmdiDoFA1CNue1Rd3ZVNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hk6CZQD2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hk6CZQD2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776192064; x=1807728064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dEC4yBKPgSFBrLYKKHiFkLCvJofnDrrJ5wkPJT0oXyg=;
  b=Hk6CZQD2GVTbSmRZuh0q128YEuR1fGlT4T5/WW3JHFcgpUT/+XUbtQ6A
   fr6L8t2vcbF0VgT4bQP2Tm5OdcPcjAa2C+NvUkh4lfQSZ2k1x3zjLAHzu
   c/NRJyGC5SYBGYmTmYy3DXUpD/XOGmWQ75sShBe22nzFTPjd8Zu1sFUyY
   5SkHzAJJjDTKnekawOkqdjmWHPdFZHeMpOQktVBG3mQVUZGx0ZT/1I0na
   oFR1jViey9XN90OtDdzc/iCUzCawG0N1rAQsbMoPmDKHYZjaB3+iADtz2
   VfW6W9HJRYEvKduEJwWDnhF4Q3siSvLM8ocoMqjPzdsUzapmHQHe8tZvZ
   Q==;
X-CSE-ConnectionGUID: ENvjBXFFQSyfKa1gIkRnuA==
X-CSE-MsgGUID: sx3lk6vhTu6nE/xlx9e/uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="102619714"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="102619714"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 11:41:03 -0700
X-CSE-ConnectionGUID: mdhvQHKZQn23dnNDB0jA4g==
X-CSE-MsgGUID: oYTTvN+PTyqj33T3bekyrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253394021"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 11:41:01 -0700
Date: Tue, 14 Apr 2026 21:40:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Cc: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: xilinx-ams: refactor alarm mapping to
 table-driven approach
Message-ID: <ad6KOyYDFn-8qpgj@ashevche-desk.local>
References: <20260414093018.7153-1-guilherme.bozi@usp.br>
 <20260414103316.18455-1-guilherme.bozi@usp.br>
 <20260414103316.18455-4-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414103316.18455-4-guilherme.bozi@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 07:29:19AM -0300, Guilherme Ivo Bozi wrote:
> Replace multiple open-coded switch statements that map between
> scan_index, alarm bits, and register offsets with a centralized
> table-driven approach.
> 
> Introduce a struct-based alarm_map to describe the relationship
> between scan indices and alarm offsets, and add a helper to
> translate scan_index to event IDs. This removes duplicated logic
> across ams_get_alarm_offset(), ams_event_to_channel(), and
> ams_get_alarm_mask().
> 
> The new approach improves maintainability, reduces code size,
> and makes it easier to extend or modify alarm mappings in the
> future, while preserving existing behavior.

...

> +static const struct ams_alarm_map alarm_map[] = {
> +	[AMS_ALARM_BIT_TEMP] = { AMS_SEQ_TEMP, AMS_ALARM_TEMP },
> +	[AMS_ALARM_BIT_SUPPLY1] = { AMS_SEQ_SUPPLY1, AMS_ALARM_SUPPLY1 },
> +	[AMS_ALARM_BIT_SUPPLY2] = { AMS_SEQ_SUPPLY2, AMS_ALARM_SUPPLY2 },
> +	[AMS_ALARM_BIT_SUPPLY3] = { AMS_SEQ_SUPPLY3, AMS_ALARM_SUPPLY3 },
> +	[AMS_ALARM_BIT_SUPPLY4] = { AMS_SEQ_SUPPLY4, AMS_ALARM_SUPPLY4 },
> +	[AMS_ALARM_BIT_SUPPLY5] = { AMS_SEQ_SUPPLY5, AMS_ALARM_SUPPLY5 },
> +	[AMS_ALARM_BIT_SUPPLY6] = { AMS_SEQ_SUPPLY6, AMS_ALARM_SUPPLY6 },
> +	[AMS_ALARM_BIT_RESERVED] = { 0, AMS_ALARM_NONE },
> +	[AMS_ALARM_BIT_SUPPLY7] = { AMS_SEQ_SUPPLY7, AMS_ALARM_SUPPLY7 },
> +	[AMS_ALARM_BIT_SUPPLY8] = { AMS_SEQ_SUPPLY8, AMS_ALARM_SUPPLY8 },
> +	[AMS_ALARM_BIT_SUPPLY9] = { AMS_SEQ_SUPPLY9, AMS_ALARM_SUPPLY9 },
> +	[AMS_ALARM_BIT_SUPPLY10] = { AMS_SEQ_SUPPLY10, AMS_ALARM_SUPPLY10 },
> +	[AMS_ALARM_BIT_VCCAMS] = { AMS_SEQ_VCCAMS, AMS_ALARM_VCCAMS },
> +	[AMS_ALARM_BIT_TEMP_REMOTE] = { AMS_SEQ_TEMP_REMOTE, AMS_ALARM_TEMP_REMOTE }

Haven't noticed before, please leave a trailing comma here as it is not
semantically a terminator entry.

> +};


-- 
With Best Regards,
Andy Shevchenko


