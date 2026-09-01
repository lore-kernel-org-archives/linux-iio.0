Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9233438A9;
	Tue,  1 Sep 2026 01:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226552; cv=none; b=WiBxnJNsu+U0+77mUNce8uppig0spmOn4dvwHO2uFEGVyBPdCE0WB6fsHHNSNViLTBEQx/FZDsxLLdjxQlqDfpWonIslYdBTf9QJ/nm+fV8qv0JpcpLtoVx9UMfYsP1/Pfp2lQw1SD5s/nqfauz2Lapy8opGcBgl2oeYkjyXIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226552; c=relaxed/simple;
	bh=Qz9aU64NIbcl63hFQCFb8MwUfaG/2rRncUJ3TcC0zso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKMeZFRnCYMbOv7CZoF7x0Ha1+z3z7I55pG4qXdPl9BIMNVhez1LP38JKOZKniNqzLYMQSeMenZRMHQb+2w0k1geoZQhXacJBNzLQGbMfNcaOblp7s/UXOyVxlIUQVqxw89Oa2mGU2VuRo/ogEY4/V9cDrTx2OxC6kSmL+Ii7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBjbQZps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBjbQZps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614F51F000E9;
	Tue,  1 Sep 2026 01:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788226551;
	bh=cThL493FiP9aKgSZCya8BR1UaBMAKEInJ3wHPpoqMa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eBjbQZps24CwUws2qO/5VymHVlsF6hJXG1x5RGjG3MZ0Aaaa40QvJOLxbP9//P2Ui
	 +OIcLUlyJ2aU0BjQo9RZnNeRr2ZCYLyK8LbGsd1VZQiqRDFGFgZmKnYNEihK63RSq+
	 KeVlV8EfzKaoTgBTJ0voWa5THqHtQsWuEGhFoMExpQRhvqI0nEU3eZNcaA0t+TerBm
	 RvA1SBPPKK04Liu5lxPs3q74qLXPbjYcfSxBQTub6/jm6QmIhId7hHxELOfQJjOTUW
	 SYKjxjVUi2OgGVrPohBFQW2RYhcLcgtKx00audvm78iWlo1G3lVoPsiN3cng3PY3wc
	 xhl6wGhw6l80A==
Date: Tue, 1 Sep 2026 02:35:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yang Zi <2959243019@qq.com>, lorenzo@kernel.org,
 linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hts221: fix division by zero in
 calibration data parsing
Message-ID: <20260901023544.0f65a55d@jic23-huawei>
In-Reply-To: <apUnohaFf1HaqWN9@ashevche-desk.local>
References: <tencent_0F43B1BC41CE4066DA52B7B25FBC04C41A09@qq.com>
	<ao7zrbXG6f-pPxIB@ashevche-desk.local>
	<20260831010021.67cbf4c1@jic23-huawei>
	<apUnohaFf1HaqWN9@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 10:05:06 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Aug 31, 2026 at 01:00:21AM +0100, Jonathan Cameron wrote:
> > On Wed, 26 Aug 2026 17:09:49 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Tue, Aug 25, 2026 at 05:21:10PM +0800, Yang Zi wrote:  
> 
> ...
> 
> > > Do you have HW to test? Any fault injection perhaps?
> > > The problem with div-by-0 is that it's implementation defined, meaning
> > > that it's how compiler decides. Now, the question is, what will compiler
> > > do in the current code (no patch applied)?
> > >   
> > Whilst all this is true, the code shouldn't be relying on any particular
> > behavior.  So do we need to know?  
> 
> That's my point. If code relies on that, it should be spelled clearly in
> the commit message. Then we will deliberately break that (nasty and wrong)
> behaviour.
> 

Ah. Got you. So a statement that the condition (probably) never occurs in practice
should do the job here by side stepping that question.

> > Reality is the hardware is almost certainly never returning values where this
> > is true.  
> 

