Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699105;
	b=VPIr+Vw2SewCdhh2gLflGeOb5pOj1cJsJbbLTaWt3Fib4U9XeIVsYzoC64LMpbwYO+cm
	 34yQs9R0qUn9ZZy2ylb9VKaysNfbsd72VBcRRo+Zi0DdXnERlHDGqC3ob0qA1UUsZEStN
	 JBTij/sHzYU4dschBkPRoIlhE6XvOmRqRSpzywUQTT1AfdfnU1Z3NDqwYnbSZtpliE+Tp
	 vJ/lGQ3yU9lwk7Cx0245MM4UoqwWYzkf3QdjrARS9VO/CjyOfFdGjakCFbgOXWEdlUZhy
	 fHrFufS8r9NOqTgglubnDDstKdA1ddIi3sKXNOLoThA1pGJxbdJAC4nKOWOR0r723jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699105;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=eJXDxjtpxlaRlyectS+NiI2BE6CyW1HF3ivWw5VpKUk=;
	b=2si7xxnWZ4UOSsPmAHdHou3MaqTCjHj7GgkrzoZ9CnY8huxaQ4HhyAtT3PC9nU+ffgH+
	 /qG2LGgBpjLIny5N7Xlh08OcNsCrNB4o4RHUn27XVLZtTms77IXDc6e6CGM7WwtDqOr9A
	 6qJzJyl8vZHybj0PAcYewYR/P1lleowmDy1m2DSsH2xfnZnpj5Q2faXWt5sWd+ljbaLlA
	 mzxm1s4Z9w9bxbxvidmANwxp8/gP3FsS711r5u1O2sZz+UD/kbrBuO47JNp0PGU2NHjgP
	 qYYtWr/l5kOEYuO+ChxdZHVBQ99bo12caF1JPSuHZXJvVR2JKWJIX1y+e0dZtfFfm+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aZMKTuDW;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058A0606A326;
	Tue,  3 Nov 2026 09:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 058A0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aZMKTuDW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793699103; x=1825235103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qP/t4N3PI5wThGHkMAYxTPrH5iaWsuCbk6aKxmmZ9b4=;
  b=aZMKTuDW9EXEPyFDszcUWOfAo4dW10KGsxa0mX4IUAJelhU/Q8NwGA85
   DeypawCnLpC7ebfOH/aXiBV0lw+S4u1hW4jlMo1dSz5Jpd8451KyqkyMH
   k6JQRHqHCzbmt+jsh2xMuOhWBKVmbrloqnm5q82d+j2qDGOyy6x8MpU5n
   MIxVLu8ZnsY9neTjA14MlWNKZIf8BQ/BUMoXNPgNHLRFmgKyQAtSlb+je
   FiljiZcRxOvh/OKXJz60xd2yKwV658ELbiqNuq2ZZ971c5hCA9d2NJuW/
   vE8skjvGtEJ9upwoLa6JYpQ/vJ89dfKr1uwh6H7Xcwu3PcdVrkygRBMIg
   A==;
X-CSE-ConnectionGUID: OC4+zF5ASJSDsEfSey1gGg==
X-CSE-MsgGUID: lFbuFQQNQ96JoJNMvwte6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2443826"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2443826"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 01:45:02 -0800
X-CSE-ConnectionGUID: zHbXd8tfQoSfJzSB11ByKQ==
X-CSE-MsgGUID: eAFN0YoqR82Ahh0sG4Z4vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6237758"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 01:44:57 -0800
Date: Tue, 3 Nov 2026 11:44:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Guenter Roeck <groeck@chromium.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Remi Buisson <remi.buisson@tdk.com>,
	chrome-platform@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v4 0/9] iio: enable context analysis for all drivers
Message-ID: <aumtFi5Jdzs8NIWE@ashevche-desk.local>
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
 <20261101033018.05897c08@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101033018.05897c08@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 01, 2026 at 03:30:18AM +0000, Jonathan Cameron wrote:
> On Tue, 27 Oct 2026 14:49:45 +0200
> Rupesh Majhi <zoone.rupert@gmail.com> wrote:

...


>  #
>  # Makefile for the industrial I/O core.
>  #
> +subdir-ccflags-y += $(CFLAGS_CONTEXT_ANALYSIS)

Personally I would move this to the end of Makefile.

>  obj-$(CONFIG_IIO) += industrialio.o
>  industrialio-y := industrialio-core.o industrialio-event.o inkern.o

But if it's already in, it's not a big deal.

-- 
With Best Regards,
Andy Shevchenko


