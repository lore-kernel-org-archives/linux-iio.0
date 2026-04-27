Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FE031E850;
	Mon, 27 Apr 2026 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320951; cv=none; b=g23nW51TP/IJIN8PoKVs4f3m6hJETRZYv0XEwIAJ7r+1oB9m8owG29gJFq/fs+6vAxMsrlT/B3etFeVCnqCy7geBwgUQVxXArLxuubrl+w3cxlWkh8Ie7aUaYy/lnyA++LG7J+7VWpze60DwvNGbXd6pcJX54JHVW7B/BuK/Csw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320951; c=relaxed/simple;
	bh=yZHOTBiQtUuTRtWyWIyzcYm8UrZNMLERY6mqk6GAp5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXw+OMQ5iEjke4oR09r7kOuIDAkEq1fVzvrugYhe2U/1uYXOzYKmki7/G2uNYDWC+hqhdFf8fdc1AmhHujEvzXCqfLX6RiQUCfhGMBTQCEJuxwABhXgDuvn8unfnFtaPS68a1DBNOnIa4cL2CDRY05r++hSKJXgoZfbtLAkLhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jItj4zWv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jItj4zWv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777320949; x=1808856949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yZHOTBiQtUuTRtWyWIyzcYm8UrZNMLERY6mqk6GAp5Q=;
  b=jItj4zWvKm3i4ZXuGPbgfIjgx3bI65InhdDtYTMcPB3SCXI3L5nOajLr
   XujLoj6XNzGTeMW35lcWgUumlBCmsOLQtNh4yBSvB8RClhoAZy3uVuJS9
   4/geJZ1nIPk9tvEVZmRGo8/FbHSneyWBSKSZiM1A3zL3JTLrXWNX6NGS2
   3qar7mWgzfAF+mC+3hOHRZDg+DWhsPMdfAT2HinvIspWvrjiG7UD7Medh
   vR5oQWQ4LX8YVYRXPPKqhUF7I7k7LxHUBpQs7SOp3hmGtrDbO4V6U+Tz3
   GNYj5g2aKbj+SENtK7Bj1SjxSTHzhNqmEkiMafF7VvfvbAALycEYYihHZ
   Q==;
X-CSE-ConnectionGUID: vU3GRTHZTZ2HZ934f6vBpA==
X-CSE-MsgGUID: gC4WNtDfTH2Yr/vSQpehlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78138719"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78138719"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:15:49 -0700
X-CSE-ConnectionGUID: vxzXE+ODQj+UlatNIzUdjQ==
X-CSE-MsgGUID: r3lMQ+6ySwiS7+3Y83diDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="238074948"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:15:47 -0700
Date: Mon, 27 Apr 2026 23:15:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iio: magnetometer: ak8975: modernize and cleanup
 driver
Message-ID: <ae_D8Fo7o8AiyPFi@ashevche-desk.local>
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
 <aejKKKD4JdxIzlk0@ashevche-desk.local>
 <CALoEA-w=N7ch67R+DgdqCrSy+5GtbuGkiAbJtnf-9c=Q2Mb6CQ@mail.gmail.com>
 <aetDc7Cvb-_qkf3s@ashevche-desk.local>
 <CALoEA-zCU_Em4U0F+Kf64g9yvQupLM5fXtQo_OxnPftcDwSwgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-zCU_Em4U0F+Kf64g9yvQupLM5fXtQo_OxnPftcDwSwgw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 12:23:09PM +0200, Joshua Crofts wrote:
> On Fri, 24 Apr 2026 at 12:18, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > Sorry for the delay (if you want to help, start reviewing others' patches in
> > IIO mailing list, you also learn from that). Now when I got my email pipeline
> > clean, I am about to start doing what's been promised.
> 
> I wasn't sure that I can just start reviewing, so good to know. No worries about
> the delay.

FWIW, just send what I promised to send, this driver is a rabbit hole...
See 20260427201412.3067235-1-andriy.shevchenko@linux.intel.com.

-- 
With Best Regards,
Andy Shevchenko


