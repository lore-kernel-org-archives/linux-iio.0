Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F183EC2E1;
	Tue, 14 Apr 2026 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183995; cv=none; b=SSk/QQ0F9MvnliGiXHo3sqV7vGvuwbtFkEj62QJ8TeaswZIYCDMvsRBe2JL0Sfho/qG/w05JzzTfns2c/GTX3AuRP3ab+IS+FNgMQVLBoK1+Le6dBIUNRl+ezdmfFLO/xWAGr/++xZM37zHEcYRvNtdmesgBA+h0Crj8uyxxRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183995; c=relaxed/simple;
	bh=16ldZDjiiRMYREuquAdji1NyDG5jt/T07RxpspYcnqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki+FPSy8LNXaH9Razru3XFYnJzRSVgUidM8xoQiwrBpQViu+prrKSb7bn/k6tfeKEXcPVZ59jEdT3ElGuyRI6eCP/wl/Ux3jbXnE3hxZJ3KAfiz2jxY2k1Zj3E+dftqGWAD3i73WA0yZIdsrmw8Y4gZdS64X+CGVovIaz+9tDNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtHKUf4K; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtHKUf4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776183992; x=1807719992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=16ldZDjiiRMYREuquAdji1NyDG5jt/T07RxpspYcnqc=;
  b=dtHKUf4KPTv+i3M1lkQqFG2iOWneJ2zzjRlRxVx9WiS30hMSP/QOfnjR
   JyY711+w/hpHoQ22oN5qVyuWHS/rv11Ijyjp0j+wxCNSdZzyb0hb/ygWI
   mC7UnSZD7dSCSj376wymHxNCRFIn6kiBH9GgMLBjRxyZrJ4hxWrtDlaYz
   dG0VX9WmdSgpgrK1LdCuYekHXkUesKq0qA4T/Sr5yMjJ/NrBZ7gtSuVUz
   f9C0ibpd/f6rsDTLWbB6JQI64COQ94K+4j1X1Ns+uemyUXVlXJIaTEwZ4
   wsVTnOED/8wRFKl09i9vCnRdezIpzw2DAb5NEuSJGQEAw98alMaq4ar8E
   Q==;
X-CSE-ConnectionGUID: sKVvBPvVSKG7NMQ/7Tuhrg==
X-CSE-MsgGUID: gX2LncweRO2wu8z7kCZx3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88528457"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88528457"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 09:26:29 -0700
X-CSE-ConnectionGUID: IJT6IC4RQjGx5FZcFA0IVw==
X-CSE-MsgGUID: 7s8uMb8dQQa/1ZqzxRCPZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235101949"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 09:26:26 -0700
Date: Tue, 14 Apr 2026 19:26:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana.Lazar@microchip.com
Cc: dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org,
	Jonathan.Cameron@huawei.com, jic23@kernel.org,
	linux-kernel@vger.kernel.org, andy@kernel.org, error27@gmail.com
Subject: Re: [PATCH] iio: dac: Fix passing uninitialized vref1_uV for no
 Vref1 case
Message-ID: <ad5qsFP_7l3FATMA@ashevche-desk.local>
References: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
 <ad43ofFZwzEkYifY@ashevche-desk.local>
 <30022c5e780b2312e764c9e25399d67b2eed165c.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30022c5e780b2312e764c9e25399d67b2eed165c.camel@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 02:26:45PM +0000, Ariana.Lazar@microchip.com wrote:
> On Tue, 2026-04-14 at 15:48 +0300, Andy Shevchenko wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe

You should get rid of this message. It's incompatible with OSS development
process.

> > On Tue, Apr 14, 2026 at 03:33:38PM +0300, Ariana Lazar wrote:

...

> > > +     vref1_uV = 0;
> > >       if (chip_features->have_ext_vref1) {
> > 
> > I'm wondering what will happen if we do the below unconditionally?
> > 
> > >               ret = devm_regulator_get_enable_read_voltage(dev,
> > > "vref1");
> > 
> > If we have no regulator, we get a dummy one, right? What is the
> > voltage will
> > be? 0?
> > 
> > >               if (ret > 0) {
> > >                       vref1_uV = ret;
> > >                       data->use_vref1 = true;
> > >               } else {
> > > -                     vref1_uV = 0;
> > >                       dev_dbg(dev, "using internal band gap as
> > > voltage reference 1.\n");
> > >                       dev_dbg(dev, "Vref1 is unavailable.\n");
> > >               }
> 
> Thank you for the review.
> 
> This is a safety check to ensure the devicetree matches the available
> hardware. If Vref1 was selected in devicetree but unavailable in
> hardware, the scales MCP47FEB02_SCALE_GAIN_X1 and
> MCP47FEB02_SCALE_GAIN_X2 and also voltage readings would be incorrect
> for the channels that use Vref1.

I didn't get how. What I recommend is to do regulator request unconditionally.

> I did something similiar to what you have suggested in the first patch
> I have submitted for this driver and checking first was recommended.
> 
> https://lore.kernel.org/all/20250927185324.2f9e8061@jic23-huawei/

I briefly read that. The check was there, Jonathan just asked to modify
the check itself IIUC, i.o.w. the semantics of the check was commented
and not the check presence in the first place.

Did I get it wrong? Jonathan, can we get rid of the check and ask for
regulator unconditionally? (Maybe it would be good to print an error
code in the debug message to be sure why it failed to get the regulator
or its voltage.)

-- 
With Best Regards,
Andy Shevchenko


