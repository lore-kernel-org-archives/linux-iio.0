Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60353277C81;
	Wed, 22 Apr 2026 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887268; cv=none; b=eKHhdthFNxQJOLwbV2KZcN/Q0MdXrmLXso2vpuLJihpjXqlpK4LIlnLxBRSzJ2+1+BK7mBnaW/e5Vg5nh2PfyF6R+BXki4JMveQc8AqzNRks7M3m8ore0uaxDWj8sIAlmpSQ3q5146ctu+mkhfycz9wWLhWKzEXvERMs9auudb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887268; c=relaxed/simple;
	bh=T1ErwBoSslmu2BemlZ6/Zq2+X0CCFr1gocopok9tgFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr5RWaI4xeDdTlNXg/LIr1AvY9BgsJMAu2VSB403zj9qOy/UzeJdC6hgHmww9qmol08NHKoXeWM6bAS1X1OYhfQr6xFPb+RfiHb96TUXJ5y3uRZfQTpZsaDp8SL/vCBp4Gj/pvdPc2RBH/fRMnGyekvUEmobvq97L7KurpERmEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMuEH6z8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMuEH6z8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776887266; x=1808423266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=T1ErwBoSslmu2BemlZ6/Zq2+X0CCFr1gocopok9tgFc=;
  b=OMuEH6z8xoHbnJaWfuAvzqfFyp2upM1w3cgmqTf/ccd/vZUzBByK6HQC
   pBSrYQlk+ONC17YG7Vd/PNzJt4Co+Xb8TZ/PNYYq56jYwI44NOUFdIG64
   DmoI4k8CWE5AaEckTOCudM+P/UL25MiSNth5FN09r0/D9pgn39mXz/OJc
   AgDkcxKJ8opIauqyMitwuemflI/eTQjnTGN4g1RhvPXI1azF4vPF1MLlf
   QfyDakFJ8ZJ2VUsA2+Dp4vUWa2mvLPgxEnRCFaTvHSluLoAzu3IXn3M7r
   3f6FC3qrtMPf6zhgLC7oTVFrKiDPA8T3ItzchXf4S9REMBdUkU33uY2qY
   Q==;
X-CSE-ConnectionGUID: JDT+nlhDTu6RLZ+xp1NvGQ==
X-CSE-MsgGUID: lTIHowHUQ3moehuVDxCAiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77913381"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77913381"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:47:44 -0700
X-CSE-ConnectionGUID: v/KpHql8TiOoe/Sc42lV7g==
X-CSE-MsgGUID: 0FJaHPFVS4mHhoLw34Ip1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="234232180"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:47:36 -0700
Date: Wed, 22 Apr 2026 22:47:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Auchter <michael.auchter@ni.com>,
	linux-hardening@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 08/22] iio: dac: ad5686: remove redundant register
 definition
Message-ID: <aekl1dJ1mwkLIy8L@ashevche-desk.local>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-8-ed7dca001d1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422-ad5313r-iio-support-v1-8-ed7dca001d1b@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 03:45:42PM +0100, Rodrigo Alencar via B4 Relay wrote:

> AD5683_REGMAP and AD5693_REGMAP behave the same way in the common code,
> and that is because they target single channel devices from the same
> sub-family. There is no reason to separate them and it will make things
> simpler when refactoring the chip info table.

Not sure about naming, but LGTM, especially line that removed the trailing
entry without comma — kills two birds with one stone.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


