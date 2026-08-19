Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC221F91F6;
	Wed, 19 Aug 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149038; cv=none; b=PL+ZyoIpvhKyn/vfK8IWCyHv3hSx6F+X6FI+ixM+iR0Q6x3+IOF3EPThkrWmvENz9ODVNtbJTR6zxZFCuJDPYiilalytJ1OWv0+ObC4sCP/85BT7/nS4iKEqe1kP2zA8bpC1B4VxGo8wRLOfI8AdFlrALidZjqwnVgVmvwbUq6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149038; c=relaxed/simple;
	bh=7E1Su1F4qolwv3/mfAgdoIoQgeCmyyyC+e/XU95cKaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqHff2nKEKb28qmVZSxpWU3brFExovtXj1EuV7uR6RD7Mc0+SjHX61PksY4QGRYgr3nSK2O1Q0O1XFMvBiL6qEbNoyJ9tRKuZVO69v+iZ5oGAROOj/2dY3Uog7nJ1o84ArlifgEz3qyIbAAtQ6S45Qkj3LLvaax3L/twu6X9GXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFhvUEcr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFhvUEcr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787149038; x=1818685038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7E1Su1F4qolwv3/mfAgdoIoQgeCmyyyC+e/XU95cKaU=;
  b=TFhvUEcrBZRz86pYDGX55pv3IxnZK9OEOFt1rwDnOH/7twWXq1CHBqhx
   9Hll5n7Susr1gVxg3G4UueShroRODDqD0UzWULPHMElVK/yMHdwXh2G9g
   ey7dLjRPxydBhOo4y0li12gQtZXywpVj6+hpCWCU8TK3Y/oE1aE4sIZ1+
   Jgv8TCSrHyZcfjpZ2AuubUKUSQf6uMkG9eyLlcfqrh4HQoXhwX3HDQQ3C
   +icPvYDVEzGZcPgRaIp5uQMv+xEkmcOz4Z8S7jUql8SsHpWkWWPthmXrw
   HXNX/lPm7BM4bXbGUbM4IVqN/cJoCqCUrR8Mf/2E4NMg0QoyFLTgxrpGW
   g==;
X-CSE-ConnectionGUID: pR51VxcwQOa8u85PUMWHoA==
X-CSE-MsgGUID: QtPedjHkSDy0Uylga5kCsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="110451123"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="110451123"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 07:17:17 -0700
X-CSE-ConnectionGUID: ISZhsaCiRQGZSHVnw2iGww==
X-CSE-MsgGUID: iqVYcWDkRX6/hSrJx7pJfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="264241227"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 07:17:14 -0700
Date: Wed, 19 Aug 2026 17:17:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/9] iio: dac: mcp47feb02: initialize dac_data field
 in channel data struct at probe
Message-ID: <aoW657jDvmMiOsaX@ashevche-desk.local>
References: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
 <20260819-mcp47feb02_refactor-v4-1-beb2aa3bfd09@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-mcp47feb02_refactor-v4-1-beb2aa3bfd09@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 03:41:05PM +0300, Ariana Lazar wrote:
> Read DAC value register to initialize corresponding field in channel_data
> struct when the module is inserted.

Since we have a cache enabled for regmap, can we rather read back initial HW
values at the probe time for all non-volatile or precise registers?

-- 
With Best Regards,
Andy Shevchenko


