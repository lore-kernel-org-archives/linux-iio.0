Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB439DBFD;
	Fri, 18 Sep 2026 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724824; cv=none; b=u+Xf3llNo9XTaRRlndbhwleiBe0b9xzYk9o5pv7CEx1Dhn51f/dDp0lkP/0QbxHLlO3HydIp8Txm2BtbxpINmBFukdJNzKrMl5nGcbAKh3b2zklMWZYdpDUrBXyIUaHs3xTMQ0byMU/vWcHZPHC6nzC3QNg1VB2bgqM4fYCsf8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724824; c=relaxed/simple;
	bh=CXJ4Z1EeGE8RCIyJIt2bVorzhhYCwcfJDxB2v3PHikM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4mjTkdmeYwGRds8qgsVCU0o3xZC/nNhcTZZF59xcPmWuGE/NFEMclmm+zUAPYJBWl0KsbMVSS3y024lyEp7dqna6PycEyEy2A8+5rpPny47/T4fFurAp+JLwKULncPvv2Tqrg3jpJJd0zIUgm081g36aWtZC24YeNgwCuD6Ei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnbVnSme; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnbVnSme"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789724823; x=1821260823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CXJ4Z1EeGE8RCIyJIt2bVorzhhYCwcfJDxB2v3PHikM=;
  b=SnbVnSme85uzGrMx6xWZ0Dr7vo+WcQoCgkDfOLhwhZT3D07xoA+Lb9+w
   yd5zLXwOnPq8mHEIN8czShbU6gWb4LZqctYrbknINRs6Zcb/WfXH2ExF0
   gQQPldTB75X0Je+OY10taeBwkbWdUihg9IZFvRsJAkFP63/QDgOhd4lzG
   fXRl61dRt2z/rHZ0kd8nEs+w2dqvlb6z1ED++LUbjKp2Gto9Wh4OhkKJT
   CKCMiv91QahR0FTLCsyYydB+8JM04ORVUggR8Cd4PHLpV+Si0guWtIzTW
   AQ4QPvtpgdoNBWqZ3ffu9lZajSXVuDQvIIpsgYFfDFfiGbzZVq1aJ80IH
   g==;
X-CSE-ConnectionGUID: Q7Z7WonBSrGXPhYPpSUBAQ==
X-CSE-MsgGUID: daIXs4i0TdWByJCVT7gRVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90350410"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90350410"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:47:02 -0700
X-CSE-ConnectionGUID: sGWSrPtTQVqnekvLoOOTuw==
X-CSE-MsgGUID: X0VWp/onQlK6IJlqJc3B6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271638906"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:46:59 -0700
Date: Fri, 18 Sep 2026 12:46:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 03/11] iio: dac: mcp47feb02: use field_get() instead
 of custom dynamic macros
Message-ID: <aq0IkbY9obvwKxRs@ashevche-desk.local>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
 <20260918-mcp47feb02_refactor-v7-3-82ca794eafe2@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-mcp47feb02_refactor-v7-3-82ca794eafe2@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 12:06:29PM +0300, Ariana Lazar wrote:
> Replace manual bit operations which select channel corresponding bits
> from a control register in mcp47feb02_init_ctrl_regs() with field_get()
> macro used with masks already defined for regmap operations within the
> driver.

> Suggested-by: Jonathan Cameron <jic23@kernel.org>

> Link: https://lore.kernel.org/all/20260913224339.490d89ba@jic23-hlaptop/

No need a Link tag for the simple suggestion. I believe there no any unobvious
things that were discussed at that Link.

> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

Also this is not a fix, move it towards the tail of the series.

-- 
With Best Regards,
Andy Shevchenko


