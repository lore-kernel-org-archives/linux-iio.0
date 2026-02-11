Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECF58460;
	Wed, 11 Feb 2026 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770818357; cv=none; b=SxG92Xd9glyI9vsHDnL+ckuw9Q0YlfIbFZSQ/n940dNbPmUPPEiel8R+Ci5xeQ57Ws9cQBZILc0gnYiEg4aMnJ9GmBUyI5XaXJNwRq6GMfjUfDVsTuPpT2Ie3kucRtq3gOk+vp2toZmP1OHZfVXaYk1tAk7PdXa6APLeOW6I+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770818357; c=relaxed/simple;
	bh=q7puB9U/jRd2gvc6qPVaVmnw/tbUaNeFgx2ECtRXlKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYEksljAaWB0qgBebgxKWpTxZGI0U/qf8ZuotAzjxqe8UUgCav1areUug+yGonqZJLwwHXVYIOG1wyP5PeQe9Cja+OfU3EKN0JeqjEikJjmP/tVAss04rzEvbuYOvRZ0ckdGRTacDayCqMN0sGLo5KP7taWVZ+7SBEL1Uv66BbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXaIDyYJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXaIDyYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770818355; x=1802354355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q7puB9U/jRd2gvc6qPVaVmnw/tbUaNeFgx2ECtRXlKI=;
  b=ZXaIDyYJDnnui9/fDU7gO0k8KZy8qMMvaIJzsV/0XvLoLe5zACOzkmb3
   di774pFc/6RV4l4lBPG2bbn+APy4f7vRLRnbqXDgQucX5Rccsom/3uDLO
   C4NAkq11HgP8R342H5F507vnYacOF9/8+7EaozOzIYApiDFlpDlWYumXn
   TfXwH6sUVqc/cfAERKMLIvvKV8PG3xWeMuV7cq1SDrdnTooSF/2EoNHM3
   SOX35bmxLvP8omCTpHR9UvwHJSYi6Qyqc+Z37YmqZXd3MgNXLkle4Lwq1
   v+rhGgxjcbwQG/5EZF84WvC9tPquIK136y1in3xDXNHEAdtFSN2Z/Cy0x
   A==;
X-CSE-ConnectionGUID: u8lJmtH0SQ6AlweQ7OPj0Q==
X-CSE-MsgGUID: YqkzuzoIRVKG5JItPj/qLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83333193"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="83333193"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 05:59:14 -0800
X-CSE-ConnectionGUID: ri3JGDD7RViYQGobnltM+w==
X-CSE-MsgGUID: 1/HIFqCYQDS4zRHzF1fTVA==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 05:59:11 -0800
Date: Wed, 11 Feb 2026 15:59:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
Message-ID: <aYyLLbD1oy48sMGW@smile.fi.intel.com>
References: <20260210-cm36686-v1-0-aef68dd46ad4@gmail.com>
 <20260210-cm36686-v1-1-aef68dd46ad4@gmail.com>
 <20260211-sceptical-frog-of-revolution-fc3cf4@quoll>
 <b95d7a49-6191-4d85-b725-4a941505b40d@gmail.com>
 <6f97c68d-0236-4d04-8199-768ecee7c4dd@kernel.org>
 <242d5502-bf58-4e25-8258-8a6c75ff3623@gmail.com>
 <aYyGIPNeHWpluaoF@smile.fi.intel.com>
 <59d12283-28c0-446e-b591-a7c3d022f50e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59d12283-28c0-446e-b591-a7c3d022f50e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 11, 2026 at 03:44:37PM +0200, Erikas Bitovtas wrote:
> On 2/11/26 3:37 PM, Andy Shevchenko wrote:
> > On Wed, Feb 11, 2026 at 03:32:41PM +0200, Erikas Bitovtas wrote:

...

> >>>>> Please implement previous feedback.
> >>>>
> >>>> Since I am making changes to the existing driver instead of creating a new one,
> >>>> I introduced a new patch series. As I mentioned in the cover letter, cm36686 is
> >>>> fully compatible with vcnl4040, so instead of creating a new binding, I create a
> >>>> fallback compatible for the device. I probably should have named this patch
> >>>> series something else.
> >>>
> >>> That's fine, but that's v3 of previous patches. Your work was to add
> >>> CM36686 support. How you do it, evolves, but patchset/work is one
> >>> continuous work. When you rework approach next time, you also start from
> >>> v1? And then you go back to previous solution of new driver it will jump
> >>> from v1 to v3?
> >>>
> >>
> >> There has been a misunderstanding. I assumed that since I will no longer
> >> be developing that driver, this warrants a new patch series. I apologize
> >> for this.
> >> Here is the changelog since v2:
> >> - Remove the previous unnecessary proposed driver and bindings.
> >> - Add a fallback compatible for cm36686 of vcnl4040.
> >> - Add a new compatible for cm36672p.
> >> - Add channel info for cm36672p.
> >> - Remove redundant information in the dt-bindings commit message.
> >> Here is the link to v2:
> >> https://lore.kernel.org/linux-iio/20260209182432.00006c3c@huawei.com/
> >>
> >> I have received some feedback regarding the changes I made to the
> >> existing vcnl4000 driver. Shall I submit the implementation of it as a
> >> v3 to that series of patches?
> > 
> > I guess v4 would be better as this is assumed misversioned v3, if I got
> > the situation correctly.
> 
> Yes, I started a new patch series when I should have continued previous
> one. I will submit an implementation of your feedback as a v4 to the
> patch series I started initially. Thank you!

Do not forget to include the _full_ changelog per version

  ...from v<N>:
  ...
  ...from v2:
  ...
  ...from v1:
  ...

-- 
With Best Regards,
Andy Shevchenko


