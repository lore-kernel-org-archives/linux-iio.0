Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE27543C7D2;
	Wed,  8 Jul 2026 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522326; cv=none; b=re0bq7vR1O3MEqoR5YBs2tSLoEdJIEdjIA91Z0fkQBNOJifljuvMrASLIMndBa8Y0bhGpMupOk14cM8X6fjhjTO5MpVewx/QhQXryH4wLczcNSsNi++mf4i+30I7BVTyYhAvGHTqaPzGIRzE1pi4Z+YKEobk2Tg3y1dBZpVvbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522326; c=relaxed/simple;
	bh=+RfC/xqi5foyvk7ovWqVRKrPk/rOuEWPd2u/U/fXfac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0zLm4pAktMvOT/tMwYFOGPfe8b9TMaGh7Ol1E697iCpwyOsvEp1ds0hXpK82ZOIkCFNp6n3RwuoREcnm2Q2FtZtQs+zPPbSS7tUC17u2e1Pb07R5Z1qH6smsxQ+q76A2xHghdc86kA8l3nL0oGjidaXY7YxVLFOBlAM5RYjzSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqqYD7qm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqqYD7qm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783522325; x=1815058325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+RfC/xqi5foyvk7ovWqVRKrPk/rOuEWPd2u/U/fXfac=;
  b=TqqYD7qmAbuerlI/NtDfBEhs5+65G/seNtE2uoMqTTtO8XKe4Big9A2A
   DZV9nY2MlRrnVs0VBpf3Oac8LBBKu90psFVwDGahXgRL4RG97AwatOJfq
   c3xVCNHIEn3NvVbcnc+NnmKnxv/QDo3Y0JbexAAEJfq220wWU4ejwi5GP
   1PilbpvEw1sF1PonW3S5KIuaFe8XBo8M5UyBdZXBsMmcEtUdr/l3BDBFy
   BuDTfCNlNSGWQil5GIa0tjJBEh+JpvEKEoU1WBo9rbAmw5qlXOW/dLuXO
   G739TcsxTgWmWbbOv+APj0z+xaHSyM1KeWb/BEv09kZ0MJUBBqnR972gO
   Q==;
X-CSE-ConnectionGUID: hrrOEuO4T4WO7fvieciQ+w==
X-CSE-MsgGUID: qajyCrQqRFGSYSO9Rhx7ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94791446"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94791446"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:52:00 -0700
X-CSE-ConnectionGUID: pe2I5EhiQv6m3EpzdylWeQ==
X-CSE-MsgGUID: 899EseynSvCfbO5YFHPVYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="292497405"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:51:57 -0700
Date: Wed, 8 Jul 2026 17:51:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	jic23@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v9 2/2] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <ak5kCs3BkB_Trr2f@ashevche-desk.local>
References: <20260707112714.2261727-3-shofiqtest@gmail.com>
 <20260707140545.0000029a@gmail.com>
 <ak0X8yrg5ujz8r5L@ashevche-desk.local>
 <CAOTCDVth36hE1JqAi3vJ3hKuqhs_yyjV0ZZx5mZotiJYzNDATg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOTCDVth36hE1JqAi3vJ3hKuqhs_yyjV0ZZx5mZotiJYzNDATg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 08, 2026 at 03:54:19PM +0300, Md Shofiqul Islam wrote:
> Hi Andy,
> 
> I want to address your concern directly and honestly.
> 
> I did use AI tools during this development, primarily to understand
> kernel conventions and check my code against subsystem patterns. The
> implementation decisions and the responsibility for what I submitted
> are mine. I should have disclosed this from the start, and I did not.
> I apologize for that.

Yes, we have a tag for that Assisted-by.

> Regarding types.h: Your feedback was not ignored. As a new contributor
> managing feedback from multiple reviewers across nine versions in
> overlapping threads, I lost track of your comment from v4. When
> Sashiko flagged HIGH severity issues, I panicked and sent new versions
> too quickly without properly reading all outstanding comments. That
> was a mistake in my process and entirely my responsibility.
> 
> I am committed to contributing properly to this community. All
> outstanding comments, including types.h, array_size.h, and err.h, are
> addressed in v10. I will not send another version until I've read and
> addressed every open comment from every reviewer.
> 
> Thank you for the direct feedback. I understand why you raised it.

Thank you for following the suggestions!

P.S. Please, do not top-post.

> On Tue, Jul 7, 2026 at 6:15 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Jul 07, 2026 at 02:05:45PM +0200, Joshua Crofts wrote:
> > > On Tue,  7 Jul 2026 14:27:14 +0300
> > > Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

...

> > > You're missing array_size.h, err.h, types.h
> >
> > My comment against types.h was ignored. I think that this contribution is
> > heavily assisted by AI (which has to be mentioned), otherwise I can not
> > explain such an ignorance and mistakes from a human.

-- 
With Best Regards,
Andy Shevchenko


