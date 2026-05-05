Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D192264CA;
	Tue,  5 May 2026 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969960; cv=none; b=jzGtbdvynCF/n/L3enVyFpKZsjP7awWFNNBT0+sEbz3jElByKD52tm+K9oeJ3/QAR+XCxyKDGX3hwBaJ07ia7jA5Yzg8uy3Ny1L59N/6qfLfvj1cX/0RqNJmK3CFAfalKCevao/HnKaguLiATLPwcYJeLctJlfplOCmqS+oUhQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969960; c=relaxed/simple;
	bh=lPBVBaJ1RuXmNHoSGWo5sczbzS6rH0e5GCDlSBKixvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTDrFUSoEmlWyBc4EnMjiwERQChfh9fwlJw5h4+1JAg1fZQ1BE0kXgsxEtSriAGg+f7WzHZao45YPYjOA1rJ8QT0+eJrai7P2lTK0LvvSJLlU/k+NZU94q1yFfDHt37Ri8J+d95jD9vNB6Mzkf9IPFdGls2NgI9QxeW6/cfXOHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dquUDED/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dquUDED/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777969959; x=1809505959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lPBVBaJ1RuXmNHoSGWo5sczbzS6rH0e5GCDlSBKixvQ=;
  b=dquUDED/B95YGGi++i3Ee6wRcTbpx0oJK+JEUyVHEB33GlVW3aBUQUPn
   sEXtvCmkjHHRiLmXCIebY5kJ6ijVHasutuE9zRoPxKck2qSWJzNdfTZdq
   THmW0AEuXP4HwuEHVC1OIlEsURBqrSSYbsE6n5jeV9gKWqfWx5jpThYjk
   JvxkxwGXF2Oi3NZE1oJoTBCESTFyts/R0dW9vcFBNyVAA/alXwAsVFGB4
   z4caP5rCTYSQqp9pNQ7CdqTb77ALMJMgMiDzDt/InN7sOeIAVPGIXYqHO
   z4jT8PE7I/Br23Qbq+/AWYaTu/McXamvXMGmwnWmGraD2AwIX5P/k4uj5
   Q==;
X-CSE-ConnectionGUID: ipa2968jQai7VoRSiRu/oA==
X-CSE-MsgGUID: K3NxgO3FT32giAWiSClU8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="66362996"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="66362996"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:32:38 -0700
X-CSE-ConnectionGUID: DeJWMtcvSsOE7r+U9VuFsw==
X-CSE-MsgGUID: D5txDQIUSHOL8ZPb5COYyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="232613705"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:32:34 -0700
Date: Tue, 5 May 2026 11:32:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: Re: [PATCH 09/10] m68k: stmark2: enable DACs outputs
Message-ID: <afmrIFscjnn9yaxN@ashevche-desk.local>
References: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
 <20260504-wip-stmark2-dac-v1-9-874c36a4910d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-wip-stmark2-dac-v1-9-874c36a4910d@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 07:16:47PM +0200, Angelo Dureghello wrote:

> Enabled DAC0 and DAC1 outpus disabling shared ADC inputs on ADC3 and ADC7.

...

> +	uint16_t val;

Why not proper kernel type?

-- 
With Best Regards,
Andy Shevchenko


