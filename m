Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9767830BF6B;
	Wed,  6 May 2026 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055692; cv=none; b=axsdk2NvjzP5cuOR0gDuDDbAElNQM1N1DKGf12WUlKm/+DA3eHNZzJ+mvZrEbYaaGSCC1dni0QN/F7VybzNtFTLtYVFbmaLOcz13sJ45QA5numkYYW3kmhmtl7b7mZFjsckQjiYDWIjMvSrPQyWGw5S0vesMf0U0yiJaOsKq+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055692; c=relaxed/simple;
	bh=2B22UBrSzYuHgs8Xe0BP0mH/NgtY7kHtbZrhpV+i9g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naNQlQtPXw4phTk5Lk3kYYaQoKmFInv7PTLqaj7Z0ITMJ6QEWmEQHpLipTRmUjKrjn6HecMdpcpUWyseJQkQjhM6Hku/BqPkE30oTOjrMXF+O0egkgwFoeyfpWNmAkaiBwaWpHC1AUKSB8sXlbVXf13UUjcRNLEcPQBMxGrUKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtXX85Gd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtXX85Gd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778055690; x=1809591690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2B22UBrSzYuHgs8Xe0BP0mH/NgtY7kHtbZrhpV+i9g4=;
  b=MtXX85Gdmpx1+dUAKLDhZGq5hO6Pn0rqeVLxPo3iimbj1JyfoqiFtDZz
   u5gcvuhjKgD0LGu83cMVqXbmUNlxi+3pz3/AdebUQ2QQdqrM+6bOnkRUF
   HP87zZG5irsQeax33a4EX229qGBwCKc5iHEwO8r4bIbukdqkYdmHfd5Yu
   febc6IygzoZOcDcKUGzj/ICLFG1vMTJGFroMPDj5tpA3Dnlon3r1Y69SJ
   CJQifVTDtd8WPVEfNrfl62qGGXJgMjhs4v/qrYKa7+UbMhIqxpRdtfqdt
   nWz3FiQQTWLe5rhlSZOI/nwgoBmO8e8naKqZ60TuTiMuL+jckN173ping
   w==;
X-CSE-ConnectionGUID: ykGCAHX7RDGtMi7VWtoSvg==
X-CSE-MsgGUID: rLy5yQNeSa6uGa6vlElPGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="79086199"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="79086199"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:21:30 -0700
X-CSE-ConnectionGUID: ZlOg5uRxTsOiweJHynY5DQ==
X-CSE-MsgGUID: jKoze99NRTKolopvR7ZPqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="241074864"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:21:28 -0700
Date: Wed, 6 May 2026 11:21:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 14/18] iio: magnetometer: ak8975: switch to using
 managed resources
Message-ID: <afr6BdhnQZMV_kDn@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-14-831b9b5550fc@gmail.com>
 <CALoEA-x4GGfSeurgMAcOguXRB62ygEj-5suMVhd0x4DjXmTfcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-x4GGfSeurgMAcOguXRB62ygEj-5suMVhd0x4DjXmTfcg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 04:34:29PM +0200, Joshua Crofts wrote:
> On Tue, 5 May 2026 at 13:46, Joshua Crofts via B4 Relay
> <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
> >
> > Switch the driver to use managed resources (devm_*) which simplifier
> > error handling and allows removing ak8975_remove() method from
> > the driver.
> >
> > Note, on error path we now also set mode to POWER_DOWN state which is
> > fine. Even if the device is in that mode, there is no problem to set
> > that mode again, it should be no-op.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> BTW, Sashiko timed out while reviewing this patch, didn't even know that's
> possible.

You can ask Roman what to do in such a case.

-- 
With Best Regards,
Andy Shevchenko


