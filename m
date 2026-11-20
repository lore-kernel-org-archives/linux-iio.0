Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168201;
	b=NmFMCI1Fxs0okUC9SzDD+7UJg3JdjHE3XJ5lmFIJBLA/3qmDR5fKzjKtwKLsA3en5NPL
	 asnxGVi2fBSIeQhs28dea8mk+aGeE8EPRS/9SDyO66mIBg5Sc0E5OjL+gQERoHZJhkLD1
	 qZ54Id6Ro75rdiYRSw28bAP9+/IyxLG241mykevuEUlWOaIrCKxJ5UYQTOflpfmJlVce2
	 ejdapnLreGbYNQyRHOojElSg6C1/KzlAFp/N3iRXYlxeA91HIjz1VPPWH18l3djGkfH0M
	 TlU+WHh5DeainJ1N4qk7JNXRYk1r/3atb8IojozPgH5MsbBt9cgVR86olIzTD6z26mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168201;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=iZDnMqhtL79mPhZUb2+l9hUhWV2bd8sgU4sQ+2/W6OI=;
	b=TM2v+fHvoyRAPmIU7V9yQL8K6oyjVEA2Zg8HMEOQC45OdsWOe8vt/XNsC7NWxbE8XtdY
	 9CDN8ThFwmd56SSQ7iejXxKUN58bkYOfEFNyzQ16FpxA62+uZbzhtjFJ4NE/m1R8Y7jJT
	 NIPfQShnWU/hIeYBNslboHHC09AFsrfFK6pLstzmxaFxE3gdXTP6NOBHC2wfd751JKnUH
	 d0Kjd7EfKlyNNvTh+/jTdmDILRtHnUvHB+kx2DG6An2Ur3ojoxOKYJO/SfPXVw+ACDiHK
	 X5GZ/FE1+72oN3YSyQzc+aWliiaZvxsHKL0oUpc+hg2kkMaNZFR7EeACThSZBVdx9DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I7adaPWX;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126A606A32A
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 09:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D126A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I7adaPWX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795168201; x=1826704201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QZN+GI/cKWD7oRndxOBlg8n4/EuvL51GYtWOS2ppsH0=;
  b=I7adaPWX9QaW4itZH3OeSqQfyr/09zGzOnh4ppgPERpMkNhBt5ZXoLUK
   3lzYlCvO9/yjBQRjVH5hpbdQUbn7mgw504j61eoikYhz6Vhp3m5tIFtCY
   sjdrpNd1P2vz8ImjNlW0GeRj37LsyleH3XyZa8/mmKeoCrX4oQRezShCX
   fkUKxRWHWCGjVFcFVIqh4fVF3hqFhLILl0vmIG21V3TyKqIETKkcwUI5y
   VOq17Lqq89yldczhQnA8B7u4vGeO11BWE9CfkMGvPoPvnB1d1HoclTUuk
   lccJHAmGYBsZSjUbW4lum4Bko/H66eNz5YXICvcd5SFFZFDsdq8qmhLui
   A==;
X-CSE-ConnectionGUID: 2AfjvRbMQZONz8BHCSLLzA==
X-CSE-MsgGUID: xS3TajpmRuyTG6BfVTKl5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3891367"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3891367"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:50:00 -0800
X-CSE-ConnectionGUID: n+ua286pQJKxknluw5g2fQ==
X-CSE-MsgGUID: XxVMq9Q8S+O4+qVLEfmrIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="12656997"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:49:58 -0800
Date: Fri, 20 Nov 2026 11:49:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oscar Alejandro =?iso-8859-1?Q?S=E1nchez?= Lucero <aleszlucero@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcin Malagowski <mrc@bourne.st>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: abp060mg: Check for short I2C
 transfers
Message-ID: <awAXxOLjS97c4Bus@ashevche-desk.local>
References: <20261120-b4-abp060mg-fixes-v1-0-2baf026cde47@gmail.com>
 <20261120-b4-abp060mg-fixes-v1-2-2baf026cde47@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261120-b4-abp060mg-fixes-v1-2-2baf026cde47@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 01:11:38AM -0600, Oscar Alejandro Sánchez Lucero wrote:
> i2c_master_send() and i2c_master_recv() return the number of
> transferred bytes or a negative error code. If a short transfer occurs
> without a negative error, the driver currently proceeds to parse
> uninitialized stack data from buf.
> 
> Check that the returned byte count matches the requested length and
> return -EIO otherwise.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


