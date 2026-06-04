Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F4333727;
	Thu,  4 Jun 2026 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560201; cv=none; b=KJH3EXYfLpWfLXwlMoA2/qbd7babTzvYgNd3qCEkpyNyFv8naXMO1RNAuY/9xw8xaf7pXBjQxeVR11ZwrucdRvovHcimRGXjuIDOx0CNBi2xqAGDvgCWuYujz/5qTKjqn5Y9hmWLdjwfuvHZP6D8CGVSJBAxboxvDk9zSdpttqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560201; c=relaxed/simple;
	bh=7wlbzBpIne/Dq/I4A508LDQHjcIZK0mUCHGgBu3dPPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taTjm1lqAKwmsXyxC56RUKzcM9oV0zODnCLx8SF4J9M2VkVY1BU/df+VgLKhzhHcJqnBXb/bQ6yvfxvrqS+VEiqrXTOxnmQllZJUxeK9q4GOweFlMTm4ujRnEdvOoIC7Fw45D9jsHg65gD7BxL0gp3HiN3+kfL5fHja7U2HIXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1ITUDHv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1ITUDHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780560201; x=1812096201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7wlbzBpIne/Dq/I4A508LDQHjcIZK0mUCHGgBu3dPPY=;
  b=N1ITUDHvK04G3Jp57DFek/03AMtjxBl9RmkaQ7naE5hO79ytoL+MZi6+
   agr8DvUYXkX/90EFWZ9Uol/rijSjqWYSj0/HnBplQ2gJW6ER+AZehOuAG
   fP2Olap0UpOXY+VRU6+7TXt/V6PszX66OkSEfV3qmHYRNJCwBI3PUEuTe
   Ay+jeAJ0kbkObaaKh5i/BX0wpHTObJQJ+ueyFpSUjESRKPGsAT3VINPvT
   IQRKLGeIZm4SB+Pqz/p4sadzjYmUC4JE6YlciRWjE4SH22nv0Ehkp9uKF
   dQM3ip5rE8f7gy9QU34/iAUAwYPYDIwsononMUiCai913M4rwZnNgcPIr
   A==;
X-CSE-ConnectionGUID: aTTDzBB2T9mcdEPtmH5E0Q==
X-CSE-MsgGUID: a8fcaIZzTC61XVHIisR5jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81442641"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81442641"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 01:03:20 -0700
X-CSE-ConnectionGUID: Uh7laE23SMKo+X1snuQ+Ww==
X-CSE-MsgGUID: 3UWW7A9+SUqWEbLEWUi2nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="268389408"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 01:03:17 -0700
Date: Thu, 4 Jun 2026 11:03:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aiExQzpIOwPgwd3-@ashevche-desk.local>
References: <ahP3O2tQdu4dNx_c@stanley.mountain>
 <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
 <20260526191946.409160c8@jic23-huawei>
 <aiEpmqKwFuIMRfdl@ashevche-desk.local>
 <aiEtIGOFhF8AfUCT@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiEtIGOFhF8AfUCT@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 10:45:36AM +0300, Dan Carpenter wrote:
> On Thu, Jun 04, 2026 at 10:30:34AM +0300, Andy Shevchenko wrote:
> > On Tue, May 26, 2026 at 07:19:46PM +0100, Jonathan Cameron wrote:
> > > On Mon, 25 May 2026 08:20:31 -0500
> > > Maxwell Doose <m32285159@gmail.com> wrote:
> > > > On Mon, May 25, 2026 at 2:17 AM Dan Carpenter <error27@gmail.com> wrote:
> > > > >
> > > > > If the *ppos value is non-zero then simple_write_to_buffer() will not
> > > > > initialize the start of the buf[] buffer.  Non-zero ppos values aren't
> > > > > going to work at all.  Check for that at the start of the function and
> > > > > return -EINVAL.
> > > > 
> > > > Commit message is incorrect, it looks like you're returning -ENOSPC here...
> > > Tweaked and applied to the fixes-togreg branch of iio.git + marked for stable.
> > 
> > I was stumbled over these patches by Dan. Since the file_operations for the code
> > in question do not define .llseek, the seek is not supported and will return
> > -ESPIPE. I'm not sure why we have these patches to begin with. Dan, can you
> > elaborate on the case where the *ppos is not 0, please?

> The simple_write_to_buffer() will update *ppos so partial writes are
> supported in that way.

Can you show the step-by-step scenario? I'm still fail to see how it may be happen.
Is it somewhere inside the kernel loop? Which VFS function(s) is responsible for
that in such a case?

-- 
With Best Regards,
Andy Shevchenko


