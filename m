Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91E1EF39E;
	Mon, 13 Jul 2026 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783904705; cv=none; b=V3WMCTb6mKGNxzTKKgB0En1p+V1AOm+ivz9bdR7vxRuSCwKvQIWjBsAOeIh9K6ScMutt26CLNSWC5nuCHQll4D1dQq/mIMB29L1LAsaEA6lXcOh3DgLAuRlbvf/yiF01qdpQrpSFzUCZUIOPw+SauKDdoqVeGCuVBrVGiegYw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783904705; c=relaxed/simple;
	bh=WgukX1UPnsQgJpG2qB3spwiGdfRW+FIjEvBZUvyME8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxVtQ4ZXlSqVYRrDaKy2b69AZ0LY5nZZsn7uJCE9Sky+hZc7ufvcTV9/tHWvymGfOZjpgiTU/0ObB8Lf7fUO5NuLMljPTYOw+ZF36qFuXXd3HGvGQG8KSOwO6xszTuwqhcDlqFqKIOe8D3/wZG4RVzI3Tf13Ixe/G/DDJX2L8tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oU2c+llw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oU2c+llw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B5E1F000E9;
	Mon, 13 Jul 2026 01:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783904704;
	bh=5zg1qxigCsPbFFCR7I5H4EX71Kv1wpD7/t+I30aOc4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oU2c+llwFoADCu7l6wEP0Js4wzWYuSmjm6/Hj9UJ0IlcF3fEldwNwXV/KQPWh2IF6
	 VNH3865HFCz24LC86nO/zrpdTp0sU8o6Klxg1er+dVqHEUZxIPhSlixEfGFoSdK7MY
	 SXEscNk6RQTJUd6s+13BpI7gvqLZLeIvbGBuNHmH1bzL51KdkPHpPylGCIkaG/9VHY
	 Om66bSbVZeB7NeyIkPCjG77ZVDNW0PzQoNS3GhoBR9AtTXvy8Ao0uCRmtaEPhuJ+z8
	 MHON4ZRf6yzUHpyRnY23Wv2+rtMcz01meQAmnP6HyeMXR7KMTYiq6JQeUXYqZ2zVBg
	 /B9mjsJiwE+7Q==
Date: Mon, 13 Jul 2026 02:04:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: opt3001: split opt3001_get_processed()
 logic
Message-ID: <20260713020457.242e3f40@jic23-huawei>
In-Reply-To: <20260712183825.1f3dcf30@systembl0wer>
References: <20260712-opt3001-unwind-cleanup-v3-1-5fa336876b08@gmail.com>
	<alOdn0m3fbznqqDm@ashevche-desk.local>
	<20260712183825.1f3dcf30@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> 
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "failed to write register %02x\n",
> > > +			OPT3001_LOW_LIMIT);
> > > +		return ret;
> > >  	}
> > >  
> > > +	return 0;    
> > 
> > Also can be simply
> > 
> > 	return ret;
> > 
> > in both branches.  
> 
> Yeah, I agonized over this since I did the change you describe in a
> different patchset, and I was advised to do it the way as I did in
> this patch so that it's more readable (i.e. we know which path is
> the successful one). I'm really indifferent to either change and it
> doesn't cut that many lines.
> 

This one is a case that tends to split reviewers.  I don't personally
care much either way because as you say the code saving is minor (but
good) vs it is a tiny bit fiddlier to read.

So far as I'm concerned either is fine.  Andy asked though so go
with that :)

J

