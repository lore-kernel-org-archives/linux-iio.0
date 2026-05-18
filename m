Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9104212542;
	Mon, 18 May 2026 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088200; cv=none; b=oI+/HZJm3TVbATzurul3scF5a+RUDVWrtTy0NSE/G1dMwe0XT6poEmVydl585BULxMr3dGhjvLHefzD1cvIHlfsCE+hDW9fpJRiBJKE7uKq5hI+zI7YlaOcyIy84iCN6DkpzB/ISiROrl0iiEqXqR/a82DHF2QsxCNpDWA1xNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088200; c=relaxed/simple;
	bh=WR9oCIPIzojPSo64gRHZlaaIuIGSxs3/FGy0IJZb8Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0YutimOz0nuyx55kVsUCejieNDqiSaOPQS78S0ieqYyQm5FCkmmyXP7Weg5QASlHuRjQ+hN/Y1cbqz0YPda3W1DqdV0Sbxz1sRPeKvMCnJ8cybwhTxKLeB6RN8G6n+CxYRY2LrpP7iUJCXel89D+9bLKMI50uKtG287+O94N5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4aC2thb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4aC2thb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779088199; x=1810624199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WR9oCIPIzojPSo64gRHZlaaIuIGSxs3/FGy0IJZb8Xg=;
  b=R4aC2thbOIxGNcOG1L+ayGFJHSXEf1X8EhshyPYNEMdrt5tnYK7rHx/T
   KBDbw0CettlrpRcZpIoZ5sEvCoHa6NDx8utAQG/4Gcq8shY7NhdPCsnj8
   P7ocspWG6IyfodKsfnd0U18uTgMpqYqCGLCUtRPqI/gY5X5wHvo5BFNuF
   qY0QiPvlj5r8Zxwd2XhnyD1xJ40HCRcS4WrNdDVpp+QlOwJNUNLtWVjtq
   T5NoFz8qFDdwE+Ha2/J4GJqNGgTwDg9k6k3d1qBhcW/85WOMhblvVB3Ls
   fFUeRALvdSFK7EzqrfF0rFUVbSbK7xiI88oQpqf9E2cSEzvQV+/EEz5f1
   Q==;
X-CSE-ConnectionGUID: Kj8+wARORLKOrrMnVTQnrA==
X-CSE-MsgGUID: iCr1m4oSRcm7YU9UlLWofw==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="67462360"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="67462360"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:09:55 -0700
X-CSE-ConnectionGUID: WGMBSQXVQDaI/vj2+b6cVQ==
X-CSE-MsgGUID: fPi187sZTs+h8vWOE6IMeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="277443483"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:09:51 -0700
Date: Mon, 18 May 2026 10:09:48 +0300
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
Message-ID: <agq7PPw0qupI_8Dh@ashevche-desk.local>
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

No, it's *not* a cast. It's a compound literal. And instead of doing this in
every driver, add it to the macro (in a separate patch). Oh, let me just cook
it for you (I added that to several cases in the past).

> makes it a bit more verbose, but we were already doing that in to
> drivers, so I went with it anyway.

> If we want to consider alternatives, we could make a iio helper function
> or macro like the first and second patches did.

-- 
With Best Regards,
Andy Shevchenko


