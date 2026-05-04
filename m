Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491FB35C1A9;
	Mon,  4 May 2026 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886334; cv=none; b=LweDnDWt1PrRTf+ogfC4mqrfcluY1MHO+G7tavzIjQTzcTIbIcjRA4zRHy3op5ScICKnrrc5d4+XsdGwepypp/4W48+NcGDEWF2+lFdpaI0EsWENjWx/LuksZpobwednJhefOXbQTa6rqw3UI4VVxRJO/+Hy+z6kqPVbpkR21QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886334; c=relaxed/simple;
	bh=KIl0w0Vvx1JbzRougE0WGiIEkV/vwYsaxSzNnNhwQnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXuvZqX9Ivl9pkUUU0v0rZ8VABm3L19+3UfzqmHDg7tflB+/OOztj4sriKPfSSNQCK1jLzHHPv8JY0yG+ym7/Dh2KAjmgyLa0uYZmxPBPZmGhJPFzzyyl19+dlsg9pEynrUJozEmWpOFEbb8kmGDpTV/Apu3CcC1ZI5ksZp5o7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Krg2SUnS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Krg2SUnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777886332; x=1809422332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KIl0w0Vvx1JbzRougE0WGiIEkV/vwYsaxSzNnNhwQnw=;
  b=Krg2SUnSERE3cwg8Oy7Il0FUF1qtSfq4AkejW+ydalgvJKHxGmbLv5Vg
   zu1pODr42Mxx6sTh52zYbWDcksH6tpCbTLYcDIYJaQDzWcWHMn/36lEz7
   ix8s4jDt6bynYv8KjDUiIJBQBOGu+hGX/fFoCuSJYKlLDRBbEyNvLj9iz
   z6WJw1+U44uh6AK5w1H9u6uBluVQGjNKQ6L9SPWUWHUIE0UeybRflCa4L
   AyqhOUZfIHzi3aT1eCYn6pDDKUJn7OLIeJ/q9WhU5xVWGkNSu091s+N5y
   Q2e+Y09xML/XF/3fTYFpIb1/JZmBWZ/k3DtzviLPkOExlD8z/q4YxOLjc
   Q==;
X-CSE-ConnectionGUID: SeE9R1gKSbmDNZh9I9620A==
X-CSE-MsgGUID: Xa0+fnj5Rc2eIeHYJe9E1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78732017"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78732017"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:18:51 -0700
X-CSE-ConnectionGUID: TuRO6cPUR2iwZaJgR0AIrQ==
X-CSE-MsgGUID: nbTfzC5dShmYYE+dLUGCAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="259111145"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 02:18:50 -0700
Date: Mon, 4 May 2026 12:18:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v0 00/14] iio: magnetometer: ak8975: Additional changes
 to the driver
Message-ID: <afhkdxsxDbUDqG9g@ashevche-desk.local>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <20260428173540.28b7913e@jic23-huawei>
 <CALoEA-xm0FGRk1rUWOO1YvzczC86Bgvu-t4Fe4iy3S_LCTygRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-xm0FGRk1rUWOO1YvzczC86Bgvu-t4Fe4iy3S_LCTygRg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 11:13:36AM +0200, Joshua Crofts wrote:
> On Tue, 28 Apr 2026 at 18:35, Jonathan Cameron <jic23@kernel.org> wrote:

...

> Given the relatively big backlog of email in the list, should I wait a
> bit longer sending the combined series?

I'm fine if you send it today or this week.

-- 
With Best Regards,
Andy Shevchenko


