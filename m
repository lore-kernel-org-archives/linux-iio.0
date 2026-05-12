Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B437427A1B;
	Tue, 12 May 2026 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585194; cv=none; b=C8tNeNG8xCDU6/AHn3DKJHRXAHhaFr2OlxTtY86m0fNkwfRqD3rYKrGF+gk/fUP4pt86O5VGC2fx/iiJzf+CfSX0hNmQ1WfZF1FiQpEkgrsz3N66XULoVlzO6j+OlkK+MaXq3Xpw0C9R2SwgYH/wuerTM6hR2/fZZdy67JN6djA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585194; c=relaxed/simple;
	bh=ZBUU84ONRzGWT6gYVgtzY5cHeUph9XvKw8+PLmJ49oU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxim4kpDjNfvJY7+GS8rqZsZEhRrdJD2ISqK4HyI87fK6l/wtVBrEQjndhjXu3Ji7SNn0gBGudFs00qOytsu1TPmkfObuYmt7S65TIizXN1ZSxqkvWxbnAdZL1dJglUyUrjEbaD069jdGZJolP32SUJfFfhCtvB0L4vywcpkI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs5R8Aob; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs5R8Aob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B45CC2BCB0;
	Tue, 12 May 2026 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778585193;
	bh=ZBUU84ONRzGWT6gYVgtzY5cHeUph9XvKw8+PLmJ49oU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vs5R8AobgDClMuUgEsjBx7lMMfWOfWGIswPdrsUQ1KjKoDxLFataVtmUdNv/wAa4U
	 jAmC8RCvn26EVySJiiScHNhKv+eUXitAodD475jK8OKJm4Pn6te9yqRh3OzgsNDBxw
	 tzKD7/LLRKJYp7qB4KFXLagsnDlD4C/fILApynIV4dkgUBD7s4j+xUVydVNhGFIuER
	 S3vevMWPfPVucKuNFlRmXKQNbIcsYL285eHeM+mRJtl+4lyO8+vJr3T0f7dZtKJBjV
	 o/dQvqJxXCjtltjNEUJVEM8bAzDw9K0m27YntlgI+qIupZtc8F80roQ4xRpyMZVUwo
	 IwkvbKguX0Faw==
Date: Tue, 12 May 2026 12:26:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, puranjay@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: accel: adxl355: replace usleep_range() with
 fsleep()
Message-ID: <20260512122624.5d2138b7@jic23-huawei>
In-Reply-To: <agLXhxaVkqj-UeM0@ashevche-desk.local>
References: <20260510113853.50019-1-sozdayvek@gmail.com>
	<agGE7F5zm2pN_dBk@ashevche-desk.local>
	<20260511171331.77f3ef39@jic23-huawei>
	<agLXhxaVkqj-UeM0@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 10:32:23 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 11, 2026 at 05:13:31PM +0100, Jonathan Cameron wrote:
> > On Mon, 11 May 2026 10:27:40 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Sun, May 10, 2026 at 04:38:52PM +0500, Stepan Ionichev wrote:  
> 
> ...
> 
> > > > No functional change.    
> > > 
> > > Strictly speaking the upper limit is not set as 10 milliseconds now,
> > > but defined by the internals of fsleep(), usually +25%.  
> > 
> > I'm not following.  There doesn't seem to be a statement of anything
> > about the upper limit that is used - just one on it not being specified
> > for the part.  
> 
> I meant that switching from usleep_range() with explicit high limit is
> different to implicit fsleep(). And that's a (subtle) functional change.
> Hence "No functional change" is not fully true. Hope now it's clearer.
Ah. Got you.  Thanks for talking me through it!

Jonathan

> 

