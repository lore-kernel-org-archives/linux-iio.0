Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A1425B09A;
	Sat,  4 Jul 2026 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783184460; cv=none; b=AWQahQKjVEQM0e1okIuZ9sBKR39CxB5tFv7mkPKq4kZs5L8UAIszdnTl/5kWrfYIk0tYi69P4EifKfrngaIwA5Eb4JL/GU9XIpQZ8xNwfxR2AHIJRHNobZhkhLYTrogfEiuzGs12OLJM8h//GqXQCzpGUS7k0tq7JV0IWH3EUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783184460; c=relaxed/simple;
	bh=zzyiIgFsw3G8UwSKhhtNCXzTAwIBDPliDibODScLB9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocLAOrfaP1IyHUdgpkG/o4DOfIhsiHyowo7Jha5RsfPI6OF5HsFSPi7ub29YGbokKRiB3vG2MCi+4v8MJaisTwJnC/9by1bBfW4PqfWxO9ZE1+zw/PUHG+aIbatG573mDrlIFFOeUlwdH77hDzfkawyf7X3CYX2DDftglbyp6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5drI2lF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5drI2lF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783184459; x=1814720459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zzyiIgFsw3G8UwSKhhtNCXzTAwIBDPliDibODScLB9Q=;
  b=I5drI2lFb9hoiOiFV4zqSFwk5c0bxntBVd5ydtOuEBCHas6FgsEMil8v
   G0pFxyEoBAZdCiSC7gquSnJF0+voL5cgTMwS0216rtglPdfkLT/BJ1Ik5
   stO/KxxkKvqCUzLcJTMryF2knZMni1fp1tUscik8VnGZsn2ElWhxmVFw0
   D1CEwpTwlg2wA3ng+rO/LtC06f6dyx9Hif2BD0TpOSu0lluRCMXH/0g/e
   mWrACIg7rEqub8ginY4SOmrxAoSU0/4+3jXA43Co/T5g66H5OtiQjxw+J
   ZJEgvuQrOSTBdKwGupNZ2nhIrBMI8pHUt/fFQOt28sC4Ngtsigevmf/pE
   w==;
X-CSE-ConnectionGUID: CLNcSjTIT6CrK8AahZT7wA==
X-CSE-MsgGUID: NL0l1PYhT1uGdx4d4wA+/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="87799106"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="87799106"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 10:00:59 -0700
X-CSE-ConnectionGUID: av4Gar+yQ5CNOwqPPVySdA==
X-CSE-MsgGUID: l223jG6kTE+KO4m8HHbX6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="257218737"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.241])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 10:00:50 -0700
Date: Sat, 4 Jul 2026 20:00:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Prashant Rahul <prashantrahul23@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: adc: ti-adc161s626: log buffer setup failure
 in probe
Message-ID: <akk8QD1iQHk1Cvvv@ashevche-desk.local>
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
 <20260620174708.111470-5-prashantrahul23@gmail.com>
 <20260623203636.69a7429a@jic23-huawei>
 <DJH77MBX1U37.1JJ1Z6UGLF0LT@gmail.com>
 <aju-_HSz6jNkR_NM@ashevche-desk.local>
 <20260625120952.471ec21a@jic23-huawei>
 <aj01H48IHTyhn4ZR@ashevche-desk.local>
 <20260703013907.57b0f114@jic23-huawei>
 <DJPWN45EI416.1GR6QTDHBU6SC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJPWN45EI416.1GR6QTDHBU6SC@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 04, 2026 at 09:20:46PM +0530, Prashant Rahul wrote:
> On Fri Jul 3, 2026 at 6:09 AM IST, Jonathan Cameron wrote:
> > For now I've picked up the two straight conversions to dev_err_probe()
> > because I'm keen to (slowly) stop using dev_err() in probe functions.
> 
> I can look for places where dev_err() is used and can be replaced with
> dev_err_probe() in other probe functions, then create a new patch
> series for it. Without adding new logs or removing any existing ones, of course.
> Shouldn't take a lot of time, what do you think?

In some cases it would make an additional churn. Each driver may require
a unique set of the cleanups and refactoring patches. Better to do something
that you have HW to test on.

I also removed some people from the Cc list. Why did you add them?

-- 
With Best Regards,
Andy Shevchenko


