Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C1509EE1;
	Tue, 13 Oct 2026 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904821; cv=none; b=F/MHdEg9AGB/GHb0n/j652tIW2MzJmdmx0DY2YrpLPZljrYub9AGecAlpksbA1QEiRq02RPKnSoWffeaiZEA6S0/2sJ3DYuPkXz8IPw7apfhxNU9dAbdDDveGTzAyWEiScxtHOewNWsuDOcGOueQ4gNl4h9jdtADSMCwZSWf2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904821; c=relaxed/simple;
	bh=8oHdbrV6rYwyiI05u+5MoALHGbWPdWCv1oJHKyyUP9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek+bAD1g1B8SyIVLqL163n8n4gYvEu5kEiF9EAwdQaiN5+jxwkvbyD81tw4IdB3FLUvuvO5Z6oQNxJTaRzTdvAPaXW2J3rQ7hOna5r84IiiGj0WyTtPqLbU0uI0UZsWhj6yf4wKjf4W+g7i7rl1NLzPuabQAiXz4rkUe9FnCCpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duGKusyn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duGKusyn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791904820; x=1823440820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8oHdbrV6rYwyiI05u+5MoALHGbWPdWCv1oJHKyyUP9E=;
  b=duGKusynfWwzVUstmSbOeuhdy8B7Tj1te7abxBwPXI1W+8/7sK8x050V
   31nOxe9xEWpZ+a1Wz5Fud87QqM+fEbHCbml+ukoOME5A/FUd747eu47xm
   dgDjUe+GHc+NJEHD8OTusG1dw7zkGCfxARXuEUyLHbkrzJdKwDBzHg1eZ
   YmSYPg384dmevklqRH/BLAb24pYRxV1f7UAkDTL6DQqfucHBYwtxfvAFa
   W2T1k2fIsuH7H9jGuV8610bQXoJeNNthLUtzuPlJCzhpRkRsuFvMid/bx
   OLTox5mib02/ImjDkDYjH0lqsT25bWI9gYDPQ5aoKNPZ9ESIhJ0nSt2iR
   g==;
X-CSE-ConnectionGUID: w3IyO2wpRoKu9obwnB/N6g==
X-CSE-MsgGUID: Cd3S+dWQToG8nrRdrnCAQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="535781"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="535781"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:20:19 -0700
X-CSE-ConnectionGUID: bvXYp8hwQliQh0joIV2xEQ==
X-CSE-MsgGUID: yKKbzPgZSG6aSavID9Ps0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1116254"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:20:16 -0700
Date: Tue, 13 Oct 2026 18:20:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Andrei Stancovici <andrei.stancovici@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] iio: adc: ltc2497: add LTC2493 support and
 line-frequency rejection
Message-ID: <as5MLkl3pSyR3Q46@ashevche-desk.local>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
 <179189735509.1005940.16593087405634433360.b4-review@b4>
 <as45F3tHGzTc6lMk@ashevche-desk.local>
 <as5IbgaDG3FWby3G@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <as5IbgaDG3FWby3G@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 04:09:46PM +0100, Nuno Sá wrote:
> On Tue, Oct 13, 2026 at 04:58:47PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 13, 2026 at 02:15:55PM +0100, Nuno Sá wrote:
> > > On Fri, 09 Oct 2026 11:43:33 +0300, Andrei Stancovici <andrei.stancovici@analog.com> wrote:

[...]

> > > > - pyadi-iio hardware test suites: 41/41 on the LTC2493, 36/36 on the
> > > >   LTC2499.
> > > > 
> > > > The series was rebased onto the base commit below after those runs. The
> > > > rebase left all four touched files byte-identical, so the code posted
> > > > here is the code that was tested.
> > > 
> > > Not sure I agree with how you split the series. To me, patch 2, 3, 4 and
> > > 6 could be very well just one (adding support for the new chip). Patch 5
> > > becomes preliminary patch which is adding a new feature the new chip
> > > will also take advantage on.
> > 
> > But they are sound like a good feature-wise split. I would leave that as is
> > currently.
> 
> Yeah but all of those features are things already supported in the
> driver. I would agree if we needed substantial changes for the new chip
> being added. But that's not the case, just a few lines (or even one
> liner in one IIRC). To me it really makes no sense adding a new chip to
> a driver and in a following patch on the same series just setting one
> more chip_info boolean to true.

Fair point.

> Have no strong feelings though but not how things are usually done.

Okay, meaning let Jonathan to decide.

-- 
With Best Regards,
Andy Shevchenko


