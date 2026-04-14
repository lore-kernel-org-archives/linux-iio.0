Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0653C2770;
	Tue, 14 Apr 2026 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159236; cv=none; b=b6470A7+W+4bGtJpUNxhRiQPskhB1pfjUTlDoT39CE59gvuRsYE1QPS0YxwrEAfyAKWW7pd+oAsmwhzSj2BqHwpeIuwh2F40IgeIHDfVP+S0IL5Xf+QPK/VCqDfu5qh9wBiX0jgU7rRL8BdwBtBD4uF3QQJ2kzRDMa9H/441Iws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159236; c=relaxed/simple;
	bh=cNk6gwFQ+fqFB2KgDR+hkbweRQe4ri+OsMpQNFHSr5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPr8eYuqyptStcndztr5ZEfmhPCaUzM8mGF+8mnBuVvkbRn+sLVbcV+iCRtb4Dk96OzLD9/34O7596LxtjWhtCfCtKzoF9H2RxmUAWEXxWOoO1WPjD8eWXFfoDp87dxzeqFfm1FSQkqXmZQgta0NyLn1MamaYAbrxkTAiVb3zwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ixw7B2gJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ixw7B2gJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776159236; x=1807695236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cNk6gwFQ+fqFB2KgDR+hkbweRQe4ri+OsMpQNFHSr5Y=;
  b=Ixw7B2gJWFHZX9q76293KnkmW+WRpCaZQWTSp+JJDstLTtY57MMGm2D+
   ooE4BicKJquWZMGba2IqstcGb23rX7VEGRT7bf2LeYZQbQJVcya7a12d0
   JmQbViQ3s/71gfak93ia/WCzi+lYin/eCQr7zrdE7fCHB55Qmr5fkvmOC
   UGWq/N7p8+Cz8JOmIv6Rd+sMbGp/RsvkLhKmIfPZmlBen415IiZZtW1Ii
   OHT9s37x3TaejbzsLNJbw4rt3yTv3d2EwjDPJHpJgYSRlkcusXIL+jJA3
   ofW9tfqJkEqopSaAUlC4nuwQukDcte8URf6BnV9atMM+TjMMMh3XSjUPb
   Q==;
X-CSE-ConnectionGUID: sE+FXR2gTn+CCcy/r0Ny1Q==
X-CSE-MsgGUID: S5adqFZFSyOUkm150qlfzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="64646136"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="64646136"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:33:55 -0700
X-CSE-ConnectionGUID: ICrbowPORQqPyxUb8lsvtA==
X-CSE-MsgGUID: 8IimmQLOSzab/N25HvvDuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="226870931"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:33:52 -0700
Date: Tue, 14 Apr 2026 12:33:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7191: Don't check for specific errors
 when parsing properties
Message-ID: <ad4J_iWzGpwXsxFz@ashevche-desk.local>
References: <20260219143936.2276366-1-andriy.shevchenko@linux.intel.com>
 <c59c19d923d369eac2a0a46405e13e41836591c2.camel@gmail.com>
 <CAHp75VcpuxP=3cGuVrJoSuirQ3vPNR9LLWkf5CyaGcghJ2hzag@mail.gmail.com>
 <abkv_76b1cue1bGK@ashevche-desk.local>
 <20260412153040.0e6f2d7f@jic23-huawei>
 <ad4Dd2hlVdw16xgg@nsa>
 <ad4JXGgVLkwjLHwb@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad4JXGgVLkwjLHwb@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 12:31:14PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 14, 2026 at 10:10:38AM +0100, Nuno Sá wrote:
> > On Sun, Apr 12, 2026 at 03:30:40PM +0100, Jonathan Cameron wrote:
> > > On Tue, 17 Mar 2026 12:42:07 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > > I left this one for a while to see if the discussion would continue but seems not.
> > > I'm not sure it is always the case, but in this particular example I think the
> > > resulting code is a little nicer to read so applied.
> > > 
> > > So for me, case by case basis for this sort of change.
> > 
> > Yeah, I missed this one! Anyways seems the way will be to explicitly
> > use device_property_present() to check property presence. Still don't
> > love the dual call thing so I might just stop checking for -EINVAL (was
> > not doing it religiously anyways).
> > 
> > Maybe we could have a set of optional variants of the API like
> > device_property_read_*_optional() kind of thing where we just return 0
> > if the property is not present. But might also be too noisy...
> 
> I think that's what usually Sakari likes (tons of wrappers for each case :-).
> I prefer be on the compromise side.

Ah, and note, now we have kernel-doc updated to point out that _present is
recommended way of unambiguously checking for the property presence.

70fa0c308aa2 ("device property: Document how to check for the property presence")


-- 
With Best Regards,
Andy Shevchenko


