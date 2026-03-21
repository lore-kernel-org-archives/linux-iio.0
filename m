Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330240855;
	Sat, 21 Mar 2026 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774108201; cv=none; b=ZUFLpHYrjFH8UG2YE4Ff132UoVUqjZDe4nhGujgOMMPuH0MgnwptSb31nZApH9X7YEfN2HvrJwyKynuyt14y16BV3Y0hDUqhXDU7G60hX0jBpOxB5TX9u6rYNqsEExFSfPJZLMzClen9pRcmpfRBqyiCylZy+w7rar7Xd9D0oRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774108201; c=relaxed/simple;
	bh=kbn1WK1P0CLV3g9NxTzimggMcG6TtSf4XHKsAXdiH8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Od+0nvnd93XP6wnFMc2bkJO8Usol61QtZe2guZOjNl68W7+6cd5f0MA9jvvsilZC0iuRl0zO1nMj7zb9PIhIJhgRUTfwjGpzvmUxtGtmMuaThsi62b0+tyWMW2aIRd7NWFx7GHoZ2vEkgEcz1DvHqmTdV2zqm07jc8VjmBsPT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9dAXYUD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9dAXYUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49918C19421;
	Sat, 21 Mar 2026 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774108200;
	bh=kbn1WK1P0CLV3g9NxTzimggMcG6TtSf4XHKsAXdiH8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e9dAXYUDAsN9v4x1AadURqYSlSWa9Y7mxzZIDz25fB/CvA9Fyj7XD1b8lCM9cyKMb
	 F9rKRu8DkNZUirh+lv4LOJ/xxoxthjOn0mXZRo49DpIcI7mldLM7DvvygCk8RztYhv
	 d3Koaq1whNjtTUgG2lFGA6rfl0j3AqAiIQlxwwZeM2itrO1aQEDY6rdQayBSLFY4jV
	 KdQ+p/bWaAKz5+B1wT6Oz/LcZIZlM+DgBADkf6carn+i0Ct0isAYEjuwIxZYfTnf7C
	 +juQM6z2gUQ+iqOOkPzxxjzQnqohMQvNin2+WXg7FyqqK5FABtdD8feGRyz7b+oEYL
	 f89WoEbIKQ/Zw==
Date: Sat, 21 Mar 2026 15:49:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, morris_mao@aspeedtech.com
Subject: Re: [PATCH v3 3/4] iio: adc: aspeed: Replace mdelay() with fsleep()
 for ADC stabilization delay
Message-ID: <20260321154951.632ef7d9@jic23-huawei>
In-Reply-To: <ab0iDUp6t2LuGlAA@ashevche-desk.local>
References: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
	<20260320-adc-v3-3-bc0eac04ef7c@aspeedtech.com>
	<ab0iDUp6t2LuGlAA@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 12:31:41 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Mar 20, 2026 at 01:46:37PM +0800, Billy Tsai wrote:
> > The ADC stabilization delays in compensation mode and battery sensing
> > mode do not require atomic context. Using mdelay() here results in
> > unnecessary busy waiting.
> > 
> > Replace mdelay(1) with fsleep(1000) to allow the scheduler to run other
> > tasks while waiting for the ADC to stabilize.
> > 
> > Also fix a minor typo in the comment ("adc" -> "ADC").  
> 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> 
> I haven't suggested the idea, I only suggested to use fsleep() for the purpose.
Dropped the tag.



> 

