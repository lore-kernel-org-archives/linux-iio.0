Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083176;
	b=ZF6USQmOLmgseXFBrUOarCQSzdrtWrLoJVHAUvv769LP/FuiNn/ZifBgtZIZ/yxv9AC9
	 ra6E9cReanXEKDu53meCJahvMHV3oC68cjVgYusXiRQaBCKpaO85OtJdR4kEiXYE2/9Qj
	 ZPZOK89Lqaff24cWGz/3e+2GmqbgQ7aYEpnojNYYbCYumTIYADbpkAPgNNP4IL0gaVD4D
	 z8ryfAFvI8XMbrVLz0yXSNWsaDqPcU2doqmquOJi8vMXptKncUpNNxA1sAWW5bJoa0wum
	 PpNAaJmGyAeOFPVEoBEanUovQgV3DheYB+IpYfgw54TuI+8aJnzxeW2m8g/B5lw8tHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083176;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=uRejSTPMCiGO4GXGk6v+xmi75k8q/RPmj6yZZ2pttAI=;
	b=Xp8kD0XzEVEnQxnPl7lFP3XoiJfwfUQ/hUbrUX/LkE1USG6g7OD/rsAAvbq64uXai4sp
	 nVurDfkhmhJIuUeT/s6DEs8tNT3Obt6rklgfujJ1FHhNW1lxgpfmu3F66W3uX0B7d1vCc
	 UrymKG354L+gwx9FjUHAxxFhRb6yGDHU3lCs7Qlpup19elk2A+CAe0nFKIXvB/zp35b4z
	 DMwizVWBemJ9PjJ3WWwjqO8U+MAo9hPzb0cKFo38/HabCKYcwtxfIiWdaHy2XzVfxjUtJ
	 NfeGxBtR0NBELr6sl7Foo6TLdqWjBEJY+ewJ3bsvkY/nltkom34wpSSqojE3FRmnRzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X1hdxtCc;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1088606A320;
	Thu, 19 Nov 2026 10:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1088606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X1hdxtCc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795083176; x=1826619176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QzxDvuGhfotlufT5Ecy6t1DogxdV0pauonxQV5H0upk=;
  b=X1hdxtCcgVvYBMPh06+5IhsJCXhirC7/HC3wK1g+QcSFWqvKZ0FAejn3
   1jlZR7m2uZOJo7VB4Q7GAdakp/OIaPBMB9rsQz1LFarh6avV0odVhBatD
   Rq4ORvrrQPbLCTQGEu4uSU9MSWixyuQ0Tt5Xfo5jg9XcF+ZzOCwdaDDCZ
   l9zEMTbSJFC6z1TfiGDxtrQJ/CutgMsV3zir9QOvDMZtf9z7xUYGL9xwn
   QTOwyrhv3vCo3ZsigWlCYEWNAyHttGAwc4kMa/DWiJyV5FQvYN96xQp2D
   EN0GiYffrbkUgQtUPsEi+tXIo95Isk71qrUE6WisqlsvDg/tLUkVC5Tq3
   Q==;
X-CSE-ConnectionGUID: +/JrBcFKRceYDXRTAU5CAw==
X-CSE-MsgGUID: sBg7+KAiSF6vfwT5VoE05w==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3845484"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3845484"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 02:12:55 -0800
X-CSE-ConnectionGUID: 7rPDtEvLRXalydjflGoIng==
X-CSE-MsgGUID: PpF1xTr3RxenJWquZHZAWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10773836"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 02:12:52 -0800
Date: Thu, 19 Nov 2026 12:12:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siqi Chen <chensiqi@uniontech.com>
Cc: nish.malpani25@gmail.com, jic23@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, linux-iio@vger.kernel.org, linux@analog.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: adxrs290: propagate chip ID read errors
Message-ID: <av7LotsnpvN7lMAF@ashevche-desk.local>
References: <20261119030709.3792433-1-chensiqi@uniontech.com>
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
In-Reply-To: <20261119030709.3792433-1-chensiqi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 11:07:09AM +0800, Siqi Chen wrote:
> spi_w8r8() returns either an unsigned 8-bit value or a negative error.
> The probe function stores its return value in a u8, truncating errors and
> treating them as unexpected chip IDs. Consequently, an SPI transfer failure
> is reported as -ENODEV instead of the actual error.
> 
> Store each result in an int and return negative errors before validating
> the chip IDs.

Starting from here the rest of the commit message should be moved to the
comment block (after '---' line).

> OpenCode was used to identify the issue and draft the code and changelog.
> 
> Compile-tested with CONFIG_ADXRS290=m using:
> 
>   make O=/tmp/opencode/linux-build-adxrs290 W=1 \
>        drivers/iio/gyro/adxrs290.o
> 
> No hardware or SPI fault-injection testing was performed.

...

Code wise seems good to me.

-- 
With Best Regards,
Andy Shevchenko


