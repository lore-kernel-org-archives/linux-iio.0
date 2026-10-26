Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008496;
	b=rUe5thNgD0Tj4BmgEwxpyD0jPmgrQBRhqygJ6pCedjszMaiHJqe8y94F72BRdeMXV+0Y
	 RYzms+3bts+RFnS029CfWv0evgbd698K5TgV+dM8nIpc9Gqh8uJwOC0vApnbpoFQKCplG
	 n25twQJqEcKlOkcZhTGmJ7OSL3Xe4mALbxKG3wuVNF9RGHui2pn4dAHXVh5FEq7H8pwlZ
	 IpCdP8eUjzALG+BdUYpL3+7bDgIusoIgyCG4oKjEkrFnIrdnJxOkAgsZM/LtorWm6XaS3
	 iOT1/WPht3skZ86SSehy7FODavwVKq1pIsWVZcuUp9MjYi04BWFnPLD7m7thTBUsR0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008496;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Rhl5XKCzXvApo37B3Anoybp14FTZKRPyYuHfVQYcFE0=;
	b=cFHGrDzZjUnuIkvZeC7z1D1pldCwWgYwdgq7KFrmkYHqdnI7Tq5X/DrTBWgNGLugZyou
	 BimLImezNZYkclxRLwCVTuVJvG2yKMHRdt77sQlfTSyfJifY9YqI07EqO9u3phWsZvRKs
	 GdepLyZgmJE+OviH0P5JPIbqLzz4bgzi0Ey+T8+yoJxfXeLBDSlXAgJ7qFkm+/9dE9ZuP
	 cCEYSHwLV1i+9OWoXXpZT4XDPRIylLj2JEPZSg4FETqmOx+L2ukOC/Rrm/wiXV255iHLC
	 o67Fys55vBu8hgpUotZME9pxqQAprTnb8dY1jqS8C66QjFsvbzfSa3nXXgjXBNkhxpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X6WNJsCR;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC056606A31B
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 09:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC056606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X6WNJsCR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793008496; x=1824544496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=beo8dnUgjK8V4lg17aZH8T7ivuvp/sBNAyLaCetA6xo=;
  b=X6WNJsCRRMAMX6xyoMZZ+yTuLmsAQ+hbL89rSLe18H9qAA7XwjdK8yrn
   4PtYHfmsdsxvgqAd4ZjjYZANnr6qP56mEchPFeEdIZPFcvvHWB4SWKzdQ
   wZoW/ruodfs2U4ItUrwxkAHqm/Nk9xHlNcA8nHmqGBXKW890RAKOlxGwQ
   XRLtqniQGdl2FO8g440DlOQVSEg/7XtjbQ6pKoBbzS2+ibxgHfnAv4Fhx
   emKo9Vqg0b9MfStV9SVv3XvIpqVAtIS+LpmREYskqGS9+kIy9hvCh9CKI
   x5DyqGMPLmJcPCuEPiY8JIoqeTwIR8n7M7+DfnQuLr142Dcy5u75c7hT7
   g==;
X-CSE-ConnectionGUID: wMg6s9e5RHmO0ZwopczckA==
X-CSE-MsgGUID: wI/vUjHgS+qd6X3c4bQFeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1682943"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1682943"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:54:55 -0700
X-CSE-ConnectionGUID: ITwvtZYTSKq3HJ2QjpfTiA==
X-CSE-MsgGUID: NqoLZvclQ/CovmkcpGkEHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4336521"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:54:53 -0700
Date: Mon, 26 Oct 2026 11:54:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Brian Norris <briannorris@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] iio: gyro: fxas21002c: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <at8ja4gmUy7JdF_I@ashevche-desk.local>
References: <20261026032051.1004536-1-jic23@kernel.org>
 <20261026032051.1004536-2-jic23@kernel.org>
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
In-Reply-To: <20261026032051.1004536-2-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 03:20:50AM +0000, Jonathan Cameron wrote:
> 
> This driver propagates the return value of pm_runtime_put_autosuspend(),
> which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> With the driver modified to discard the pm_runtime_put_autosuspend()
> return value, it becomes simple to use PM_RUNTIME_ACQUIRE() and
> guard(mutex)() to simpify two locations. At the remaining location
> simply dicusard the return value.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").

Yep, that's what I meant by doing one step forward. This version looks
exactly how I would imagine it!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


