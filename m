Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793458271;
	b=2HGOjVAnt2cQ7Ii+RHk4lIKqjD7XkTJSp+6kvpT0F/7xTaH4iQxJRcNGBkrMifY1bkZZ
	 +mfZqriotq2SjDEmzzDJ968Q+CYnsKQikPIbvs8K1CHXqzOdSi+Jz20pKNOF3MPG+HDbD
	 FiFz1MF5WGS9rcNUZMqxtsav3Ezn5BFMwTNdtir+rj98JDHPQjhp2X0rxZehUFi8W3A+l
	 m9EEbBwnmxXdhflbsB9vHenIP7SSdVKPEgs99yFcNxBhCXrsCSmJtiGwDkGLB7kOXW3Lf
	 2raEPSiWMxqwVtFTtJZBmVlB4pjmH1N6CgeQe9ZTWumPeLwsBtMVWz1vjs1oaFP2dHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793458271;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=yX+Eb2hbcn1VGjIA9ugvOGDuJoIr7z5NQD3gBPv+gJE=;
	b=gYe2yWxCVDfknd2dAUVk7PG81ALfN/KxBOmxxs8B5j2jAKmEamJrJvnTS8zVPQCldSKD
	 fnVTd8/gOGJrKrH53nPHWYDHa44nMJifU69Q7dDBItOzG5q1lNNcc3lckXiJPwXYPTHOG
	 qhgKq1cLqtpbQS0IctZMBbJpgqsKoYEgHoXcVk5FsXU6edwVNAb/fxL88t+s9H0RKHAYh
	 2oRrtxdIkd2mCCnvukjMxIHy5AO7PAE7jFjtR5OrVWTawY1RzTQ9Ki5k4VfEEC+Q+uf/k
	 Xzn0ff7GglI3y7UVHAHWmAALP1U9tM9Q/gXTlLMxq/3iPTmR5+dnNrC5gYKV8Tedfsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WbqhGeKx;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ED2606A31A;
	Sat, 31 Oct 2026 14:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1ED2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WbqhGeKx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793458270; x=1824994270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GIFMjVskQIqlefjjExfal5xqxXFAr3WcxyIFbCNZQBY=;
  b=WbqhGeKxqdO4S6sC9tia8s755aCGTPygEPS/XiK/dnjEf07yo94tJNsV
   hEwdiduAQe0VsOnMVQJwS0gEHr7Er8F5ZkjZCY5WzZPsLUOIEC2wiSNf6
   sBx55FHYrVVAa78RzIRAJ5LM3aneOj+a0KRhz36lFFL0tvKL73ikKVXM4
   iB5Fk9m4Jhkn91TObrJjfdhfl566IAWWgqjYK4s6M9MKF9AhBSyfx13Bm
   7oWIgIQn8nS5qjQHw5oKaprCKGiSJnqMjjVM7nHoYjMsFzGhtvPx9VP73
   FfKPBxpikvQa7b3AiYfvvYyg3ZHNiZLlb4NK2rqFOktHXT1BbPBKhQh1A
   Q==;
X-CSE-ConnectionGUID: EqW6KsNMThGY9FWyR2G6Vg==
X-CSE-MsgGUID: fV+IRKBPQwWBTiT5pH2xVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2299026"
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="2299026"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 07:51:09 -0700
X-CSE-ConnectionGUID: QD58CKUZSmyLGT4iEOd+aQ==
X-CSE-MsgGUID: KuRn2edPTv+RlIDwxEcLMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="6012669"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 07:51:07 -0700
Date: Sat, 31 Oct 2026 16:51:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: vidhu.linux@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 3/3] iio: proximity: Add Benewake TF-Luna LiDAR driver
Message-ID: <auYAWEQNZyHwogV6@ashevche-desk.local>
References: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>
 <20261031-tf-luna-v2-3-ce403579bb8a@gmail.com>
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
In-Reply-To: <20261031-tf-luna-v2-3-ce403579bb8a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 31, 2026 at 12:23:30AM +0530, Vidhu Sarwal via B4 Relay wrote:
> 
> Add a driver for the Benewake TF-Luna, a single-point time-of-flight
> LiDAR distance sensor with a range of 0.2 m to 8 m, connected over I2C.
> 
> The sensor is run in trigger mode. Each read starts one measurement and
> waits for the timestamp register to change before reading the result.
> In continuous mode a read can catch the sensor in the middle of updating
> its result registers unless it is synchronised to the data ready output,
> which this driver does not use yet.
> 
> When the signal strength is too low the sensor reports a dummy distance
> of 0, so such readings, as well as overexposed ones, return -ENODATA
> instead of a distance.

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


