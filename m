Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825443815E2;
	Mon, 20 Apr 2026 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673272; cv=none; b=fP0FuXj/kx0/hbWAUv2ZxWDJQu7WIuofDjDf5X6kMMkm3nLtd4rEh2smu13oIg1VuFhPbKYpl9VmZsH1o5pYugwidLU9vnqqCy9gn4SGzu2ttyWRqGNTkCPyclLwJmHuwJBHcJkYpBgZ28Ig0sfnYAjyw7F+uAawlBywORu46HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673272; c=relaxed/simple;
	bh=Hox/NHC7DWBH5XJcwgjkput1zansHFHSyXXfPoX2t5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBloDX08B9dGDGerU+8x6RxH+ttNbxARKLp5ylfuSXkNjgDoNTnpZt18oi4ydskw5NJIenOvD26pa9VPHjcBWb/yJUJjzl6FSUE7+LrZ1/cr8ch7YvycalV5ibhU1qqtXpQxjW61UN+Umt+tDxlGksGcNnFoCRdcoNa7rOdsalc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwYz1E8L; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwYz1E8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776673269; x=1808209269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Hox/NHC7DWBH5XJcwgjkput1zansHFHSyXXfPoX2t5k=;
  b=DwYz1E8LUtEFZIzm+WqNkfWyOpU8tpvKG+WgYZDWPWuDWyepJ6hqBKiT
   6HST9fJImirxJ28jLSCP5p7YbDmKaKgoKa7Rw0tNiIU0e4MPPYfowMfrS
   1WxKDlXyJjR1MFThhNpa4XsVt4ouUp0dezlLWU/ZY7qBECzKPCSu63Q/s
   IEFq6rrbdk+pWFkZV5JPRiTAKDDsNMjBMin8XSnr06GVvcIoIocG69qJx
   a2+GdLKRM2IPq4+e8QMpOHzpmFZtXXDTbfRYqBOHUcTQ+lC65uTQLa16k
   2PzvOp/q8lIme7JHRixgdoFnoH3VXcWHijapgZ2ACu2hdpcgJiVW3qAPC
   w==;
X-CSE-ConnectionGUID: pWT3f+qkRXq4mgqpgqHgKQ==
X-CSE-MsgGUID: 2AnngaU1S2uNr2HM6ftDBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77708023"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="77708023"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 01:21:08 -0700
X-CSE-ConnectionGUID: V2u56sirQEKzIe9a6xKgIw==
X-CSE-MsgGUID: kLqsftOGQ3+po7Gfon1drg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="269695083"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 01:21:04 -0700
Date: Mon, 20 Apr 2026 11:21:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] misc: Remove old APDS990x driver
Message-ID: <aeXh7j410AxESy4U@ashevche-desk.local>
References: <20260419083125.35572-1-clamor95@gmail.com>
 <20260419083125.35572-4-clamor95@gmail.com>
 <20260419143346.45ed78c2@jic23-huawei>
 <CAPVz0n1qrSYr16zSSqRHuTWVkRfdC+c9w+mxAhtzgfHzL41XFw@mail.gmail.com>
 <20260419172216.3cf10e51@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260419172216.3cf10e51@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 19, 2026 at 05:22:16PM +0100, Jonathan Cameron wrote:
> On Sun, 19 Apr 2026 16:41:24 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > нд, 19 квіт. 2026 р. о 16:33 Jonathan Cameron <jic23@kernel.org> пише:
> > > On Sun, 19 Apr 2026 11:31:24 +0300
> > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:

...

> > > There is the obvious point of ABI compatibility raised as well, but given
> > > we don't seem to be getting much push back on that maybe that's not a significant
> > > concern.  
> > 
> > I did not found any ABI in the Documentation/ABI regarding this sensor
> > using grep,

The code is what is in use, it has an ABI. The question if it's in use or not.

> > maybe you are more familiar?

> Doesn't matter if it's documented explicitly (many older drivers are not).
> The question is whether anyone has supported parts and userspace code that
> makes use of the sysfs files this driver provides.
> 
> Their userspace will be broken by dropping it.  The lack of upstream users
> makes this less critical but it can be argued it's still a possible regression.

Usual recommendation is to google, and check Debian code search engine.
I randomly chose a couple of sysfs nodes and only kernel code refers to them.
So, at least there is a good sign that it likely not in use. But one has
to perform more checks (all attributes, more sources of information) and
summarise that in the commit message.

-- 
With Best Regards,
Andy Shevchenko


