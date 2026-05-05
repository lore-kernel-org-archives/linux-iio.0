Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493C2C0323;
	Tue,  5 May 2026 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973367; cv=none; b=oELBnYk54j/ZgqspUYfB5akQSb73LiV+qDwvj2ceiB5oPn+DcF+RE9Z4nXuuZrleaYI+jKZGFRYTX5qybajYKUTAFM+IFDX/87VONavrCK3x3CMOAwabFYgUtOblfKQMJAvePb42bAsTBkiubphDO7N5Liy1/RL9T3NVcE4683A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973367; c=relaxed/simple;
	bh=+3d9JMushZLLuLWVNW8laZOKoByzze/3a6H5ByqFO4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdtWnRavfhO7i6hE+7HAnBhB3zwHK252MIkYqUtJoBRY3HO4CUcw9KOI6m8IfgGBfGyXCU3jmIRpvUY3td5fA6a9AH9QYywXuaO6Kz34ri+u+PEgf9yMi754ob8UJ0yM08+vrtMSuNSTm7iddHgzPLBDqrWm46ZQGwpg01luEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8oi3+tL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8oi3+tL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA66BC2BCC7;
	Tue,  5 May 2026 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777973366;
	bh=+3d9JMushZLLuLWVNW8laZOKoByzze/3a6H5ByqFO4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V8oi3+tLAntmeans7eZy6kGq0FifDdl+c/l+UrOzSfr6jZ64GgiWFE9mTakdY41iV
	 dh2CURfJ/JbYsQAX3Sl2bPcQDz8XneEPvp2l1ufRz5JOPE73U2LHrN2P4HojulNMhK
	 +gQ4nXJpkLe15LpDLM0QPqwgOO5Ah4u02HbD+sZAq+03w7EzWRuPPF4WRc7NQbH/k5
	 Lvd5ZN15z1ZIXZKL9uDy4hjEvrGmlZZoFJXMD/2YqEB8PHDSdeuGulS1ErB1xnONpL
	 vZBmpGRasiYCzbeRWhWtILxNntY11M/8WlBV7sr3RPCJ2k+4J47j1IyXAZH9Zbyf7H
	 CvD79+iH09yKw==
Date: Tue, 5 May 2026 10:29:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Miao Li <limiao870622@163.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, waqar.hameed@axis.com,
 dixitparmar19@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH v4 3/3] iio: light: stk3310: Use sizeof() for
 regmap_bulk_read/write count parameter
Message-ID: <20260505102917.2b49fb53@jic23-huawei>
In-Reply-To: <afmTBZSUpVrS5AP0@ashevche-desk.local>
References: <20260504030408.105762-1-limiao870622@163.com>
	<20260504030408.105762-4-limiao870622@163.com>
	<afmTBZSUpVrS5AP0@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 09:49:41 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 04, 2026 at 11:04:08AM +0800, Miao Li wrote:
> 
> > Convert the hardcoded count parameter to sizeof(buf) for all
> > regmap_bulk_write() and regmap_bulk_read() calls in this driver
> > to improve code maintainability. For details, see [1].  
> 
> > [1] https://lore.kernel.org/all/20260428192213.7c5c80e5@jic23-huawei/
> >   
> 
> Make these two lines a formal Link tag,
> 
> Link: $URL [1]
> 
> Perhaps even Suggested-by tag is also good to add.
Tweaked this and the previous as suggested + added tag to previous.

Thanks,

J
> 
> > Signed-off-by: Miao Li <limiao@kylinos.cn>  
> 

