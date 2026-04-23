Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F92363C5B
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966393; cv=none; b=BL0slGzUS0l+Uz0ohOgXtYkA4KXc0PiHbWh4vxQbURJkMRJb0tr5J3Vf+S6K1DbjSyDuaupri7Q29QpF/JZGe28I61G6BQCdsfMNWKv8yYOocjWnXnVKOhcKOwHzYEWPHvz7nWfgGTr65pD/s6/UQkmzIm+tzWXzOLus7rmzQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966393; c=relaxed/simple;
	bh=KB/u2mdrCSMXiG1SOZGn9IXBM529EAuAMtkHe00G64c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBXua8ipUEmT63Gn5sCaoWW3nBDcXtFEOz/71roDXJ1ztPUi0iP8PgJ7xvRg/ObTBZkcqgYIwI6uY1N676S2BBU5QHthxjjmHy6GOvnGH2x+PzpwsYhr17whQ9FdQfFmN4DBXEZ6TTwiXEpNqrOoiFmluIJIQraj3iraafaGapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+M0Lixj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+M0Lixj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776966392; x=1808502392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KB/u2mdrCSMXiG1SOZGn9IXBM529EAuAMtkHe00G64c=;
  b=J+M0LixjCfS/7fKiexVfB2D2T5GUnuW8x1YOf/117rWt/lSWdQCGzpNy
   sBAF/19nlUB8in17uFR91e+jn5ZtRCZA1c9OsWhlUexLkI3zctWx33otM
   8EEbqgVY8hyAvhYNTsRLVveLvfCtF1DdbyssKnzvQNZPiH0HTWOnfbfb1
   GW31PBbecwmCUijVpEUCHz8+4pJXcr9OGIHQz/EBlDOTooEDiFDp71O3P
   qn650Rt3LQ7cEpmrxxTz++lppMryRNtOpYgOtYfrjcJRYry5iBNioYI7C
   WZLhcAYAFmI/PnKfK2BHclt+f78+1kuYUj8iNHJdhj/4Wio9hmvEhQQZl
   g==;
X-CSE-ConnectionGUID: fN5QrzoZQgSDIz6asly76Q==
X-CSE-MsgGUID: XURAl/fhQzCpuwRKLwa3fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="81549696"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="81549696"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:46:31 -0700
X-CSE-ConnectionGUID: qFAXaM9NRSe0F8nVv2Jxew==
X-CSE-MsgGUID: j29f2UkPQ6GUH9D3S7MzjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="263122354"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:46:29 -0700
Date: Thu, 23 Apr 2026 20:46:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	nuno.sa@analog.com, Eduardo Augusto <eduardoaugustoabc@ime.usp.br>,
	Christian Barry <christian.barry@ime.usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: adc: mcp320x: sort headers alphabetically
Message-ID: <aepa8jD4uBrtY4WV@ashevche-desk.local>
References: <20260422222553.67660-1-gustavo.pagnotta@ime.usp.br>
 <20260422222553.67660-2-gustavo.pagnotta@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422222553.67660-2-gustavo.pagnotta@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 07:14:12PM -0300, Gustavo Pagnotta Faria wrote:
> Sort include directives alphabetically to improve long-term maintenance.

> Signed-off-by: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
> Co-developed-by: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
> Signed-off-by: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
> Co-developed-by: Christian Barry <christian.barry@ime.usp.br>
> Signed-off-by: Christian Barry <christian.barry@ime.usp.br>

Is this SoB chain for real? If you want to give credits to mentors or so,
it should be done differently.

-- 
With Best Regards,
Andy Shevchenko


