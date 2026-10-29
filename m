Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281833;
	b=o8h8btSPrByRiyHj7Z8eXPmwjL8Ij531BA2cZexD8eV7EPHuUFpwvJF7mLfprp7EgZT1
	 Fulrh/HQ0McBsqTVM5tdB9lhDntU3DwxU81tPa0shZ0kEhIrQTydn24aPbbiXCzHyox+H
	 8QUklBgsD/+HYyt7klOdAYho4h22e4BKPOokWkJQK05UaxatTBPKZhx+P6T7J3AkaBTuQ
	 Yn/gj8k5V5yH2p0lThJi4rGcjYQ01gZtxB81+DAA0z5t2N1SsYzX5p3LzrpQrRRRIdq2d
	 vJTF/wjm1THivRCaOvb/2o6C15qGO9gUSUikrZyvb8WUPdlFSplMSqtEWx0lxnkpF0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281833;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=sSHsKzLsHQUVggxTPHadLhnPfpmPW07sWdgMC5S5cgc=;
	b=lTsDZxt41pDocJHJDDb7MhdsOFTZ33kpxMUUpSDyTn3Y0aTL8+zcopCMIUXk7HPFBSLQ
	 Cd+iSoCXFgKRXSHoGW60uaOB8GZh9wJW13iTL9QeK1gl+zjtnp1jnaCXsheQZoP0cHuIs
	 e75QODg1CxIB7uTtLWqeyJRByOuyQTKCyAvhMENO5fiqtI5j7LWf789F1nQQcS9UvPHD6
	 Tn6wgvW7h9c+MsZAnU/kKYwVrmDOyrC7KVm6EjtdiIeMPOxLNObwuAkEYlyMOZPNA7RpK
	 iYPmc9XN4K8OkqvZlX/Sj244zB912pO66IS4WkBvBQ54NJwUT+pb5WirgbAetS1phww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n7HD251S;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F5606A333;
	Thu, 29 Oct 2026 13:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 573F5606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n7HD251S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793281833; x=1824817833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7UGBE/NWvXSnEbju+Ufc22HBsAe2j6gnngo057bYACE=;
  b=n7HD251STQtuXB8eHE4uJnahfmqwlgUm17EYeLat1ZBGhlwAyz5RcFxl
   Y3iV0dcfcyFNZFrYMlhyCFpooRYgutFZXYO51vcdASwvp3kjDL7ywXi/S
   n06Odouq5J2Y2jdEv7d7ISBSJGLhtPeB4g8AzjIlho7Nq2beCL489c0KX
   9U+pRjpPsvOIT5Xe/f99EKPqbXUNPd+aak11t5uqKoMT81drznvpbw8Wk
   kqcVc+S9HGB+9HUNjl2KgO4x5Q6YgOdUb8eDIJHeOUyGyh59SUCv5dqMt
   p1zyJjNzJJr8K0IsBTgEXeXcJYuJWRdsd/hbhgotp1BKhvSgmKMCJa80C
   A==;
X-CSE-ConnectionGUID: UrjsxWfrT7GtVWyvsetOOA==
X-CSE-MsgGUID: QLBadroiQXG89uFeMJ6lYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2014675"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2014675"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:50:32 -0700
X-CSE-ConnectionGUID: ZyQTJhDNQs+TsrQE5GFC5A==
X-CSE-MsgGUID: qYkapjJHS6e68ZZvxZfzeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="6974876"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:50:29 -0700
Date: Thu, 29 Oct 2026 15:50:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>,
	Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 3/3] iio: proximity: Add Benewake TF-Luna LiDAR driver
Message-ID: <auNPIsQ4pDMb8qPc@ashevche-desk.local>
References: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com>
 <20261020-tf-luna-v1-3-53a88f93db24@gmail.com>
 <20261020092316.00003339@gmail.com>
 <atcbe2O6REJqok2n@ashevche-desk.local>
 <CAFqz8L+fCc19aaUhs6k0a47y=oxhiM9PSgjMgjY0JYH8HN5wKA@mail.gmail.com>
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
In-Reply-To: <CAFqz8L+fCc19aaUhs6k0a47y=oxhiM9PSgjMgjY0JYH8HN5wKA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 29, 2026 at 07:49:15AM +0530, Vidhu Sarwal wrote:
> On Tue, Oct 20, 2026 at 10:42:51AM +0300, Andy Shevchenko wrote:

...

> > > > +static const struct regmap_config tf_luna_regmap_config = {
> > > > +       .reg_bits = 8,
> > > > +       .val_bits = 8,
> > > > +       .max_register = TF_LUNA_REG_SIGNATURE + 3,
> >
> > No cache?
> 
> The only configuration register the driver writes to is MODE, once
> during probe. The other write is only a one shot trigger, and the
> registers read afterwards contain measurement data that keeps
> changing. also need to read MODE back from hardware since the sensor
> can silently ignore writes that come too quickly. I was planning to
> add caching later along with runtime PM to restore MODE , but I can
> add it in v2 if you think its better added now.

Just add a comment summarizing what you just said.

-- 
With Best Regards,
Andy Shevchenko


