Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A737C11C;
	Sun, 19 Jul 2026 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784451065; cv=none; b=UMkqfRzSRpQ9vXFfOuCV8phlk4wp8QIMnQz84LR+R3+WHX98cPKeAqujZoMWDxyPt7Tv5z37i0ZR4sPQaee0lAuVB0PDZQGAzBgl2vYER73nF6RKbohq7/rFpKCDnQTHXGPettbfgDijY308Y+uwTVx396jSlNOoWvtKJF9iIc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784451065; c=relaxed/simple;
	bh=hlFHADT7M8WKqTUivZ0uesc6ti/xylnQDSjOfcsb9rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnGDUpwBjUBgb3vMQNOe1KAQ+kao6aSxC083ZlRN4o2dKQRv9YKETqhfSTJf04zgen6mAVoS/M2+7j5MxXeRxnu5guqbWKqEKo+amaJKVwORJsixOXbr+tt9Ooa3DJKaRzfuqvzPKV2Eu/026DaEp36XtwKvWR1RCdOH3GhkOAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQcY13VG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQcY13VG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784451063; x=1815987063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hlFHADT7M8WKqTUivZ0uesc6ti/xylnQDSjOfcsb9rg=;
  b=nQcY13VGaRAmv5GQNEhFVC44LOan6Zf3+NgOwQHzR3Ci4hLfsNr2urQz
   KDR7Ri/ELlBTXRcaGe5QI4qR1SqSx2f3J31htyk79yMcsdfSUktYDLzAb
   DgPmqighuP/88I2nvJbmN27UFATkCcmwuv8MrDXpRxHlfwycAAV2vjWps
   cappoMeKaVFYlJmIcPhgTs8nr7EnhLgKw4QC+Aosoouqi+FGVSz/oPcS0
   YYUxtz8Rei6PRphbgz9Zhqh/F8BF0N2se/e4f7ak3mlyq932nEnLBiENz
   psNuX65B2I6NZWN+5/4a8gPZpMvVhDKD42km3pUmcfmNVbdn+22UrwI90
   Q==;
X-CSE-ConnectionGUID: E1g5NgdkSRmR0oKU4p53ug==
X-CSE-MsgGUID: PxEgoyC5RNCwhRSco2Fucg==
X-IronPort-AV: E=McAfee;i="6800,10657,11850"; a="84830378"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="84830378"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 01:51:03 -0700
X-CSE-ConnectionGUID: uk2FLjnZSlqSQKaOnnJWqQ==
X-CSE-MsgGUID: falftuuCR0i44QhfWAmBFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="255405333"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 01:50:59 -0700
Date: Sun, 19 Jul 2026 11:50:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match data
Message-ID: <alyP8NlQzRpXnSq9@ashevche-desk.local>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
 <20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
 <alkmAcDvSXr_COc_@ashevche-desk.local>
 <ondynh4kmchzugk2l24klamrcaje3qxnhgiks7gnc46wwwvo35@hysk2zaimb2e>
 <alnknz55FbyyqqlL@ashevche-desk.local>
 <gy2dn5emz7sreavy6kioz27f3sx2ip6zhkgzs2uz4qzecpkrbe@zgsortof6aqn>
 <aloD5HdbntKu--xC@ashevche-desk.local>
 <20260719005533.41520a27@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719005533.41520a27@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 19, 2026 at 12:55:44AM +0100, Jonathan Cameron wrote:
> On Fri, 17 Jul 2026 13:28:52 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

...

> I applied the following rather than going for a v9 for just this:

Thanks!

> Shout if I messed it up.

...

> +       if (!chip_info)
> +               return -ENODEV;

Perhaps stick with -ENODATA? (Maybe in a separate change, dunno...)

-- 
With Best Regards,
Andy Shevchenko


