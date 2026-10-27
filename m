Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089802;
	b=RYPV5O7KctmVUZ9/0J1ZJNINmLCWYQydSsj+ueOC2Ffm2TarPoa0CCG5rRxjHQ1F9Zys
	 98M/NChg3BzsPbXKueJahjV3SwQJHErbwvnhGkvruX7/NxINfYLTI4RJAKfZaIa7U3dPQ
	 xilXxpiWuEFC3usI6HgggFMvvpbj+vjlTBhCR7m2ckMLcSbbGIZvJn12YK6v+R8W65oGl
	 baV8NhmKVd0hvEXN6IHjpLpPInIq6g4ozGI8om5zLFqwEZYxuO9X/YDOfWt1h6U+CE3Kq
	 KMZrmxFKpSyzy+o8DuMBlFhjkXwFY+HZEMq3/OVffTNRjeoAmwu/pRfav3ou3t+lbaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089802;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=HDrak9ecyltLPRvmfTfXlRlqa8cJFcYynihc/bbUHxg=;
	b=L4Vk/a+vi0JIheTeHaPSxbP6jEvFY3yUEOg4CYOPwMFFxU5+/MBiqWqJ4HEIF6V3MsHq
	 nfqltBEr62xyGvMQkteJL418peT0hJiT0GVs4BX/L06PbmMMiKNYx4VpJl+bD+QjwksUo
	 5j9i7QHqyOIglBFZ9doBo0YvUm7jLpIawxwWhQgUen42nsihsOCx000/kWZZrUnkruQVc
	 3sBcB7ZR84ZrqS4IBOGYAaGwrSv+mj+l6/nx4pwfP0mB9FxesrVz6oZxDXG4KhbkGJd/w
	 i8cQI8JHp/OW4SKtq/W9M6CNE/a/9Z3+X6LxumiHCsDHF7BBUOZtyWnNmhY2zidLOkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VatmS8ff;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F193606A31A
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 08:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F193606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VatmS8ff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793089801; x=1824625801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iM2qfJFYbj9URsIbiYn/2s1LDXPWP3Z/y+cDhsqBhsM=;
  b=VatmS8ffneCXM2K1dqFbP4Lz1Y93+k06Nyz3WVFN9Av0W9ig+h9nZ6Ju
   1GldhEh4uBdawvuduetHba9S4bKcINV82DbEliDMcqORkd4yxbDXOGID8
   h4gL5EPv28myDmZb/TtIjvVlc+dnErzkYbdEvXZv1pLiZXQ2Rikdyj2jL
   ImHiwn6PD8Fc5NvZdMK0Lj72Nt9VhtI2AbROq5z9jecC3VolFvuQPFgIA
   o3Mua/BA55QNIfm2ww/HRTTpmFcv0JProSdk/5M47//YiYU8h2qA9DL/s
   8SDB8SRBmk7jBHD7Hlmm1xzw//E97NMjD1E/mo9m/KOJwmJFlxoP6y74H
   A==;
X-CSE-ConnectionGUID: C1HdW5Z2T7225pUtF+2saw==
X-CSE-MsgGUID: IEC6HLrbTpWh7yUd2hA1pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1694073"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1694073"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:30:01 -0700
X-CSE-ConnectionGUID: yiUr2zW8R2649hDUVEg5kQ==
X-CSE-MsgGUID: s/6l5Sp2Q8GGwrc5qmudLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6331369"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:29:59 -0700
Date: Tue, 27 Oct 2026 10:29:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Archit Anant <architanant5@gmail.com>,
	Stefano Manni <stefano.manni@gmail.com>
Subject: Re: [PATCH 19/39] iio: adc: ad799x: use iio_push_to_buffers_with_ts()
Message-ID: <auBhBYR5DOqkSEn6@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-19-8b136778eedf@oss.qualcomm.com>
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
In-Reply-To: <20261026-iio-v1-19-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:37PM -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Move the buffer onto the stack, local to ad799x_trigger_handler(), and
> declare it via IIO_DECLARE_BUFFER_WITH_TS().

...

>  	b_sent = i2c_smbus_read_i2c_block_data(st->client,
>  						cmd, st->transfer_size,
> -						(u8 *)st->rx_buf);
> +						(u8 *)rx_buf);

Indentation is broken (even in the original code). I would reformat as

	b_sent = i2c_smbus_read_i2c_block_data(st->client,
					       cmd, st->transfer_size,
					       (u8 *)rx_buf);

(yes, it's possible to move cmd up, but for the sake of less intrusiveness and
 better reading the changes fixing indentation just good enough).

-- 
With Best Regards,
Andy Shevchenko


