Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146333CFF6C;
	Mon, 18 May 2026 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089212; cv=none; b=G927Y4+u+3U47liBhgWPfbask1WtIXfE16W4gWgFnuwGO1nEkIBmrFqSDvo1K3HfiaGFfM0nfcz9k89eldEO6XXZ379TNlsGZ8larMVX0GC5v6pM6jvtixevkrNbUonoSu0doJWw4lmmTdM73eWCOX8jl5iOc5+V5rBp6DdY6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089212; c=relaxed/simple;
	bh=t53bHA1/nxgmKznFl2xB1CX1LnkvFJuRl85dZH2IABE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC7fnFTmvuKw/CYlYU3uOKl5sozBIF08X3K/N41dgBE9plXgvsR8RCRwzwieABV2ukGlSVo4nWBUvJdYoVw8OXI8ucfvaon3siQuQ1pLOjh4i8EWfecvYApYmWSU6PsX/pfNnNkcTzBVw/LRM48LhhpZKVb8jI4zX3Sb+yHYy9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZKZvF5Z; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZKZvF5Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779089211; x=1810625211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t53bHA1/nxgmKznFl2xB1CX1LnkvFJuRl85dZH2IABE=;
  b=gZKZvF5ZHNWtD7zL91iZz14/jIRgicEtMWLVs4uHx3M0dGvxzaQAvbOv
   xLlgdMVY+gM/M8uKzepfUEpGiK+xDmFaQCzfxo6r5SGRKpOBut17JFz+b
   oDeaUFoYBEf9xH/AiUD2L71Vx8HJxWHciKxaodaef0UaHzhjHZdOApYdq
   q/OAGonZcJXQR0QqliCfxmInXmY75TdyrwotEC/Y74G3k3m5YVJISC++L
   TAMspUb2qCDxQ0UVRUPuKENG5H3tUhGSnk0BMbJuRm7lfOYl+wd1Vduoc
   u94Ny/lsQWNEmEGqhI1ZrH1p5h30v0wbkuofglh+X8jFehN4ywxiipOmR
   g==;
X-CSE-ConnectionGUID: ddxVCHIkQw+ifEWx7U3Vcg==
X-CSE-MsgGUID: i6FSUufEQ/6XHzqDE6qPeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79914921"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79914921"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:26:51 -0700
X-CSE-ConnectionGUID: 1zI6GwacTxqeoB8ZnGOasg==
X-CSE-MsgGUID: +v/e/I8qTTGyxw8wKlu63A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="235113416"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:26:47 -0700
Date: Mon, 18 May 2026 10:26:44 +0300
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
Message-ID: <agq_NJfR7aLA-gJu@ashevche-desk.local>
References: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 17, 2026 at 01:17:17PM -0500, David Lechner wrote:
> While looking around the code, I noticed that there are a lot of places
> were we are manually filling all of the fields of an IIO timestamp.
> 
> This is error-prone (as seen in the first patch) and more verbose than
> it needs to be.
> 
> I went with the approach of using the existing IIO_CHAN_SOFT_TIMESTAMP()
> macro for doing a struct assignment. This does require a cast, which
> makes it a bit more verbose, but we were already doing that in to
> drivers, so I went with it anyway.
> 
> If we want to consider alternatives, we could make a iio helper function
> or macro like the first and second patches did.

I like the series, just incorporate my patch, test and issue a v2, I will give
my tag.

-- 
With Best Regards,
Andy Shevchenko


