Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5034921BC;
	Tue, 12 May 2026 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574226; cv=none; b=uCPkDbwa/H+jG5tx8SEnpW4ExM8yElIP/fiL1jX9aKx8FMHF/0mcfr/Oe3nblSMaFcgXOZtJG2sMz4SLj3yIlmdoUaoS6RkuqHq/8avfFVP95LqmqDAGfZxU/Bg7dqJi641MdX/1anpoAdkBG7Gb3q647PGK0nPDSw14ixYqz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574226; c=relaxed/simple;
	bh=hnqf3NW6SjnvcZcCs4gI8M96mYXiZxmRIBSprSPGbJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sINrTup3kK05T7VSFOEyobubEeAoA9KDJpkDdyh8ey/2xBY1xtxmhnwbDC/eF3dSedu1n8raNBxtIMuL9TnZqZs+SnX/R9u2/1JZKfeULmmDXDAuNvRo0yVJpS0UBTqwGIkuBtjujwooMrJkODzVUqz84tduP/1tjz/gd0hC09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiHFKSBV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiHFKSBV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778574223; x=1810110223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hnqf3NW6SjnvcZcCs4gI8M96mYXiZxmRIBSprSPGbJM=;
  b=PiHFKSBVgYOYrsjhjNl8q3qeNd58R4Go7IwxZAJvnvw99dni0Ie58fFc
   FnAtkZxUlsW74heZgAbk1TO6oPoF9ZCE/9OlXld0HwfrmVi4UYYPsgec3
   0Qk36UN0Ih26ksBnLXZoW8YPS6CTAs22ZhOT1TJH/oU5oZxSyxWIiIesO
   F9KDtKDRT8otkmx5nsqv24hJr+77o0yomOYU6Yt+ZCuRdaCUf2LsszYi+
   MpU46YoPSZo73F0bo7eCqFru8ur3wyM5E2/wxDAU/FYggvTBMbPareIvb
   wXk6dEoxFLROwZRMstX6FPqs4KPoe+wMkxgFqO6c6/ShTr1P1awb/y+tl
   w==;
X-CSE-ConnectionGUID: MWCZfWNJS1em2yIEFq16IA==
X-CSE-MsgGUID: RtvHKzuXRnS6+3DauzSjcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="104931933"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="104931933"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:23:41 -0700
X-CSE-ConnectionGUID: +cqM3aUFRSeUh6vZk1fpxA==
X-CSE-MsgGUID: Kg9gyPXGSqyTQvMdvI28qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="261458598"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:23:39 -0700
Date: Tue, 12 May 2026 11:23:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed
 resources
Message-ID: <agLjiS9xv9HyzX8K@ashevche-desk.local>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
 <0a3e455c86cef14fe3481019031ebf04f98470f7.camel@gmail.com>
 <CALoEA-x9TtnWbGCtTo-jhrJ7Zic1S7J=xRYSL0VZgOvTb1GGCA@mail.gmail.com>
 <agLd7t10HBjbEzYq@nsa>
 <CALoEA-zJTJ1nA7-7nyeMnF7m87utM8SZvTBcMOY6kibZPA4-hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALoEA-zJTJ1nA7-7nyeMnF7m87utM8SZvTBcMOY6kibZPA4-hg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 10:12:35AM +0200, Joshua Crofts wrote:
> On Tue, 12 May 2026 at 10:06, Nuno Sá <noname.nuno@gmail.com> wrote:
> > > This is to prevent a resource leak. If we register the power_off
> > > function at the end,
> > > any potential probe() failures will leave the regulators on.
> >
> > Okay it does make sense! I now see the action is registered after
> > ak8975_power_on() which what makes sense. Still would like to avoid that
> > weird pm_runtime_set_active() call. It would be nice if we could
> > guarantee through PM that the device get's suspended on unbind. Oh well,
> > I guess this is ok.
> 
> FYI, there is a new version where I addressed some of your comments.

Btw, can we rearrange the patches that the most controversial one(s?) will go
at the end (as much as possible) of the new series? Then we can work on it with
a less burden and unneeded dragging of the 'good' patches. Jonathan, what do
you think?

-- 
With Best Regards,
Andy Shevchenko


