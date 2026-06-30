Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70060385D9E;
	Tue, 30 Jun 2026 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822500; cv=none; b=sz0am4jb2UQNt2Qznvd0MdZSKNgJ8c+7f0TQiGtO9vTknB9fmvossYZQI39I0l0zm49JTSnHfoeNof8lutNk2Mv4mCPmyh0W4AY+mTusf+ct8eBHRs5UWIXudQzO95UeL8YJHG70ibh/Ghvbcv9YZ62zZZiSdTenzv5CEQ5WTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822500; c=relaxed/simple;
	bh=6Oav/jh6FQcY54ohmIvBnvDmcJOnWGwuTAfSCzZdQlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbZedxvbSdYdl2fw0J76WfSV5gEgjvchcHjs6h6SIji5W25bV/7FzeZfS7/Hx8k9tIukvqOQy1Y8CUgGIz9f2dIRTaRYM0E84sTzyKCnfqL9XmP+aQ7dwKnnl9a6+mBAzwcZu+YrYN+IGWSrW7xluo8abTYwdFsepDTQ+XHPdz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2pGcS2I; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2pGcS2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782822499; x=1814358499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Oav/jh6FQcY54ohmIvBnvDmcJOnWGwuTAfSCzZdQlg=;
  b=R2pGcS2I1ygdLjwcOJCNacC/alrluzpQk2Tiu4mc+UQLzDsVndur6UQI
   r0Qp4Mwi5mtyg3PjnrlYsXoaU8f7unq8FZ1+Nc4npuuiiXaQWHJ18gabe
   wzZJm6GV99KQKeZP/gPnqOfjcT2bEngoZWQo1fiE6/0hxKJPBmc9C+H1y
   +k0qGkbFaeQudc1TfBmM/2IOrbckkqwXJS8nJpdypmmZC8qMkolRrTdOJ
   ZRiybVpSBCswG8Ui07YFh4MNULhkM7xHwAWMUolbbZxo67OCBCKeYPXbm
   cDY6QDNDAQ1h8FpHs/NgnRcE7pvJmqhgmIi+19nlvZ0/cKmBR9FrdwGjV
   w==;
X-CSE-ConnectionGUID: cwwVxFjdSSSZ9Tjy7uuvsw==
X-CSE-MsgGUID: bdHvF+ipRVqrRgCcUL5rzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82522970"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="82522970"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:28:18 -0700
X-CSE-ConnectionGUID: bVMpU3I9Q3ur9Bfx2ZtRCA==
X-CSE-MsgGUID: GWvvekUsRgGmTs1lkAKWvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="276536485"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:28:14 -0700
Date: Tue, 30 Jun 2026 15:28:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	linux-iio@vger.kernel.org, andy@kernel.org,
	antoniu.miclaus@analog.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, dlechner@baylibre.com,
	duje@dujemihanovic.xyz, jishnu.prakash@oss.qualcomm.com,
	jorge.marques@analog.com, joshua.crofts1@gmail.com,
	krzk+dt@kernel.org, linusw@kernel.org, linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com, mike.looijmans@topic.nl,
	nuno.sa@analog.com, robh@kernel.org, sakari.ailus@linux.intel.com,
	wens@kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
Message-ID: <akO2XF2dejbao6Zn@ashevche-desk.local>
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
 <20260622221550.374235-2-jakubszczudlo40@gmail.com>
 <ajpO9zaZbIl3x1uC@ashevche-desk.local>
 <20260629235118.1abc4067@jic23-huawei>
 <akOqIVDibovrbBAK@ashevche-desk.local>
 <e966a0dd-d8ef-4009-b609-546a48bd16f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e966a0dd-d8ef-4009-b609-546a48bd16f4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 30, 2026 at 03:08:42PM +0300, Matti Vaittinen wrote:
> On 30/06/2026 14:36, Andy Shevchenko wrote:

Thanks, Matti!

> Just my random 5 (or so) cents.

5 because Finland doesn't have 1 or 2-cent coins :-)

-- 
With Best Regards,
Andy Shevchenko


