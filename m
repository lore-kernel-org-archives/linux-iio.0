Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60E399375;
	Tue, 14 Apr 2026 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166390; cv=none; b=LzztWcyqPYmEM1hBibOa8ipsD0669NdAeES3EAFiS3OrveIAdsOs45zDRnAT3hR01vKA8PEIS9P0vvIITerhomFjrsBc8HWZaBnxqCPQ7JvkeciqDvmaP9THpV9JXeK+JFPQ6a9xtYRmtODasPR0GdisamjNPyUaYn18nDo5xQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166390; c=relaxed/simple;
	bh=2CaMzWPUzuDaXCd90z0j3y1RLVWl75u/5ubiZ1P3Sc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIzTfK61TfBvTBP1yULnJ3yfPNt3TdSNPvQ4j46H3knz43qemidVVP262/X2+2l9i6ZPfEIb70KcYxG+juIkmwzGOZfpcL7ZUn8XRG+yLiTWMv3Q2O9QFhqFd7hBqVvb5LWJMd/0EP2b85rte/eSHddi5cpcOsEOCyaRN6CalcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWLnG3cS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWLnG3cS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776166389; x=1807702389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2CaMzWPUzuDaXCd90z0j3y1RLVWl75u/5ubiZ1P3Sc4=;
  b=iWLnG3cSAbz69qc3yRW4UGKwc68xWqvO1m+XkooEga+g8LHd5ypQmz71
   T2sEr3g7XI7m7tPYIYcTm7ZQTNfrPMIoyN05tKnSuwxWqOYE/941trD0v
   3rY2gVy0rL9W8DkYmPH4Mn2wnvjvpKn7Czh10Fki9RwKEfPFKVtC9fhnC
   M4MsHlwiu2ZdL7b8VJLnJ/CDH2+3vyVepY5bmHG9PVaGVErH6101A5/uT
   vGzY69Y2QymbyTZKQqabl/FKPc4mpqrjTtZN7apSEW5ThHfGI/WL6px0+
   58Tc0giwJbVJBgkJu/7jbtOi2rzCCnIvKV1hF3VzgMfl2Qe9eFC8ShlgX
   Q==;
X-CSE-ConnectionGUID: LVeSdpF0QlCABVVdZ9/Cww==
X-CSE-MsgGUID: jyRDBB7cQTme8caWRAIkzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="102576895"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="102576895"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:33:08 -0700
X-CSE-ConnectionGUID: E3gAO0PNRxK3O1eH0peRQw==
X-CSE-MsgGUID: P3xDdFcMQf+p2mODx7zoKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229945312"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:33:06 -0700
Date: Tue, 14 Apr 2026 14:33:02 +0300
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
Subject: Re: [PATCH v2 0/3] iio: adc: xilinx-ams: refactor alarm handling to
 table-driven design
Message-ID: <ad4l7jao9Fj6T6Nr@ashevche-desk.local>
References: <20260414093018.7153-1-guilherme.bozi@usp.br>
 <20260414103316.18455-1-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414103316.18455-1-guilherme.bozi@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 07:29:16AM -0300, Guilherme Ivo Bozi wrote:
> This series addresses significant code duplication in alarm handling
> logic across the Xilinx AMS IIO driver.
> 
> To address this, the series introduces a centralized table-driven
> mapping (alarm_map) that replaces multiple switch statements spread
> across the driver.
> 
> This improves:
> - maintainability (single source of truth for mappings)
> - readability (removes repeated switch logic)
> - extensibility (new alarms require only table updates)
> 
> No functional changes are intended.

Please, do not send a new version in the same email thread!

> Series overview:
> - Patch 1: fix out-of-bounds channel lookup 
> - Patch 2: convert mutex handling to guard(mutex) 
> - Patch 3: introduce table-driven alarm mapping

I will look into them later on.

-- 
With Best Regards,
Andy Shevchenko


