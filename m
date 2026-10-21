Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608823;
	b=ZX1iqdsV2hTCSz5Z+BPIH8gNAXF7kYr7zTtsCPywOF2tr6BWI3Y8diVdFSOdfjMz96IX
	 JIvMfFjSI7ImfqSlgjUkjqjbA53NpO+7/o+tynCvGrsgUwzbIuyPt6iZkJzbpvp1fPm67
	 y71nzi4mx5jMOXP6U87NuiJ21KN5RV6vfjCLtfoNmwr1bpCy31ZTzM0qsvMaKTkxvtjvC
	 zfP2ZeZpVVCdQibEhD2181Gi8sGiHx69K7lq3HTC6FV8nQ+DWZ3QxtLl3HMeYJzYxDz10
	 1btTQqq33PMvGeIaBkMhvgqzQKNdpuHwRwN9PWVVj4mFmBwGgwIr6/H1pWJSmWIlk5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608823;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=7lnmtc17BSdgNxSiz6MhbF6463BF4PmzHevtPUbsEmo=;
	b=TStGTsYEB0apZlvpu60Tti/SCOc5POARpJmY03OOoDJ/eC0vlP/zfPnl0UT6BNmhX+FH
	 CDL4wB3Gylb1v8F1epB+yAyuyZqA4sntM10MVRysgmAwuHCW4qQ01Myel/FyqV7V9QxxH
	 T9g+YNTuVR62+IrV8aSskbo32R9XHtW9smVILBY2SpjQOwPgCah6spxStw4ZnXVfMDNG9
	 k2oggyJcYinH2/OggunHmS8wkANQHmr8730xetPLEEvQSTezEw8LcXaYIesg08X3iT5Qg
	 gKFV3YBdKsqvB03Vr3KKGCdodjW8H+0weUuEluw1qu0dNcZdtdoBMb+T38j1E6lVJDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lmuQ6dXd;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6313606A319;
	Wed, 21 Oct 2026 18:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6313606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lmuQ6dXd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792608822; x=1824144822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o0DFkB9dJs1Dl4KwJLBNMiua3ECNncQS2ZlsCMjSNco=;
  b=lmuQ6dXd9yhpjpOwgG0Jv4Y0VwIj3eLMtREGbtJygP0gaIJhNF10A37M
   6zyrZ7n4H1JKiVVeRA+aXX+aEsyFvtdKHgKxekMfB7H+LRXWX3xAI2pT7
   YtVvOuDh8zuZCX5+sWmB03F9TsPSbVDGh3WNaGWH1ev5OlIyQdECZV7tm
   7SOT0kefAx5d7vwHYkjHKCOkmZhOZ9OcaZ0frUP995yq7+Fbsnadhcr7e
   HHJAD6B9r912yOMD05gTd6xjblDGkOihdt31atG4n5igLGggyU31iN4TG
   EEIegWPhoufq6V5vfoC4HDIaE2Qe0yZaT0IyVoqsv2XLBwv4yDwu29wTm
   A==;
X-CSE-ConnectionGUID: Iw4IXsTdTb2E0cmg/eotew==
X-CSE-MsgGUID: bmIfcGbRRKGDK7UCu2uVCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1328749"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1328749"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 11:53:41 -0700
X-CSE-ConnectionGUID: FTnDbCdWSMSVE1Du1M3NjA==
X-CSE-MsgGUID: 3tT7CI4rSDeM8UzVU6jMFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3221989"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 11:53:38 -0700
Date: Wed, 21 Oct 2026 21:53:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: joshua.crofts1@gmail.com,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: use named initializers for temp
 in hw_info[]
Message-ID: <atkKMNHPRLSrD3iZ@ashevche-desk.local>
References: <20261018000924.758186-1-kapoorarnav43@gmail.com>
 <20261020095936.00002ff3@gmail.com>
 <20261021183823.169199-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261021183823.169199-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 12:08:00AM +0530, Arnav Kapoor wrote:
> On Tue, 20 Oct 2026 09:59:36 +0200, Joshua Crofts wrote:
> > Your patch fails to apply, please check it out.
> 
> Thanks for trying it. The patch is based on iio.git fixes-togreg, on
> top of commit 2b8d4cd20ac8 ("iio: imu: inv_mpu6050: fix swapped accel
> and gyro startup times"), which changes the neighbouring .startup_time
> lines in every hw_info[] entry. It applies cleanly there, but not on
> togreg or testing, which don't have that fix yet. I should have said so
> below the ---, sorry.

just use --base next time when formatting patch (with `git format-patch`).

-- 
With Best Regards,
Andy Shevchenko


