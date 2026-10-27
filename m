Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098576;
	b=YX9ttJoZfn8PWQQfF619OycXJQgcHQKbrfeO6qh02Z6berUHArdGZKtL4aL+iveqjGug
	 Wzbhuc4S6uH2cYCOkQQulVMVK9CyacL9HNiieEkT1IsQPZHbpQ6fc6JAmveC1Y4YU9rmS
	 tLdQE960NYmNa5sSCWV05CG25GAtA/0vWxOZMVKc+R63kLTzgCMcp6MaeZV9Ix0vbbhYw
	 Il528VEMi4VcDcnBY1cjOC6ikzUPas43FCv49v9X1uCgGYntyDGp9peaMC2QJu5YNGNvH
	 9HUdMMLuh9DEr3+66JaoANlzDob5DZs176AF2y7xwfHol1T8O/GuvJi6P9qRY1m79gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098576;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=9OzsCBBp/SgsxmwS79rcFm7DGsFFA8h8+x85Ahtmsxg=;
	b=Y4lmFTjM3nH0ZaREFvOQQttAk2E8y/1EUS0BSvsZXD4pBi0LXxY1AlbvYR9StBWPV1ic
	 qFQgBV9qfJmbUI3gSLDYeQNbT9mTAl3v2uQpnLweBlKJzBwcA87tYlFZM0I2lEUVsLxHF
	 xc/54Hth2RbAmTOgKvtuWYQ+OyTEbjz/dvCpQHjnbV/oRX/SAcbZ/O34JiUCfyHlw+bmJ
	 +8FCRzv004CnhWUEVBed45yaIOjRMW+LkMdM+5E2XwLACU3sOf73Wn6yrmsZeHumwFs9r
	 bCgfExJUYWd7Oc972YTsNN3TcykYnMsySrwUkTYeZY/VBFhI+7mZnXwVx3jEHfp5B4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ZCE/Wov9";
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC7606A325
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 10:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AEC7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZCE/Wov9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793098576; x=1824634576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3yGG75cY+CaOuADLR2A+EKQ4RAuDZTObnAO1s+qbkcY=;
  b=ZCE/Wov9p65j2S3XL8U+CUIlJxvH0nvIP3qNXBjz2xxs1BkP6tvE5reF
   Ija1hFWpzkGaWVio2EgojEMBK9zOnGX7JJE6Cs/dJjxGKlPjJg7N4vMHi
   AjvCZWkAWN5MK+kxOYzSkMiBlhXLYi+pp8mKgL0kpFif067Yu/F5MKrob
   85V9rNsoBXmC/DbmNxBoRfOQpiYno0M650qIde2FbyMOwt/FVPITFgx22
   osVt4OKn8ktm01nFcVurec6e8lGMYACsFZTP/guzkxVGXy7+WEIMf3KOF
   AsBIc3R0QplY+JuJ3auo445dP6zqP6q8Zi8XX2GaaHmhWcXxbzU6UEzHY
   g==;
X-CSE-ConnectionGUID: EXmxUTOKQkmEYrLtaCwUGg==
X-CSE-MsgGUID: lMc0Nl2hT2Kuuna1hee0wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1789139"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1789139"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:56:15 -0700
X-CSE-ConnectionGUID: RgY1llbtTIOUfoumr7cHtg==
X-CSE-MsgGUID: KdyZGgeeREKRrYfNKHP5Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4664313"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:56:13 -0700
Date: Tue, 27 Oct 2026 12:56:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 39/39] iio: imu: bmi160: use iio_push_to_buffers_with_ts()
Message-ID: <auCDSmJXFjSNTLQn@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-39-8b136778eedf@oss.qualcomm.com>
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
In-Reply-To: <20261026-iio-v1-39-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:57PM -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Move the scan buffer off struct bmi160_data and onto the stack of
> bmi160_trigger_handler() as a zero-initialized IIO_DECLARE_BUFFER_WITH_TS()
> array, since it is only ever used locally within that function.

...

> -	iio_push_to_buffers_with_timestamp(indio_dev, data->buf, pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(scan),
> +				    pf->timestamp);

One line?

-- 
With Best Regards,
Andy Shevchenko


