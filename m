Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908951;
	b=hlc/DVAfonayP7FlDCgiJK1mNGOOF003x0xyIL0UFDjbCSTlXSt0pPruj6+VgyifS2ix
	 rdI+Qh2S0XTwiLj2aH2eRW0mXDu86O3F2YW62dtvlsHRXLkEW17IhVElwmyJcTzvzysOh
	 E6C6IWbjMp1YdjUD/Pj6y/3mQAKmqtAHRQ9J00QmdgfiJ3prGHsmqrjqWgjULaC2i9UhB
	 qqc80LsnxMuTxbneHHRQHyQX5TuCymwKxHZyAfXmX3SjLV8m1DXoqWCKqEwfqb2Zb4WzA
	 vR3SUI28MmAA9lXX2Du8QQinDKBUxysTxPh7UOAllnYq1oj4eIkN11LQmZwuL3srtpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908951;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=3Q7tJA/hWkM7pBtd/K4GljKp9oRMuO4CBdoh0ya9JKg=;
	b=r0HrnvMzBZszkL5dlhLOIC4V3lSOIRcZwiHlQGojQ+FrCLyN6jtARHGkiKQl8P18xsq0
	 ICNIDgx3a94J0v8Ndp01Px6QutIvBeO7BdQBzLKl0rlbW/gJ2Z9KOeuYXR1HSbLt0J6vI
	 PXX17vmhV5mf9egN2h0sdkWWyBaolaI7KO+mHhXzGE56I06o/VEOvG8CO2CJItdcDL3JB
	 RihezdWx5e+TMSZf+GnVUZkxYTeMMyeTSEf68OIuABct9UfTg6GfEFS3ROQAblQJqb4JW
	 sY3ZrgsNh+Li2Jy483Xtkvai328AbIaYh1UeoV2u1tSFh76JyypoI/jUcaNLsPnWNVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ihtgyhuq;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BAB606A323;
	Tue, 17 Nov 2026 09:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75BAB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ihtgyhuq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794908951; x=1826444951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sJ18Jf4VXrBJ6WMpaYmgubx0JBlxlmL0zAQrq13QY6I=;
  b=ihtgyhuqzhnpbHHfALaslfdcLGExtm6k+GijdOrJfh6MbDY5YOg8cH8L
   qbq2hOWraT2kslyl+AXHvg9z0ZtsBcKRduq1BWT40YdAdSa8kLNhMygFV
   PCEtcKSRdvAAE71c3senohQWafjRxQDxNpjDV8X7kj6EEqIko9OY8YfGc
   9/M8ZzSwkBLBLzi1pidkejqic43sBzeV2cvXIUKSk+47EiS3lu04tbuLV
   +yCkTtBhw02JzThcqPexkIU9PaQemcWsVAj+bncDbeokgpnorJaiJ6oe8
   ZCoFj9gUw+78HnJoxs1ivX61kxBrJMbbjf1eGgsfv6qxDETRkpDc2bAKs
   A==;
X-CSE-ConnectionGUID: QVx72QgLRaC1bBLNPMWorQ==
X-CSE-MsgGUID: fCPjOlq3QvuEdm2pk01XGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3525949"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3525949"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 01:49:09 -0800
X-CSE-ConnectionGUID: j1RkJ33xS92Q0uicRK6A9Q==
X-CSE-MsgGUID: KL8ggzyTQnWQHsQiXPUGlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9868687"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 01:49:06 -0800
Date: Tue, 17 Nov 2026 11:49:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Eddie James <eajames@linux.ibm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Joshua Crofts <crofts@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH 3/3] iio: pressure: dps310: add Goermicro SPL07-003
 support
Message-ID: <avwjD41YxQ8dL2gx@ashevche-desk.local>
References: <20261117083954.335814-1-jorijnvdgraaf@catcrafts.net>
 <20261117083954.335814-4-jorijnvdgraaf@catcrafts.net>
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
In-Reply-To: <20261117083954.335814-4-jorijnvdgraaf@catcrafts.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 09:39:54AM +0100, Jorijn van der Graaf wrote:
> The Goermicro SPL07-003 needs what the ZTS8032 chip data already
> describes: c31 and c40 in the pressure polynomial, and TMP_CFG bit 7, a
> rate bit on this chip too, left clear. Its TMP_EXT is MEAS_CFG bit 3 and
> stays at the reset value, the internal sensor the datasheet recommends.
> 
> Its c31 and c40 are 12 bit values packed into 0x22-0x24, where the
> ZTS8032 has 16 bit values in 0x22-0x25, so the coefficient block is 21
> bytes. Add a chip flag for that layout, the chip data and the I2C and OF
> IDs.
> 
> Tested on a Fairphone (Gen. 6). The DPS310 temperature workaround skips
> this unit: bit 1 of register 0x32 is set.

I haven't checked with Datasheet, but code wise it is nice and clean
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


