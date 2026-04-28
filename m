Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4FA42982A;
	Tue, 28 Apr 2026 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391977; cv=none; b=RG+s7OdeifZoAOsjNnrCB+DI0xKt42IbcwT9gQy0pnOQi8chqXQKSJ6nBXTQrv/CwH09gwgidHKr91uQB6CdP/SLV7SlRuzAKT+bux39ec24mGQoWBxEpByjml63Rw4Xkx1pJHaEDpMolP689ms4ljKGzh+hI07JEXMWcWGu1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391977; c=relaxed/simple;
	bh=GQGZE9oSf2JM07Cg5Yr91218pEvfwdCnN6pb1NLp/KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLsare2K/MJihTd1nveUUhJvWMUSeZS6TfCP/DQ7x6azbcZf75Q8GDhVHnkYvtHB1LX6vEvDKDv8Ax4zAwGsg9N4IN5VNWWq4GnOkLbZvdp1e0X1196h8avXa7sSgNqLjzZFZxvETtZOqsnrhQXfI8K8bl7TQ6Ik8YUVKzd7NVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlJ7BWO+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlJ7BWO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777391976; x=1808927976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GQGZE9oSf2JM07Cg5Yr91218pEvfwdCnN6pb1NLp/KY=;
  b=HlJ7BWO+BLqskx135qy9KXPdXYpdbD1HEcLVRW4FXcuNoPDn/zN+B0Wh
   vymWwZqR2aobjmhFCRctddxYbHIt0JXXNJ9HbwrOJ33s2hoNHB0+mgkjl
   BJOnuIs+4MjPisMmJYTQYUdUCcsbAvkzzyMDDNYH92vfIiWADyjPcomvm
   9Gb9vg9JzsJT45rXpo9iQ3aOQXTrn6cWjjuva5p3mCXwvNGqdi5xNHC9N
   2EGShwW0Oet9jBsb/IVi8qUtJo3Yc4n381x76rgVmGPkF7LncCgxZvu1K
   lXFLXrqdpvrIzyEeFfbcqsR8jdElONY7b+lHUvbWzMItyTdQ9xigX4fkd
   w==;
X-CSE-ConnectionGUID: /wMj2J5MQ76AacYHXU6ffA==
X-CSE-MsgGUID: kv1sXZYJS4KFGDExMdCJjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78196466"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78196466"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 08:59:34 -0700
X-CSE-ConnectionGUID: FTkWsHSEQAWOwO8I++qXiQ==
X-CSE-MsgGUID: dvkXVD/mRpuVS0Z7u+UJ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="234288783"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 08:59:31 -0700
Date: Tue, 28 Apr 2026 18:59:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hw-consumer: fix use-after-free in error
 path
Message-ID: <afDZYNprYaQzcfpf@ashevche-desk.local>
References: <20260428-iio-buf-v1-1-dcc63ff7b800@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-iio-buf-v1-1-dcc63ff7b800@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 10:53:25PM +0800, Felix Gu wrote:
> In the err_put_buffers cleanup path of iio_hw_consumer_alloc(), the code
> was using list_for_each_entry() to iterate through buffers while calling
> iio_buffer_put() which can free the current buffer if refcount drops to 0.
> The list_for_each_entry() loop macro then evaluates buf->head.next to
> continue iteration, accessing the freed buffer.
> 
> Fix this by using list_for_each_entry_safe().
> 
> Closes:https://sashiko.dev/#/patchset/20260427-iio_buf-v1-1-2bbdac844647%40gmail.com

Format is wrong, missing space.

> 

Tag block should have no blank lines.

> Fixes: 48b66f8f936f ("iio: Add hardware consumer buffer support")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

I am also wondering should we put Reported-by with the reference to AI somehow?
Jonathan, others, what are your opinions?

...

> -	struct hw_consumer_buffer *buf;
> +	struct hw_consumer_buffer *buf, *n;

Please, name it rather *tmp.

>  {

-- 
With Best Regards,
Andy Shevchenko


