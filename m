Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC84A23;
	Sun, 10 May 2026 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778436832; cv=none; b=lGxGRNCj5yTxonR8a9C48CwG4wac2nfrNAZbMW9FXlQg0IKqKHjovWx/YEGEwjH4N/txoXusOyfs37x06FIn6inKmNFBknEPOYzD6ZTV13+MBFGrlWaJNWjXj52UWPlMHDeg7TLXmp/od3xdPlHuz4ehyI/lWVYALwHIrnAXAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778436832; c=relaxed/simple;
	bh=iVFsfgz6l2/+k9tMQVPuHmwSH+CcMqSjIljnQXFEsvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2zdkJ2+uFNVhxyJ7ISoUIb265MrFequDLWwg6t296C2QckNicw98hvfuZmyd63XFmbMJBe+PEc/LuDXvnlam6OrlcWG1B/7QFhagO4d3WCA7X0po70k5CX+rDKx0jDW530HUEG4x9hgF4lQFq7H6DtSUEWgo0mYlaOc4sSzjqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mky19BaV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mky19BaV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778436831; x=1809972831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iVFsfgz6l2/+k9tMQVPuHmwSH+CcMqSjIljnQXFEsvk=;
  b=mky19BaVAdRCBiC1JTJSY67lIUPEeqt4Oxzc2OopxEp9p0h8BsmbEz6n
   glcbt8w3Zll8kTWahnbeUicXZXkGkHFBqkcr1TXI7qU46DWReptSXEMQi
   zxgw/KQKrBaja/Bayy0f23gKrl624qrQUz8qyjH0bDgKu+u/ODzl61YGl
   AHGUDRTwVt5xEqxb0X03gi4r5CtG6FE1QHZMzYX548FtPGR6hcANs5R4S
   ZD6ue4adX7/qpBns4IRTzFfX0vT3t81rw260Q1vtF5ABxvJLUYbKdInTy
   Z9BD6be2FlBNMROYi5nyUHpho2sflkvGiP0kpUFWChAQLxBvjUDB9oeEo
   g==;
X-CSE-ConnectionGUID: TV8NghjfQWqGxflSg0LvEw==
X-CSE-MsgGUID: s25qPBBgSuqd2vXFhXy3kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="78480872"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="78480872"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:13:50 -0700
X-CSE-ConnectionGUID: C/w68USzR/WhlGv15LAvFA==
X-CSE-MsgGUID: LhSxVOobTSmDfAYrenpYRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237202417"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:13:47 -0700
Date: Sun, 10 May 2026 21:13:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: azkali.limited@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, CTCaer <ctcaer@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: light: Add ROHM BH1730FVC ambient light sensor
 driver
Message-ID: <agDK2A5BeNQtz2xs@ashevche-desk.local>
References: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 01:09:48AM +0700, Alexandre Hamamdjian via B4 Relay wrote:
> Add a driver and devicetree binding for the ROHM BH1730FVC ambient
> light sensor. This sensor is found on the Nintendo Switch console,
> where it is used by the system for automatic display brightness
> adjustment.

Always for a new driver put a summary of the study of the existing drivers
in the area and explain "Why do we need a brand new driver? Can't we have
an existing driver to be extended to cover this HW?"

> ---
> CTCaer (2):

No aliases, use yours real name

>       dt-bindings: iio: light: Add ROHM BH1730FVC binding
>       iio: light: bh1730: Add bh1730 light sensor driver

-- 
With Best Regards,
Andy Shevchenko


