Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08033542F8;
	Mon, 27 Apr 2026 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281286; cv=none; b=SHhN6SM7KWjpbTiZk7EIvkgBfbzvztFNOKZmEHVIRU+r6Yv5Kj1pWeanrG2wm6EsvmLs4pjr66UfRQDuoSFUgcNNTfV7r9SWtGmmc0d3TPD5kXHZziVqTA8Xc5s8gsbkWpslcTIUXeHa9nQITiTNRZPWlcwBZ19agI3YUkWgfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281286; c=relaxed/simple;
	bh=L+VUSESxJWMNTH6/hMlY6WIVcBb885TUUzzoYZQMV9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgeOjFf/krrZIX3i+gnPCG3kMUj8UAnfEAXeh8IHt31MfqHl0ZFLKh7qXlLcMEqDL7wSN5fau+WZkrsRTEBzPxp8atwEMjgr2UcMFzMTebwueGWfTgYc1EB7QOVRD9JwqFOFwGvuWFSpEy1Lzt6yjEYbYjVIoW/ya3GLnUO/9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6XPq6uH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6XPq6uH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777281285; x=1808817285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L+VUSESxJWMNTH6/hMlY6WIVcBb885TUUzzoYZQMV9Q=;
  b=Q6XPq6uHzpjtctzhpyYjTUKVZUS/ttMP+ub7+MlgOfbQfXZXmwNm3ZaL
   dpvaCoIdmDMkI/edIIGd6+ACcPI/+xraSr7GLR2N88GB20cqTJTA5uwhm
   ftT09Wb393KCVtxcy7Scq7zwlbIrni4I4rookROhqvYCFvRpCKgryq9LR
   UDXwYfZCmVS3Vs9YZgGWxY07QFosjpKG8W/1IYwHmsqK6u/TRjymG3QU4
   +k2yGd2rRYb+2hWGvwcpMfVU4Cy30Rie9oVHigmN3WNbE6/agm+H3CkRR
   yo7EZImNSnPrps7HUDVgyAfKpvtMrtqjHoIYuKzCQgJJND3LBLv2XvECX
   Q==;
X-CSE-ConnectionGUID: i9yRuOEmS4ql+F5bcnPmkw==
X-CSE-MsgGUID: Tk7WRbWBSSCcEQrM594hcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88477582"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="88477582"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:14:45 -0700
X-CSE-ConnectionGUID: uLrFl3k6Tdyd56DCCZyGYQ==
X-CSE-MsgGUID: Q7wB3U6GRN6hTKKuowFyAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="233852015"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:14:43 -0700
Date: Mon, 27 Apr 2026 12:14:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] iio: adc: mt6359: fix unchecked return value in
 mt6358_read_imp
Message-ID: <ae8pAGBGGOvsURka@ashevche-desk.local>
References: <20260427085458.38546-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427085458.38546-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 09:54:57AM +0100, Salah Triki wrote:
> In mt6358_read_imp(), the return value of regmap_read() is currently
> ignored. This is problematic because if the bus read fails the variable
> val_v remains uninitialized.
> 
> The function subsequently assigns this uninitialized stack value to
> *vbat, leading to incorrect measurement results being reported to
> the IIO subsystem without any error indication.
> 
> Update the function to check the return value of regmap_read(). Ensure
> that mt6358_stop_imp_conv() is still called to clean up the hardware
> state before returning the error code.

Sounds like this deserves a Fixes tag, but the problem is that the whole driver
is written like this. Why does having this fixed make it special?

-- 
With Best Regards,
Andy Shevchenko


