Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700103;
	b=1PcwPVXo18Kdi1cQeyOrpjwMtjj1ZpUMyXfb/LtT6ojIaBnEiXhFbrQeB/TU+Fe2WGwu
	 Dbn+oRM4Ik34f4WqiC6DiGgIxe5qpBR0y/x6gIhebu86CCXDD7tRJJtpEu18Xmm+dlSCU
	 peO0KX/Tbw5UQAtgwVN7AQcsHG265gGKGVpglxU9TSfAw11/urWINiU0gu8MSSrHRCRQp
	 Iak1AjcEh78oeAEJsTRQD2SzT3ksdQtTNL6qFsdbtrJi88XHFmyyn4vfO6EdBHMlH313F
	 4aspKSif6tJOcM6Np+vKCuW6pbsXH31UWPSk+PnfLt7v4MSkAizIRqSIWlKkPRgRAcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700103;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=FqjOBQ3xr5kwaGHmjLky3COOWtd1V+xD1/etHhnAFZU=;
	b=2oplPyWtPzjjYbnCVPinPf0X5XxokknCKl1n6Q0aDyo1dh0ElhaiopJ/IQtImmmm8+Fd
	 4EzJnZFT46wVWs2lvTc/PZIAbTSsOr4SuWfWNh32l6Y7TsmpZEoqNvgtVQImYdg5CtKjP
	 6mHvlaZLvoNTRtU0NeAOnjZMtmcn3eWMRDpZsyaJlDdTGjhBnA7Hsa56GuTUm3bwVaXWO
	 Xz6YME0vBNWQ6O6JBzToJo4INoANnQuzN3+b9330Yua+rn7yQN1UcsGbtbwOyQFrnHAvf
	 CrKWMaAsKgbtZ4bFzTezUuG2KSuJ2RC2bLL32rdqoU7jeLu5V7GXqceRHJvM2x58PdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S7Ux2+O+;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542C606A326;
	Tue,  3 Nov 2026 10:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3542C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S7Ux2+O+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793700103; x=1825236103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/UZzLak2/xNgfH1t1NAvGuxOOsCUaFsLQSniakLlK/4=;
  b=S7Ux2+O+ulws937fC/4jLRfFsiesFBAmun5pMpyhF0inh7TAfi1Yy0WC
   BJS2jMsRMTs5MlHPt5PJiJYXxqh4YlDrvpsgpO0ZQF76OLPny1nJZFnaf
   X11E04864uHr08nLVkVa4X1ALvNR2mTJtdpkJ3LO/L/sCy/iV/d+enDBu
   NQdi/Vt2rMZOVHvGBB3fNh5tARFUevwUxAWK23oHzBgpgTDaZIaY6fguk
   4X1qORagJfCC7c3cgOa6Hluiw6nst+7U8bR7/F9j+sq0CGwa1Wuk9B4w7
   jNTUg1Z7f2l/1vekHWxujveTR6q8AVn5PsFkx7VK3K7hoAFAm/BGhsQNn
   A==;
X-CSE-ConnectionGUID: YpZ0RBnGS1SDyQuBsRiBZA==
X-CSE-MsgGUID: ANxxJBlVQhukfLtUC8dhPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2413708"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2413708"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:01:42 -0800
X-CSE-ConnectionGUID: 2ogpPpswSQWp0KB5mHcIhQ==
X-CSE-MsgGUID: aST13NSzQCKvLHsSz43b1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6376728"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:01:39 -0800
Date: Tue, 3 Nov 2026 12:01:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: chemical: sgp40: Replace manual locking with
 guard()
Message-ID: <aumxAT4Gg4Zm_hgw@ashevche-desk.local>
References: <20261102091258.247402-1-jmatko@utu.fi>
 <20261102091258.247402-3-jmatko@utu.fi>
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
In-Reply-To: <20261102091258.247402-3-jmatko@utu.fi>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 11:12:55AM +0200, Jaakko Koivisto wrote:
> Replace manual mutex_lock() and mutex_unlock() with RAII-style
> guard(mutex)().
> 
> Extend the lock in sgp40_measure_resistance_raw() to cover the
> I2C send and receive cycle, preventing I/O-errors if the device
> is currently running a command, or clobbering the output of a previous
> command if a new command is issued during the sleep-period between
> i2c_master_send() and i2c_master_recv().

>  	/* we calculate as a multiple of 16384 (2^14) */
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  	x = ((int)resistance_raw - data->res_calibbias) * 106;
> -	mutex_unlock(&data->lock);

We don't wont heavy code to be in the critical section. Here it's quite obvious
that the call should be scoped_guard().

Side note, in case of use guard()() make sure it's delimited by blank lines, so
it's visible at a glance when reading a code.

-- 
With Best Regards,
Andy Shevchenko


