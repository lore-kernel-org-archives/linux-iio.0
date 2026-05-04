Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0D347FEC;
	Mon,  4 May 2026 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884605; cv=none; b=H/K3WdHMPSTF2DhzuhetYryu0xwEcxxoVftZqG/0xgux13jEZJlcCHdre7SYHgJJQ5I50wksrlQxKfRQeUKhmYF/g5dKDkEK0LpHjUs/mmOrouCeBPBy4vAM2WHPgTMkK2Q5z/VtyormpdIz8+tHgeEoFv767W1UqubmeYlEpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884605; c=relaxed/simple;
	bh=E5/3IXrHr1wWCPFOgDSzjncuDvgx7ruERQsETBo7jWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJ3dPUfhEU9uMmixcqXbsSSNBlmHcC+Oal9kH3RppYrrJu1MtBXYvltbpa6Z9XOoJJj1RiwOA+mVfdGF/DXfcHoPYBaz1YVA3KySz36+jwmzfte9aQIvDw8xzE6+X0s/YFeY0pQePt83epn88/SqFS7dp/nWL8KE0Mk4XRkmYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9JLj3vq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9JLj3vq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777884604; x=1809420604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E5/3IXrHr1wWCPFOgDSzjncuDvgx7ruERQsETBo7jWs=;
  b=d9JLj3vqzb3ULaakrQ96vHdGm+wyFGECMVfoDrGBXeEdj/eyGe23dHt3
   +owzR/QDcOZvNAL2u3o+EkK5lOT3gDyq5HE+QTRAMw4IhOkRUkZwF8YbN
   C7tmqFJ74l+tBZSAkJPkpVa1BXvyYqDJ6g0k9Aq73cyQ67k57YEJAMsxm
   yZOtSCHr+XiQnu2+HdCloxG3iYjfuXjnnFmlzfa4r0oP5LjllldDcCVm3
   ENn0WO/uR4G3pmEpSTelfblCG1vQvpMPI0JSjg25g4DnW6EBvnB56VREY
   UGqMuBz0EzYcXH/QzcKPbN335k4c9L7tz4RVEJT1pCruOFVfi3KX8jGpl
   Q==;
X-CSE-ConnectionGUID: wrfLhuYBTNCWyuXUYqPegA==
X-CSE-MsgGUID: YN9+YVaUSKywOlijYyOTJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="66270002"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="66270002"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:50:03 -0700
X-CSE-ConnectionGUID: jgvuJRxdSRamJU3X5GEdAQ==
X-CSE-MsgGUID: yiwXgVSiQcmvUkVUBEXU+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="273571272"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:50:01 -0700
Date: Mon, 4 May 2026 11:49:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/8] iio: light: si1133: remove unused macros
Message-ID: <afhdtqJVFPLhprLI@ashevche-desk.local>
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
 <20260430-si1133-checkup-v4-3-fb3e9dce41bf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-si1133-checkup-v4-3-fb3e9dce41bf@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 30, 2026 at 05:04:23PM +0200, Joshua Crofts via B4 Relay wrote:

> Remove unused macros unrelated to hardware definition.
> 
> No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


