Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595E3D16EB;
	Mon, 18 May 2026 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089029; cv=none; b=IUghZCRv7ucklV+4KkKR5OZfTi4XYVMJebEPEkb+fVHO7HahEqEoZL6vMe8wxd8fbDGNCRt5eqYxvLtuPCH5pER8iWqvbUwNlVVBBtk1BXD1LQskStOWy5s2r/1OfTh1C4ZG4OxJG2s413tWChBR+L41gn22BQAlHWsQfQ12Ibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089029; c=relaxed/simple;
	bh=Nn3A3vAmindilk1fNlnp7BEXPwv+U3vQxYhSLEMgtF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I95yypBVdQhWuRUN9PVmPEnWErRzERFzsFx1jFzSnSf3ozw0d3qooGqSiO9EP9uPnH2+V529Gq1Z36UF9QZ1yTIXhjz2mI/7i0LzHaYlFKf+rLd9GUdMrc6QUTPTP6RUHAZU/zCpD6U+l95gV40xMhxPiW9aniijdY3GsqOqhWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKLXSzWt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKLXSzWt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779089027; x=1810625027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nn3A3vAmindilk1fNlnp7BEXPwv+U3vQxYhSLEMgtF8=;
  b=MKLXSzWtKW/b50emsY0bVEtTzayzm+v9jL+G90e2w6DQ/tVPfJtE/rrp
   ZlYgmCFsP8q2X68lC1zam4E7VLjIg68toupnlikxTVChL7asIAqVwRiDh
   04OI0WhIjBng7OTQdWENsSwMirix9oR1sD/9LaoVFabzdca3S0FYFHnTu
   UU+OxZpJ0WINu+fyFt2mGteuc1BzDrdkaaaSvY4rwle5ImLHIG0n4SLGk
   UgoSuDnJEtMKpcjTBDg6ab92LZ3N3jIj6BDQ5vaRjhXpAJ6UrCOnr4cxL
   Zi3NXcsyyO/S1OQ9+fykCY3c83iObR2aTatM9iHJDUVDLbKfqn5YLE+8G
   A==;
X-CSE-ConnectionGUID: 8qA0VB+wQdKYsRFBOdflXQ==
X-CSE-MsgGUID: afLH7DZCRBGHf34r3MlcbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79789002"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79789002"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:23:46 -0700
X-CSE-ConnectionGUID: TTUB0lTQSJu1MzH6wr1ojw==
X-CSE-MsgGUID: i2NpznmuR4iym3GJQD2XPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="263125293"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:23:42 -0700
Date: Mon, 18 May 2026 10:23:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH 0/8] iio: timestamp declaration cleanup
Message-ID: <agq-fF6dNl-fRVXE@ashevche-desk.local>
References: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
 <83c11e2c-9688-4cc9-b7ee-6380de30fb58@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c11e2c-9688-4cc9-b7ee-6380de30fb58@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 17, 2026 at 02:22:03PM -0500, David Lechner wrote:
> On 5/17/26 1:17 PM, David Lechner wrote:
> > While looking around the code, I noticed that there are a lot of places
> > were we are manually filling all of the fields of an IIO timestamp.
> > 
> > This is error-prone (as seen in the first patch) and more verbose than
> > it needs to be.
> > 
> > I went with the approach of using the existing IIO_CHAN_SOFT_TIMESTAMP()
> > macro for doing a struct assignment. This does require a cast, which
> > makes it a bit more verbose, but we were already doing that in to
> > drivers, so I went with it anyway.
> > 
> > If we want to consider alternatives, we could make a iio helper function
> > or macro like the first and second patches did.
> > 
> I should have looked harder for existing alternatives. Just found one
> more that avoids the cast via a local variable (in ad4170-4.c):
> 
> 	/* Add timestamp channel */
> 	struct iio_chan_spec ts_chan = IIO_CHAN_SOFT_TIMESTAMP(chan_num);
> 
> 	st->chans[chan_num] = ts_chan;
> 
> And similar code is found in ad7192.c.

See my patch. The above with my patch applied can be simplified to the
inline use.

-- 
With Best Regards,
Andy Shevchenko


