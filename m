Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700959;
	b=wIJ2ZwpAx5lDexBxYUOTBbfOlIMZC3rmdUsWOU85IClavo8qvqmNcdlgQY9pWqkX/AAW
	 wGht5Y3SVDRHg9Q6k/BKR8A4QT7wgFibKG5Qdh+9v5uMhdkwcSrJfcPAilMcas9RwULDr
	 sLvHb2bJ1Ei+kBZcUs6ge4HNEqnUVyYAhEf1u2pfoHt6c9euC1t88Ef7SLJpnAxgmXJjN
	 vF6McaaTteZLNz6oVwqPqjRcEVLgh+M/PR4YU0p2Jw8H8VZ8O6/M3HufPHtUspmd2W0bA
	 +vDC6npPFwQBaerlliwzqduHvADV+47pgSi483S2my2xhxQEv1/sMOI/d1c0C7wgxdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700959;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=MT3pffe5eVAN70K/eZlf/x8C16Xani/XXvuOJb+kA1I=;
	b=EHDolG2+DH0RzS1fAJSOIny45mMqLPYAuXYqDsredFqgzqNKmosMEwDplga1kr3CbUhf
	 HlDFy3GC7wGeub8YwssF4cpehbfB2KITyATusL4iNguNVc704L8S7NFwuhoPn5k20mDcI
	 rtYwRN6OjnN1M5/NCSGHLR1XUZad1I2kg6xFc+zN+s3CZgL2FnYT7Uqpe9TRzy3mXtPeQ
	 bFDCkr3Ogl6lduHhgNSb7p+CMflP4Y1CSGYLVQtbRTmoq9ZanHz4mB7RjTzwo3eq+djv1
	 8KSMy+i0LCvYeYmpEQPbdglULrtwnSGFdtyDx7V3RRY9XJpjq5Vz65imOTfVx6VyIaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i0bAenkb;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB21606A32D;
	Thu, 26 Nov 2026 13:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EB21606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i0bAenkb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795700959; x=1827236959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kRbxpg6fYPj/Yi+CY2NDda10UATIlhg+d8xBrPwMXP0=;
  b=i0bAenkbO047qVcdUQ8LYC7kLqo9Ot8CDtuWJIGFHpFbbK4gnuzFSPaG
   ZGJJfGbDSAQvS9jd/u3arhP1Bs+Wwnjj4TYCcyaZwXZKPX4NP1mjePeua
   JxA/Y7wLFV7M095mtkz7YRVtnjnvuE04SSzYxnGQPQIprO9V3pIg/f1/Y
   7pfNCEBoPpgaT4GKEQJrhRZcvQiO0hvAUDViS1EkM55Krif8mBtI3Kv7p
   CN92Tk/rc05cwXIuacUC7nxjAdZouURn22inVYSYJ6GYjDK6F+qBZO7Sv
   Z7q7j8IXMZseydfcDMqQWoGEhhq9cD0zuqbSXbJv2soDL15eMCWqDiOoJ
   Q==;
X-CSE-ConnectionGUID: pOywovpFQ6O7zvyNLlyyNg==
X-CSE-MsgGUID: Swu6PXigT4KEoFx91nFJYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4522632"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4522632"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 05:49:18 -0800
X-CSE-ConnectionGUID: hZ2myhofTlmWyNkMXwl5kQ==
X-CSE-MsgGUID: zJ+sJN1CSJ2FyGLj2uSYDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="11957066"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 05:49:15 -0800
Date: Thu, 26 Nov 2026 15:49:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] iio: pressure: dps310: use time unit macros for
 sleeps and timeouts
Message-ID: <awg42TwLsgf_Xp3U@ashevche-desk.local>
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
 <20261126121331.10438-6-zoone.rupert@gmail.com>
 <065da662-2670-4f7c-93dd-410e9c11d18a@kernel.org>
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
In-Reply-To: <065da662-2670-4f7c-93dd-410e9c11d18a@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 02:17:34PM +0100, Joshua Crofts wrote:
> On 26-Nov-26 13:13, Rupesh Majhi wrote:

...

> > -	usleep_range(15000, 55000);
> > +	msleep(20);
> I think it's safe to use 15 as specified in the datasheet, as msleep()
> guarantees sleep for the specified time + a max of 12.5% slack.

Wouldn't be better to have some margin still? You know that time goes
differently on different CPUs and in general time can go backwards (in
computers), so the long sleeps can (I haven't checked though) go both ways,
and a minimum sleeping time can be less. Also on the other side firmware
might have issues in some circumstances and require slightly bigger sleep
than specified. That's why I proposed margin.

> This can be tweaked whilst applying though (or not, at it's pretty minuscule).

-- 
With Best Regards,
Andy Shevchenko


