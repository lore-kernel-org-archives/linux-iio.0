Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096974D2EF5;
	Wed, 13 May 2026 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695126; cv=none; b=gBNWV/G75ZEwYjGwXoFB/UmPkSIB7PH8lynxBr6/Wk8AN33mthKos3LEa9vW7cML2ysnopGIgcBel/cLm06rmlOcEAYoG8wMn5SXVYbglwNaJ/Fg4RdLY4lbdRGO24HKwJqP1On4s/HA0sSm86mD7rjtKxqdqiaC6SFjvMU5OXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695126; c=relaxed/simple;
	bh=CPIe52sbFkWAypWsZK3X9/E+hdpLTLhpw5Zx83NnTqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+2Tn7yAM2eAfaCcr6NSZ61VdoCsALqAr2MuWUV7ePHErHCe65HGK/YJ5K5BYEd2H0M+07THO3HMWhg0gOeMB7qiz3vcP0bGqy/TJMFg5u4xH2Mq/TOwps+e0rZcGVoOVltMBDMjpq1orceXzGk8aWBoE7dGy8kmzDJIco7fK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miX6W4Za; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miX6W4Za"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778695125; x=1810231125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CPIe52sbFkWAypWsZK3X9/E+hdpLTLhpw5Zx83NnTqo=;
  b=miX6W4ZaTmQSryR9BovW0JNcBHvx/HuyOccNTi2RHDdqZngfsUYQOiWa
   g+aa8rsLsjrrs44pkDZgyHLl+SrePs2O0IqpyiyuUvO32Xq+3mCrENtuF
   nqK85IsaEpd3wSIHpX5fw5pn+5MTuSAzAAoG73Aye+NquOcoJ3vHihtrx
   rqEPpp31GDitxC9Hlz08tmDLHCp35KyG1ZSPWv97su7IhFjwul6F1vEEG
   YJFfmNAbnBJscghIyPbGsIUKYM1Hjf2ltsyNmox/EKZYSNY+dIoAVbIqG
   13MtYLck5dHla1bfR7OL4uB6s9oCqEj/Pw5vG+D+vRcXAmKLd7Rjb63xs
   g==;
X-CSE-ConnectionGUID: Ozeb/ARMSka2ldtlXRWMkQ==
X-CSE-MsgGUID: KDGwUtebRX6OiqbdSq8bVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79488738"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79488738"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 10:58:44 -0700
X-CSE-ConnectionGUID: MYhN9ylVTNONQfoXdlkNhA==
X-CSE-MsgGUID: j9cEtPDGQ1au3TrXPzfMjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="235089180"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 10:58:42 -0700
Date: Wed, 13 May 2026 20:58:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 5/5] iio: light: tcs3472: move standalone return to
 default case
Message-ID: <agS70Dph8-zQT-e6@ashevche-desk.local>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
 <20260512223215.25596-6-aldocontelk@gmail.com>
 <agRfMWL9BughLT2x@ashevche-desk.local>
 <36ed59a7-8af7-4458-9e90-70ea251b389e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36ed59a7-8af7-4458-9e90-70ea251b389e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 06:12:25PM +0200, Aldo Conte wrote:
> On 5/13/26 13:23, Andy Shevchenko wrote:
> > On Wed, May 13, 2026 at 12:32:15AM +0200, Aldo Conte wrote:

...

> Thanks for the review. Before I send v3, I want to make sure I split
> the series the way you want.
> 
> My plan is to split v2 into 7 patches:
> 
>   1. sort headers (same as v2)
>   2. convert locking to guard(mutex) (drop Suggested-by, clean up
>      trigger_handler)
>   3. replace == NULL with ! (add Suggested-by: Joshua Crofts)
>   4. use devm for resource management (drop Suggested-by, remove the
>      dev_info change, add devm_mutex_init)
>   5. use 'dev' for dev_info() calls (new, taken out of patch 4)
>   6. implement wait time and sampling_frequency (drop Suggested-by,
>      fix macro style, simplify cycle_us and all the other revisions)
>   7. move standalone return to default case (same as v2)

(Also collect tags for the patches that are not [drastically] changed, like #7
 here.)

> Two things I am not sure about:
> 
>   - Should patch 3 ("replace == NULL with !") really be its own patch,
>     or do you prefer it inside patch 4, since that line is right next
>     to devm_iio_device_alloc?

Jonathan is okay to combine in some cases, but I'm not sure if this is small
enough. Ask him?

>   - Is patch 5 (dev_info refactor) in the right place after the devm
>     patch?

Basically sort patches by severity, with this in mind seems you suggested
the right order.


-- 
With Best Regards,
Andy Shevchenko


