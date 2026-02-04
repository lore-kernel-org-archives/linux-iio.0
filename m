Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E8838F229;
	Wed,  4 Feb 2026 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195868; cv=none; b=PO3riT1EYHGycFZ/yYbxW2YvcL4fO4BsWCpyQqRLeEcQGb9xLwnsVrJSswe+uG2geUlIyVbysxhGZnEb8O4CgAVv1Qa+V1Qc69JiEnS5xRlOF2u8fGWc1Ra4pY1GnejZkPqNbFGa/XiItYX/z/a7LpFXjJPXGuJmRCpjY3haqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195868; c=relaxed/simple;
	bh=M+vWK7sKLLnNbVd7LqxMHVuEyMxj5VyxnjX/VonKCAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd7+01f3NBYbhUcB6C1lkBvqflD2qZYWpJelbz2z4qa0L8Ci84CmbhhgyUXNmKk3lziFX67ikRQ+MQj2J3Q0XZisIy7S+MXHwTcN7AD6EmRVgUCXihnO7HwHO53bMekEGg6l9gkkGbgslp6XtsFIIdi5QhGRik0GgPBxCWvqzBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xl8cZ1dG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xl8cZ1dG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770195868; x=1801731868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M+vWK7sKLLnNbVd7LqxMHVuEyMxj5VyxnjX/VonKCAU=;
  b=Xl8cZ1dGFlUQTXRgnr4SAPv7nuoPz8v7OWZJ50sRHrWNqScJJ8Mkt2TG
   UBhJinEpjr3ffNgEzoP/D+tmTAduekYrExT4FiueIvbeK69koB1b6pQa/
   wmFuqYBgvTO8+1Lpp7dbMlGpII0g7p+5STIF9sAUZjCtf+e3MWHao7fGN
   cdPA0eHan5I/d6O06r6x1lHswMHyi7CgtmOaXR8AKHgU3+So5t2CkE0hf
   C0Ni5/BxlAfFMZTk9qfclyAEMMu7xkF0iNKrNEkqrnFXMlFXnGEDbp4Uu
   uyMP2FaVI0rrow6uyG+DfAHjFSd/U8M3uM4GU41WQ9ccl1W7CZhcxn6w1
   g==;
X-CSE-ConnectionGUID: o4hTXknDSLGZL8KGVLdtvA==
X-CSE-MsgGUID: xfdCX6eoQ4aehh65wnqq2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71274373"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71274373"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:04:27 -0800
X-CSE-ConnectionGUID: waPV5WEPTsuF8EkNl3Z1Vw==
X-CSE-MsgGUID: GhwomYxPSZGoU7n902YqJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="210151008"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:04:24 -0800
Date: Wed, 4 Feb 2026 11:04:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gustavo Bastos <gustavobastos@usp.br>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH v4 next 6/6] iio: sca3000: manage device registration
 with devm helper
Message-ID: <aYMLlij_VDbxcxbI@smile.fi.intel.com>
References: <20260204061219.791037-1-harshit.m.mogalapalli@oracle.com>
 <20260204061219.791037-7-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204061219.791037-7-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 10:12:01PM -0800, Harshit Mogalapalli wrote:
> Convert the iio registration to use devm_* helpers so the probe no
> longer needs a separate cleanup path and remove callback can also drop
> the unregister. After this there is no need for having a remove
> callback, so remote it.
> 
> No functional change intended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


