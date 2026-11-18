Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001494;
	b=5fbEwC8aDGrvszctdg780fQCBPq0nhzWTcvgB2wT1ENEnJbsp2Po6JojUZC4cf3G05rw
	 8q9wCyLSeQi8cOYHI3B7TGtDWSGf9/wsvpPcErki5q+jQq8F6FXZ91NLKfqO4CuoiJD3N
	 zimgMg7PsEUxRo2/Nfoj4ZEawf5Z/d6fT6ewvMtIxQNFBzEu9ei6a5eGZ36LsSnorTgic
	 1j6SQ0Vv6TEFA2WaAYKV6rS16ZT8oQLVfUDR3Zfen0CaJFykvnj9qb7VQRJi/7PUztrgA
	 SGHhm35VBZ2tSZJ1WZoimF3j/LLJgGkt6l83LC+Rz7zQcpytykcE9N5PNPQfYmgJTSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001494;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=+AJdmr09+iBj/Z5WLYyc48Zagz6XLfHcN+HSHTDIS0c=;
	b=KmNsttHGjD7YkQu3BPT1R+qkbscFZrrsjPkgN+hSdrMTL0yZUnmBjG7tNDdtWjfFYdrR
	 zUXQWVFujgKVSw4pd5OCjEhRSbkHL7u6SVyB1zByOXEz5LRhy8kZglosyAqVrUFsZkV0N
	 u7SpHDOkVOLegOxs8IkB+UzCQufkTUqyra5TT8dlV9+XDGQdWWW5cK4qTZzEN46ECyJ5K
	 TPS7la7jDbKTZ7StwLVt/A2Vb0OsBvo6PzlhQ9u4MBFPb/zBOyz0fzqNMNS76bm2U1IbA
	 t0m0YB9jwVrr9BkMau00V5w5a/SAEJL/xGuPMFzgVUUvv66dYvGNKSy5pIG/lncIAtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lWqcoD9b;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9FF606A31C;
	Wed, 18 Nov 2026 11:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB9FF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lWqcoD9b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795001494; x=1826537494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZplAlreEN+1G2HGdfsT/GfZ9NWcBNLei6WdM38+/mfM=;
  b=lWqcoD9bFlpvcLjRdPe4ZGakqda2ZjVskOmL/CCQzFw03nWXURiu1IQp
   wmR2userQcIWj0/Evl2qV19M/UwqaIXyGFEFcfmaLI9F/Hg8jQ+JYzYMw
   qOs8TYm9BnqamkgxoSSN6QMq1u/FyN+fxXvqCoFUff9y3eoUcgJJ49a4S
   /TvMDPLTbKM0eMF+BG2YeeA7IGo8rWP5rnup6RP28tuDlNOx5jzYBf6Fq
   OCxa0NnQRY4IXn2QNHlll30hQLsJRZ+CesEhxVJc/ilTK4MFhV024jjvQ
   3Ra4kJP3RASu6FZgfKijakS8Sp4/RjN+y776dfFS3e2M04TFUbb8nMvZw
   g==;
X-CSE-ConnectionGUID: XjHNxGGnTOOpaV12vzkmrQ==
X-CSE-MsgGUID: hWN2IehiRzOlA6jfAcONfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3832639"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3832639"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 03:31:33 -0800
X-CSE-ConnectionGUID: pU98kTazQZ6gsyiNdtAAmg==
X-CSE-MsgGUID: /oIa8dH9SiSshSF91r2EUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10205773"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 03:31:29 -0800
Date: Wed, 18 Nov 2026 13:31:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Daniel Campello <campello@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Semtech SX9xxx: add a reviewer entry and binding
 maintainer
Message-ID: <av2Mj3meE15gT7e3@ashevche-desk.local>
References: <20261117172612.25535-1-kapoorarnav43@gmail.com>
 <avyoLGkkCkxu11TA@ashevche-desk.local>
 <20261118083606.00005f7e@kernel.org>
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
In-Reply-To: <20261118083606.00005f7e@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 08:36:06AM +0100, Joshua Crofts wrote:
> On Tue, 17 Nov 2026 21:17:00 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Nov 17, 2026 at 10:56:07PM +0530, Arnav Kapoor wrote:

...

> > > - Patch 2: drop the DT binding F: lines, patch 1 already lists me in
> > >   the maintainers: field of the bindings (Andy)  
> > 
> > I was expressing my opinion, it was not an AR, it was rather the start for
> > the discussion. I'm not DT maintainer, I don't know what the rules for the
> > maintainer records there, OTOH I don't know if DT parts belong to the
> > MAINTAINERS records that have only R: lines (and no M:).
> 
> Not sure if R: makes a difference, nevertheless better to have the
> dt-binding files under the MAINTAINERS entry as well (i.e. grep -b5a5 SX9*

`grep -C5 ...` (C is a combination of A and B).
But small letters 'b' and 'a' for `grep` seems misleading above.

> MAINTAINERS if I'm looking for a specific sx9xxx binding file).

Okay, fine with me.

-- 
With Best Regards,
Andy Shevchenko


