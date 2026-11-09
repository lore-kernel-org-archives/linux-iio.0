Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245775;
	b=tuopXaOB5YPACqQPwhKdjIk6epHK4RfwBIF7me1nyigCzWYKhfpa3bynqo4uDiPG76+Z
	 mGvxK1zecLuQs22o73dz9OTFf9cyk1ekuVfL63DHO8GSUG85rOHdDAKI5QDziZVAXATTs
	 fwOngjHQIgLvm6QZofpB2lmdDl8OnqTN55jdFnFdfSJFBz0+Hy6a8zH0BfUOSR3gWbCq0
	 eRrbpZC4PDxqKwZwbXIio4c4J0SfwOwGzbH8HwN7ZfsxYwAHgcQfaFeLsj2D1sP5793ar
	 hBfSEgxpEUeVykcQOT8QupmAn+wFyre0YPccTPLyL18ktb1Sm3Itrey3g+ufnTNEslw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245775;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=r9bq+chRchYAfXx9mI2yN82mtsH8hX+gX/YQ5HzOClQ=;
	b=MbxX3Lct8OSUHE347inEoqFn8+asBSAtAlpMhgM0iC+IFHNp75pzX8Fl419HKovYpD/u
	 GsZYMZD5aOo1A4mEJgDKGilsgG14Z9QVDIFvkIeNTQcAfRQC3Rly2WXu5IUpLId/GHPkl
	 Ju4cKRvbvFU8oO+Tn1NM1KQFA9yF8n3jBxJvYZI73HY+YU4oqT/xSZ9TksIZftXGG7dMc
	 TFnwH27KgA7UKvly+35uhv3CFpthgTwK+18Q7TLu9uFxI932XN/7sxO9TItuoQj7UVmTu
	 JQvrZbEWSOG0Xl4TPVv0lLz4TYupiDUgn28eo1PuVQknCtmwU2a2UNrlyBwTfakIehg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S874eiFn;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA208606A321;
	Mon,  9 Nov 2026 17:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA208606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S874eiFn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794245773; x=1825781773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hdyTdFadcQX22sjAfG7PRrxEsSCtvFDfvM7l1vBgoMo=;
  b=S874eiFnCBhuSn/rpmd29OpjcY7j/DLpWsViCuDlSD/oUZ6kczxbbrhz
   CGvk7Lsq5JWaeqkdVh/MrlKQZuwyGy4yQV48ztJNGq4zRcz5Xo+/xv/sR
   P4EascQQU5HEHgLM+F87b0G1VsepspQSTKzsKZtfHkNyiVALMjgwcQDsx
   rPji5JOjRBstQ/2Smh5RG/9oLqqObcdoiHLdoGhqD3w2yhR6CQ+XCuEAi
   ml6r0DvBriTgeEpvpNlW5oqf4XwWglKtHFeolJd0SIa5wsS2e+GeqlXBH
   C8y0j7A+W+JhHqRB8Kyn/eMztpsgjCBd2+wUDs69d/56ioYwAaT/YloDk
   Q==;
X-CSE-ConnectionGUID: e71rSWR7Q6SjOHfC4wDW3A==
X-CSE-MsgGUID: sVSjMqg7RhiLHNymA3mE8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2965801"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2965801"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:36:13 -0800
X-CSE-ConnectionGUID: mID5p/+qR5agI2+meAPCdg==
X-CSE-MsgGUID: EcqNnB1OSGyI8rDd44kGHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8111962"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:36:10 -0800
Date: Mon, 9 Nov 2026 19:36:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Adi =?utf-8?B?S2FkdcWhacSH?= <kadusicadi1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: use __free(kfree) for
 temporary buffers
Message-ID: <avIEiKfQIOkjgaal@ashevche-desk.local>
References: <20261108201522.249539-1-kadusicadi1@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261108201522.249539-1-kadusicadi1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 08, 2026 at 09:15:22PM +0100, Adi Kadušić wrote:
> Replace manual kfree() calls with the __free(kfree) cleanup attribute.
> No functional change.

...

> -	data = kzalloc(data_read_len + 1, GFP_KERNEL);
> +	u8 *data __free(kfree) = kzalloc(data_read_len + 1, GFP_KERNEL);

Just a side note.
Would be good at some point use something from overflow.h for this.

>  	if (!data)
>  		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko


