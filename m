Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE5739DBFC;
	Wed, 29 Apr 2026 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446120; cv=none; b=VaLXEm3QSiSD3gknDwUHEqS/3BPRkdyQIzmoBT7opZrzfyvvMTqTPRcIYV+NNzjwHFu3BE738WYbQrhtJ4x0urfbb41y4YFq9IjcpQsZpYksUtCqoz7ygaBTz2cclAh1s7n6jIrfbXu0/Q3kCSd6Dsew8MLZHyTLMf9woUFnRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446120; c=relaxed/simple;
	bh=/ZwfX7O5SCBOQ98YvFl//tUB0hURsI3izutezHbDmao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3K4nvi+AD2Whb9bR+1eZl4MBgwNTfiXLvT11ZMiptyLgji/EsrSegzYLkp1VPh2o7Y8nxn4ASSH63mp1FKo/Njwz71TcOwYsL4ejgAtYmaRqjSmGouPRx/LTTEoJfEKH8A4HmussFRRsLc+x/pASUmgvVsWdIRyYAcVjhdnG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AO4YWd4r; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AO4YWd4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777446120; x=1808982120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/ZwfX7O5SCBOQ98YvFl//tUB0hURsI3izutezHbDmao=;
  b=AO4YWd4rkzVkgXNJ+o5R+J0oSUEvBTJLoibF3lKphK/GoMRrxNx+XBZT
   OYkLVBkVp2C6Zsv9T5uLcPtSUluwhXebOUD8vf6nIWbLaPU2+OVuJTc+P
   Vk88KXqdQliYq9cO/0iLzkb2C/HarOqUOn6VDZ0hg740bWj56v7iNpcg7
   ziDxDpgWmX6jaxVSSINv3XR/3W+2d3e0ulfyulsgwOtiV9WEqofmrSsCi
   Ph0+M65P2Qc7tagdRPMY9P5+KZVGWmr0x9g08r6D4D+YZJloyqMFZlk3n
   ezD8F9xBMgBJB7rwnTnxb/ig5v+rGNCdU7Gt7Lr3b/amgQ6HkdqhmZOwX
   A==;
X-CSE-ConnectionGUID: bndMAB+cTzK/4UkEp/A9YQ==
X-CSE-MsgGUID: sMpnGDN6TZCfmGfIXNyOxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77397301"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="77397301"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:01:59 -0700
X-CSE-ConnectionGUID: W4F9L/V4RUis/KgyFnJCdg==
X-CSE-MsgGUID: NGn6l15USxa9twXStA4k5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="229836051"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:01:56 -0700
Date: Wed, 29 Apr 2026 10:01:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Felix Gu <ustc.gu@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hw-consumer: fix use-after-free in error
 path
Message-ID: <afGs4jBXEMWDMFbE@ashevche-desk.local>
References: <20260428192636.58e4fc8b@jic23-huawei>
 <DC73DE77-89A2-4268-B07B-2CED5C1D7592@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DC73DE77-89A2-4268-B07B-2CED5C1D7592@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 11:34:22AM -0700, Roman Gushchin wrote:
> > On Apr 28, 2026, at 11:26 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Tue, 28 Apr 2026 18:59:28 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

...

> >> I am also wondering should we put Reported-by with the reference to AI somehow?
> >> Jonathan, others, what are your opinions?
> > 
> > Would be nice to do so for these - things noticed whilst reviewing a patch
> > type reports.
> > 
> > Roman (+CC), any suggestions on how to do this?
> 
> I appreciate when people are recognizing Sashiko, but I don’t have any strong
> preference.  Many engineers are using it locally before sending patches
> upstream, so we’ll never know it anyway. But Reported-by/Assisted-by tags are
> appreciated when appropriate.

The problem is what to put to Reported-by as an email. For example LKP bot or
syzbot have dedicated emails for that. What about Sashiko?

P.S.
An offtopic, how can I be email notified on the reviews done by Sashiko against
my patches sent to Linux kernel project (mailing lists)? If you can add me
as andy@kernel.org, I appreciate that!

-- 
With Best Regards,
Andy Shevchenko


