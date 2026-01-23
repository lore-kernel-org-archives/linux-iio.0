Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B0350A1D;
	Fri, 23 Jan 2026 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155387; cv=none; b=KnSHsxC3uPODp6vPVmK4JDWs7JZ1hOiMoAxS0zMJFM0OnkksTsYfraxEXBtkLYEx8vp11Xm7Py43Bg7AP0yYt3bp6IIp6JL+Cu3E3SmwmJn1KI6LN+yKT1wTrx86heMD9HsG9ebubh1YRcMN3RcMYz7EBDO1In+cr0pxR8MqNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155387; c=relaxed/simple;
	bh=c1ab4LkOHQ8qfkP3VSw/0QTzrKUlCilO8pM3vKJxZPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dz/jlki8ofVKEbVYdcWeWK4TxVc9auRNsJSUmCYom/Ok7G76C8K/im+9M7dDhAVVqr3zfR+qRdRKW0sNW01zMehtDzq0BQtyPaX7XwCg/LCNG418gDvWbielZ1tlYcJcjc2334TPijO+GkcoAbtitfImV+OD7YphX7f+62FxLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIFG1EMD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIFG1EMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769155387; x=1800691387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c1ab4LkOHQ8qfkP3VSw/0QTzrKUlCilO8pM3vKJxZPc=;
  b=mIFG1EMD4CSAOPKKD+G6NAlROkB+EG6cam/wLzM6IL2aZyWwdiQcx1Ln
   caqjmjUs5GtkHiGJbKlf7vUcpmCuQUB7YuHTgsm1tH5KJRF5fXN7qL2pt
   +YqPGBzy3CRwi2KrO3otxcQSZddr4vNNxB+G6eTI4UNAZIHrxtzgxlnDP
   ff0Xij6IYF1QWVcPq/L4KW1MEDTjSEydtJbkXffRkHU0zbQP7mpEsCjmt
   rHeEmQIpzIfsLIkOFTDBXBsztYFEZM7GZRahMH9Mri03LKSkapWNv9mcn
   dWXYlUyptQ2VLCAmKoveJofyLYXj05sTRB/ti3m/6VcXwpHpPT+/Fkj7W
   w==;
X-CSE-ConnectionGUID: E4OrWHPIR+iEKt+BciGp1Q==
X-CSE-MsgGUID: n9KVGcWmR5eSa1Eydwj0IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="57977916"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="57977916"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:03:06 -0800
X-CSE-ConnectionGUID: McHcWqU8R8iwWy9HDcsOpw==
X-CSE-MsgGUID: 03pI/lhRRSuCsHeNoBUD4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="238220472"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:03:02 -0800
Date: Fri, 23 Jan 2026 10:02:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Benson Leung <bleung@chromium.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Shrikant Raskar <raskar.shree97@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v5 2/7] iio: core: Refactor iio_device_claim_direct()
 implementation
Message-ID: <aXMrM4rDBHj0-pQU@smile.fi.intel.com>
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
 <20260120-lock-impr-v5-2-d4d22347041f@gmail.com>
 <20260122190401.510234c4@jic23-huawei>
 <DFVGV1BDS81K.3VWJ5CAO37A1X@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFVGV1BDS81K.3VWJ5CAO37A1X@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 05:20:55PM -0500, Kurt Borja wrote:
> On Thu Jan 22, 2026 at 2:04 PM -05, Jonathan Cameron wrote:
> > On Tue, 20 Jan 2026 01:20:42 -0500
> > Kurt Borja <kuurtb@gmail.com> wrote:

...

> > So sparse does change what it moans about with this one in precisely one instance
> > There are 9 false positives with Al Viro's updated sparse - I haven't checked the
> > original one recently.
> 
> Hi Jonathan,
> 
> Upstream sparse is kinda broken right now.

Yep, please switch to Al's version.

> I'm not getting any false positives on the locking stuff but a BUNCH of
> "error: bad constant expresion" on MODULE_*() macros so I don't fully
> trust it.
> 
> I know at least one subsystem maintainer is getting these too so I guess
> it's an upstream problem.

Yes, it's fixed in Al's version.

-- 
With Best Regards,
Andy Shevchenko


