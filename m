Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95C31578E;
	Sun, 22 Feb 2026 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771778645; cv=none; b=XuNvTbhi1Cee5jWW4V/C+j7yifxpDhfNepNfXWL3WKMRXjLIyPhHG6C2jhfWu9rW1rfLKMx9ZEl8NacZiXujlbEVlo7HVbyOYHF9YT8EVgFshl1H1py3NOtlKMx2gubQ0nes3b5rOVmTt4mSDOj7AL48mA/++l4SPgKHUN2IvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771778645; c=relaxed/simple;
	bh=S8CXqd//JToMTT9Z0M5Y2HQhFnw+h3uGpmBAjaD5BSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qe6JXn6I3z2l9MZ5T4AwGwPBq8wGYscTycLQllfuyvM5Gva7y//ULjF0I0WWnJ5kamvmwO48v9z+Egp2TpJni+QjOm2essrwSoyOAq3Bz6AcHUh6DoG4EWX2FXzVNN2DEewwveabkAiTFQHdzUKRXv/NgYDggOEN7IQcs4ovlns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZkdgPII; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZkdgPII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B0BC116D0;
	Sun, 22 Feb 2026 16:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771778645;
	bh=S8CXqd//JToMTT9Z0M5Y2HQhFnw+h3uGpmBAjaD5BSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pZkdgPIIJXl/3MPHoiFligMFXmsBsllVH/yIp+oLCm9tka+XoUHnQUUTXCOhg+rWH
	 zDGn+h/l5HvTM4SJnxCCWJMnyVbEh9QBTH/UWtL5gS27pjfILV5CWrYV02fNQ7Zw8q
	 +gVHM+9fri/l9wXBjCxdli+8BRIrvAriMhhLEW6EqVYT7MzFApZhi3qstIHKAj65he
	 VQgQ3clu+wIoDdUw8njAGQvwy8BfTbk07yTBbeZ+Fh4iz1IxOl+QmoZJ27pOx1iypp
	 rgrlFDvUXOYppaMZDfQ2rUVf8/snfPuEBWrYWP8zJfK4HTYnYJT56Wdn2/wu6PwvBv
	 qI3Ja1aBc5hhg==
Date: Sun, 22 Feb 2026 16:43:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iio: remove redundant else after return
Message-ID: <20260222164356.18721d31@jic23-huawei>
In-Reply-To: <aZhsCm4W5ZjLHh0J@smile.fi.intel.com>
References: <20260220133337.85216-1-antoniu.miclaus@analog.com>
	<aZhsCm4W5ZjLHh0J@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 16:13:30 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 20, 2026 at 03:33:29PM +0200, Antoniu Miclaus wrote:
> > Remove redundant else branches after return statements across several
> > IIO drivers (ad7298, ad7606, ad5592r, ad5758, admv8818) to simplify
> > control flow.  
> 
> While technically you are correct, the only patch 5 makes sense to me.
> The rest might be better with 'else' be present. It depends on the logic
> between the lines, if they are of the same semantics and it's not about
> returning error code vs. 0 (success), it may be better to read them
> if they are started on the same column.

I agree.  When it's a choice between two 'good' paths and the author
felt if / else made that choice aspect clear than I've always taken the
view that that is reasonable.

So I've picked up patch 5 but not the others.  5 was a little stronger as
it's if (A) do something else do nothing.

> 
> TL;DR: I am not going to NAK, but patches 1-4 is an unneeded churn to me.
> 

