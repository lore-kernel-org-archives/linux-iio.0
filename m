Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064C38C2D8;
	Thu,  9 Apr 2026 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775726982; cv=none; b=dm1maBgusM5P1MOY5lG4OWskpR/aMQGW/gExS+O3oCts36Z1a+ChxceHlGLJjszfCozXqIz06G1nS3EQ21DNac2KuUNsSWUiNUoKwQ9Ww5/Wo7iYhha8elIUWbEl7866tgEtCwG0nVvwddHrtYO1dMmLQI6OUM+3Bch9tb8IATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775726982; c=relaxed/simple;
	bh=XnKx2MkzYvigN1NdHgK8JUvv9eo4psSstsni3PB6dDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKZeCmcc9JSXOQ6C+6IHfjtbVDI+OWWxHrG5q/U8Kq2v84uuxiAVgM6bstginIXr2BnTDVylCi31JlC8paRnitJUh/XiM5MYeIHt7a0aWd7+ZJhwEgXTXQoN1wU2CbPmTg99tZuR9Rjtx3yuEQH+6EV8+ak23BkyUnOensJFqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoMlMs2W; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoMlMs2W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775726980; x=1807262980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XnKx2MkzYvigN1NdHgK8JUvv9eo4psSstsni3PB6dDk=;
  b=MoMlMs2WlmViEtTXIf3m5CpOwdi/OhL3/CDHe4MTXTnxKSuX2Tu/6ghI
   Z3QmatV/q0PuDl+FkE1nUBHfpHsbfGfA0lar36TTFrMOAQwXrU2f/rK0u
   mKA3rLwvsXLeQJQuTWs8LixFnF8bsiBrR9mYNVAaleQtIfgMXDkxobvK/
   BB+1rkT/6K0tb8d4qp2WKRUF2YP5v3S3yRVysYSZRty99+X6vFz8IDCFX
   b/81UBo0BfVzGwbSxxwGEOUFamP+173G9G6xgG2tof6mil57atV8T+3kc
   ZEFG68NfsNfUjem4EbBMuOlGbMFpp6dpFSmuF5eIPGPdj8MT7Db7vcuGW
   A==;
X-CSE-ConnectionGUID: ew0gA4sbSx+n1Bk654UOcA==
X-CSE-MsgGUID: oXD9zZyZRJGxCd8oUjIuSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="64267751"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="64267751"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:29:39 -0700
X-CSE-ConnectionGUID: 09NRn/j/S8O3SPiwjUvWIQ==
X-CSE-MsgGUID: bS+1Ng7XTdu7Ip2WQmLTng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="222224744"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:29:38 -0700
Date: Thu, 9 Apr 2026 12:29:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: light: vcnl4000: move device tree entries
 into one line
Message-ID: <addxfwFDto5JuT4X@ashevche-desk.local>
References: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
 <20260405-vcnl4000-drop-enum-v2-2-7c8dc98c3974@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-vcnl4000-drop-enum-v2-2-7c8dc98c3974@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 05, 2026 at 07:08:39PM +0300, Erikas Bitovtas wrote:
> Make device tree entries one line each to save space and LOC.

I think this patch is better to make after the conversion is done.

-- 
With Best Regards,
Andy Shevchenko


