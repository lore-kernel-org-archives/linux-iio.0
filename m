Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426F35C699;
	Thu, 17 Sep 2026 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626851; cv=none; b=se/Fvktuepi2bIVROCBjm2Jr4Mv2039dcjH1MW/2WGksoTSrtfh1n7IaNLkrNWXvH7S3hM9sj5bRn995OW2T2ZtpVjbRdKPoJ1/koyf/ArnJCbFdUsB4jfiVfyjEWbGiVnODCXhAI4cL6ZTS/lxeXiMhNRdvCe/doyg/TRiJSnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626851; c=relaxed/simple;
	bh=oBqHdSw4oEXcx0AiqnJ/mcvv5pJ37qQbhVraLtPivcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZRPubHV1wyTolZmCBHQuyHl44I4NzDBmsAoL0b4NKxx0SXkxtxqW9VqOG5sYaGH9uZmb7s3slppL8rRYnjrnO6kId31d96Hmr0OuhU9s7KhDj+6Sq/Qm5X+2C12aJgWQH4BPXXWfLjqKqZIgMPhTYTi3bsXF/IFzvEOKhuHWE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKWmSjFw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKWmSjFw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789626850; x=1821162850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oBqHdSw4oEXcx0AiqnJ/mcvv5pJ37qQbhVraLtPivcA=;
  b=lKWmSjFwvmpZdc2dnB5+3uSDissHJKPaHJGGzfHqH7pkO8leDNH4Z7h9
   fYTM3QxAwaGi5nci/Ey4tHL0kLZ877D8Do4jFDqyHuEJoP7dCVzAGuN2I
   Ym9iQeqb++4zYYf+uln6pbyvqCQbwmmB+wkHsnzMc2lwaeFk55njBPubF
   icodjUd+f7fmyse7L6Msnj78i/RuG2xGOOVrp61f5/WS4o5SqEj41qMGV
   yNyzzscjlGXE1oOmNwn3bzj3rLtiZFoGJHYZC8H86aLlg4+RYTmQ0E45T
   dD+oZyhWYP8DkrFw6hHC3imtwOH36BTt3FS7cNbh1fDk6anRESSa7moyW
   w==;
X-CSE-ConnectionGUID: zXRzsMoQTg2B1qvuNFk3hA==
X-CSE-MsgGUID: OpHGMfH7Ru66WCkDALI/rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107523364"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107523364"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:34:09 -0700
X-CSE-ConnectionGUID: +iRCG2OhRqOjq5++DiIv0g==
X-CSE-MsgGUID: f3VkCtQ/R7mB9nR4sp4pbQ==
X-ExtLoop1: 1
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:34:06 -0700
Date: Thu, 17 Sep 2026 09:34:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: iio: backend: use literal block for commands
Message-ID: <aquJ3GYIZkDSkLXN@ashevche-desk.local>
References: <20260916180739.2296401-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916180739.2296401-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 11:07:39AM -0700, Randy Dunlap wrote:
> Use literal blocks for 'cat' and 'echo' commands to separate them from
> the surrounding text. Otherwise the lines run together, without any
> clear break before or after the commands.
> 
> Use shell comment style to go along with the shell commands.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


