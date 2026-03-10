Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E2D35839E;
	Tue, 10 Mar 2026 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176697; cv=none; b=SJOhuREFLNUJKHE3PhhPEv5ivmBF+8+SnJmcdEBjiiZCVUiSx2P++lbQZmc8TiBj9F9CwbYNgLh9dPi8GRXT2RaWkcAOoIxP72bY52kxvZL240CiNll9S/HG1NymVrJHMeIlgjP87xsMt2nPjcV60c5IKGIUW/8cN7825u7batQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176697; c=relaxed/simple;
	bh=UX70/uvem7sLv8Ucq/JRSZ/teAciH2nfogDypRcnTQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8XKO7tcGT26jjRABOys3UNO3tpjeHdYcCf9+XWsl35COuQWOrFMJjinm6jssgwGzwQ5LynMP+FFFrhV9ZO6lXK7UZG86xE1ZPvyixUs4C+wvE/2IzbLeyV1OTTWjGqxmqO2vBL6NJhQCTGwR10GryrWWf61X/s05lMIaYHH0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zxzhd9Ts; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zxzhd9Ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773176696; x=1804712696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UX70/uvem7sLv8Ucq/JRSZ/teAciH2nfogDypRcnTQo=;
  b=Zxzhd9TsMMScp7jnqYIfDAK+jUhI5s8KB0CTVBvbw3iytZkw7MNg991D
   cGZWc2KwTZHDrY8L3v7laMiyuVxycmTYgv8FMwr9VC00h2abXkNqup23v
   ohT7SFal/5PB1AueH8w7zVsAFT7Jfb10eSLH9LdZ4+FyBTBvuCFyh+j0y
   /NaBntKCtesTSKWliYfh1TGzXuZ8dMLz0rdvhtf2mytl6zSrIL3Foe/d4
   fQf3i/jhbmauzGu5mImeO863QxI7+CV2dd86eQq/XX9jjz255gyVOX+j0
   GHS1nqtdX0m0hDXjWiTpUnXj8N+Jw40jX0ZW3YjUnL8SS6DEJM2GGKGQ2
   Q==;
X-CSE-ConnectionGUID: pc/DKbmJSXq8GjLQLOmKHQ==
X-CSE-MsgGUID: uzeamDiqTT+YmUCbhCHfsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="84565542"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="84565542"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:04:55 -0700
X-CSE-ConnectionGUID: EsXsJIaRSueYoALZrd0I0Q==
X-CSE-MsgGUID: O19iVFFVT2GKY+obqTRQZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="219358122"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:04:45 -0700
Date: Tue, 10 Mar 2026 23:04:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, m.tretter@pengutronix.de, mchehab@kernel.org,
	p.zabel@pengutronix.de, tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
	pure.logic@nexus-software.ie, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, kernel@pengutronix.de,
	kees@kernel.org, nabijaczleweli@nabijaczleweli.xyz,
	marcelo.schmitt1@gmail.com, maudspierings@gocontroll.com,
	hverkuil+cisco@kernel.org, ribalda@chromium.org,
	straube.linux@gmail.com, dan.carpenter@linaro.org,
	lukagejak5@gmail.com, ethantidmore06@gmail.com,
	samasth.norway.ananda@oracle.com, karanja99erick@gmail.com,
	s9430939@naver.com, tglx@kernel.org, mingo@kernel.org,
	sun.jian.kdev@gmail.com, weibu@redadmin.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH 0/7] drivers: Simplify cleanup paths using __free
Message-ID: <abCHaqV77MtrEqjU@ashevche-desk.local>
References: <20260310200513.2162018-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310200513.2162018-1-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 11, 2026 at 01:35:06AM +0530, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Hi all,
> 
> This patch series replaces manual cleanup and explicit kfree() calls with
> the __free attribute from <linux/cleanup.h>. This modernizes the memory
> management style and simplifies common error paths without altering any
> functional behavior.
> 
> The __free attribute provides automatic scope-based cleanup, making
> resource management clearer and reducing the chances of missing cleanup
> on early returns.
> 
> No functional changes are intended in this series.
> 
> Testing:
>   - Compiled with W=1
>   - Build-tested on i86_64
> 
> Based on:
>   <linux-v7.0-rc2>
> 
> Feel free to share your valuable input in context of the cleanup API.

Do you put random people in the Cc list?
You may try my script [1] to see the difference.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


