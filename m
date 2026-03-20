Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4C35F607;
	Fri, 20 Mar 2026 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774036815; cv=none; b=YTVxQhDg2klV/Kvajg71nMr3ivcUji95Rqxw03Rok1LHKQucvKeDt8dem2MeZkxTEej9b/mKyJNYz/esnnO15jcUe4SJy+qO2Jk4OoDm5v3Cwi7Don9zG6e3rjxgZHlIxK9YS527eGhG1qoQ7FDlRFk9Yrm9ndBgiSUMKBjY+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774036815; c=relaxed/simple;
	bh=3r5Dqp+WPxxPo6MxzHzpX2ZPdVn63bA4BVuyeCdHdSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIzm8K1/wLQlOO7sERgzeqX0214qcNE7raWVneVufEFIT9FJst1s8/CUgGcJ/Ij1V+47ojjDaoHWJWobc4FRlUTyJ1nv4TleS95NwcwMl0C7SOBVtGbDdM9PRIUh5K0C650D88FPlzrw13uUNjQ6mczRR2ZfXrF3fws3weNuMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDtpb9b5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDtpb9b5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774036813; x=1805572813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3r5Dqp+WPxxPo6MxzHzpX2ZPdVn63bA4BVuyeCdHdSk=;
  b=dDtpb9b5ROYjXFePXch0190/qq44y2FiEomkgH3fvK+6qqQ4gtUmRjoK
   7Kh/63OR508JmriU4uQitaqr3A4bRtLA1UPCiC+ngsi1QwaOIblyWhVVt
   7LG2c3/57VsrXlOa33IEIWZDYrteva4BIntbTDNSTQA8VHykpT+8LdRno
   55k4qnk36m0sp+q1DtZTBDPRxIyQBXBpwv+t71vjw9+P5SmPmQAvW1ddV
   pCshbWpCYFOW00/xqI6Hhj2xT3Cpb3i45M0HHHBkV8RT79sTt6dhnAPID
   SwWW2uMK1J2yDrkdwIcN1/WVPVivPjhpBXXGEtdyGMFjyU6T5Y+L6WJ+6
   A==;
X-CSE-ConnectionGUID: LEht97kHTHmrrH5YHqzhSw==
X-CSE-MsgGUID: pGGCAVbzTEeMim/K406xMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="100584499"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="100584499"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 13:00:12 -0700
X-CSE-ConnectionGUID: sR98MtiCSdypSm62QI/DZw==
X-CSE-MsgGUID: vjCPd64eRQevYsybBhJggw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="261283105"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 13:00:09 -0700
Date: Fri, 20 Mar 2026 22:00:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v2 0/5] Add Invensense ICM42607
Message-ID: <ab2nRu2XnJx3SqKP@ashevche-desk.local>
References: <20260319182956.146976-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319182956.146976-1-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 19, 2026 at 01:29:36PM -0500, Chris Morgan wrote:

> Add support for the ICM42607 IMU. This sensor shares the same
> functionality but a different register layout with the existing
> ICM42600.
> 
> This driver should work with the ICM42607 and ICM42607P over both I2C
> and SPI, however only the ICM42607P over I2C could be tested.

Please, make sure each patch is ~750 ±150 LoC, so it's reviewable.
Last patch is unreviewable 2k+ LoC!

-- 
With Best Regards,
Andy Shevchenko


