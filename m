Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910908;
	b=khQUVSgn7Ht7bcvBheVvw//yEzo8On2fTRHxzUgg2hkjl/fiVZ3BIMUrts00x89IV2dP
	 e3ju0XILn1l0gPT2M+b0q7mzy6Ewk4mF3mU5pTuYaJg5vr6B+CsjRJXxjQFQNJ3Ibl1rP
	 rUlkeiI7xhb++Bj0jo22gfws2idluKzXt7j7YqUYcBwuGBHc06oJzoHJNUX0hVtONlLki
	 d9nK4Y7OXnim1QZpxFRT8cGOmIre36ccsmbWnu1u3CbwxP95jT2sleEGPJ+6FZctI54fO
	 8HQUphaERDJ6aHv8Ik3ES55Sm16NN7r1JEBoLx2o1SGbyYOcvcOzjgZJBY7xlfEQ7zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910908;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=EaOV9WO5qtb2YHPP46vOg4EtZLM1r5qyyr6pytop72I=;
	b=pqsWoe+d1G2nnA/9VtEmO4IuOPvb1hFPYZQxgyrtztJQPGFoBhLEZ46dNbDq+n+tS4EW
	 BzXet7LdXX1G3UYAXXNyJri2rZTjaVA+J9RbaQZ41LJzPVRT68prwUcoIduWkQHCB4zD6
	 KiqK2DBA8XeXxRIq2epY4Lr6N5EhtMbPmYv0udXyToctU3ZpIxq8/rsOZnxv/xaoIxFA/
	 MZuk+CUBNgHBVAfhCqMewHgRQ7NSVH2dI48hoFRjeVqJ4axq7yQYhBRAKi2veZJREHFy8
	 dMsupYM7sm5lVEb289aKEydhhy2AVim0QuE4HkjTHUdACpKot20Yh2erz+Ik8ZkpkXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fzJq5mfD;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1B5606A32C;
	Tue, 17 Nov 2026 10:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A1B5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fzJq5mfD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794910907; x=1826446907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+uTMWuT6D/iKk+Oboc3PMt2EYstxhtXrE3u2XNyl6zs=;
  b=fzJq5mfDzvcx0XPYdaVQcMArEmJD3EynavIRP849FuxOpmP5Jci5nFHm
   W9+fMlK6y0KSL/0gOzsHnlEM9EmFMvLilLx5gHR5mAj4SjyMNZyAwd3RW
   8h2an1MyC2uj/MZeNB3Eeo1tYED6jTp/bn3y55/z/JivWLO5E0V977Z2m
   yUCIf9gFsrgS8nJVfTiP9P4OhcBYdp4t5XUPnbUtcZRKOFbMtNn9lf55H
   9fBLNFnCiXz+dCaCkm2XBBscYKRDfix4+AFg2fTRLuHfFlCMAZ6kzbCnN
   gBciuEIx7e1AFJuboAD3aFmLghThIaGCeac8TsqyXr461oxpTH9EGmh8C
   g==;
X-CSE-ConnectionGUID: +sOr7SvHS/mj/u3j4bSScQ==
X-CSE-MsgGUID: M9uhb7rZRqe4k577HdREBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3668145"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3668145"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 02:21:46 -0800
X-CSE-ConnectionGUID: LrMiaeS3SLixjVVL2Vw09w==
X-CSE-MsgGUID: BrXfmnB9StKvEQZHkNoaNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9754083"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 02:21:44 -0800
Date: Tue, 17 Nov 2026 12:21:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: bh1745: fix 16-bit register accesses
Message-ID: <avwqtvhrxmgLe8np@ashevche-desk.local>
References: <20261116194214.45174-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261116194214.45174-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 01:12:10AM +0530, Arnav Kapoor wrote:
> The 16-bit colour data and threshold registers are little-endian
> LSB/MSB pairs, but the driver accesses them through regmap_bulk_read()
> and regmap_bulk_write() with an int or u16 buffer and no byte-order
> conversion:
> 
> - bh1745_read_raw() reads 2 bytes into an uninitialised int, so the
>   upper 16 bits returned to user space are stack contents.
> - bh1745_read_thresh() reads 2 bytes straight into *val, which the IIO
>   core leaves uninitialised, with the same result for the event
>   threshold attributes.
> - bh1745_write_thresh() writes the first 2 bytes of an int, which are
>   the upper (zero) bytes on big-endian.

> - bh1745_trigger_handler() stores the raw bytes in a u16 although the
>   scan type is IIO_CPU.

I didn't get this, what's the problem here?

> Use an __le16 buffer for all of them and convert with le16_to_cpu() /
> cpu_to_le16().

Otherwise seems legit to me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

And you also need to add

asm/byteorder.h.

-- 
With Best Regards,
Andy Shevchenko


