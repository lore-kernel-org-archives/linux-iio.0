Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AAC3B636A;
	Thu, 11 Jun 2026 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161933; cv=none; b=VmN5XJM4oztzVRMcJFYbG4qk1ULC/IkMqiUlWxSqRNqxVF2xcjO06UlvE9AuTAfD2WWpNRKrU11Ljtxv3sQ3YzVdO8UN+7dgGllxczHnYITsQrIl0bs6XRqA2MqQEnhglODG2kSc3Xx1pHddyUal4zxZWIMEBn3HFpmaqx5DkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161933; c=relaxed/simple;
	bh=6/exjtGUI+H+BFU2tn1CFAXIxqVdrkenpMmUmWZvrj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVL+TGjoyJgK3+aVQWb/5aILvF/ILoZ4pt/9WyjNepDEr+sMSp7alxu4Rpv2beDYbjsianXZIZP/MLZTi2umiNfylYR0f6Wxv+kGh6B7UeI6FxwA+heQSjF1fc7JcSbqMrziTAxLtnr/4987T8zBUUAHxKtqXw8JnZCL8acaqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Or9QGCKh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Or9QGCKh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781161930; x=1812697930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6/exjtGUI+H+BFU2tn1CFAXIxqVdrkenpMmUmWZvrj8=;
  b=Or9QGCKhD/hmtcywWER6ZxEGOSTCmZ/4AKGMEztBVHQuO6SoCTFbhsCy
   8NXcw+c9buwS+Tt8blcmcKjrEciy5RoMnJVa98xedkuJPLNn3tDdUteSb
   3r2aBJZHgoZiVH2+xjPwf+Uz7rg33jtOiI1TNRqq5QH4azhCXCfKzHCjw
   6XeUnzSrb8Oya9Klr9BPwrWkvCBcS+6FHn2XXQt/YGWMqfsKnfUv4TxrN
   384iluA2S8cP1ix26d5MOfeDGo0qsix5y4OUfJrHuen1VSF7ovn5WhUPf
   ycY82nfOZI8VPoM8zcVMgEbneASt/NBmaRGT3sywZYDUOzp6NykgFGzu4
   A==;
X-CSE-ConnectionGUID: FQOqnbIxSreMQPuSVs/g8w==
X-CSE-MsgGUID: /3NWd2IATIKVoCUFwGHoOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81973325"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="81973325"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:12:10 -0700
X-CSE-ConnectionGUID: RbYTuUx7ScGeDpYa6Q4KPQ==
X-CSE-MsgGUID: CHyDdo05QcCi2c3czCuREA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="243947336"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:12:07 -0700
Date: Thu, 11 Jun 2026 10:12:04 +0300
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
Message-ID: <aipfxL3ttO1-7W1T@ashevche-desk.local>
References: <20260609160326.45123-1-m32285159@gmail.com>
 <20260609160326.45123-3-m32285159@gmail.com>
 <20260610-pastoral-dark-ostrich-5ca3f6@quoll>
 <CAKqfh0Hi8EkShh3s4dUqAJRDExQLR0NVOvd4An+bY5hat4-Lhw@mail.gmail.com>
 <e00caff5-55e4-428f-bc57-3885699b221c@kernel.org>
 <aipatjyVcltbspRJ@ashevche-desk.local>
 <6c5a657b-f316-4982-8cb8-8c09f1b1669a@kernel.org>
 <aipfPwT4RJGdA4TT@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aipfPwT4RJGdA4TT@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 10:09:57AM +0300, Andy Shevchenko wrote:
> On Thu, Jun 11, 2026 at 08:58:47AM +0200, Krzysztof Kozlowski wrote:
> > On 11/06/2026 08:50, Andy Shevchenko wrote:
> > > On Thu, Jun 11, 2026 at 08:37:33AM +0200, Krzysztof Kozlowski wrote:
> > >> On 11/06/2026 00:24, Maxwell Doose wrote:
> > >>> On Wed, Jun 10, 2026 at 4:09 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >>>> On Tue, Jun 09, 2026 at 11:03:26AM -0500, Maxwell Doose wrote:
> > >>>>> Tomasz's entry is no longer valid, as he is not active anymore. Add
> > >>>>
> > >>>> Why is not longer valid? I see activity in Feb...
> > >>>
> > >>> Strange. According to git log --author="Tomasz Duszynski" last commit
> > >>> I have from him is 2023. We also did have an RFC open for a month on
> > >>> linux-iio with Tomasz Cced with no response.
> > >>
> > >> So you did not check enough... and no one needs to read RFC :/
> > > 
> > > Hmm... lore.kernel.org shows last activity November last year (07-11-2025).
> > > What other sources do you suggest to check?
> > 
> > No, only lore.
> 
> I used this request:
> https://lore.kernel.org/all/?q=f%3A%22Tomasz+Duszynski%22
> 
> > As I said, February this year.
> > 
> > https://lore.kernel.org/all/CAObtm8zKUAWNS23nRMhc9ZR-zn7xeVOFPiV4ai_x7Bkd5puiyA@mail.gmail.com/
> 
> Okay, you used UTF-8 name, Where did you get it from? MAINTAINERS has no
> diacritics.

OTOH, you may have used simply email approach. With
https://lore.kernel.org/all/?q=f%3Atduszyns%40gmail.com
I got it as well.

-- 
With Best Regards,
Andy Shevchenko


