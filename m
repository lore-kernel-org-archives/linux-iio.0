Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74357413225;
	Wed, 29 Apr 2026 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777487180; cv=none; b=dSBt92iuQjV2wnXsTo9HVHI6ZrumDEqBh/7ZuBQoc8mYnxCCHp6mDWPUjWWYw/ie0sYNVWiZ3iF9ckwXBPuQt+rn8LMcHe+FtLbqWv1ElcOAuC05wjoM9TBQAX0sxZdqX9aI2v1O6qaMVUV9+bf2AyKrVbHb+ew7G2wbidgVA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777487180; c=relaxed/simple;
	bh=cDg+aE3euxu4FHlGKVcmaW+ZgpYfGYA6WaB53laRhHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sArgMDlepFSRHxfNSzv8X3wCIqTZCkp0vI2QBszij4hPUomBmxY1b5aSFfLIrFZcSif1Ol4wWP2sr9yZJKCqydpYjXwbkAxPeuS2bH/wItVNtel7TaL8r1rhxIz8eo/mZDSsRMF1BoBZU9hfgxS/nT3l3tSxNBzmmP+CEtEePT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2IQHshy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2IQHshy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777487179; x=1809023179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cDg+aE3euxu4FHlGKVcmaW+ZgpYfGYA6WaB53laRhHg=;
  b=X2IQHshyLUgHL84riJp/N19cNnEI5vfFdNQ30FVHNCvH379PVSj6P5FI
   jg3Q1ffVbj+9MxNK2smqo7/3U2mMsyx5KTPJo6Yc0J467/CD+GyDNIsD8
   TBpr+fp5uqCYgB1pqjM+ufWmnT+ngoz/K2RE3HEtnK3iCkp5UX7LFd4Bq
   ODa9imCqfUoQaP3LIkWY2C7xoUWtvijNWTN1w95KZhujC4XovISC8uLsE
   YU08Y2/0Y5JdhPlLzA2mwGjV0r6/wX7ck5AABtI9tmdbghGdFGmYa+3Qn
   Cg/WMzPM8NivGfpjAbVbF5bvekj3JO0dpitcYht2asOq7L7BFpdXd7jCQ
   Q==;
X-CSE-ConnectionGUID: 7JNyQ6ERQimtfpOVgBLUAw==
X-CSE-MsgGUID: FNP8r7pUSzCCqXWAjAjm1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89888329"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89888329"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:26:19 -0700
X-CSE-ConnectionGUID: FxekHzo8QSq/GlZQ5EHZsw==
X-CSE-MsgGUID: ANYV+FoSSZaP8AUoUTOV/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="236114279"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:26:17 -0700
Date: Wed, 29 Apr 2026 21:26:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, songqiang1304521@gmail.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
Message-ID: <afJNRnuQGnnQPA4w@ashevche-desk.local>
References: <20260428222600.91322-1-m32285159@gmail.com>
 <20260429114154.290e588d@jic23-huawei>
 <CAKqfh0HnQADMZhxn0OEp0jV2BVGKP+wRyAMOS4g9OOm+QSv_6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0HnQADMZhxn0OEp0jV2BVGKP+wRyAMOS4g9OOm+QSv_6Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 10:19:14AM -0500, Maxwell Doose wrote:
> On Wed, Apr 29, 2026 at 5:42 AM Jonathan Cameron <jic23@kernel.org> wrote:

...

> If I find other patterns that do this kind of:
> lock(&my_mutex);
> ret = my_function(params);
> unlock(&my_mutex);
> then it may be a good idea to consider writing a helper-wrapper in a
> header that takes in a function pointer and its params. It would take
> more thought, and we'd probably have to avoid variadic arguments, but
> it may be a good idea just so we can keep the same scope and keep the
> logic clean.

Won't fly. I am pretty sure most of the maintainers find that bad. The problem
is that the caller should be crystal clear to show what the critical section
is. Hiding that information behind macros drastically reduces understanding of
the code,

...

> I think that would be sound
> for a separate patch. I'd ordinarily include that in this patch, but I
> feel at that point we might be deviating from the original purpose of
> the patch.

I agree.

-- 
With Best Regards,
Andy Shevchenko


