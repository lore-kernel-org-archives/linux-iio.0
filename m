Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A042F390230;
	Fri,  8 May 2026 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231953; cv=none; b=cMgtYJl/DOXRPA4HV1Z1YOzAWJW8WxO6ZRh3wShBb+JJUmd2I7WATYKv4SRIFmILm56unQ1bVxae0ocZ9I442iusZFEiG4VlfBfFhDXXdN+rigOERpNqgYCZcS9PqiFOGMyDr5+63LKHpBfZqx8I7UgUkM419M2xF1oCJRw47Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231953; c=relaxed/simple;
	bh=kZBNuxc/uLOSkY22/1CWq9ckisRILCV36I1f+kOHHyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB3j56hT4c+kX8SRTIsQDOcRNnS5dgG2DCaxlJ5nSUjBNyC4i9iOFv70JaOeOOvTEc6nd3qQGj9saVPpT4174cKKWhUC5yknQiSi4PfLUgv1o+3Ng7ww4LUyKhPahRTX4NMzOsUDs3doPT6O2nWKRTxsSX6rbpe9wBqqxLeMmsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJbElILv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJbElILv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778231951; x=1809767951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kZBNuxc/uLOSkY22/1CWq9ckisRILCV36I1f+kOHHyk=;
  b=jJbElILvgFb6BiDH3BPkUmtQAUnBbhDH4BQY9PsBWUk/21t8RjQ7/DfO
   7+31rwd622zrmLdCcb1X+kucCeeqY+yP6ijQTkQZ0T/Bl7UdbEc3X1h2R
   7Qp6J2c4P6H6JHqOOn3jDdYH9bTcrJJyrUz47ZEHPbX3YOrI3j9L45HUC
   RNEzeqdJHjKmcTaWXlBIKkx0GwR1v0Ad75OS3g3XKw6V5MLmq08SMyzO3
   ARG5wknhakfkK6goBTm72xl0ec6e4ybDjlU/wvqHqv/B9ssFTcf7FDBSO
   iCki3keNHz5uLh+exZTEBgNr/+c9QcRA41NTaieZ0ZefRKQXG+b6e/rNd
   w==;
X-CSE-ConnectionGUID: GOjeE3XLSp+88r4ZoXsy6A==
X-CSE-MsgGUID: 4JctVwpqThytgbQ4t9QZxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79238638"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79238638"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:19:09 -0700
X-CSE-ConnectionGUID: BbjTKtk7S+S/LmwrZr8Z+A==
X-CSE-MsgGUID: jouEi2aQS+OaVSfOdIpq8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="236651262"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:19:08 -0700
Date: Fri, 8 May 2026 12:19:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] iio: magnetometer: ak8975: driver cleanup
Message-ID: <af2qiO0BZLoGy1P4@ashevche-desk.local>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <af2TFa3qd_7tcxeR@ashevche-desk.local>
 <CALoEA-wUdMm5gu=OhhgYV1C3o3MHEzfC0i9gjjUz6CE4B+xw1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-wUdMm5gu=OhhgYV1C3o3MHEzfC0i9gjjUz6CE4B+xw1Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 08, 2026 at 10:59:12AM +0200, Joshua Crofts wrote:
> On Fri, 8 May 2026 at 09:39, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, May 07, 2026 at 04:35:49PM +0200, Joshua Crofts via B4 Relay wrote:
> > > This series is a continuation of the previous ak8975 driver cleanup
> > > effort, as most of the patches were picked.
> >
> > It should be v6.
> 
> Jonathan said to either do a v6 or a new series, up to me.

Fair enough.

-- 
With Best Regards,
Andy Shevchenko


