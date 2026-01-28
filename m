Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7C7E105;
	Wed, 28 Jan 2026 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603655; cv=none; b=rDuUzV8yooGYtR/3gFCr3zFQEeRuqHb1lyomtLaVtb5j0Vvm7IuiTGzhTEKeQCnrPAgXHA/sgFlpqGKYZF9VnWp1TTUInar2Beihyncths3ZCwNimrqxuM0NceMo9mxlUby2YnEvml/X8Zqy9KHnLLEVbZmPqws5RRZoeg1mhP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603655; c=relaxed/simple;
	bh=bRjNK2yYmZdm862l0t3nSXcWJ/swA3XFIKygtz81jvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1dShM5gn1opLq6a6UWMrxT17r6MqhR9XRRSeh1Qm5hJBHxyzVaDXs/SiMM3ZufyMWC3sfxzU7g47r8wWXM6RvtLxGO1g1rzShvkNmfzumBtlAHQDnkihLjS2+I8WGzD/PP5b6AadzBgAe05RQBhrHPHfRvY9bod5PESXaJaucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEvhkYbh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEvhkYbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769603654; x=1801139654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bRjNK2yYmZdm862l0t3nSXcWJ/swA3XFIKygtz81jvs=;
  b=PEvhkYbhQiSgl6Dd3KIX3PL6WaX6B6ZBWPnN5/w6gKkqBFwQXMXj9xCZ
   RnH2cO6um94ZQsD6nXVEXCU58GwHbUcIxzE8331p5VoUOGE9FsAZITDG8
   poBxiFpBcsXLC/A2fR2SCC3mJZRllBQ0aVM1FcCU9ZiJV2FDodBPRj9HU
   bTvBq0DTNxSERoyiOAcz92dfD0DNfSlkT0xPqNVD1Ysj4DB++p0D5KnsR
   QL14dYZIpTUn7ZYZP1aiiTnA5yJ4eMgpUCi2TGw56ICx50g78RaeZnOzb
   R3847fHQK/nFcqjsLnShe79EK8KwA92OH8AzAwr0JxtQ6on+DEtp6Bdk5
   Q==;
X-CSE-ConnectionGUID: r2xtNtmgQWidHBIyphmI2Q==
X-CSE-MsgGUID: OCyB/Pp4QWKlCj75wvrFoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70713956"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70713956"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 04:34:13 -0800
X-CSE-ConnectionGUID: E6PPdn54RACdaoWfPKP3GQ==
X-CSE-MsgGUID: JLcTLA4+Qj6ws1808auhpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="213229959"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 04:34:11 -0800
Date: Wed, 28 Jan 2026 14:34:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 20/21] iio: magnetometer: Remove IRQF_ONESHOT
Message-ID: <aXoCQLWD62SchgR_@smile.fi.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-21-bigeasy@linutronix.de>
 <91aafb3174ca943e240dd8164f27080eab085e29.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91aafb3174ca943e240dd8164f27080eab085e29.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 11:40:56AM +0000, Nuno Sá wrote:
> On Fri, 2026-01-23 at 12:37 +0100, Sebastian Andrzej Siewior wrote:

> Reviewed-by: Nuno Sá <nuno.sa@analog.com>

There is the v2 available.

-- 
With Best Regards,
Andy Shevchenko


