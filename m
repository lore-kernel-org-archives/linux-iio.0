Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565258;
	b=k+/f17hdl72VY/vUDetsuVLAoXVdP/jQo7/c99+YmTxySdRJak8b+mRKy2HW8zyDtUXr
	 Oak6uOezx5IqJev3nVHUKZ2qZy2NX10/xk6EvKMj9tpOE2WCwjcJTh8e/BrT0ic/H34Ja
	 EVSlhd78t3IvlbQtyS+w+wBpA/HadyQAvrIh4wI1alKKrgFXaN74tzUpOstX9MVzqks72
	 4J9cq4ldfSfGjRJdG2VzeVneO6mSOzcTiNZP8CQBDvbeGv/nc6Y0cqG23tvm4UPob9X4y
	 17thZ7ljBlnpI0z4dU8URWTrYh1njcTzsYDpLvsvJwg8AtQgalhSb63Sl8/4naNeDjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565258;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ApuaSU74icQpUtG1jhi+LU4LikfJD2XTst7XYPteYzE=;
	b=R6X3hmbidvx7C75jdUiwwfqqyZYW0CRFC6V7EdJc4p9Fb1iaZbKNkbQkUKWJD02Pvfu6
	 N/61iaryeogcXDx1LWgsWlVJ8GXCuZCp6aYo1WfdMjiHunDk4/6mSUg309hE3yFRmn3jH
	 irIFCpkL67LN8S2DGkaRwTGHKt+/fxQD4i5GcImE7167cgH+tpY30i+CrfuJH4OOhAz4a
	 rTvoqg5Gp8t1k/Bqmd67p/oiVc5U/cnj2OcMgdKwIaOKl6qlt24P9eQBI64uIkKSK9Ms2
	 ex6DxuJNE+U2W/AQJNy5/57bHV0DvPQVtK0c1Uthh13ZmKf2Ndo6q5rw39x/wly61eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="BM/NTVVZ";
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF723606A319;
	Wed, 21 Oct 2026 06:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF723606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BM/NTVVZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792565257; x=1824101257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iXkJaOf0hTRjgmGgbM6k+DxFr9bYqP5hlnEeIwLlwMw=;
  b=BM/NTVVZ3BQb5s1Sp7uq93U0U2qePEl1wnC33T7o45gL0zvV/q5e/ZtN
   8WXKszIYcL0QGaCd602ZgqvqQkz4/kHrUmNnByCCQDSlW85LnVHdngzcu
   MqK1GOFI1nYTIGW8dRFyqzeh+aXIxWec3PQmBwLZPdDkycTW0+kuD8rZQ
   TqBcJ8AjqrLNc5tCYjYYJXzlokGrkBs+vjuv164lFaOF4ReY2kJOF34Ph
   HcqcUXFkD5QUEcPuokCcf0wvF5VBCakF9zCEf7jKkkUL9L512J/MglI33
   wgNU4VJI6LizcYH7hQAdjStGKxJcx9/CrF1Wie+CpcbfcaRkDCG0HYny3
   w==;
X-CSE-ConnectionGUID: 3oBmdl6hTs6ZaRPDdaO7Wg==
X-CSE-MsgGUID: Bw8jrls2Te+de/tOjuqAog==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1262464"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1262464"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:47:36 -0700
X-CSE-ConnectionGUID: /kqY2X8UQ5acfpW8VEcolQ==
X-CSE-MsgGUID: cTIjsCwcQcuRHKnLFY5T8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="4811458"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:47:30 -0700
Date: Wed, 21 Oct 2026 09:47:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: update gyro start and stop delay
Message-ID: <athf_2jVU7eUri-0@ashevche-desk.local>
References: <20261020-iio-imu-inv-icm42600-update-gyro-start-stop-delay-v1-1-ed52290a4ca4@tdk.com>
 <atcsENHqXSRvn7SU@ashevche-desk.local>
 <BE1P281MB142605780E1D5B1B051ED4A3CE672@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
 <BE1P281MB1426FBE0884F6FC89255B5A2CE672@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
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
In-Reply-To: <BE1P281MB1426FBE0884F6FC89255B5A2CE672@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 12:55:53PM +0000, Jean-Baptiste Maneyrol wrote:
> >From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> >Sent: Tuesday, October 20, 2026 14:40
> >>From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >>Sent: Tuesday, October 20, 2026 10:53
> >>On Tue, Oct 20, 2026 at 10:42:30AM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:
> >>
> >>> Following datasheet gyroscope specifications, the maximum start time
> >>
> >>What datasheet? What specifications? Please, be more precise to refer the
> >>Datasheet name, version, chapter, section, et cetera.

> >I will add the reference.
> 
> in fact, this number is not available in the public datasheet. Only the mean
> value is accessible.
> 
> Should I just modify the commit message to delete any reference to the datasheet?

I would rather see the full information like you put above, like

  "Unfortunately the public datasheet "$REFERENCE_TO_IT" does not specify
   these numbers".

> >>> for gyroscope is 45ms. Stop time is required for letting gyroscope
> >>> mechanical structure settle down before enabling it back. 50ms is a
> >>> sufficient value for that.
> >>>
> >>> Update values to these numbers.

-- 
With Best Regards,
Andy Shevchenko


