Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592631;
	b=DiwFV7Jw+6EsyUyb+s3wsorKtCr253WAlObDNzGdlbNbeF7meuIR6EMjWbhR3Rkz+Vmd
	 zZUuno0miZLUNnqh7FvDiZedHSw9CnIn/YVr6CCvYPrc2wFKXvHoR99a9ufmIbpCF13d9
	 MGydc+QHoS2iDlJL99a2CTRa4sN2debgofvfNosuAdeElEaGj5y+mEin8rTZxwYf3V5y4
	 YCWL4HBNK/iSRjr5XjBJJnGXxsQ3i0cVtalNO8SUu2mXXTH1AJjCdzX9DRb+KbWJfxUui
	 Wf46fVFAXxUb/YZXwbX2l7g1okaBPqfP4FLzeMY+yqEU6T8fawxKFv8EO7FtehApFIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592631;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jb+vfbNXloreD+xqRGxnuP44OgtQpnNM1Ty2GHb0qck=;
	b=UXPbowmNgFuGZUqjT75gtd+2666gvZS66ubCfgWDzIJq23fX7hbS/N5r9dWApqn/qK1a
	 pXoleOVHx1J0v49AOqEI7r2z36WjvcoPugZVXIlWalXTW1TnbcjkZBtkyLkIeDzgR/b+L
	 A0FRihe3NEwIAxmBOV36KT/DDTokPfTPL6svt2V9bQnJWuamOF2/1Qyi5yE5Wh3zthr2T
	 HD4XivCu4no/+XtG2L0xYK3S02xGQGeOIImUUId/yjnqG/a0rGlrUF1a8XAf1idopDlcf
	 TPQ2nGh2ZerW3N633CPds7JW/yUrDhmzzeMX4FSjMH5hTQdLkjXb1QY4Pydu0wSEAQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mO7N7i7i;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA59606A31A;
	Wed, 21 Oct 2026 14:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AA59606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mO7N7i7i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792592630; x=1824128630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ro1PYdze8Pv3Fy03q6iZknJsqp2OdbiERqciVNqzv0U=;
  b=mO7N7i7iQ8XD2/FX+FooogoBM/JIMDJMwOGRwd65t0JOBh1/shH86laC
   6bSbOg5xW+4IaIuZ9XYqD+GZDfCaqjGJILl5gok1GKjoXkj8wFtHwE/FY
   Gm7KSsaJCCrWuqbuVb1w0vkSjx9+CprMxP25xHJkG9ZJnkadJAFeMMVQq
   kWSMs2ZI9op1Hx/DqiMhfkmOCkFLRdZHuyV4HUqQdRPm2FPj4OS0lrBGX
   gqHBebgL6IEkft+0O6QVAq9blL3yYgyazNEfCyNduWnzWFX5za5et37wO
   MKTjotJHXmIoykekRywLmZx63h9GbWe+O67T45trIBeUCCHbNyzmZrDrz
   w==;
X-CSE-ConnectionGUID: oeYx7ampRFC040X2IWuxig==
X-CSE-MsgGUID: 8UMoTCNWSTih+B3sVWKeyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1336109"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1336109"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 07:23:49 -0700
X-CSE-ConnectionGUID: nT6wuyktTvO6IIrpOxM2Gw==
X-CSE-MsgGUID: izpanyToQMahVeI7+wlQdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3094082"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 07:23:47 -0700
Date: Wed, 21 Oct 2026 17:23:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations
 on mutex helpers
Message-ID: <atjK8DW-XLQ5gepC@ashevche-desk.local>
References: <20261021052435.112686-1-zoone.rupert@gmail.com>
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
In-Reply-To: <20261021052435.112686-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 08:24:35AM +0300, Rupesh Majhi wrote:
> Since commit 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse
> support"), __acquires() and __releases() only feed context analysis.
> Their argument is parsed before the function body, where only dev is in
> scope, so with analysis enabled for this file the build fails:
> 
>   error: use of undeclared identifier 'adc'
> 
> These helpers take and drop the lock for the ADC_TM driver, which only
> sees their declarations in the header. Naming the lock there would
> mean exposing struct adc5_chip, and with no annotation at all the
> analysis flags the unbalanced locking. Mark both __context_unsafe().
> 
> Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")

> Cc: Marco Elver <elver@google.com>
> Cc: Bart Van Assche <bvanassche@acm.org>

Move Cc list after the '---' line (similar to the changelog block below),
it will have the same effect on email headers, but won't pollute the commit
message.

> Assisted-by: LLM

As of today we killed that tag, drop it.

> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
> v2: explain __context_unsafe() in commit message (Andy)
> v1: https://lore.kernel.org/linux-iio/20261003214516.128573-1-zoone.rupert@gmail.com/
> 
> Found by building with CONTEXT_ANALYSIS_qcom-spmi-adc5-gen3.o=y, which the
> driver does not set today. Build tested only, no hardware here.


-- 
With Best Regards,
Andy Shevchenko


