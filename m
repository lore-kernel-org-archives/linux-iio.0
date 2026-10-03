Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ADF2F1FC7;
	Sat,  3 Oct 2026 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791039741; cv=none; b=a6YlelJNKeVaw0DlpEx+dM8do3Te4QNh/U5dK9MU+1j7aNCEYIps4md8Q6yrHCyemdKRPXKov8NBiWPj+biQeAKedYuBAa4KGrgWJpmluqpmyFX/AmzatEQa+JKDsdgxVDcoUg61yzcnJjNwKt3pilgV7VYTQyqXVMMEhcQw7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791039741; c=relaxed/simple;
	bh=cQ+YELbePZylW2mZliCc7IaDpMKCTRPESA7eaijtq+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfJnNjh5bZxHuSHmFP9buTlBUXqYqbWTvm9LRLNUrJWjDJuxDgbUaUl9zdtltgGYgcVa+pgoxSDR1ZYZQQNR9SeF2zhTk/PWLh7Y2aZJhQZFMP3PUv5XVC8awqL/qC64kV1x9nlSOzTW8qDWCvAdftVIrZzhzme/D1jojm9CQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUV0QjAC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUV0QjAC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791039739; x=1822575739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cQ+YELbePZylW2mZliCc7IaDpMKCTRPESA7eaijtq+w=;
  b=GUV0QjAClkgEfoUKUL8FL1OZOf7/VpMvEqhfUSyOxKeRN5qo+VKNgG7X
   rGBorm10tuK7c7CeMAK1P0S9WSe4qOgd0Xv9GI0ntrNbNeIBTXHBcwKOZ
   tTpKhL7zPi7jRAVUccBDYCnyw9CiSMMGAawDX3yeo/wHFMP8W5o4xmKzA
   c+PrjhTT6HExAaOhEUI4UuUrsz6Eypii6g2EyK9RMHOoOUM4nj66ew9Nd
   uYqq1jb4Z5TvTa7PKGZl3UuGwK/TCZZ24tafjO4iUVspXTbDPrbjXbF/D
   3pWCwYG6g+OKvkpyw6CH0g2mNJs9R28ndpMqV4nsdJh8JEmbb0n0cyzl7
   g==;
X-CSE-ConnectionGUID: hq/0WWawTzWYojWMBH+3yg==
X-CSE-MsgGUID: WL9Fo6F3QKWbMgC5d15F6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="91883461"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="91883461"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 08:02:18 -0700
X-CSE-ConnectionGUID: 6IqjmuD1SNyntD6eBjnptQ==
X-CSE-MsgGUID: OQgShzM1QFyyGM+kojhAgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="305961762"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 08:02:15 -0700
Date: Sat, 3 Oct 2026 18:02:12 +0300
From: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To: Kanak Shilledar <Kanak.Shilledar@axis.com>
Cc: "andy@kernel.org" <andy@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, Kernel <Kernel@axis.com>,
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"jean-baptiste.maneyrol@tdk.com" <jean-baptiste.maneyrol@tdk.com>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
	Henrik Grimler <Henrik.Grimler@axis.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 5/6] iio: imu: inv_icm42607: Implement MREGx register
 access
Message-ID: <asEY9DHDisqVcQ5D@ashevche-desk.local>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
 <20261002-b4-inv_icm42370p-v5-5-c65281b745c9@axis.com>
 <ar-tpjenoxMloYq1@ashevche-desk.local>
 <afde7beb4019d8090d3df30bb4e0a1b7ca00ad4a.camel@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afde7beb4019d8090d3df30bb4e0a1b7ca00ad4a.camel@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 02:25:48PM +0000, Kanak Shilledar wrote:

> On Fri, 2026-10-02 at 16:12 +0300, Andy Shevchenko wrote:
> > On Fri, Oct 02, 2026 at 01:54:29PM +0200, Kanak Shilledar wrote:

...

> > > +static int inv_icm42607_mreg_read(struct regmap *map, unsigned int
> > > reg,
> > > +				  u8 *data, size_t count)
> > > +{
> > > +	unsigned int val;
> > > +	bool idle_set;
> > > +	u8 blk_sel;
> > > +	int ret;
> > > +
> > > +	/* MREG access is one byte per transaction, no burst
> > > support. */
> > > +	if (count != 1)
> > > +		return -EINVAL;
> > > +
> > > +	ret = inv_icm42607_blk_sel(reg, &blk_sel);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = inv_icm42607_mclk_get(map, &idle_set);
> > > +	if (ret)
> > > +		return ret;
> > 
> > > +	ret = regmap_write(map, INV_ICM42607_REG_BLK_SEL_R,
> > > blk_sel);
> > > +	if (ret)
> > > +		goto out;
> > 
> > So, can we use regmap ranges instead?
> 
> We can't use regmap ranges because the register accesses for different
> banks guarded by a specific routine of writing the bank selector, the
> address pointer and then finally accessing the value along with
> checking for timings and clocks. There is also a limitation that,
> accessing the registers in banks other than USER BANK 0 can only be
> done serially. It doesn't support bulk reads. This is documented in
> section 13 of the datasheet [1].

Sorry if I missed it, but this is an important part of the driver design,
if not yet, please add a respective note to the commit message on it.

> > > +	ret = regmap_write(map, INV_ICM42607_REG_MADDR_R,
> > > +			   FIELD_GET(INV_ICM42607_REG_ADDR_MASK,
> > > reg));
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
> > > +
> > > +	ret = regmap_read(map, INV_ICM42607_REG_M_R, &val);
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
> > > +
> > > +	*data = val;
> > > +out:
> > > +	/* Restore direct access. */
> > > +	ret = regmap_write(map, INV_ICM42607_REG_BLK_SEL_R, 0);
> > > +	inv_icm42607_mclk_put(map, idle_set);
> > > +
> > > +	return ret;
> > >  }

...

> > > +static const struct regmap_config inv_icm42607_regmap_config = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > 
> > No cache? Why?
> As the virtual regmap config has some caching for USER BANK 0 registers
> only. The indirect banks doesn't support caching [1].

This is strange. You mean they are volatile by definition (HW)?
Otherwise if it's just a software issue, it can still be done,
for regcache there is no difference if the offset is real or paged.

> > > +};

> [1] Datasheet: https://www.lcsc.com/product-detail/C5129967.html

-- 
With Best Regards,
Andy Shevchenko


