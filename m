Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACBB3770B;
	Thu, 29 Jan 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696898; cv=none; b=f15MhfETXdLY/QkoitEq22gdk5QdmyKApnJjdzc/6KoKcYhewUTcn86i4Vy/83qekEOfN9d16ye4oGXCvd/nHoAVoLcmHrri269iNuAHzZs/omJtGD8ZnFu/cwmVpB4m5p5feJEP1WizxilaiN/PnCP+Mq5I2j1lsi6pt5fVrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696898; c=relaxed/simple;
	bh=Ee6OYHndePDmN1kpulvnwUEGWJEFEK+lk+lzSQ9Zcjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ygg5WKxzYh3fY0V1WGxBCCLhatwfFUFG0UbuzGkwPZC00BVtn3BhKNiK5cNb743xCm8e4u+x3D2fp0MJYS0fmRIWwbdZngRkKzQwS/ufE0i+hCDZhHlkDkLx/h1gHwTjf7WjFGqfBiP/XsLygmwA8Yr0xMq/dtas+puoQWx8iy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmNrVDWg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmNrVDWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769696897; x=1801232897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ee6OYHndePDmN1kpulvnwUEGWJEFEK+lk+lzSQ9Zcjk=;
  b=TmNrVDWgGW/KkEFbXdIc/3DgJ6I4LTDqZp+DdnakBNob/+KvJUvk/OYP
   c3hBgx/xcCtAw0dfpoPdCBZd+A8RqsGrSk0sWcz/rbb0n/5cSIiqqG+Cc
   AkZy6PuVFKJnUtompX3/JX0aIq982BLXkTwz2mrDaHAIjL5qey0OT0gA4
   /lANX5ABVon6ihpGK+jAFzYNC/2sx+uICMVkdarb547dAlfvY2ZIAJcTm
   yiudcH/jcBhhNX4dv0se+j3Lt4AmAG9Lcgw8x8o5LOxuH96y+a+Ad9jnC
   YPDt9T6WSjJEYxa7k00C1Dpw6IaHD2o8vQMYYY6/qQ2yeXT8VScJOehR0
   Q==;
X-CSE-ConnectionGUID: 45Lg3EARQPCHYm0eicWG/w==
X-CSE-MsgGUID: sLVEQY01TkW50DKsesG+mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="74560674"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="74560674"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 06:28:16 -0800
X-CSE-ConnectionGUID: Ogop6CQCTTeLTmnmTlnUdg==
X-CSE-MsgGUID: vqyrYJO1RL297swjter3bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="231504461"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 06:28:13 -0800
Date: Thu, 29 Jan 2026 16:28:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>,
	Gustavo Bastos <gustavobastos@usp.br>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: accel: adxl372: remove unused int2_bitmask field
Message-ID: <aXtuexNdZhKvfAg6@smile.fi.intel.com>
References: <20260129141205.106285-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129141205.106285-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 04:11:57PM +0200, Antoniu Miclaus wrote:
> Remove unused int2_bitmask field from adxl372_state struct.
> The field is declared but never accessed in the driver.

While patches are okay, you have two issues with the series (or three):
- the email thread is not a thread, missed --thread?
- the series lacks of a cover letter

And optional third one: should it even be a series in the first place?

You can use my script [1] to make it not forgotten.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

P.S. I hope that this simple thing can be caught during internal reviews...

-- 
With Best Regards,
Andy Shevchenko


