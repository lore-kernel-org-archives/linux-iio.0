Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94DE34EF05;
	Mon, 23 Feb 2026 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848050; cv=none; b=joD7WfKL+O3D4p0dtuXoW6hTsthOx1sikOssacLujx5Ie54+vOg1xSZnoCVDxxnvOTU7xpw6Ti5nkNyPvC4HN/8/kLlW6Wn3Ksbqiwt6VkFAXc5dAVCM0Owaf0pMyqUxYX7y6ZOfVVe6qIG901HEx1ULFhyjAwbaQ6Y+9pPRUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848050; c=relaxed/simple;
	bh=I2sIivrsXWQnUYO0g4r5QHk8BYlrjTXCGMh5WoQzjk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkqFzWbtU9elrpRh+IhOCxQX5Pr8uxkZxUmtOrzFrQE0M/Sdc0Rq8T7WqtxrZ10NofbLjObRuTyByJ1U8MsY45h1i2GiCikvyS9LI9TOnJcVjVVQWV6Os0fdfE27WiZwwHEjaZPXZ5hfsBfvvV9X9Xai4FEXP0v7KwVrxRtu7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8vugKSB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8vugKSB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771848049; x=1803384049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I2sIivrsXWQnUYO0g4r5QHk8BYlrjTXCGMh5WoQzjk4=;
  b=R8vugKSBSNKQtxmHQSTw5tsEp2DtwFp6tyfKqJK2RZ5U5/6xM2JXR4DJ
   qjckrr+kqPc9insXZbZicd/shIpzqjry9O00cqRaVDRvxALUi7pxghz/D
   sewSETZjMljkWMDI6TJDwk9ZxWnpOY3TQuVqGJmlcwWkvoY1YXAuS6NN9
   w7C4c87RtkngELap1wqOnSMNrT1PD7v8vlPM4yeRJIg0jLqazS2Msu11Y
   2PESObqYF5eiXpAvifkra+GAI0aDF6zvPi4Ib9W8dNc/6T6S3afDBtqvA
   cj3y+OBQo+YkKoBWFEXdkYcep8CUL4EHsVYQIMNl6Cxb8ZxRFrajQQzP5
   g==;
X-CSE-ConnectionGUID: fQC5SrRTSeqvQDI7Kqe+QA==
X-CSE-MsgGUID: C6fybr1iSROiHBSuVr0Zew==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="75449205"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="75449205"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 04:00:48 -0800
X-CSE-ConnectionGUID: 4CoHZkcgT/KS85lQCYcKIg==
X-CSE-MsgGUID: HLiKATdTR7Sgi2ckULr8Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="214773617"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 04:00:46 -0800
Date: Mon, 23 Feb 2026 14:00:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/10] iio: light: gp2ap020a00f: Return directly from
 the switch cases
Message-ID: <aZxBaxO_dbPynSzi@smile.fi.intel.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
 <20260223034020.27625-5-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223034020.27625-5-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 22, 2026 at 09:40:14PM -0600, Ethan Tidmore wrote:

> Return directly from the switch cases which makes code easier to follow.
> In some cases convert pieces to the standard pattern which also unifies
> it with the accepted kernel practices.

...

> static int gp2ap020a00f_exec_cmd(struct gp2ap020a00f_data *data,
>  					GP2AP020A00F_OPMODE_SHUTDOWN);

>  		if (err < 0)
>  			return err;
> -		err =  gp2ap020a00f_write_event_threshold(data,
> +		return gp2ap020a00f_write_event_threshold(data,
>  					GP2AP020A00F_THRESH_PL, false);
> -		break;
>  	}

> -	return err;
> +	return 0;

I would make it also to be a 'default' case. But the driver uses different
styles anyway and I can't easily find a common denominator, so it's fine to
have it like this.

-- 
With Best Regards,
Andy Shevchenko


