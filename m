Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F7E3403F1;
	Mon, 31 Aug 2026 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197277; cv=none; b=oM8PlA2XFoAMCZr6HlWGOzWzDrEkFWoNsSTIg2+mWyhxuYdquaePesnamLxRaaoFvcgcPPPsR9Rmk9l6MUU5mF5nRYjQkCvfMw3dZNChH1cCwd3gANapcB2KdilCYMdw2ljZ3UFHGg3brcjkYodND22OiDkems7F32qCwRcnsb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197277; c=relaxed/simple;
	bh=5QGJGwJ1DdD4TDbE6b7CpBXvbRH/SItT61WmcLpaYSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRQq/7c88OGMR2xU3RCGPFfjZBGbJJmTPzeNhT+i3OMTmHhTb3X3rfDu/BRElKgsEzetrgTF4UP7w9Fem9od7SKW/SDDLctiMESgtT6obyJgjxnuSlC0HhDXPYTNRAdn7zPJTIvZebsYMEZ2qZd89qTDWDBupJNeymytIZ1FF0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqS+AU6u; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqS+AU6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788197274; x=1819733274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5QGJGwJ1DdD4TDbE6b7CpBXvbRH/SItT61WmcLpaYSY=;
  b=YqS+AU6u05qg6Goo59OfihuYHH+aTxSm09eKIJUpFvVYqvM1lZctVaIh
   iHBFi6/izrTyqwtvfavoDZ0gt2YmFk03psgB6URNzAdNdavhnq4W4XnM4
   VD1yKrI+YXX6LcMpLTz0X850JdYQ+p9I4UFYypFPI6MhhmPU8DVhpHLKW
   BKi7j0FPo3gdymBC5IxqJxQDz6gBE89dG3HA8e2Vthmej8sufYdk8QG1N
   RoH9yCGXF1CtBw5SSrXANbNfzACkuw56jYh82+z95HTf9hfcwSIjII6NE
   82+NX9J4siBBrOjbaGEtmozHP5bbk8EFHvmrDhr57phZWbOUjqTdJak5W
   A==;
X-CSE-ConnectionGUID: KrJLBGtgSXyTmEvRX5leIg==
X-CSE-MsgGUID: y4V5aY2VQIyLqrVpVftydw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88736874"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88736874"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 10:27:54 -0700
X-CSE-ConnectionGUID: Ft87HSaHR9mAmgd/z4SPYw==
X-CSE-MsgGUID: tsOwvMyPQyG9m3SnwIjR5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="267050356"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 10:27:52 -0700
Date: Mon, 31 Aug 2026 20:27:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akshat Chandra <notmissinge@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: add SGP41 driver
Message-ID: <apW5lW9_L-rpT3jS@ashevche-desk.local>
References: <20260831151235.64076-1-notmissinge@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831151235.64076-1-notmissinge@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 08:42:35PM +0530, Akshat Chandra wrote:

NO, we do not accept this.
Please, try to read kernel documentation and follow it.
This patch is far from the kernel standards, sorry.

I would recommend to also read others' emails in the mailing list (linux-iio@)
along with the code of recently accepted drivers (can be found in v7.3-rc1)
that follow (more or less) the standards we require.

> Signed-off-by: Akshat Chandra <notmissinge@gmail.com>

-- 
With Best Regards,
Andy Shevchenko


