Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A2E199385;
	Fri,  5 Jun 2026 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780648106; cv=none; b=k378/sNfZ2BisANTXKozRFiWQc2sKJ8b0YQcr6jQGUnHdatN7IbWtZUfRhsoy3Ct/RcbTS17lqU/AOlmsqE5pZiHb+G9rwntsUCE1pxcXuotH2koe4UIuVgZxN4JzPAhc91+CY0BWoS/MfybSlvN1wS2SB7h2R8VhENgNoxzpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780648106; c=relaxed/simple;
	bh=RAj4HtOj+3Z43Stx/wILY+7CKE7lMTY/A7NN01QW0e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+Iu9h5Lf7shisnaMD44lSedIss1PzGYDGuvCdyQQ+MgHX4mCvvSeJ2x3UxMrhCG1meVdDlGHf1dar71+VPKt1+ZnCmWbUXKbiTEAFco5gPIH7fNL3d/RRRWSu9edA+3gCyLWEg76PoCvharD5XF7kvYYi7aarG8jf8VNiCiAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NqelvdrS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqelvdrS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780648105; x=1812184105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RAj4HtOj+3Z43Stx/wILY+7CKE7lMTY/A7NN01QW0e4=;
  b=NqelvdrSXT1dkC27u60ZJ+Pw2DLVXZV3z/+GhRcyGTVNDSGp4Sy/fB3v
   Hl/z78XW6zfj+P4Jb35226WcnTohHimMEnHjCrDoFoilmZHHCXPhRgBzh
   FFgLThRAWzmgxVmhBWmDy5Eut7X70JIzo9jwU1GHxvRgll2ANxvdS1Zz2
   VpO7jYVPsTcwMLy/2LBXmWtPHBPK72RcpKOoaV3D0J+c1oTtrD2f590y5
   buIPVpEQJWiMgjhmMY0J9OQpaBuXlqtEjxn78EQey2W+3A4Vq4Iyb8DNo
   XIGP2HhQzo6CCNfPiP5DEr+JSIlUr2OUhxWf54BR7sWn8IkRcQu/V0Fz+
   Q==;
X-CSE-ConnectionGUID: 0Jw7S3lRR1eRWCaodYCXQg==
X-CSE-MsgGUID: 1Gk+mF4HRjKDw4eV6X7X6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92164925"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="92164925"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 01:28:23 -0700
X-CSE-ConnectionGUID: 5B5rE6VdRoOAgwmYoK15kg==
X-CSE-MsgGUID: 2U9WMVgcRs65qpmJzA+WQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="238435353"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 01:28:21 -0700
Date: Fri, 5 Jun 2026 11:28:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aiKIoqR0IQBZ-1ZD@ashevche-desk.local>
References: <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
 <20260526191946.409160c8@jic23-huawei>
 <aiEpmqKwFuIMRfdl@ashevche-desk.local>
 <aiEtIGOFhF8AfUCT@stanley.mountain>
 <aiExQzpIOwPgwd3-@ashevche-desk.local>
 <aiE3N6zErq2WcCvS@ashevche-desk.local>
 <aiFVuvVtaWbjfVzA@stanley.mountain>
 <aiFWg6vC2cVbONTK@stanley.mountain>
 <aiGRzFrSU6QUL4R2@ashevche-desk.local>
 <aiJo1kjN3_XDUdBc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiJo1kjN3_XDUdBc@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 09:12:38AM +0300, Dan Carpenter wrote:
> On Thu, Jun 04, 2026 at 05:55:08PM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 04, 2026 at 01:42:11PM +0300, Dan Carpenter wrote:
> > > On Thu, Jun 04, 2026 at 01:38:50PM +0300, Dan Carpenter wrote:
> > > >    168          ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> > > >                              ^^^
> > > > Uninitialized variable.
> > > 
> > > s/variable/data/.
> > 
> > With what I asked in the previous reply and what you explained there
> > (thanks, btw!) I still think your patches are not fully correct. They
> > will require to atomically write all or nothing. If we want support
> > partial writes we need to go with that differently (reset ppos when
> > we got enough or more than enough data).
> 
> Requiring writes to syfs and debugfs be atomic is pretty normal and
> works well in practice.  These are very small writes.

Perhaps. In any case your patch will break existing partial writes, right?
I'm still considering that resetting ppos is the right thing to do. Just
need to find where the best place is to do that.

-- 
With Best Regards,
Andy Shevchenko


