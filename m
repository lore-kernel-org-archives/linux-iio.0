Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB483CF66B;
	Wed, 25 Mar 2026 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447822; cv=none; b=FFZ6zRa/AvV7ckVx8GEr2FT26CFqigESaPNVJ98byKrzC65/TnrAF0VtxAyFDMQWH9zSjrfjWGliSYOxZ/Cxsawlv5wD2pq5VHhJ8pvU7bAlqYkmWizSBsmGI0P0PnhJ07a61ZvqG3vRMdODn8v5L/yE1LKTofEVFi1xd6XZ/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447822; c=relaxed/simple;
	bh=GFO8fg8Sk9oNGrDSd+fG0u/XZxE+fUmO/YQNnGW6Uzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF0tZuDLrb2robWVUI9NGkfc4gYtXMQGd5V4FVylCz87uR9VF9p1BdHoZh4pMGMIa4mZm5fkglfn8rkHttUVptREooHklkyijYr+eMgdp5ggVMdIG724I1Pg1C/oTU2kV54PsZ3RLVeZEkz7oRPukFYuxgngbPCt/R4L/Q/6dsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIN8lM8F; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIN8lM8F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774447820; x=1805983820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GFO8fg8Sk9oNGrDSd+fG0u/XZxE+fUmO/YQNnGW6Uzs=;
  b=LIN8lM8Fyw2tdasewFsU/gSKrO8XDrvN+MMzvMWxV7btGbN866NVUdmJ
   jbuTABeP2sBb84zU7Y78HPIqZz4rvi69vzgYv+di3r+uKTIfAClRUJCBP
   jNkPhIWF8wsW+PDms/Og6aE5qLvqXdOBnh2FbvmAnHQAmwVlMyu7tvaAK
   UomLxaSgGX46HnS34X8Y9ds5OkznkuXIBWOQ32ul+1us5VfDKbtzzsM1A
   3AIO/xPj7NtQoy+WH4vld29J0y4ANPHBzFD8bvjElovzaDa2bMJoJf6ld
   KOUyVzC/gTM31dDYpGVbYuX0e+hquEAJbjxTwRNWfSra5UoMJqNdNRAp1
   A==;
X-CSE-ConnectionGUID: XtsA1NvpSze24nCVHwjdSQ==
X-CSE-MsgGUID: LoA4fs7FQsCf6Gp9VzXYGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86179465"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="86179465"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 07:10:19 -0700
X-CSE-ConnectionGUID: whiMa5g6Tk6qH6btb6N5SQ==
X-CSE-MsgGUID: KP3/5X+7SGmbVelSOq2knw==
X-ExtLoop1: 1
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 07:10:17 -0700
Date: Wed, 25 Mar 2026 16:10:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Milan =?utf-8?B?TWnFoWnEhw==?= <twoexem@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lorenzo@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Add ACPI ID for SHIFT13mi gyroscope
Message-ID: <acPsxval-nfltuVP@ashevche-desk.local>
References: <20260324193626.77231-1-twoexem@gmail.com>
 <acPNhGlmTJk4pfRG@ashevche-desk.local>
 <2ac6cca6-a7c5-4892-93d9-49f850953511@gmail.com>
 <acPU86AwRJPUb22L@ashevche-desk.local>
 <71a591fa-d103-4043-a313-e796483e8709@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71a591fa-d103-4043-a313-e796483e8709@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 25, 2026 at 01:39:42PM +0100, Milan Mišić wrote:
> On 3/25/26 13:28, Andy Shevchenko wrote:
> > Interestingly it has accelerometer and gyroscope described there.
> > Is the other part already supported?
> 
> Hi Andy,
> The accelerometer is supported. Checking iio devices:
> 
> $ cat /sys/bus/iio/devices/iio:device*/name
> 
> i2c-CPLM3218:00
> lsm6dso_gyro
> lsm6dso_accel
> 
> Both the gyroscope and accelerometer are shown and recognised.

Hmm... But it has different HID? Can you also cut'n'paste that
device description from DSDT?

-- 
With Best Regards,
Andy Shevchenko


