Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119132;
	b=McHeSRrHo0ozwahwWs4xY6YBnvpJ/V/RpoyuZT4lsyrvFiMSRvCgljvGM/nhOsyTsN2t
	 zz67lEcpDRyIwhOJaCNDgN8004YsNIhe8WdUjvMzhY1Poo2MEoUGanKhN4XUaVPF6fyQw
	 7P4HkPMnknPcchNnTMA6244s1lLgSQQN33maEgPHebHbZTZrKJt5DjEiCzX+XVcNBxX4K
	 WiHEZGul3DNr9jRWvQKQcOJPDA9EKP6Tn9J6A0WbwNoX+MlMWmn0fF3OWrYNFIHuwpa8Z
	 kmXuHr4jGanNbfFqruFP+FLEovQWT9l1osXLqsH1a+jROWgPZgvunen9D1U04t01jwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119132;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jzQIrHj1G3jqd9bBRBis5tbjb1WQm8J6Y3klssZvro8=;
	b=Wb0Nm71Di/rg+m5mpV6G+aRob851/JrhKwPFWCcP0alMmxYK3FVcspPSn+LTgPbeQ6Zc
	 7RmtP7bIQ1end+EtnBRCYqsrXAOqQVHsVgryS5gYwIVA/vOXyVQG+4AA97YjE/16oUJQb
	 dp1LBdHphumxwgZCYUYYH+n7XPJaBjnBezGfU8Kt+jud0KLMV/01X1lBw0fDoHQ3VmT/w
	 mMR3p4GyRQ8Pw8mcZsTlQ4IiM/uy0ZovWwJtu/ObsrnN5t1tMniOBl0wA8uRSABg6TwD3
	 Kes8w2ObSwR80ZU1+Ky/Ejg3plc9U1mGvowfK7PYt0o+4FnLBlABxl1PZ/O282qRMjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FJptNceO;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09B606A33A;
	Tue, 27 Oct 2026 16:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D09B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FJptNceO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793119131; x=1824655131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g7sCcEq9TtkRENM74OMlQpEMBF7EghIKUaErVVdl0/A=;
  b=FJptNceOg17mH2GVD7E6jVif28pwm2cqbtOSWeVI8dOwRNMNw6sJmS21
   ElDkknPrLsu02hFQalvEnblpZ8BXHGTEnpO162soWJgvV+/+pbW+cWvXV
   jdlUy3W5o1u65O7CIIA56qSgE1vqP5cE9a6otR/rMAeO+JNbOQGi/bmcw
   bcwjH3UPTv6dyPSFDteS4QiuuAJ5ptpGvhRk4WguAjZnALx65uVeEHGe5
   lYz6YYARO7yAANdGb3a+kKVGOMWLQek8xPpcFD44/S7sy8W/wsgJp0C3l
   FpMdwsgOXlFOqZEArirlXVs5xCtb6N4QO8xZm+32GB98Z16e9+eTlqg42
   Q==;
X-CSE-ConnectionGUID: zEKvnRv4QQyljr1aqoA6dg==
X-CSE-MsgGUID: 6fcbdiQ8S8q5EcUtEm/pNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1932840"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1932840"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:38:51 -0700
X-CSE-ConnectionGUID: QtfpyYSLRR2JufCpp/i02g==
X-CSE-MsgGUID: /luXp7qeSzqCWNw1UdhRMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4960354"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:38:48 -0700
Date: Tue, 27 Oct 2026 18:38:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	stable <stable@kernel.org>, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Siratul Islam <email@sirat.me>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 15/15] iio: sx9310: use the data of the I2C table
Message-ID: <auDTlTzfivw461zZ@ashevche-desk.local>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
 <20261027-llm-char-misc-iio-v1-15-0d818334f6c7@linuxfoundation.org>
 <TY3PR01MB113467B6593E80D2C10C0152286602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY3PR01MB113467B6593E80D2C10C0152286602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 04:25:30PM +0000, Biju Das wrote:
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: 27 October 2026 16:19
> > 
> > sx9310_check_whoami() takes the chip information from device_get_match_data(), which only looks at the OF
> > and ACPI tables, and dereferences it. For a client which was bound through the i2c_device_id table, for
> > instance one created with
> 
> Not sure we can extend device_get_match_data() to cover this use case?

It will be layering violation. device_get_match_data() has no clue what i2c or
spi or whatever bus is. So, the answer is definitely "no". (Technically, of
course, it's doable, but see above.)

-- 
With Best Regards,
Andy Shevchenko


