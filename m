Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB037882A;
	Thu, 11 Jun 2026 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161799; cv=none; b=DHYnCjO7sM7Vq9OEedas2g2RIkZNcCj5uX2b/e1XO/gNlRZaQKBmsL+IOYfI7cymKDH5Us2FuBhT9/2q4ijX124LQbaixh1MQulAEqtN1NFLJenTKg5/a8ungonv07OEbDfTBxiLjCHjJ3O+bjHOVTDT3Hb72zPBzse0tgjy4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161799; c=relaxed/simple;
	bh=xfdMogpj2htefuo7CIYT42X3W59/9KhWgTuhY9Fz0U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw97PkXFCZB22ucVubnu4li0V+wSrTsjPLqljRB0yprVt0BSRLhBk+k9lTNi1T9/BHbF/O5sWirnK9TawBevG4RiHKJ3xct8FR8B4VAbXqOS05cf4F1fp8Zv2TCECe4/K1kMleqjYOSnOIxkIWX1V2d9/8odW0dYmL+qDBxKLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8ssVpRD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8ssVpRD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781161798; x=1812697798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xfdMogpj2htefuo7CIYT42X3W59/9KhWgTuhY9Fz0U0=;
  b=W8ssVpRDzRQNcb9NFDkFVuEHeVLsMLFC66EuN0p3xRmTgGuyh3dh8qKV
   cjDEbE23e/6VOANjubK8anjVO1p6O1HtufIuCGdUllzDHnVLKVeD4tkHy
   KqqjU2i0IgtJb1gxquZauf4RHMf3vENMvvOkrLi/u/ynBMHsQYdDj2v0N
   4HHFP32lYC3+d5RQfiV7AhycWyxWFCtffLkufMy6mKFX7IUDdoNmuCzjt
   rktAwHh4BtvvQZXavnZlfUgqEpvJZniUwoVDLqvxDqsO9252SNH4+AeWn
   Z1Aw031EVR0M78GKx9mH8GUCKDjaZ2U5kEE3XiuCuKvzEHODlrNHcOOcM
   A==;
X-CSE-ConnectionGUID: Zz27C6GsRB+Q8ROizOFg6Q==
X-CSE-MsgGUID: vAiCMQecT0+WUiRa6JVfIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85864776"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="85864776"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:09:57 -0700
X-CSE-ConnectionGUID: d+9SmuDVRTu2DVbo3AvuUw==
X-CSE-MsgGUID: vuH/lvULShO1Cz/cJkSdzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="284484413"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:09:54 -0700
Date: Thu, 11 Jun 2026 10:09:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maxwell Doose <m32285159@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as maintainer for PMS7003
Message-ID: <aipfPwT4RJGdA4TT@ashevche-desk.local>
References: <20260609160326.45123-1-m32285159@gmail.com>
 <20260609160326.45123-3-m32285159@gmail.com>
 <20260610-pastoral-dark-ostrich-5ca3f6@quoll>
 <CAKqfh0Hi8EkShh3s4dUqAJRDExQLR0NVOvd4An+bY5hat4-Lhw@mail.gmail.com>
 <e00caff5-55e4-428f-bc57-3885699b221c@kernel.org>
 <aipatjyVcltbspRJ@ashevche-desk.local>
 <6c5a657b-f316-4982-8cb8-8c09f1b1669a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c5a657b-f316-4982-8cb8-8c09f1b1669a@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 08:58:47AM +0200, Krzysztof Kozlowski wrote:
> On 11/06/2026 08:50, Andy Shevchenko wrote:
> > On Thu, Jun 11, 2026 at 08:37:33AM +0200, Krzysztof Kozlowski wrote:
> >> On 11/06/2026 00:24, Maxwell Doose wrote:
> >>> On Wed, Jun 10, 2026 at 4:09 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>> On Tue, Jun 09, 2026 at 11:03:26AM -0500, Maxwell Doose wrote:
> >>>>> Tomasz's entry is no longer valid, as he is not active anymore. Add
> >>>>
> >>>> Why is not longer valid? I see activity in Feb...
> >>>
> >>> Strange. According to git log --author="Tomasz Duszynski" last commit
> >>> I have from him is 2023. We also did have an RFC open for a month on
> >>> linux-iio with Tomasz Cced with no response.
> >>
> >> So you did not check enough... and no one needs to read RFC :/
> > 
> > Hmm... lore.kernel.org shows last activity November last year (07-11-2025).
> > What other sources do you suggest to check?
> 
> No, only lore.

I used this request:
https://lore.kernel.org/all/?q=f%3A%22Tomasz+Duszynski%22

> As I said, February this year.
> 
> https://lore.kernel.org/all/CAObtm8zKUAWNS23nRMhc9ZR-zn7xeVOFPiV4ai_x7Bkd5puiyA@mail.gmail.com/

Okay, you used UTF-8 name, Where did you get it from? MAINTAINERS has no
diacritics.

-- 
With Best Regards,
Andy Shevchenko


