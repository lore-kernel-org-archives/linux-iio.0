Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705629;
	b=WmfQkhRoU+Sk/hua4LE5RlAq22shOKk6Pw3tnsuQfZxQCWOdAZ8HUP2ZM0WBHV+LJnAD
	 cGgcUyGUsCTJdvkFS+Fzw4aQws/VO/pI7TvrEQ8AGx/f2DnTo9Adn3jLVML+HVmPBHKXp
	 VFSVPsEH8gAjD5ufyBiwfTDwoa3u5U6You0lbAA+km9o63WBp2YLSXDtcDHHx2CAKLGEY
	 ydQls0hxg8eI6B8exgATRrKO32qkhdPHeQmHRJZWO6jcGlB65Y7VhllYIaM/OGem3grby
	 QdNyxydegZpcmbFBOSTN10fayaJwjmuWsALGHfCgyosdkx4t3nHfKGY6WefwA9MnXig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705629;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=noFm1T6FB9ZUqu2KzNm5eL/hajCmZQmHLSSL6wG4xok=;
	b=mOSxlcdq+aF8dgNGcDckqmWLuDjQo/BnGOW3uV40hM9u68zjumGR37Tc8vez3hAuga8o
	 ccZsKYre/fPNzpfn5iq7760AkwZj9wSvakIys1fY1i2TzuYePPfVNpjXbRhSdtC5Km1CT
	 SxbPPnWebdGw+e5ew5HqpYfTbNBKuI5AOfFYlOpENEKTI7jcqUFWEWVW4H/JjtknzmVfB
	 +3q/Se41FCkH4PAD2HxptzsotC4M2Tu7sN27oDxLZJzuPXLSBnaPXl1ooX/YbPuJv3ucO
	 H75p60gxAICxvB549RUSGECeYJMyx9W+QCWyQP9ZIVu6Rtl07wIQPQKyKQnYmq20mFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mopwIIOV;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E144B606A326;
	Tue,  3 Nov 2026 11:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E144B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mopwIIOV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793705628; x=1825241628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g77E0G2Oqe9GIwfRoorO9Lft9w5btDGcI6TOVx0gmmU=;
  b=mopwIIOVgQGvDTh+jEF5RVIuqYrdvk3QwETrWrLEcq8YxB2WQyzeMhqu
   GFsDCwPri5iY9ZIBwCV6RwdmnjNWZGLgJ4x7U60eP99gOykww9ycJnz8v
   2Snhdkpqqi+qBvduAKmcb2uxhdaSFRvzYT6co7qrvalV3hH55JnIxC1Ky
   keMMoO14LiPXTar6vjt0taBBYyckMMM9Oq/3uV9F0QLDj1C2aqDCZsMZ5
   kHnQ/DWvWpitQNQMGPYcXap0rPVSylCm+IaJQ1CSlLZo/WEb6KTzSzypj
   sVxYlVJ+obWqe9R3UD0j2BDH9mFXhXV9EP9GppVpBVk+0Co9sPRfNqwyo
   A==;
X-CSE-ConnectionGUID: +Vi66S7HQK+lMDEcn1omqA==
X-CSE-MsgGUID: NZ8vePioQEqNdwCACmMBHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2454803"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2454803"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:33:43 -0800
X-CSE-ConnectionGUID: nGjFPcLfQRKaEur65VhIoQ==
X-CSE-MsgGUID: 60qfWQg+Tx2oC34QoJoBKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6522746"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:33:41 -0800
Date: Tue, 3 Nov 2026 13:33:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raffaele.tranfaglia@gmail.com
Cc: Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: test: iio-test-format: check that nothing is
 written past the string
Message-ID: <aunGkq5O9KAYKPmG@ashevche-desk.local>
References: <20261102-iio-test-format-char-v2-0-926100689e62@gmail.com>
 <20261102-iio-test-format-char-v2-1-926100689e62@gmail.com>
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
In-Reply-To: <20261102-iio-test-format-char-v2-1-926100689e62@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 08:33:55AM +0000, Raffaele Tranfaglia via B4 Relay wrote:
> 
> IIO_TEST_FORMAT_EXPECT_EQ() compares the buffer only up to the first NUL
> character. It does not notice if iio_format_value() writes past the end
> of the formatted string, and it cannot check output that contains a NUL.
> 
> Poison the buffer before each call. Check the expected bytes, including
> the NUL terminator, with KUNIT_EXPECT_MEMEQ(), and check that the rest of
> the page still holds the poison value. Take the expected length from the
> string literal instead of calling strlen() on the buffer.

> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +#define IIO_TEST_FORMAT_POISON	0x5a
> +
> +/*
> + * Check the formatted string including its NUL terminator, and that nothing
> + * beyond it was written. _val must be a string literal. The buffer is poisoned
> + * again afterwards for the next check.
> + */
> +#define IIO_TEST_FORMAT_EXPECT_EQ(_test, _buf, _ret, _val) do {		\
> +		KUNIT_EXPECT_EQ(_test, _ret, (ssize_t)sizeof(_val) - 1);	\
> +		KUNIT_EXPECT_MEMEQ(_test, _buf, _val, sizeof(_val));		\
> +		KUNIT_EXPECT_NULL(_test, memchr_inv((_buf) + sizeof(_val),	\
> +						    IIO_TEST_FORMAT_POISON,	\
> +						    PAGE_SIZE - sizeof(_val)));	\
> +		memset(_buf, IIO_TEST_FORMAT_POISON, PAGE_SIZE);		\
>  	} while (0)


Format it as

#define IIO_TEST_FORMAT_EXPECT_EQ(_test, _buf, _ret, _val)		\
do {									\
	KUNIT_EXPECT_EQ(_test, _ret, (ssize_t)sizeof(_val) - 1);	\
	KUNIT_EXPECT_MEMEQ(_test, _buf, _val, sizeof(_val));		\
	KUNIT_EXPECT_NULL(_test,					\
			  memchr_inv((_buf) + sizeof(_val),		\
				     IIO_TEST_FORMAT_POISON,		\
				     PAGE_SIZE - sizeof(_val)));	\
	memset(_buf, IIO_TEST_FORMAT_POISON, PAGE_SIZE);		\
} while (0)

Alternatively

#define IIO_TEST_FORMAT_EXPECT_EQ(_test, _buf, _ret, _val)			  \
do {										  \
	size_t _sz = sizeof(_val);						  \
										  \
	KUNIT_EXPECT_EQ(_test, _ret, (ssize_t)sz - 1);				  \
	KUNIT_EXPECT_MEMEQ(_test, _buf, _val, sz);				  \
	KUNIT_EXPECT_NULL(_test,						  \
		memchr_inv((_buf) + sz, IIO_TEST_FORMAT_POISON, PAGE_SIZE - sz)); \
	memset(_buf, IIO_TEST_FORMAT_POISON, PAGE_SIZE);			  \
} while (0)

-- 
With Best Regards,
Andy Shevchenko


