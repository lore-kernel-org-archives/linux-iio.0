Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3BF2D238F;
	Tue,  5 May 2026 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971887; cv=none; b=jJj0l7u0trj6BOkUM/v5p5SdWVONZg8gZUGa1pMEhhgoNWBJTPuRQ9ic4D4HuOMmQy8KIiBAPo9OAmvFDmOPFKAasw2qVZJ4Vz5dS46Mxg/+C924BP4ZT94I4UPRN3yvVwkJZ5GMpIGtByxYXVMb/cUK1OAza+x7suRrWSKXzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971887; c=relaxed/simple;
	bh=56rvixhTVyl8krE6GTyyapnpK+0U6X4NJn5d+LifSPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1RmgmWYtj5HviNZ/AtVs3aCpQEY8uPTu81w8yJs/PQhkakRrDuA6Uwpd7TFwGu4MNfnG6gt1SqR334i7khRaXL8BYjDKEUfhiafshcZo1YvrmJuOx1NR/DibVvcNXYR2X7/85iyT0b+CI2n+dBAR24AeIYXXfbquJ58rE2aguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lC7iB9qx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lC7iB9qx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777971886; x=1809507886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=56rvixhTVyl8krE6GTyyapnpK+0U6X4NJn5d+LifSPA=;
  b=lC7iB9qxnH4yo/lk0L2y4taHP4E2N4svnV7m8xSID/UlNRyXrmY1XNq1
   LNTTadG/JxGOtUw+w3tJQt0y24h3F8O3TioKfCdGy9lpr4dyNExq0HUP7
   PuWRPYp/xRUlH37aKfIfhuy1u6XelH4v5XL4Jl+g8thCVIWfTpwLaNUFh
   NQGf+aKS4oGFiPBfdD708rnNuB8mkqy1CDmbkmSkKZ6mjk9NTnE8paVaN
   yLDpYNGrRnk3gd6f1s8SeWQMpPeQJBZejWasaft18d6iisF+YnxlMt9C1
   NRUWsE41mH1/+7f5zczFPW7pRdKGNIUzIlHuAHnmVrSUCjz6q3mVYhda7
   w==;
X-CSE-ConnectionGUID: 2imdmwsfTmOHfcmLxlGNVQ==
X-CSE-MsgGUID: Y/eBVXKrRZmqJfiAL0uNjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89429474"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="89429474"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 02:04:45 -0700
X-CSE-ConnectionGUID: DrTPJP0ZT5anxW41/COagQ==
X-CSE-MsgGUID: J9oUMFEcTUGCvZhYpsHXXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="273910171"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 02:04:43 -0700
Date: Tue, 5 May 2026 12:04:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com,
	nuno.sa@analog.com, lars@metafoo.de, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] MAINTAINERS: iio: adi: consolidate entries
Message-ID: <afmyqE6-XcT-SRt3@ashevche-desk.local>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com>
 <20260430190642.3434650-3-sanjayembedded@gmail.com>
 <20260504172457.4d7c7390@jic23-huawei>
 <AB6B7E29-83E2-4BE8-AF74-1DE8358527E6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AB6B7E29-83E2-4BE8-AF74-1DE8358527E6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 08:00:23AM +0530, Sanjay Chitroda wrote:
> On 4 May 2026 9:54:57 pm IST, Jonathan Cameron <jic23@kernel.org> wrote:
> >On Fri,  1 May 2026 00:36:39 +0530
> >Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

...

> >> -AD738X ADC DRIVER (AD7380/1/2/4)
> >> -M:	Michael Hennerich <michael.hennerich@analog.com>
> >> -M:	Nuno Sá <nuno.sa@analog.com>
> >Specific maintainer. Why is it going?
> 
> I'm assuming that to avoid de-bounce issues from *@analog.com domain, we are
> adding linux@analog.com mailing list as primary contact. with that in mind,
> this series drops all entries which match the wildcard and have analog domain
> maintainer or reviewer while keeping the rest as unchanged.

But it's removing people behind their will! You really should do this
case-by-case. Some of the people who left the company might still want to
follow the driver or even maintain it. What you should do is also pay attention
on the Supported vs. Maintained which makes a huge difference on the
responsibility and financial side of the Subject.

Btw, Have you consulted with your Legal department on all this?

> >> -R:	David Lechner <dlechner@baylibre.com>
> 
> Additionally, When David is list as reviewer in individual driver entries, I
> consider as redundant part; All IIO subsystem drivers/iio* already covered by
> top level entry, which includes Andy and David as reviewer.
> 
> Summary of changes in series:
> - analog domain specific entries are dropped and catch with linux@analog.com
> under ADI IIO section.

No, you should give a good explanation why in each case. Yes, you may combine
the cases when people left the company, but you also need to
- consult with your Legal
- consult with those who left on what they wish

None of them seems done so far. So, again BIG NAK from me on this series!
Rework them and even part that drops the entries that already have the same
maintainers as current ADI level ones (assuming adding Nuno in a separate
prerequisite patch) is good to go.

> - Non analog devices reviewers and maintainer is unchanged for each driver entry.
> 
> Further, I also agree with adding Nuno Sá as a maintainer in the top-level
> ADI IIO entry, so that all drivers are maintained via the mailing list with
> his oversight.
> 
> >> -S:	Supported
> >> -W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad738x
> >> -W:	https://ez.analog.com/linux-software-drivers
> >> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> >> -F:	Documentation/iio/ad7380.rst
> >> -F:	drivers/iio/adc/ad7380.c

-- 
With Best Regards,
Andy Shevchenko


