Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81964CA26D;
	Thu, 11 Jun 2026 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203461; cv=none; b=bb5s/ZnWKY9xGT71yXUaCeMd0taVSiwGDY59ueEZW6mCk1W2TNUTX2rrAzbJfgmx0MVj1zc1qEQSuFSDAMKh//5TkLdugUbrakAywoyWn9dhOTcH8JAo7kKNtmXZEpjz12gnDxvbR/TJ1eC8NRX6PG8eKj5zJz44IZfI5eZACXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203461; c=relaxed/simple;
	bh=Uu0EUrYcYzRxhipVR8GRy+mGyXR7hyimQ9lyzacRiEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUwu5McKhRWrv9/X9QTHLfhJV/pbBrXRylHKF9OCPYC/v3HlAwlSs4XGQISdHp6H96gFJJ0lxNN9h5/yzRiWo897Lq/Yb8DqII9eAmRnFj1lINBocUjEZr7vVNK3BOKUyNkYwZY7tX6ZFd3Dc/1q2TN2bxoH1/M7h0YdHpmsaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8yUp6V7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8yUp6V7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781203460; x=1812739460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uu0EUrYcYzRxhipVR8GRy+mGyXR7hyimQ9lyzacRiEA=;
  b=F8yUp6V7FYJ3DKyDk364kElPp7p7uqhziIHJ0eQJ6akZW0LAyXilqOZK
   k0bRiHNYta1s7wL4sR135w6i59Ec2+Qoik6d+mToJQFYoBjfHGCXGUBE2
   Uh+UnOizvMfH1KaIduokWVX+7L/h0kBZfxaXWwx2d4G1GtGpGxiN5eFlf
   YfhlUPpLJJg6tCVkr/jTJgZ7lWCKJA7LH552zcDC+t+L/e6/j6UGA2Ubx
   DAL+7ruN5y8aJLrY7/nyxHC2p+bZkwPB1TSBVABqeQsFTWxSgKYTu+J2p
   KBiv8ho1us1X+n7WmezAfEoy/FrunCv4pXomQcTKFuWUpnkTOBOPn56nJ
   A==;
X-CSE-ConnectionGUID: CusZmr1zShGcuweHHFaXUw==
X-CSE-MsgGUID: SmDqGqlTRFyb8ImFj5GNSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99605124"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="99605124"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:44:19 -0700
X-CSE-ConnectionGUID: Elqz2B3WTtynczbdNmzzsw==
X-CSE-MsgGUID: EpMDXPKZRW6zS1yILICKGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246457518"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:44:17 -0700
Date: Thu, 11 Jun 2026 21:44:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	open list <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] Documentation: ABI: fix brackets and bracelets
Message-ID: <aisB_zJX1goFb0YN@ashevche-desk.local>
References: <20260611085620.127959-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611085620.127959-2-manuelebner@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 10:56:21AM +0200, Manuel Ebner wrote:
> Fix missing and needless brackets
> Fix missing bracelets

Please, use proper English punctuation.

...

>  		all VLs from this port. This may include packets with errors.
>  		This is 64 bit counter.

> +		port_rcv_packets: (RO) Total number of packets, this may include
> +		packets containing Errors. This is a 64 bit counter.

Side note: 64-bit (note a dash) is the standard form of telling the size of
the fixed-width values. Perhaps also update at some point?

...

> --- a/Documentation/ABI/testing/sysfs-firmware-dmi-entries
> +++ b/Documentation/ABI/testing/sysfs-firmware-dmi-entries
> @@ -93,7 +93,7 @@ Description:
>  		  /sys/firmware/dmi/entries/15-0/system_event_log
>  
>  		and has the following attributes (documented in the
> -		SMBIOS / DMI specification under "System Event Log (Type 15)":
> +		SMBIOS / DMI specification under "System Event Log (Type 15)"):

Probably similar approach as in the rest?

		and has the following attributes, which is documented in the
		SMBIOS / DMI specification under "System Event Log (Type 15)":

>  		- area_length
>  		- header_start_offset

-- 
With Best Regards,
Andy Shevchenko


