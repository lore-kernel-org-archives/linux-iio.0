Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609398;
	b=UTknLShHafM6PVK9aqjQvVDKho4gDs5aOj6RdDCobqsjR4rXuouNZqpEucMUgOm8NuwX
	 XMYAecSgxGieo1u+wsnCd0fS1ixRknXJGquAzh2MTI4GnIHrkeWJFXoVZYhrybM4X7W4v
	 KWesV5X+Ok65p0AbNmtW/GJz/mUiVlV+a0Hg9WAVQH55lquSUT5oZkdETTHzkbRm7JhKZ
	 UF9GFhznAC3fsGgAGFlFqlvskVS1AkJWbkZueXYtYqnFOOxZdqns+TLyGaUoiI234dWKL
	 nMLsIFF7RRsVW7W5FVWj4q78TyFm63biC5rIhtc3EclK7iBQfG2rZw/MSb6Qqz06ofA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609398;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=vrSJU4GgBQ150PF99g7M45HkRrI5pLJYV4NvvKGCVjQ=;
	b=Fc1ZeWLmP8U8cedLiv9YOq/7JJtn+wWnFqZmj1EBGOvQvwRow7N/dnCnmAMG3k2xre+1
	 3TCnQetsWjQePRs6niGWKG3qxrLs1BduIpM6OWip8aGVEqoGEBDExYJaLuSkB3ZIJLU4c
	 FL0VUCgYoG6brU7J5o035AL0+kVkAYb5+hxlgq86vaFT4NFtjBtcbJ9IMIglBD54PBdl+
	 fbJ2FpkCUK9JabXp8Vy+OhDpe2tTk0Q/K6qre2NrZMGdl9fDjJCYgxvwPYe7HseuKKR3W
	 51RORuNIkp1F9N/v0Cxgr9j+R8cO7japIduaWjxUHpsTin9H2aH0pOGnyutIi9cpsGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="e/KEu2Dl";
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C1606A320;
	Wed, 21 Oct 2026 19:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E6C1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e/KEu2Dl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792609398; x=1824145398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4h3cHqTXriG4rqXH/umCjPSbZXlkjNMeDELIzfETGqg=;
  b=e/KEu2Dl08ReNUoKAeP6Ki5hRucwV2EtgzCzTYlm2GKMtxl8sCI4m3SG
   7F9L3+TsPdLvn56zlIkVnhhRZgfxM6lwYxRYtBm//ea2dYdIb1UpHLCDo
   3UYP7h5iK+Kdj4QxxbpS0TEOTWxsrlMsMSeSAEq0CkFk/kQf06WwhhGSS
   i2/BL+3/g0QRWabpJLVgMvKMPg5MBdcCxP9QnZwXY68NIzQ6FRTsTrTqc
   4MNVzYNkzpQSGkpPTZCmszwo3Q9Yld01H/06fZCiztM97SnYjZZLbARCE
   KXjRjEQQeD3rcUM2PSFgUHiogdGbtf4xLy5YWJbMeaEShJ9cjkRnVEKPc
   Q==;
X-CSE-ConnectionGUID: JD8IOpq7Say2tkZ8PnysBg==
X-CSE-MsgGUID: uw+R8yX8Q+OrlhAI/j36uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1236242"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1236242"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 12:03:18 -0700
X-CSE-ConnectionGUID: trES0lCxSlKF23Su1cy7Ew==
X-CSE-MsgGUID: gEt0x1TAQ/iMhUVCFp6H8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3237846"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 12:03:09 -0700
Date: Wed, 21 Oct 2026 22:03:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Allocate unique ADC_TM
 aux device IDs
Message-ID: <atkMam-XiXcrUOFB@ashevche-desk.local>
References: <20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com>
 <atWzFlOgRICAGM-R@QCOM-aGQu4IUr3Y>
 <20261021195401.6a70fe6a@jic23-hlaptop>
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
In-Reply-To: <20261021195401.6a70fe6a@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 07:54:01PM +0100, Jonathan Cameron wrote:
> On Mon, 19 Oct 2026 14:05:10 +0800
> Shawn Guo <shengchao.guo@oss.qualcomm.com> wrote:
> > On Thu, Oct 08, 2026 at 11:11:54AM +0800, Shawn Guo wrote:

...

> > > Assisted-by: LLM
> 
> Applied to the fixes-togreg branch of iio.git and marked for stable.

JFYI, this tag now is killed from documentation. The idea that the use of AI is
described in the comments block or so.

-- 
With Best Regards,
Andy Shevchenko


