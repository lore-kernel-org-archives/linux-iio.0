Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72C287511;
	Sun,  8 Mar 2026 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773001652; cv=none; b=ko8pH2WrXWSp/fsAKnbaIkMeh0lGdk7wciKOagzUZxrcx20ETn4ueVbsRlF48Aj+saVkdrh78xfIlFupNNcopYb3lYmZmiS8xb85+0QG65I7F3ztmRlfInIPPBGOeqOYMFTe0ihsHUmsm25aGICRWqb/pByDuT9SMpft6smRQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773001652; c=relaxed/simple;
	bh=842Mv371r7N900wDtTAmP1fZPu7pkrIcySHK2nLAepw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+mHpt6Wdz/xRA91x/IsyXcKIAywI0NtfShhPUG9Rnrm5VPyXbU21A1U6A9n0ti/2II+PJBkxUhYCjplFFbJlrYKoGz99aKXUVJ0gi0jWodMhD8ReD3LZtYfm6mGHgYIH2L1Ta+GeN5cLx/4KJ3sihIXvf19CAQKjNyPEgFh5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XbJdqg9b; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XbJdqg9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773001652; x=1804537652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=842Mv371r7N900wDtTAmP1fZPu7pkrIcySHK2nLAepw=;
  b=XbJdqg9bbmfgjwLzvCOH+ZtDnyaWLd3Wc3TrClCQ675X0WApM+0ZZ0i6
   fwgkbNRimsXFHta3cxFN33K0S9M+3eUUy23IoOK2a+lfIwnE0LBEhQk9w
   3J1XESg1/hnkWk7tS0Of5Etkhl4PhoIP9h8fRuhyff/ZiP2BzPEsZxGtM
   w+fyXyIc2R7p0eH22vOSqm74C/Gr4FyqWFvOivo4eM/4+T51fStCJ26sP
   if82A/FiLMEO+LZ8N1u6NWenQdmWWWe4wF2VzXvp9Zfta1Z5VWG/4bPMB
   XTzGGzopdtPpic0FNnUF9ZbIp3zsH73O0nwx+b1xSLDO4xoMcUwwINwX7
   w==;
X-CSE-ConnectionGUID: OPlx9l05TlG3x1zwGoqRyQ==
X-CSE-MsgGUID: axtvYfKWTaOnTH/OejsQgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84359056"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84359056"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 13:27:31 -0700
X-CSE-ConnectionGUID: xyvEwSSOR52Nm1KTe5A9qQ==
X-CSE-MsgGUID: 3FRv/el5Sh6O64alzrbRZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219527684"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.83])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 13:27:29 -0700
Date: Sun, 8 Mar 2026 22:27:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Francesco Lavra <flavra@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
Message-ID: <aa3brnQzYT2fKeZo@ashevche-desk.local>
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080706.2844472-1-flavra@baylibre.com>
 <77e10517-2b6e-417b-95d3-185d3a067ba5@baylibre.com>
 <20260307130312.2efd100e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307130312.2efd100e@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 07, 2026 at 01:03:12PM +0000, Jonathan Cameron wrote:
> On Wed, 4 Mar 2026 16:35:39 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> > On 3/4/26 2:07 AM, Francesco Lavra wrote:

...

> Whilst I can see the argument, I'm not keen on more punctuation in the filenames.
> May well trip up someone's parser.  For now squashing the spaces is probably
> the best option.
> 
> This made me spot a major issue though. We can only add to end of these
> enums, not the middle!

So, if not yet, we need to have a patch that adds a big fat note/warning about
this on top of the enum(s).

-- 
With Best Regards,
Andy Shevchenko


