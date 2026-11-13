Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579004;
	b=rH5ajH4oiVgYuM+FlgL4KSmuXvfC/TSuBSTnP8VkSW0vTKtACSlR7CNO4Za9nWhlBIYR
	 dzlwQcvFoRgLasGCmAzK3U3TL5wUpTEjkpCd84l1zvMoBcBMoLSyraxlgpvtIJt2ibC6H
	 lBatQFCtThGu5vww2GjQTPgCxf15loQG8KaA3GmBVeh7kIatg6b/PjFBio+UrNAyhOQmo
	 XXTFimZ+6xB/wIoBM6eq2Pn0So8BqhWlhhctGa1k3n9ADFWrPchXpPwPHUjArPB5m/NSB
	 aCSQFACQN9ACBadH8mp0il6ErQPxNvlLFQ1S/NOelTYH0Kb2tGI9azAmrK01egDXkHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579004;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=oc5tqgUx2jgGl39zoG7TRqGoMncEFONZmst1nlS9KHg=;
	b=YTv4lj9tOmdqENzVVdCEtAGutyzf8NfFM8ba/S1sWwufktC8Lo2IbEpgTky2wJk2RS0r
	 Qe1rXOjf+fB1k4uTV4lcaszmWcT6UQs8gpoFEoUbn7mXfSKIxTsWi57nG5N9rk6lq1O+S
	 KWCuh4KwL9NXgftXdiW9h9BPrWxzNY9Cnyg4/Ki1vnjIxUg55B7X5VS+5frzZh9p4r/vg
	 KNLdQBAU6iSse3XQAjVhAwWRMklB0xzPofipI1PaCXvQufhSkZZz0huVPnFCoUQhOQKt5
	 dvSbEIHNycm68xit0rVuBFslVn6k2CbqzsVbfD/E9gqwNFI5Af03vscbL6LrRQONUxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=boOmEMDF;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130C5606A323;
	Fri, 13 Nov 2026 14:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 130C5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=boOmEMDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794579004; x=1826115004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NTiwvRZrh4h1yNEnLF6InFjE9odSaqV2VRbkYVv00UM=;
  b=boOmEMDFMGyijuKHa0ZzOu2GDS3fzpg3tfxRAwy2dwV9W35J0x723sI6
   h8OFcntUxToz6qrIG47G4qbHPpHDq6axRv3mcy3LjeG1IlIfcP6iIXPRI
   LitSxWVoxnoPScMU+DDw2ftlin6WKw5NtBi1C7GxcxVIPYOKoxtQnAe37
   b6YZIshZ9W+3Vyma2PLLVSvRb+OX3qwo/S3Zm3/tcAzDbW5ZTeO5qTC74
   0FTwiIAalhTsYzQkrmSF0+dXFNPSD0MrQCYYzOc+ycPwy0lynRSq03tfu
   6Db7z6+1AYLU4yM+4FNNHLt3hXUaxQFIxGQsjDzrSdU8tew0jMpEvGsFX
   Q==;
X-CSE-ConnectionGUID: RLiSwbFAR/GvoObnCzSftg==
X-CSE-MsgGUID: tmRHbv+qQ0iVOefi0++7wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3477707"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3477707"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:10:03 -0800
X-CSE-ConnectionGUID: AAfmjh9MQYCCU4mIiNf7CQ==
X-CSE-MsgGUID: 1toIfdcIRzGzl4mnE80QTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8953701"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:09:57 -0800
Date: Fri, 13 Nov 2026 16:09:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Sabau, Radu bogdan" <radu.sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
	"Budai, Robert" <Robert.Budai@analog.com>,
	"Gradinariu, Ramona" <Ramona.Gradinariu@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux <linux@analog.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 0/8] iio: imu: Add support for the ADI ADIS16607
Message-ID: <avcaMvcntGjnKPAK@ashevche-desk.local>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
 <LV9PR03MB84148ACD16DBA8896A81582DF77F2@LV9PR03MB8414.namprd03.prod.outlook.com>
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
In-Reply-To: <LV9PR03MB84148ACD16DBA8896A81582DF77F2@LV9PR03MB8414.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 12:41:04PM +0000, Sabau, Radu bogdan wrote:
> > -----Original Message-----
> > From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
> > Sent: Friday, November 13, 2026 2:34 PM

...

> > Patches 5-8 add the driver in functional groupings, as requested in
> > v1 review:
> >  - Patch 5: base driver - probe, raw channel reads, decimation/sample
> >    frequency, startup and self-test via adislib, debugfs identity
> >    entries. No buffered capture yet.
> >  - Patch 6: buffered capture via the device's hardware FIFO, into a
> >    kfifo buffer filled from a threaded interrupt (no IIO trigger).
> 
> Note: this series implements the FIFO buffered capture with a kfifo
> buffer for the adis16607 only, using its own threaded interrupt instead
> of adislib's has_fifo trigger path. I tested it on hardware and it
> behaves better than the trigger-based version in v5: the interrupt now
> fires once per watermark batch instead of roughly once per sample, and
> capture stays clean across repeated buffer enable/disable cycles.
> 
> I plan a follow-up series that updates adislib and the other affected
> devices (the adis16475 FIFO variants) to use a kfifo buffer as well, and
> then converts this driver to use the adislib helpers.
> 
> If you would rather have it handled here, I can instead do the adislib
> and adis16475 changes in this series, as patches ahead of the driver.

As you explained above I think the proper change is update the library followed
by the driver.

-- 
With Best Regards,
Andy Shevchenko


