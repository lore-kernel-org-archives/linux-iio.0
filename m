Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168625;
	b=1JdM2NXlVT5QCRlEvaA1LQCXC5OEx3X0g7cGvojyuLOsx6m2BvBz1G3FqbxN3vl01vQ8
	 m6cjMg/BA683hKk139cmH+h1scJDUCLTliGcZjdssi0ApxSEsUwgrN70zvny2d5NH3Fc9
	 lwazH2zV+WjrXBc0dLH6o1d0WbVg4XVpbIIYwjS0rqUH6Re7kZGv+PvwCXTEHf2sFj/Mn
	 iPUaiJMITRPSBPkI/AU23xFcYLYlV7u9iTlSQT7mOKRl+HuI4SPWI8CXYKhhVwEL3fqCE
	 gcZiCX3D2ZHsbdSVgPXq6KHsfIt7aLdWdiD4SAUigC2QtXXeCMeh1j2aDF/eqvRO9bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168625;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=11E1vsiONRZIOK89LHLfEafRaKKb19aVtEQpwGrWsrE=;
	b=jJheMFtRyzkqgp3hvBr4qC03xrTfF9dDvAOJ3/TqwTYCOzV6TOxgFEMSIMeuynrivizv
	 FOS7FfgKayQMn9V45DHubzKHkN6dgnLXsF2czdrog0mslJPy+M9lwJoMqIb7Q+n41Mbrz
	 GvMnVBr5ya23LW1T6+A7Yhna60fgr7wLDwKtHpsidLNTEDF0eo4zwApBTw/YdRDueM/O7
	 PEMk2FUMGTpslj7NSU8q4/77yWjbUC7EkkNFfvW/m20j+RtmrE/OVCPQ0dD7AbvcYToiO
	 M6kAoEc0i7NvBuQax2rXK39swzcPsAHHXCC01MPCkdjUdgijdoTuiQ7HdD9shAwBqow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F58JwMvz;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13D2606A330
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 09:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E13D2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F58JwMvz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795168626; x=1826704626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GVf3jkBbAgdsIaAOElJ92g3+D0cBMpcJVs6bHRq2gdY=;
  b=F58JwMvzRdZHK1r+B9wP4tnSj2zo7Vnp472elyv6w4emdHE5/A6RHVKQ
   PuuXDunLWYShhF9vwFhgOhc0Yt3zkOXAeDuIr0AE8vWRXrpfnnwCIGfn3
   k0LpVlziO9/QEXBIN7bi/+HZVMqjapc7wr0l/jLg3K2PGvlT0H7V+WJha
   wCaHEx/DPAGBrv58mTow+b19vAYjsu82QEHuCC7VUKSwu3Jm827ctv/JK
   OnbhHxObVJFzgtEENoF7Zz++B3QISqmgxrr6dvyJ2v5jCgqYEH13tuSbM
   zxuZpW2+AT4cQYQKnRszBPT6XjP5LSByl31hqlPNme7XZJQSSCTfQ3ls1
   g==;
X-CSE-ConnectionGUID: mofTnllTQGKYBVKIANNH9w==
X-CSE-MsgGUID: d0WB/HC0SWyJORxIyqreRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3945691"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3945691"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:57:05 -0800
X-CSE-ConnectionGUID: 77Pq4GPITuGeciWPMAVcPw==
X-CSE-MsgGUID: W4p9eFsdTkGTkM0e3/5x1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10887647"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:57:02 -0800
Date: Fri, 20 Nov 2026 11:57:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, knaack.h@gmx.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] tools: iio: Close attribute streams on parse errors
Message-ID: <awAZbHa7FJNbAkob@ashevche-desk.local>
References: <20261120062125.98462-1-zhujun2@cmss.chinamobile.com>
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
In-Reply-To: <20261120062125.98462-1-zhujun2@cmss.chinamobile.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 02:21:25PM +0800, Zhu Jun wrote:
> The second enable-attribute pass in build_channel_array() and the name
> read in find_type_by_name() jump to cleanup when fscanf() fails without
> closing their open FILE streams. Neither cleanup path owns that stream,
> so repeated failures leak file descriptors.
> 
> Close the attribute stream before leaving these paths and preserve the
> original parsing error if closing the stream also fails.

...

>  			errno = 0;
>  			if (fscanf(sysfsfp, "%i", &current_enabled) != 1) {
>  				ret = errno ? -errno : -ENODATA;
> +				if (fclose(sysfsfp))
> +					perror("Failed to close enable attribute");

If errno == 0 and ret == -ENODATA, this will print a confusing message. Try it.

>  				count--;
>  				goto error_cleanup_array;
>  			}

...

>  				errno = 0;
>  				if (fscanf(namefp, "%s", thisname) != 1) {
>  					ret = errno ? -errno : -ENODATA;
> +					if (fclose(namefp))
> +						perror("Failed to close name attribute");

Ditto.

>  					goto error_close_dir;
>  				}

-- 
With Best Regards,
Andy Shevchenko


