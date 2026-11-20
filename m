Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168675;
	b=rDtv3rXHku8uU5yHN7m4vxIE/6lYBgDe4qi26zxhypRFmL1KvhoRnwBcnB01DRevMlzF
	 rY+mKWLLE7ql7Zo2hdGxeKiZnw0gas7wyyvcnX+z3CAj/srcJywUgfH7urHrJZxh86kXJ
	 yEdNViN9SzFaG00KAtGd1In8dxc7lhfm/D0EWNqim0xnvjAo0/M/GZdpnrODyPKQaW8mS
	 1Rya1ySRLhct6osWtys0+IwK3mWbFBOVdxE8MwLkrp9gIu273ygD8Al2M2LHf8jya24/E
	 8JAKhORq0lanFn1szl1iA3V4gTpZ0F6xJSfUwgfHkCTGfvynPb8ouo27RTDacs7v6Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168675;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=X/98dSBMLDx2db/v4zjIKnzGh1th3PBgrWlLcm92MIc=;
	b=ELoG2TfzHy9G1afDwl3CPXrpDRGtyp+s5QMT/2bLJ7yaipm7Y/Ndfhi9PVRxB4WQA+lq
	 65nBR7jdzOcN8nq5IVa1MeseVnhtd3rmCM35vw5zfr2FarQpi6iOfUqkQDP0aeJ1V79d0
	 mrdb4wc4KnrPiR4qhmG5sXPSLpwh7og6OMGtTqkeihg9gotvQQftf9RwpzQzPgRvjB94c
	 jrS+6dOU0qvrFJ1pc+OeTz8UsurQx7Jg0+wxbRazKaMWsZ9/6Jth0pGBl2SYBAqrn45lv
	 PdmttLbgZojgGPDeM6Utw1fztrS5LG9ftNOEeM8iEVOph+Qx/B0h+5rUsQjjf7lU2eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mZ2ryLpI;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D9A606A338
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 09:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63D9A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mZ2ryLpI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795168676; x=1826704676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qj91Ro7tLPO+pwjMM9QQKbOp7dOsCZsl79sOjztfBwM=;
  b=mZ2ryLpIh30sXy6l32dCKhJ0Z7oySVadeLbWq52JTxY5NLOFz954G5JV
   Hi55KSNTaPp/vBMnGHzHeDjWl1Ea8U3lZfAyCNhr90ID8pPHkbi89IED0
   +avMbVfYWDh/ueEyYPIpAk7d7EP2zQn+YS3Xj0opmpkXvceSuOX30gqWb
   x0+Vx1GTBOJSZwosW0gUCzTk1Or4+Uh4/S8USGQrqQbOs1sK/+qsWgs9q
   ZG3QY3io2lEurbiLCXSiJUA9ROPOqxpoDXyAuKrAyhE/PdgifSZBx5L+f
   umA4ffOj8633ZVXHP3J4F67Srttm6TrjIH+bfLlwvTd1SQw/X8xgCxZBN
   g==;
X-CSE-ConnectionGUID: LQNDX3vqSKSGhWWa6otvAA==
X-CSE-MsgGUID: NkURxRbRQEOZpT121bfW1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4031175"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4031175"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:57:55 -0800
X-CSE-ConnectionGUID: naiGySuzQQa7QfNzhAkPRw==
X-CSE-MsgGUID: NsWhiSfyQ/ykAJD5IUF7aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10657056"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:57:52 -0800
Date: Fri, 20 Nov 2026 11:57:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oscar Alejandro =?iso-8859-1?Q?S=E1nchez?= Lucero <aleszlucero@gmail.com>
Cc: zhujun2@cmss.chinamobile.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, knaack.h@gmx.de,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] tools: iio: Close attribute streams on parse errors
Message-ID: <awAZnuq2XAGo5De-@ashevche-desk.local>
References: <20261120062125.98462-1-zhujun2@cmss.chinamobile.com>
 <20261120074417.33563-1-aleszlucero@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261120074417.33563-1-aleszlucero@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 01:42:39AM -0600, Oscar Alejandro Sánchez Lucero wrote:
> 
> I checked both paths in build_channel_array() and find_type_by_name(),
> and confirmed that neither cleanup label owns or closes the open FILE
> stream on fscanf() failure. Closing them before jumping to cleanup while
> preserving the original error code looks right :)

But the change has flows when errno == 0 after the system call.

-- 
With Best Regards,
Andy Shevchenko


