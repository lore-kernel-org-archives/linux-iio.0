Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E23BADAA;
	Wed, 29 Apr 2026 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456679; cv=none; b=NfvdX4o4I4LwKbRZdc5sQv831AyP8cNP2jxVrdHXC4i6IMsHGqv+jNK5Qzy89aaidyr9U1ddlwCEHBnqnIYy1fOtDOGmxLMioVBal0Yj3e7xL3BnewY8Xfnjl/VwJSv7pselvgYKW4I6P2G63clpznQ+r9TbsiOlVliU/SrKvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456679; c=relaxed/simple;
	bh=YhbnMlrU5ht3m0BaOIhwePCZEiCYv4sY86ZU65Bc+g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYa4H2N76YifRVuUyHRpJldcTiNHwBdYjZjVYBYNFQTz9Hfn+jGzCOmTElC9uJ/fuJaUIzHAGy00TWJjlX5JsjD4YRXRREbeycXrOjbnn5N6IPBFnBqOIoU3I/XmBmpd9AIhCY+8lRS5lKNViXP/Pdu4DI/5M4vd9OvPbW4858g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/qptKCW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/qptKCW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777456678; x=1808992678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YhbnMlrU5ht3m0BaOIhwePCZEiCYv4sY86ZU65Bc+g4=;
  b=H/qptKCW28qB/9Jy2uM0CXOFn/VrhPWsa531PAfEx5klT1rdV+L6P7I/
   fXopgdlMgSG/01q2ZwhW9oVkXXAmp5MpMdhi5l5JMqr4HJLkmM7x5gjJZ
   69qAdhuF/b9A5KzXNo0WPIa3bxlVk66+VJdLsX9cKIBA0OV+DPENBE7h3
   do6ZtnPPAoiideV7ZLqFEXQyoh8i/LZkkfGcOLwHtxBsz6oUUxUg8rVva
   cqzODERtrAJ6btosfmktHHvtOzE6nk4B9c8b8/eL3pD5g54FZfErGo+Hn
   LSdwpgzwUTrcIB3ex94lXJFBuvBaPATE4PtVTf7UVEHjQiFkgcEVk9kIx
   A==;
X-CSE-ConnectionGUID: h8SQ9J99QMa2Oyie9Fxymw==
X-CSE-MsgGUID: d6VuLba6SouGVLQpQXbPHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78572912"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78572912"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:57:57 -0700
X-CSE-ConnectionGUID: yvtDLjFBSC63pv956ji59A==
X-CSE-MsgGUID: AKO66+CGTia2Er3AqH0sdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="257537957"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:57:54 -0700
Date: Wed, 29 Apr 2026 12:57:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>,
	Piyush Patle <piyushpatle228@gmail.com>, ak@it-klinger.de,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iio: adc: hx711: update Kconfig, module
 description and file header
Message-ID: <afHWH8Wq4XNxzQdy@ashevche-desk.local>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-4-piyushpatle228@gmail.com>
 <CALoEA-wAUpZ7_2_3kB33mNB_Y_DAc_p7QwPR9a5pxL1iET_cdw@mail.gmail.com>
 <ae9otn7HuPKVtzsk@ashevche-desk.local>
 <CALoEA-w=giUoevbAh+i66ATKfXCr9WUE0R6G6DOMq2xE8cibEA@mail.gmail.com>
 <20260428185404.26f3da04@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428185404.26f3da04@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 06:54:04PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Apr 2026 15:49:06 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> > On Mon, 27 Apr 2026 at 15:46, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Mon, Apr 27, 2026 at 12:26:53PM +0200, Joshua Crofts wrote:  
> > > > On Mon, 27 Apr 2026 at 12:23, Piyush Patle <piyushpatle228@gmail.com> wrote:  

...

> > > > > +         which are used for bridge sensors such as weigh cells.  
> > > >
> > > > Typo here.  
> > >
> > > It's better if you point exactly what the typo is.
> > > I think you meant "weigh" that should be "weight"?  
> > 
> > Yep, that's it, my mistake.
> 
> Nope. They are called weigh cells not weight cells.

MODULE_DESCRIPTION() is not aligned. Somewhere a mistake is lurking :-)

-- 
With Best Regards,
Andy Shevchenko


