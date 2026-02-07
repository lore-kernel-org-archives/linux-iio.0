Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5051C33554C;
	Sat,  7 Feb 2026 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770479649; cv=none; b=H0l2XyJ8n+jMqIwFX9ac43WRiu6D4XXdNNLEam0kduIiW46+Rs7ZFWmui5yl3j9jKMN5hlKk8KeuhnOevfs2zfHsBVS9LLk7mAIyrY1b+XmVmuXwZd/6ZOTww9scfOmkzD9xCRd73rIaRKeNT52RMO002lHo15bKMAnuByTovN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770479649; c=relaxed/simple;
	bh=3Azq+Zp7/UoKc6Px2+hJKASgRkwUdIHCKXzBbjAtD9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPYpvzrnSwg3KfF+p138ecNeKal9qSWycjV6TjECd5MejhPC4iXpo7xdJWU8NZ1Z86IY77r1ZPz2ikFpa4nVf0oUSvCz9hCfRdYTuRINZ2o1FUgT5UNc4ilsF9oauOzgFftMJ3p6vp+gau2AUZ902xEFgiyRuUlkbLn0qOwCK/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaHKfCHw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaHKfCHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA3EC116D0;
	Sat,  7 Feb 2026 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770479648;
	bh=3Azq+Zp7/UoKc6Px2+hJKASgRkwUdIHCKXzBbjAtD9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aaHKfCHwzu1CctyCTglne61iHObCZ+V7JOsQM8fsT7jHpF+FAZPxQEemQ79iP65nB
	 ZoDcGq5ROSXViuolo4lLATSqc8vyI7qz4SxdI1cd+KuZ1Y7Hzain4pGKkoXk1vBeh0
	 lzeB+ue/v+Fg9E6G7JpJAcuchq67EEg6EzH4Z1T8i6OZHBBnkRKg20ozfPBKrOwe7a
	 mp1FrILSPBLsMKG5lNzlPJ8Ni5I+nMRGNQarq0PKhrIDI1+I5kAflwt7RnonKm4Sg2
	 Q0NzFo4Gpx6pQXtMhSDuF7OshfO19jJE4oc0O4EJAd6l9ZGT42zMhJ7WzALH4hvUvg
	 fgXf3Ac/+UBZA==
Date: Sat, 7 Feb 2026 15:54:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Waqar Hameed <waqar.hameed@axis.com>,
 chuguangqing <chuguangqing@inspur.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: ltr501: return proper error code from
 ltr501_get_gain_index()
Message-ID: <20260207155400.049906f0@jic23-huawei>
In-Reply-To: <aYGxa1E9WnYLXlet@smile.fi.intel.com>
References: <20260202120715.25625-1-antoniu.miclaus@analog.com>
	<aYGxa1E9WnYLXlet@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Feb 2026 10:27:23 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Feb 02, 2026 at 02:07:12PM +0200, Antoniu Miclaus wrote:
> > Return -EINVAL instead of -1 when no matching gain value is found
> > in the gain table. Update the callers to propagate this error directly
> > rather than overwriting it with -EINVAL.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> > static int ltr501_get_gain_index(const struct ltr501_gain *gain, int size,  
> 
> >  		if (val == gain[i].scale && val2 == gain[i].uscale)
> >  			return i;
> >  
> > -	return -1;
> > +	return -EINVAL;  
> 
> I would use -ENOENT, but I'm not sure if there is any ABI involved (id est we
> return this to user space).
It will surface.  Not sure anyone would notice the change, but lets
keep things simple.

Applied.

Jonathan

> 
> >  }  
> 
> 

