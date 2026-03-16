Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD41E511;
	Mon, 16 Mar 2026 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671665; cv=none; b=mFKwrTH39RJnQFY1ot+IXV1+r/VTqoR5wZMFI7usfCS/aJs29mjPtOUSkOnPB/SPpnHeHRx9ekU+NW8v34gxUNuVMd98lU+zUpOLFVguQnsYg4e4VrRsWiGYfF7vV30WDqQuazODk6C61EaTjEcwzvHf7tCBa070ezCp/gNCaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671665; c=relaxed/simple;
	bh=jMPqJw/APU0QGwiSgHptPkk0vtvJMMeAn7yDbTPxW8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLCICRzH1QUNJ+Ajw1KVRaJVpnTi7O9Koxly5jDGrXRVzfZjPCv9yfTAk5lGUD+mow3LhJ5Rf4s0D+sBlAmVxgESPP8wkK97V6SllzP79BdJ6rDvy41AiAQ6OX4m78Q7zVYz4N+B8ls7MPyvKme52DOgNGjEkGD8Br1m+Wjfum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mun9f81b; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mun9f81b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773671664; x=1805207664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jMPqJw/APU0QGwiSgHptPkk0vtvJMMeAn7yDbTPxW8c=;
  b=mun9f81bbEpcgJWJvY7io398yY/RSHWfvC+cp4UgUiH9FWJL9lkwDECu
   DkFg5gNiGbN6PR7TLIXzT6pK98SJSkR+uwkbGMdsnQMeZcWHu5J08+MjB
   1+X+2JydA9PT1EOp06zpvFfj4c1xwUHYAbSKsb/miko2fZ1slkq8vinyS
   WmDDzOixwNrcPrAvft9fZcYFhYIs4PgcuBTPl5FcOBRplKZHUaLwnqzC4
   09XGJIdNbwcfgI6cmFlXEiVHOjkwRBu1kNp2OXpAkxpJqjIKLiuW0wzFi
   oTOe8hDpi70y2Bo83chVRQr/6sXjZY8J2P2M0kcDHGCKXFZjRmtM6XmXB
   Q==;
X-CSE-ConnectionGUID: iwqZy8vtRv2hR7SKl5SXYg==
X-CSE-MsgGUID: 9MvkX/pIRXKxMzCNuj444w==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="97295611"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="97295611"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:34:23 -0700
X-CSE-ConnectionGUID: Jm5NJcCLTj28lqcf9DKrlw==
X-CSE-MsgGUID: MY2CS7BESiGyassPulQVfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="259838208"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:34:21 -0700
Date: Mon, 16 Mar 2026 16:34:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: ssp_sensors: cleanup codestyle warning
Message-ID: <abgU6sQoXB4jOgo_@ashevche-desk.local>
References: <20260315125509.857195-1-sanjayembedded@gmail.com>
 <20260315125509.857195-4-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315125509.857195-4-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 15, 2026 at 06:25:09PM +0530, Sanjay Chitroda wrote:

> Reported by checkpatch:
> FILE: drivers/iio/common/ssp_sensors/ssp_spi.c
> 
> WARNING: Prefer __packed over __attribute__((__packed__))
> +} __attribute__((__packed__));

> CHECK: Macro argument '...' may be better as '(...)'
> to avoid precedence issues

Two problems — two separate changes, please.

-- 
With Best Regards,
Andy Shevchenko


