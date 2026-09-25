Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCFD38D407;
	Fri, 25 Sep 2026 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790306894; cv=none; b=Y8NNrw+ibiuAXHVPJNlW2M3yv4qUGi/VlcoXsdZagCwMyPKiNeTXxCQwQzV2TmZmhjQYEHXgqcU5AgfEPuVQu4G02bkHPWQjaUzwdO+Fd5AlhXz2RpcleoKJr07cz8YZoft4ZHbta0Ls9Eki2DvWJ23guIbCOCPwuWbbfKFKx+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790306894; c=relaxed/simple;
	bh=ntsxCWg57E9sur+lf4IWnwAio4v//AuC6DM1pkmWLr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyDdSjiu1YOXj/unXnZqCsUqHRLqHXbCyKnqgwyhYEUcbW0V9eVK6qsBg6CKar/WA8UdkDvKeqnKHiCeuxbBIYk9P5+FNtWitmBn2jL9v+n1oSY9SThOv1wWfNITx1sL//3vN3hAMueBDMBD8AALxHZMo8KRXt7J5mSNfxU5tlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0/ed/T/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0/ed/T/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAE21F000FF;
	Fri, 25 Sep 2026 03:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790306891;
	bh=wTB6cD4BGI4dRB4kG32zjFetlHYThjEVT4rOmUCX5Qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h0/ed/T/mez+W8d26QNcyayBBUItuLUCEVgC+U3uL9Qdy8nBztZbhXBsjt1K9VYTv
	 65L8lD1p5lx7ITwsHDYe/5dURvVWBpgnsgCrzj2/Ssjpj/HYxr6aYWwwPB5Rt1zIzx
	 DDzE+IuhvZrqgxyM4/20fAisnjKKe9Vv+k35K+/dS7zcggNQN8hZJPY7/h/ZDCUfgz
	 GNaPR2ApA4FL80PrNp6RNGbL46CIH2A9wlYFgxmO9CoXNKSLWFqSrZWWVTxk8GrFT1
	 +kfK7VTH4dOt8CipXIJFsyPrw1lIUcUrXQ9mvG9MRkHtxDXCA30bIm0413UTegYTn6
	 11H686whGOyPw==
Date: Fri, 25 Sep 2026 04:28:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Gustavo Silva
 <gustavograzs@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: ens160: use regmap_assign_bits() for
 conditional set/clear
Message-ID: <20260925042808.1e43e987@jic23-hlaptop>
In-Reply-To: <arUx2r3swu5512Bd@ashevche-desk.local>
References: <20260924083527.461864-1-peng.fan@oss.nxp.com>
	<arUx2r3swu5512Bd@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 17:21:14 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Sep 24, 2026 at 04:35:26PM +0800, Peng Fan (OSS) wrote:
> 
> > Replace if/else block using regmap_set_bits()/regmap_clear_bits() with
> > the simpler regmap_assign_bits() call.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied.
