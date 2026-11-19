Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079414;
	b=avt+t2TwyCkooqrapTryIMh5XYoKvCZhroHmKk0tZ7pz8LSk6tFkloCVB1yiLHT1yklK
	 USsv3OIdhrU+ZQlwNtszwFoUglUMr/X+SVO8rkV4LTF4P7E/judtEMm8m6+yJHIHPiO4R
	 2b9wS7Kka9uR6wThO3v51xfIu6L4f9ikNWlfvHYhMLzTvnGbVjpyPWCXn2r/vgv0v4ZzL
	 1mHlT7Z4/g0LIinYBsklzNrWYQ2bJ9oSVPjn3fS6vwYxXtjoDY/qIgr3c7sneW0LjP+9K
	 nk1RICSwLef+1D/j6iANAJL2T7BlVH+nDNvddTSZz8wD4vt51fGruolJD79rMWJnlBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079414;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jt07bDXK984SAz7KfX9YONKC5Mhv+pC+i9yCYqkT0es=;
	b=HJoCeldb0uXJS5ajf2WxkJuaq/dnPPA8b/xn0JkKokX+bY8I1/cJXUoO6RQMF4/aKR6h
	 63wN504CpwAbHZktYfjZkbKK20H7rzSHddAIamrJzhQ+nKemAxvCawPwLS7dEcIWz+zHj
	 kr9QjqDwAZxUh/PHLGoFisTfebZZU258H3kTWPB8BM5mMlA/lNncygpgAgO7sUQFOk4/L
	 fajFX/t93cbzglAxq6Fme1lK5/RY+RcmS5mVcBxfcijUnQBQWDrRRkN2m1OiiWAKdv3v9
	 8FPID8McX0o3zl77KcFCdp24a2y/Dil4I5V33ln7RE+pd3dajzmTCla7zqZCJqEWspA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=efVcVxjt;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0C606A325;
	Thu, 19 Nov 2026 09:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F0C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=efVcVxjt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795079414; x=1826615414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oIG6VEstgDdNZ2+Z/zAS3a/BXQ7PqvPYPbmSpe6/jJQ=;
  b=efVcVxjtPNTwJOa82BwHvhWDXQYOsP6+WCSckSRwWZWv19Cqltp2O+GK
   7kRGB9aYwRrFYJFZRvCoaDOoq6xImOm4+04GwIL3eFhpeooRfmEL6VB4L
   Z8UV39YSgSPDb2ljOS4nfFnaILOrCQMkgUo3gJVEQzziipxk27TMV+o3L
   x0QkRRmlBIv5dRdY2ciVejIaAhVQSaiJmLrDC0oz/W3QCMFe7xFniPrs7
   mnouDM9NzcbGDF49hOngjC3ZAR4V3RaRoppcP8IZqbiU0KP6Eq7AZpSoF
   /QrmNgdyS3eqnJWtMJ90M6PYjC2EVeiv5m6671UnSdGh6oNYapD6Agx5/
   w==;
X-CSE-ConnectionGUID: uuasc00mSa2kmVG6i1RoPA==
X-CSE-MsgGUID: whxmV8kSQxWfTjpDcz1WvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3949567"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3949567"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:06:48 -0800
X-CSE-ConnectionGUID: IEiyDjZhRfi+8Ovc50V14g==
X-CSE-MsgGUID: fZZmkkEUQiaLL/ojEdzG6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10372931"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:06:45 -0800
Date: Thu, 19 Nov 2026 11:06:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: NanamiKite <nanami@yosoro.hk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: cm32181: Add support for CM32183
Message-ID: <av68I02S8S5aa9zb@ashevche-desk.local>
References: <tencent_E90EB0AF3888FA057AA5F6008C16C610650A@qq.com>
 <20261119014405.2eee7298@jic23-hlaptop>
 <tencent_84B150942865006BA546B43E5026951EA005@qq.com>
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
In-Reply-To: <tencent_84B150942865006BA546B43E5026951EA005@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 10:33:00AM +0800, NanamiKite wrote:
> On Thu, 19 Nov 2026 01:44:05 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Take a look at linux-next or the iio.git tree on kernel.org. Or indeed sanity check the list.
> > https://lore.kernel.org/all/tencent_850445458D21608E9C8821E6728457F31C0A@qq.com/
> > Pretty unlucky to hit same thing that was added about 2 weeks ago. I guess that device is proving popular!
> 
> Thanks for the pointer, and sorry for the noise! I'll make sure to check
> iio.git / linux-next first next time.
> 
> Haha, it's actually quite a niche device -- I just picked one up
> secondhand to replace my old Surface Go 2 for development work, so I
> definitely didn't expect someone else to have already sent the exact
> same patch two weeks ago!

Linux on Microsoft Surface devices has a mature and active community.
Even I used to have Microsoft Surface Book 1 at some point... :-)

-- 
With Best Regards,
Andy Shevchenko


