Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629473;
	b=MrWj03/nFSVPa+Oi7PP2bwDM52y04rZVc0HKhQZIVnd7FBiSLDlaxk/JZd6aPu++6ocC
	 /rAHJhC4GE9nHq2GHlzqXLBdaojhwl9oPSoJrMmxLEXHUtpkLHFweDdtj478JTKKQSS3F
	 cgXHkRdstrNkYpg8G9WwNHoHRTqh/ko4iImvuP6/2pbFVRxf6v5fqVG28T9GXZpwUJFcc
	 oQOli5iJ/uAlhTNMMsnidCsi6Bz+uiEoekDzL6tRllnGS1ERiuia5M66goLJAIybz9mdN
	 qkQNTQ3AXpARlt+DnGGDE15tcLDp8ik/ztVYWsmC434A4oSPetyIwwBkRj3eKeDh4pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629473;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=J5veT5Urp7LS4mPes9RJNYLBYsRtx0DgXSJ6z3ISQTw=;
	b=lyVPpMABv9HxNU6bfZbcctDADp6UOOO8S5Mjwk3sIGrtfcXaEzY9OuYDEOt3hHQdRNar
	 IrbhNqa9/17UjJhQ7ZaszCq5IPvjK/0wK9YfsldKBbiw3rL1xmpr1LxyVUlO58TkV89jm
	 Jdc4562cVa1HWUlq//3TQLMOQP5MsbV7WqH66jOck+PkEFO7E7SkXlAmykKYFpI9v7aD7
	 BQmEO6loYi1GjV/O7yMWVz1iaJ9YbdsVkC1RlO65NE35RsLO6HRlQEzy/gmxDJiA3cX0L
	 q8c+PrtBtVjXrVHmtDVSSvyGxPp2KYq0pA6P2zIgH7uA2xX2yp65FQisGRsdSsT1j7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WlX0oxJL;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EB7606A327;
	Wed, 25 Nov 2026 17:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64EB7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WlX0oxJL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795629473; x=1827165473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6C7sh1ZYPfUztVvl/yxEe++JQm8hzCvJb8GdlZXhPXk=;
  b=WlX0oxJLQ3ejtzEXvHMRrPg8BUzP78zgEczhQwrsLHxw+F1AkXphHrp5
   KXByf070XrNMfMu33Bb8m8ea994CKjgYgo+OI3SPdx8RytAGTh2mLQ2EP
   Cid/7h8fa7+XMTtevs5TwwKtpaJaLnVgKXZqozPvwCNIua9UR4KToKss+
   G/V4siP6BVMSgHvAJsheRGK4mYMFmaSmyzUsn3Sy28s58bnOXZPdKsv9l
   MFur/AwXGn/irxRjJIR9S/0RIvnI4UszBvMQNbnN8+hPXqX9ziry2q3SK
   AQtAcRVerqkngVydDXbRfPn2zgINqGZWGRS4SCT6GTtxKNObT9Cwzk/mS
   g==;
X-CSE-ConnectionGUID: Ry3fooHsSIitvsycNukVEg==
X-CSE-MsgGUID: BWA+vYlXRj2NJX7SfnvOqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4422535"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4422535"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:26:53 -0800
X-CSE-ConnectionGUID: 5J3yiETdQyaGWFSROQsHiA==
X-CSE-MsgGUID: qRZVRo18QaasqFzpxFIm/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12131608"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:26:50 -0800
Date: Wed, 25 Nov 2026 19:26:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: Re: [PATCH v2 1/1] iio: core: Split debugfs routines
Message-ID: <awcaWIBZbS4Iq4uj@ashevche-desk.local>
References: <20261125140251.384361-1-andriy.shevchenko@linux.intel.com>
 <6d517c95-82e1-4713-bc1f-9922a975e26d@kernel.org>
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
In-Reply-To: <6d517c95-82e1-4713-bc1f-9922a975e26d@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 03:22:59PM +0100, Joshua Crofts wrote:
> On 25-Nov-26 14:59, Andy Shevchenko wrote:

...

> > +static void iio_device_register_debugfs(struct iio_dev *indio_dev) {}
> > +static void iio_device_unregister_debugfs(struct iio_dev *indio_dev) {}
> I checked Sashiko and it points out that building with debugfs disabled
> causes compiler warnings:

Right, you were a bit late after my reply to myself :-),
but thanks for double check!

I think this warrants a v3.

> After adding inline,
> 
> Reviewed-by: Joshua Crofts <crofts@kernel.org>

Sure, thanks!

-- 
With Best Regards,
Andy Shevchenko


