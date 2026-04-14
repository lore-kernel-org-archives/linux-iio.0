Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B302E35E95A;
	Tue, 14 Apr 2026 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150902; cv=none; b=XTqZ3bgbsEe4Ojxd2axUz0tkE1JShY0LCBlN+0SnpJM/iBUbbfmhuwD62JmLZYWwrLACdm5yNTqC8pPrnkEoLuBUZQplvkYBGuONo1JNMb07nw4CQyd5pw0eQFKZA+JOrwmxUZWByzbNo9o3rqnzkPVSZQyhFtxQ9MNJwSJdo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150902; c=relaxed/simple;
	bh=Lg6AwNi+noSUdU7+/Bf+YozYCr81gUXl7BqaU3aWAN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhBBp4jaXMUKhudnnBdSKmM6r0VYjldP1FI/YVkqdXG1i6BBpV8IxB1WwS6AIQd9QLeT9LAY/7Ft4g6P7TETtyef+FG5/QJIt6k9TyD1rTQFHrIdFzPnmmTqRo89in5CyyeYIAJbSpxptAR8L/69lelS6003L+Qp4Xm7KiFXJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0YpD1LX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0YpD1LX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776150901; x=1807686901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lg6AwNi+noSUdU7+/Bf+YozYCr81gUXl7BqaU3aWAN0=;
  b=O0YpD1LXeltHJ5rSjio1hiv7AIOYBVgYahusxA2MpYuVvjFeW5xKDAJ0
   82ZfltH3dev02aMe+XvP20xIzOEAUl88fqfYBLOHgMl7qOGii5SHdM0F5
   wg9Hhx5m13nDjy9lnun5Shi/EymxXSrczothiulw6/O8KPacMWbazhrjg
   fQiaPtXNkCLMQVCPqkNnaX/B6Vsf23S327jKNW+qAuL4GZ2eM5rqHmk1h
   H2bRc1MOdqJ8I4y9/HwQtWqh2jBm/UxDcrBrnqCmbKnBGsR6K/bI5c/Au
   NT4pF0agvMPRm5g5KvvB1va7orXXjKQA4EMwB4BwRCM6SEYdeUazTj0no
   g==;
X-CSE-ConnectionGUID: bEpa+czmSeKMLqq2+ox6OA==
X-CSE-MsgGUID: SO7pkxdwQRSFceCh67bcmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="77067190"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77067190"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:14:54 -0700
X-CSE-ConnectionGUID: k0LRaNlaREeB2+gZACKSMQ==
X-CSE-MsgGUID: i0BwJHQ1TDS7NUgpXv2jTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225285049"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:14:51 -0700
Date: Tue, 14 Apr 2026 10:14:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V3 2/9] iio: imu: inv_icm42607: Add Core for inv_icm42607
 Driver
Message-ID: <ad3paMbRXtq6BrCu@ashevche-desk.local>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
 <20260330195853.392877-3-macroalpha82@gmail.com>
 <20260413200547.75bfd672@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413200547.75bfd672@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 13, 2026 at 08:06:54PM +0100, Jonathan Cameron wrote:
> On Mon, 30 Mar 2026 14:58:46 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:

...

> > +	if (!conf->temp_en)
> > +		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
> 
> Could make this 
> 	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL,
> 			  !conf->temp_en);
> Not particularly important though if you prefer the if.

Isn't this becomes FIELD_MODIFY()?

-- 
With Best Regards,
Andy Shevchenko


