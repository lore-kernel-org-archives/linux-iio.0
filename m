Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B11D88D7;
	Tue, 17 Feb 2026 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319000; cv=none; b=q2c/skR0VwW+g0+4B8bzhoZmwnXgpNGE/pBbQcypHxsGqtueyOaSrVMf5XrDU4CPRatBg+h9Kq40RPOVtgdez1hmaJN7D7JvWaA9jN8UymdyLEJjps7B+tC6tlc2wyfrT21947VnLNaSU03fz4CUbS3vvWXVBv7fNmxGHRSDyiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319000; c=relaxed/simple;
	bh=U64Tt5ViSZSh6o8oe3+ycoAgri5/tJGret2prJ/RZ9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlKKnIW4tpy2LYjbfYyQLhHH0YKD3s9vSK1G+XsIeZKSOSNR8ylAzwloqZZL11vS3/WBazuGim2sk3YCEsQlrPFudDdscPcJSlereF8I1JmocD2V6KZjip1IQ7UACJ0KOnY1VIJen+LHgvkC6eh3+DoaEZgGPHKt5SnGXHb4D4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqcLO1xa; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqcLO1xa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771318999; x=1802854999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U64Tt5ViSZSh6o8oe3+ycoAgri5/tJGret2prJ/RZ9k=;
  b=YqcLO1xa4TxHEPMQf76I0LFghzJoeLRTfHfQnKU9yKurEq0gDJJ3Rggx
   YemRrxPKiTXfxVSjzcT+i9nmnqCUdowJ6pFjeCTu0vsm7o3mLYYQvnTaC
   wfW6E3HDyGC0MGOf9n+QSmS+pe8WQ7FNw0MzwkMpfokT+Y4tIkO0JfXQE
   5ioH3CVjxCtnSqpfD0Wb2SuPuOywtBpgY2Le9XMazwArdQI7DFk66wlMV
   dDmySTuTKtTnkwyrAvkkyJtSLxdSkrq6J01Ts63zneGX0ZZu8kIIs3eFz
   qkLKa81i53mS1NqtnjnaZh4kqP+/DxmhXCDbq/ZZYnsH9mijP4+tStSBd
   g==;
X-CSE-ConnectionGUID: am9wmQJkRraRogiz3vl4Eg==
X-CSE-MsgGUID: n+2bqv16Rtqz/HmSOdDebA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="89968591"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="89968591"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 01:03:18 -0800
X-CSE-ConnectionGUID: sBYcrsS5RoOzv27FYYbMoA==
X-CSE-MsgGUID: wxDFtPz6TcidpMi9znrzww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="212049678"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO localhost) ([10.124.220.245])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 01:03:16 -0800
Date: Tue, 17 Feb 2026 11:03:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: light: gp2ap020a00f: simplify locking with
 guard()
Message-ID: <aZQu0rFzPaDWnUfx@smile.fi.intel.com>
References: <20260216005317.11763-1-ethantidmore06@gmail.com>
 <20260216005317.11763-2-ethantidmore06@gmail.com>
 <aZLCe_5C8e82EMGO@smile.fi.intel.com>
 <DGGOWGRQGI1C.XSJ585TPVWZA@gmail.com>
 <aZQovkDI3G9-B_Zr@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZQovkDI3G9-B_Zr@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 17, 2026 at 10:37:18AM +0200, Andy Shevchenko wrote:
> On Mon, Feb 16, 2026 at 03:04:55PM -0600, Ethan Tidmore wrote:
> > On Mon Feb 16, 2026 at 1:08 AM CST, Andy Shevchenko wrote:
> > > On Sun, Feb 15, 2026 at 06:53:16PM -0600, Ethan Tidmore wrote:

...

> > >>  	int i, err = 0;
> > >
> > > Would you need the err assignment now?
> > 
> > I'm not familiar with iio_for_each_active_channel() but, if there's a
> > chance it could run zero times, then it'd run into if (err) with err
> > not being initialized?
> 
> Have you read my other comments? I also mentioned to replace
> 
> 		err = -ENOMEM;
> 
> with
> 
> 		return -ENOMEM;

Looking into the driver code, it has some serious questions about the logic
behind. I will send soon a WIP series for you to take into account. Feel
free to integrate it into your next series.

...

Do you have HW to test?

-- 
With Best Regards,
Andy Shevchenko


