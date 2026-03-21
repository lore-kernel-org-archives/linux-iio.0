Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922929BDBF;
	Sat, 21 Mar 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774120966; cv=none; b=C0NnKoe2MhzEkTisd2ETuxFzY+Fwnm4jY0BAIFoWhaFwTBb5gYvDCc97WVssFyVS4zf4VzgTZKDW3qGSE/wF6BUS1eeowaNJBa9QIDhPOG3j4l4NIOMfVeFxm7rVmWSRQFuYz12AQIkIGOzr6/siRW/eP8kHuYh7iDjYhwWVvZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774120966; c=relaxed/simple;
	bh=e7VAalkhOLnFKgoU+NXYRE948Y4LrUHN4uORvxOWnzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPt8W9ufxybdrf6EwjhzXtiRWvHZBQAZh8SVS1nG2pcHWVtuBb+ZQ9MYiy0r2YtBT/A2RiGVxskBQr25xkIJWUQB/5Q1MniGQ3r0kMqsG8+j4sv1dvm8VUsJHULLnkLE+9CPrOFb7iuZGzlXeccq/lDsbL/wlBR3XNjDa7h5iis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ1Yddmb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ1Yddmb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA60C19421;
	Sat, 21 Mar 2026 19:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774120966;
	bh=e7VAalkhOLnFKgoU+NXYRE948Y4LrUHN4uORvxOWnzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QZ1YddmbymqtuAyWfko/yaP+ACEDw7TmC/6CoXohWoEZljtLLv9UjFz/bIwKGLew2
	 npQ+9bOrrSPKmoWmzm6zVr8GzP6/5B8ZrVx8xOj4rW3r/aqAsKWeUCecrirhK8FXA1
	 WGoaeBwyYmSD1WUDfY/dNSssuqQv9coRdH7vw9Z4cMPESxi5H6jb6ybL0JFl9ARWQ0
	 By42yYtD3YcQ7M3+4JTg8M9X2+ojvpa766DbGasukzgz9bLtGlq8JP/bKLL25XjWuw
	 XIvSPfIVuNZuqzFboT9cW7kAPsFNdveuvMF6ReDCkcMNR3xY/QoQzE0frlopnhP/YI
	 /0URkthqAoBuQ==
Date: Sat, 21 Mar 2026 19:22:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Shi Hao <i.shihao.999@gmail.com>, andy@kernel.org,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 08/14] iio: resolver: fix typo from degredation to
 degradation
Message-ID: <20260321192237.1863e3bd@jic23-huawei>
In-Reply-To: <abguXZJjIXMdqcU5@ashevche-desk.local>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
	<20260316090023.14691-9-i.shihao.999@gmail.com>
	<abgt1yoYTnQEiAlk@ashevche-desk.local>
	<abguXZJjIXMdqcU5@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 18:22:53 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Mar 16, 2026 at 06:20:44PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 16, 2026 at 02:30:16PM +0530, Shi Hao wrote:  
> > > Fix incorrect spelling from degredation to degradation.  
> 
> ...
> 
> > > 		/* Sine/cosine DOS overrange fault.*/  
> > 
> > Side note: missing space after period. If this is a single issu in the entire
> > folder, fix it here.  
> 
> No need to resend just for this. Let Jonathan decide what to do with it.
There were two of them in this file.  I fixed those up whilst applying
and tweaked the message to mention them.

May well be others so that might be a useful follow up cleanup!

Applied.

Thanks

Jonathan

> 
> ...
> 
> > > -		/* Degredation of signal overrange threshold. */
> > > +		/* Degradation of signal overrange threshold. */  
> > 
> > 
> > (Left for the sake of context.)  
> 

