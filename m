Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793435796;
	b=kf2nxK/dvpY9AEh1lIT+puQ9RzJHnuTg7eQIC+Tptsv2pslR82uWeskNz9mIz4/tvAV/
	 JFx+ZAff67FuAym9e84bJ8le/+TiBhVQQi4li1WTFQGDlfNYFc/2NxznWyNV9G9MoIb3D
	 7sLXdGgi0ZESwY5IfjXnm4hUCwtoYzmnfykwP7o+fmZT+xTFIrl9LL1uD5BS6ptWWyzir
	 ddsK4kqJyutNJBtx77ATJRK4ebPKQVu5t6ev2xH6plRvqnYiKnqibN22tTR0aIr+kbOGG
	 UmYvYC78wVVGm1+cBO868347a2MgnoaIcrqLueeiifeMdNkGwx/G+JDF3pxfq2s+f0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793435796;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ZDn6PjUrK/EzlgfA37JZOLf1C7W2oa4qATBOjD5IS7Y=;
	b=JlAzj6EkN+kGPD6FV+EosRyiqDBqN5W5YnOXK4Gpn/qh6n7E4mOFHGlUItcEFjc76idL
	 PM2jDwfl0/1ZCd6oYQUEuvyB8GXqTf1niZG2hMHD8n39W5xPJbm0sMnBsYz8JnMYtGmpt
	 U+0hgxOphhhuUAPhHJ41zNhj9eTbIk8QPoqdxSZL4q9/S2+T88THRYVgFe513n6IRZGO/
	 /riqXK2oIGLTil0ZjnKEohvJa9KdroQ1ZuZXDi5N2UAHwRcw5lrDClPW3QieQZRDDvq+l
	 CVG1E0wG82CAa+NtvZCQ8TmFrNu9QP5DJ2OlpyfkMonXWEeovsHejq81+VXwfCzSBqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YmJpl17c;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DB9606A31D;
	Sat, 31 Oct 2026 08:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6DB9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YmJpl17c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793435794; x=1824971794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HNFiIEi640fafEaGc3EFx5z+gYIxLguCaOvEPMDuqz8=;
  b=YmJpl17cPuKjDH1ImuQ/zjpErL92s+03AIhoAkConSRXTS8ng1g2qKIk
   t+5N4gNe/y82sPR9YeFpjcR2KNa9s7tI+DR0HSOkYlx1FogP7XSJ0I9JW
   54zzOJybmC3UHyLK/F5F0nDkXEl+yMffmCjf+ljFUBpG33HUgbQaROqOz
   r4KuT6nLTlBSqto2iM0ClwvDpRwxYGQN3JZ9PnTHmzSoIQCjhyp9C7qkA
   bzj6KUN6a1kKWJmol9XmOk58hkiliK0Fsm81BGETmTcwh2VVL+nxBh5bn
   MMhnfeG89WlxK6vzk6UGaAuxc6pDzvE3R/eqZov8S9WdCKzQJmeo4akDl
   Q==;
X-CSE-ConnectionGUID: g5usi5Y/T+SAj7s1eT/usw==
X-CSE-MsgGUID: KQ63dNC2Szurz00wRP0QMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2094786"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2094786"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 01:36:33 -0700
X-CSE-ConnectionGUID: R98IForARe2BSfo+qCYvUQ==
X-CSE-MsgGUID: AKZzIbkzTA228RgkANMMSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5502417"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 01:36:30 -0700
Date: Sat, 31 Oct 2026 10:36:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: sergiu.cuciurean@analog.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: add LTC2387 and ADAQ2387x support
Message-ID: <auWoi0Vad8F-aTmJ@ashevche-desk.local>
References: <auSsl5_xQNXCNphJ@ashevche-desk.local>
 <20261030150705.411102-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030150705.411102-1-Nicolae-daniel.Deaconescu@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 30, 2026 at 05:07:05PM +0200, Nicolae-Daniel Deaconescu wrote:
> On Fri, 30 Oct 2026 16:41:27 +0200, Andy Shevchenko wrote:
> > But these difference doesn't explain why you need a brand new driver.
> > Is hard to configure this at run-time by choosing the respective driver
> > data based on the compatible string?
> 
> Looking at ad7625.c again, most of it can come from chip data,
> like the driver already does for max_sample_freq_hz. The lack of
> en pins could probably also be parametrized.
> 
> However, doing it this way would risk clashing with the sampling
> path of the existing driver. Keeping it separate would make testing
> easier, as well as isolating drivers for unrelated families, which
> might be out of scope for this.

> Ultimately I think keeping them separate would be simpler, but
> I'll integrate it if you believe it's worth it. We might also 
> need to consult with the authors of the original driver, as I
> haven't worked with the ad7625 before. 

If there is no big differences on RTL or programming flow, no need to create
a brand new driver. Even if there are some differences which are minor, we
may quirk that in the code. See infamous drivers/gpio/gpio-pca953x.c for how
many similar, but not fully chips are supported. With your elaboration above
I believe we may join these drivers to the existing one.

-- 
With Best Regards,
Andy Shevchenko


