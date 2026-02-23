Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB417BB21;
	Mon, 23 Feb 2026 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836581; cv=none; b=vCD35eMznOYtuv/aBFZHKpkKXo+qb3e1CLnWI+daeu4OifRw3ns0CB1RIV1LaiBwQbA1WgePl42Wh43x1yFQEzklvAqzYIhjxMlPnqrdbIMcORL7YAMkQf4V9cyHlUMZbXGllnm6T228givZOlnnFnqt3RZlnHys+iOZtWlaj6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836581; c=relaxed/simple;
	bh=Za6kNTROafhD0NJ3tD8R7Xtjb4CL21cNyc8p+KMT5tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skgOvR7Cb0mtR4XQ5sz0z99eK+/WvhZQZ6M8xoV++OCmtjNkdUS15Euv6/rZm55i45gRwcIFYwF1yyxUzvyNUoPKaq4R1gpGePnxl8fkQpkZZhMr+qATdqC3q1tsYXmNW+INtsNLuwXGQygrMEBzQXyaeyIklEnYLCQBYdo3Cns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECFonCKm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECFonCKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771836580; x=1803372580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Za6kNTROafhD0NJ3tD8R7Xtjb4CL21cNyc8p+KMT5tU=;
  b=ECFonCKmrVePyuCKkWyTRIpZj/CeAiultTSUz/73i6F8e+ctL1Vj7F4C
   9Jua++rSdFsgyK1vs05sT69IlDv2H79ufBRB4wAyc1/oeogJjUZrIsh8v
   nmv8ayxALaGfe7vBuEr2Et1Nq9aAPCjre/CKe5bWFIbg3/BRfcTEcdTUj
   yk6eW4BpVijm06hnSgsXGMeCI65GXEOBTCG+LBekHf35e/06CpyLdlZMx
   +znHGWkjUX94YYNTth5eHfyuXi/LTzsDBtHvJFrqE0W6Fkh338BBw4Zow
   Q4hANmcwwEY/n0OIrzHSOsPNSc9m72tdZnPW16UZPUVXj6+njmpoq5+nI
   g==;
X-CSE-ConnectionGUID: pEyd5BcpSdWpSRX86onLvw==
X-CSE-MsgGUID: Nli5BblFQc6H3yGVP+SkyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72925270"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72925270"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:49:40 -0800
X-CSE-ConnectionGUID: bsopCJfuQB2qDr6Of6mFdA==
X-CSE-MsgGUID: ea36aQCrRF+vwDc/e7Bg9w==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:49:37 -0800
Date: Mon, 23 Feb 2026 10:49:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: Remove unnecessary type casting
Message-ID: <aZwUn9LMaqb_tHeu@smile.fi.intel.com>
References: <20260222-nxp-sar-adc-v1-1-75e4cdb3ffb7@gmail.com>
 <20260222160325.1e4d1f49@jic23-huawei>
 <CAN4SLj2a9o_OBe-5AAbYKwaUpJrU17XBRgbJFt7XOOeBw8-UMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN4SLj2a9o_OBe-5AAbYKwaUpJrU17XBRgbJFt7XOOeBw8-UMQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 12:38:58AM +0800, Felix Gu wrote:
> On Mon, Feb 23, 2026 at 12:03 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sun, 22 Feb 2026 02:09:08 +0800
> > Felix Gu <ustc.gu@gmail.com> wrote:

> > Make sure to include the author of the code you are touching in the +CC list.
> > Added Daniel.
> >
> > I think this is simple enough, so I've picked it up now but I'm fine adding
> > tags or indeed dropping it if other reviews come in.  I'll be rebasing
> > or rc1 later in the week.
> >
> > Applied to the testing branch of iio.git

> Thank you for the reminder.
> 
> I used b4 prep --auto-to-cc and am not sure why Daniel's email was
> missed in this patch, as it was correctly included in another patch.

Please, do *remove* the context that is unrelated to the reply. See this email
as an example. Do not waste others' time on this.

-- 
With Best Regards,
Andy Shevchenko


