Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B8F2F1FD7;
	Thu,  4 Jun 2026 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584915; cv=none; b=RglevCsiH6VHFaWEljWsG5UrdKjiuCVMQivqq9VOBH0YCHbYlr7mgUR5hzBbyDx4nA2FVMDMkRm8OVOL0l667VW0E52zBx9Q7JcNCICMYp7cZkInN1ktCAx0h8ggcPEWdoHR3QGk/HZ0mobaI9xEUkoqq64yKH73jlXAKiEC1VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584915; c=relaxed/simple;
	bh=nHezW94MaWIUjKuHQTaa4iPgsO6vMfojL2bAlvRr+jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr1eTMiumMFNSWXi+POCd2jmcrdABZpA3SRF8wpyzA055RJT0U2yMpoy3F93oyfXZmFooVa1fCq86Xr9wXXPQTJ1QRRG0BWn/vFl6474y1pv32Be/ibpY/F1YDPVHP1a5Nm0CjtUQPAtlxbx0VBdOWxUr/pjY//BlqSyOAHW5wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKE6FAzz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKE6FAzz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780584914; x=1812120914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nHezW94MaWIUjKuHQTaa4iPgsO6vMfojL2bAlvRr+jo=;
  b=IKE6FAzzXtYrWNA4ZgWSbwgwFfbr2x7o94hKmW0InxklIZn6qBprrhKc
   9SsXurIvTzYHPW0kbiR18CP++nhqbS0TbQJV7YqLHQrA/X/KkGDcyhgf9
   jeLjFtluYOom2kEo/+1FwPd4vkMQ7DW6XxM+5iwPd7hL6o8nEHqa5xSqU
   +DmabBzjQJizKYOaAew4NlYfmYNtHZE7AR1RGiGBfq7if7Os9E7Z3yk21
   facnG6kOyokhu0cWyUtHe8UFArHT8quizFOG1oPEJkatUry0tpUxQO0Qn
   dytw6tHYawRBSIdjKHA2LFy0Fd4dJs6/rW8wZwOtKBYFIslENt0fBPSEL
   A==;
X-CSE-ConnectionGUID: uoQSB2wXQFGjLWsm++o3+A==
X-CSE-MsgGUID: t6+ws4y7Qsm6b2iIMFxaGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="98983449"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="98983449"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 07:55:13 -0700
X-CSE-ConnectionGUID: sqgr3HofQeCzNPsFg0NZaA==
X-CSE-MsgGUID: 5iteTpR5TbCLXzXdBqNzng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="246399563"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 07:55:10 -0700
Date: Thu, 4 Jun 2026 17:55:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aiGRzFrSU6QUL4R2@ashevche-desk.local>
References: <ahP3O2tQdu4dNx_c@stanley.mountain>
 <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
 <20260526191946.409160c8@jic23-huawei>
 <aiEpmqKwFuIMRfdl@ashevche-desk.local>
 <aiEtIGOFhF8AfUCT@stanley.mountain>
 <aiExQzpIOwPgwd3-@ashevche-desk.local>
 <aiE3N6zErq2WcCvS@ashevche-desk.local>
 <aiFVuvVtaWbjfVzA@stanley.mountain>
 <aiFWg6vC2cVbONTK@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiFWg6vC2cVbONTK@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 01:42:11PM +0300, Dan Carpenter wrote:
> On Thu, Jun 04, 2026 at 01:38:50PM +0300, Dan Carpenter wrote:
> >    168          ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> >                              ^^^
> > Uninitialized variable.
> 
> s/variable/data/.

With what I asked in the previous reply and what you explained there
(thanks, btw!) I still think your patches are not fully correct. They
will require to atomically write all or nothing. If we want support
partial writes we need to go with that differently (reset ppos when
we got enough or more than enough data).

-- 
With Best Regards,
Andy Shevchenko


