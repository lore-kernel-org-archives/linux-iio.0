Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC1279907;
	Tue, 10 Mar 2026 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138517; cv=none; b=toFc/QhMp2w5SIPfavNcu67Ryv2B9ab8B1Fahs1xfD1a0MY5982T562iOT6A6ugHSOXVLEs4P20WNFpEzzBgSI5jDwz5WdEhMLv1N27ZKoan+YFLABEZjXRM43D9RzB6CX6ujn7j5b60jmqgt4OmaaAq20008ug1cm60cvpfYEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138517; c=relaxed/simple;
	bh=298y6kHxzrb6ehOA6udjqsFp3opy8fwnqVp2AbZ6BhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/uvZtQiQfSg3DTZ8RIfFm/1BS+tlsjxCrFbvpxcJ9wgA+IGWPCluuTFgwqVuAysXI63C1XSHvceuVnU08K2svMP5zkBRe2dBnjd8h+5kYXpS9cSIlqwhSr8+wlljdLXOPAirKzjgBtwmf74oB1lQZyY6QpGFXzYcEZO1zbez/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFD0/Hyx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFD0/Hyx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773138516; x=1804674516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=298y6kHxzrb6ehOA6udjqsFp3opy8fwnqVp2AbZ6BhY=;
  b=eFD0/HyxcZpDBfrH/eykSC3kHXDkzuOD0WdtPy2UtS9bL/r7xD2vpwWs
   3U7yQF8f32ApBv9sigcL0ZMbutIAkpmkDlynudmimYJjbOwzf6qoSZjlp
   fCltpnvuSfwlUP9d5bJKWygC78vfPoFK50+OVE19FX5sjFKPPf1VW0wRh
   I624z4uzqu9b6OfZSkBd3xp5v+JT9Ny9Ed5RwkLZdS9mkIHpAWmcKumnZ
   hGyHi6DIJ1hrOYwRcX+W2hrmL8llnQPySW7fUnGlIe5Wn07KIo3RuBHza
   YocrKlcSwOfI5VemSsUzA5ySVCpI0R8JjxBUrKYyKnuG1ccHmt7w62jji
   Q==;
X-CSE-ConnectionGUID: /uYXSGiNSxqWlt55c4Ah+g==
X-CSE-MsgGUID: wSmGkXZOSser/UwC+yK6DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74057713"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="74057713"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 03:28:36 -0700
X-CSE-ConnectionGUID: VSI6tbWQQ3WdK7j4FsGTPQ==
X-CSE-MsgGUID: l7SvPCAiQR2zBbvP5oAlNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="220024517"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 03:28:33 -0700
Date: Tue, 10 Mar 2026 12:28:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Till Kamppeter <till.kamppeter@gmail.com>
Cc: ShiHao <i.shihao.999@gmail.com>, marcelo.schmitt@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	till@linux.com
Subject: Re: Request for guidence
Message-ID: <aa_yTUNAmkOUnN7j@ashevche-desk.local>
References: <aapjuiq0JSVWfmWA@fedora>
 <ebb8bcb5-660c-409c-89b1-d473ba5140d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb8bcb5-660c-409c-89b1-d473ba5140d3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 11:55:25PM +0100, Till Kamppeter wrote:
> 
> unfortunately, the IIO group is not mentoring in this year's GSoC. If you
> want to do GSoC this year, I recommend you to apply for the Device Tree
> Bindings projects

> If you want to contribute to IIO Driver outside GSoC, please join their
> mailing list as indicated on the project idea page and introduce yourself
> there.

We are already in the relevant mailing list, so if ShiHao wants to work on IIO
drivers, welcome!

> On 3/6/26 06:18, ShiHao wrote:
> > 
> > I hope everyone is doing well and fine. Recently i have been
> > getting prepared for gsoc 2026 for The Linux Foundation project
> > idea iio AD39113 driver development however i just noticed that the
> > project idea has been withdrawn from the list. I wanted to ask that
> > whether the driver develpment is still planned or it is dropped from
> > project idea list.
> > 
> > If the driver is still needed , I would be interested in contribtuting
> > to its development outside gsoc as well since i have no idea whether i
> > would be allowed for its development or not thats is why  any help would
> > be appreciated thank you for your time .

-- 
With Best Regards,
Andy Shevchenko


