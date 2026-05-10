Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800F1E5702;
	Sun, 10 May 2026 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778396543; cv=none; b=Ch8h5v3gdqFJsWlQwXpHgMy6Ep2UyEgP4hSp7NcLgFmAgQdvtTffhUL1i0pOXgIwLVXJeGR4wOBlsBwjpjLTu2qiWS3b+zy0aIZTcGcMhz+euSLSST9r0qB8Usqc2Bi/xJZtftR4op4aZoLRP7fcknBWWEGpxk1uvP76sPc88X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778396543; c=relaxed/simple;
	bh=0Zqef+NQPgqaO6SJgsRuPQ1xlt8M5lmkYkS7fD6QhTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/LmWVF9SNzy9vmWLYJMwt+PeMztM+T175X9R0dkZqqhX8rxZMxTQilasFOvmO+WfX/OscUoW4W52E7ddEKr07PQuGVECxXKFSPu/2Vq4gB3RF8y/ifD57m0P3oOpoGrS7Xa7KYrPjdJDWpKQEWyAaMW+6CRC64VGUjrYB+XWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApsN1nBb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApsN1nBb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778396542; x=1809932542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Zqef+NQPgqaO6SJgsRuPQ1xlt8M5lmkYkS7fD6QhTU=;
  b=ApsN1nBb76Nyik/8icSGoO6VSiZsgb1o0cKDth5AGPTzp3f6FQCBU/GQ
   bJvYjDe9RmIs+f0c1wXn4nk3oQrh97S76TZgOkyZ6VDvb7+hWjEVXM1qJ
   AxQU+H+YVSrVn2U2Z5HuJVrZcpHXGSHRvu//0qujo6A1yKajUTb6KLFpm
   mBpQNpt9wVt36tFNQbZABb9sANGkFGkpRVVFEPPRE7imqJHKtL5C/FeQY
   q9jhDjUMj+CuDf+juyz1FjG/nZKwmmmVvl8z0NUt8qkBTSlkKjKnUbYuE
   zl7ohj/wwEUZHVC4bR1kfz31DcDJG9ekogY1f9MOcWXTciMlcb7yQs9m2
   g==;
X-CSE-ConnectionGUID: LHu6BkOnS+aCIv8aCLd7yQ==
X-CSE-MsgGUID: k0ZYwQU0T7u5h/CGxmJhHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="104772967"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="104772967"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 00:02:21 -0700
X-CSE-ConnectionGUID: CKs31bovQTupWVDT4e1/sw==
X-CSE-MsgGUID: 3wtE4azZTbeRk4oWn/q/4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="236197600"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 00:02:19 -0700
Date: Sun, 10 May 2026 10:02:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Vladislav Kulikov <vlad.kulikov.c@gmail.com>, jic23@kernel.org,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add driver for MEMSIC MMC5983MA
Message-ID: <agAteDsZ69MIqyrT@ashevche-desk.local>
References: <20260507205033.951990-1-vlad.kulikov.c@gmail.com>
 <20260507205033.951990-3-vlad.kulikov.c@gmail.com>
 <880e0d0c-da84-484e-869b-ff77454874e1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <880e0d0c-da84-484e-869b-ff77454874e1@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 09, 2026 at 05:09:33PM -0500, David Lechner wrote:
> On 5/7/26 3:50 PM, Vladislav Kulikov wrote:
> > Add support for the MEMSIC MMC5983MA 3-axis magnetometer. The driver
> > provides raw magnetic field readings via IIO sysfs with SET/RESET
> > offset cancellation for each measurement.

...

> > +	ret = regmap_read_poll_timeout(data->regmap, MMC5983_REG_STATUS,
> > +				       status,
> > +				       status & MMC5983_STATUS_MEAS_M_DONE_BIT,
> > +				       10000, 50000);
> 
> I wouldn't mind seeing 10 * KILO, 50 * KILO here to make it easier to read.

No, it should be USEC_PER_MSEC (requires time.h to be included).

> > +	if (ret)
> > +		return ret;

-- 
With Best Regards,
Andy Shevchenko


