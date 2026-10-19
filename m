Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F44B0497;
	Mon, 19 Oct 2026 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402083; cv=none; b=tVttScdsUvACBOOn5MleGZeNCYqpg+3JApqdb9LUCpjPQ6/Wa6hxVuqk0UGHEhP7FroCWTO3vD6jYJ4tnsQNNMvABI1KT6GOMijPdkPM96O+MLbEj1lXwi9+e9mxiHktu9aaHrbNsrrJepKC4+XCvTVo3zTIPTZjfWRG+Ach8jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402083; c=relaxed/simple;
	bh=FT2BvoPD9fAs7fpPojAPc1d8v3+R+Zbu2F90ejDOIBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF+8CqDxux+4YJjnau5uo+NS/Jikbi/wJWGIT/UNQao48w+hb7riwwzNjmJYm8N+XijWe0HRcK1pn5s+DJ08ERQveVWrzY+35tIFmCSnfQGzybBKsbJS2RquIpJYo94rHJfcK9QATPh9kys71IUx75a/KpHGVnbB1YobLF2yQmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZG7si66W; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZG7si66W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792402082; x=1823938082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FT2BvoPD9fAs7fpPojAPc1d8v3+R+Zbu2F90ejDOIBQ=;
  b=ZG7si66WWZhbIcdAXbAq91Lm3hdJx9sc/yjhnpEgs5NtwPopSBDfaZZC
   HDC4rWfcVH5EQNa8yiEUBAVHcKJS5pUG+PSXyYObxszPm3DlHi8coBmr1
   KuUqEJ1kJ1LR0DMu9cdX4pftxKBfIpXmnDwvnDlRQ9VgaipXDhZjHcYhP
   yQLjP29p+BzAKqCL0+Iauqnr0UTfHkOBEqrE4WbEuRLl8W75PkG6gfLDn
   XmsaqblsBWwbtDovzJFzfKuWpAcsbPQYmTt1ih3stN9PwQ5cq+vL0vMJs
   DgQt3D6wsSNq6+ktwcbF8UN5q/lhlUnQdR2IjddAMDG8P7hBFJkm/mkRJ
   Q==;
X-CSE-ConnectionGUID: xRA5XD7cQKSEIiCWU8Up1g==
X-CSE-MsgGUID: OSiZudWWSl6JIxHktzyKTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1079905"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1079905"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:28:02 -0700
X-CSE-ConnectionGUID: Lk+cIUgnRMqjuXXoPa8qpA==
X-CSE-MsgGUID: Mibb4sQmTOObBdj9Mye4tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2891169"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:27:59 -0700
Date: Mon, 19 Oct 2026 12:27:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Melih Emik <melihemik@noirlang.tr>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux@analog.com
Subject: Re: [PATCH v2] staging: iio: frequency: ad9832: use guard(mutex)
Message-ID: <atXinPbnApcQLekk@ashevche-desk.local>
References: <20261018110107.297906-1-melihemik@noirlang.tr>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018110107.297906-1-melihemik@noirlang.tr>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 18, 2026 at 02:01:07PM +0300, Melih Emik wrote:
> In ad9832_write(), manual mutex handling via mutex_lock() and
> mutex_unlock() necessitates error-exit trampolines (goto error_ret),
> intermediate variables, and deferred returns. This pattern is prone
> to unlock-omission bugs during refactoring and clutters the control
> flow.
> 
> Modernize the locking by using guard(mutex) from <linux/cleanup.h>.
> Scope-based resource management automatically releases the lock upon
> exiting the lexical scope, which enables immediate error propagation
> at call sites, removes the error_ret label, and simplifies the control
> flow across all switch cases.

...

>  	case AD9832_FREQ_SYM:
>  		if (val == 1 || val == 0) {
>  			st->ctrl_fp &= ~AD9832_FREQ;
>  			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
>  		} else {
> -			ret = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}

'else' is now redundant:

		if (val != 1 && val != 0)
			return -EINVAL;

>  		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
>  						  st->ctrl_fp);
>  		ret = spi_sync(st->spi, &st->msg);
> +		if (ret)
> +			return ret;
> +
>  		break;

-- 
With Best Regards,
Andy Shevchenko


