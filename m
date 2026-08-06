Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924B4B0488;
	Thu,  6 Aug 2026 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060355; cv=none; b=q/2YfHQ8cKuZ0iuBgbcoIApDX4YQeCAt57/x6ea01BALhd0iktIBNo3/xDoORGuo41N1jyA+mu6dgEzaXQF3H5FvyeAN302o2oKkm6M3rrwkIafUvTmjd0C4ifzUHU0VQBk0wtPDPLgWi9v9WPtXBIZnW9KlJIBjPLxgEr5yNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060355; c=relaxed/simple;
	bh=Sa2YHFJVH+Xj6g/4VuItSxfnJNEDnyYTmOISahdJtLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1FWcq8NYLZ65TLnfhePY0t+el8HdWsw+SExBqaHYJPXASe19+UY/HYL3UZRrXAL2nVYXyBeo9VgidVetNz/Z1rmTATz8pgbSjYRiDMSqJfQZ+5gRDwgCuK/nwCpvCkZMpmD8dU4NPKja5ldzZDvfm0bXvuQhPlW4LQJtVhytIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJ42PLQ7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJ42PLQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786060353; x=1817596353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sa2YHFJVH+Xj6g/4VuItSxfnJNEDnyYTmOISahdJtLU=;
  b=EJ42PLQ7H/3e8ewrg7267Bb5qjs48/pHdt+VAHzg29LJd6F0RkPkJp+6
   sGody2iWKjZTZ4Qi5FuZMYqTCwotOKHvspVaZrtDsoXfQCf0cUbtzEtw0
   2myAlReFtZ2X0mOqlM/rMO0479tpduikjhbPFstmXywVc6ivZRHDyn7RL
   1LlIRfN7A8rtWQgEeFNILc8H1OsoGZhnL4xtzPXelywc2b29uMqq11g/C
   Wvemli2sRyfLJ0IWsgY2TL9ubkUrEAcMHx16/dlklDFyYXYSt7AvXy6+8
   y2lPwGToTOqDhwDhzsWluwi54HlHdZ/+6FkKrEku/SxpNw/r5IDYcUZbX
   Q==;
X-CSE-ConnectionGUID: ashMnlrSRXenRhr9fxJGQg==
X-CSE-MsgGUID: WtkmWAIySVyb3wGbCp+LIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="98030195"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="98030195"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 16:52:33 -0700
X-CSE-ConnectionGUID: qrk721O5Tf+t1OGyaWdYEA==
X-CSE-MsgGUID: cGzaEPkaSKy62GFi+D2ZSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="265718608"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 16:52:29 -0700
Date: Fri, 7 Aug 2026 02:52:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: mdshahid03@gmail.com, Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: Re: [RESEND PATCH v2] iio: adc: bcm_iproc_adc: Convert probe() to
 use dev_err_probe()
Message-ID: <anUeOxR0cS8Yzwh-@ashevche-desk.local>
References: <20260730155712.374464-1-mdshahid03@gmail.com>
 <20260731115309.000073a3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731115309.000073a3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 31, 2026 at 11:53:09AM +0200, Joshua Crofts wrote:
> On Thu, 30 Jul 2026 21:27:12 +0530
> mdshahid03@gmail.com wrote:

Basically Joshua said already what I replied to your v2 (w/o resend).

-- 
With Best Regards,
Andy Shevchenko


