Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45994432FD;
	Wed, 16 Sep 2026 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543883; cv=none; b=ckxPn+TAu8lZid04egaSHmEd6DdUgDeMw0i8TG4M6PU7oXov+pAbasChKQ5ZzeLEutyiDgTzH0EHziiqga5IMmTt7iYHlHQkiD95QZopOdewBpTShZxWLpKHzUfirycH4V3j/gMVvtAg5keBI8b1ecaQPwgloHW4EK+6ITggp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543883; c=relaxed/simple;
	bh=rdGpBD8Eisa9ARLs+EWjxDE/BU5fmqrO4rcGBHOTxKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNSNMYAj8oPpLVZX2ScuZnHGjYiaJqsmvTwl5SDnk8UaM2HilP7Q/+QCAK8FcCVH45zcjb9KrqTkB/Ibsp+rV8tPg6eAPcCr86117H2mnoJB7evRswXp7I8/2ALKQ5bNhSYD8qOhitnB1RNMpuhkFNMjCMYg0GeP6eZAmTx0vkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKos5u+F; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKos5u+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789543874; x=1821079874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rdGpBD8Eisa9ARLs+EWjxDE/BU5fmqrO4rcGBHOTxKQ=;
  b=XKos5u+Fmuxw1tv+ANVXGCMtIwE3uckwMnC287Ffk7A3ktCnSGVGQPu4
   5Om59v7R74KNP3leK3wiEV9m9cSuBAxG+ETRM6p3z6ms3wS4W7e42ZEQ3
   U12rAMeoJCLAK6zgiDjoRzLu2CiQqlWAgwVT2a4N/vjaY737f9GO1PNRJ
   4B34IQ6jvZkeNCTomn8i4deZVpYLwupyKxo2GcanXLigPLctv2losoDVP
   JrywAGjNsWAEpmzs6ZRraazHS+4yIIxPVJsRDRfkrCfrUBThKQ+ORTU9e
   fBRsd+zMDju8wtYYvXtS4CHRKvprZKZ6Ub6ilvmkccMQGUhsRccqrukfp
   Q==;
X-CSE-ConnectionGUID: G66v2xkQTdGIqjYBZXExcg==
X-CSE-MsgGUID: R0OzfYAPQuu5NhUbJg/ktQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107425637"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107425637"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:31:08 -0700
X-CSE-ConnectionGUID: +73MyqACSgC/S9MuG04dwA==
X-CSE-MsgGUID: xyi+tZQ3TEqb0E/J5aW5Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="311533637"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:31:05 -0700
Date: Wed, 16 Sep 2026 10:31:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: iio: backend: use literal block for commands
Message-ID: <aqpFtj_yYBcznhDT@ashevche-desk.local>
References: <20260916054924.2052572-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916054924.2052572-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 15, 2026 at 10:49:24PM -0700, Randy Dunlap wrote:
> Use literal blocks for 'cat' and 'echo' commands to separate them from
> the surrounding text. Otherwise the lines run together, without any
> clear break before or after the commands.

...

> -		Directly access the registers of backend Y. Typical usage is:
> +		Directly access the registers of backend Y. Typical usage is::
>  
> -		Reading address 0x50
> -		echo 0x50 > direct_reg_access
> -		cat direct_reg_access
> +		  Reading address 0x50

Then make it a shell comment style

		  # Reading address 0x50

> +		  echo 0x50 > direct_reg_access
> +		  cat direct_reg_access
>  
> -		Writing address 0x50
> -		echo 0x50 0x3 > direct_reg_access
> -		//readback address 0x50
> -		cat direct_reg_access

> +		  Writing address 0x50

Ditto.

> +		  echo 0x50 0x3 > direct_reg_access
> +		  //readback address 0x50

And correct the style of this altogether.

> +		  cat direct_reg_access

-- 
With Best Regards,
Andy Shevchenko


