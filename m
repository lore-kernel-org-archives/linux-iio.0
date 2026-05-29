Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B21684BE;
	Fri, 29 May 2026 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060046; cv=none; b=r+cdlY2A8/GZVv3fBll+FQkhFhEqrzauwMoOl0FyyDoYxtx/zZIofbBlpGAsL43HilG4dUxcuAzwjpzbeyd9+CYeYuZ7YTshJUtDp/LcP7Mb9bC6Gv5S3AR8VWUObMEZuQ63V//miv1YdBrI3/qKtEYC70lIsbcm5I5aylxQ3rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060046; c=relaxed/simple;
	bh=CAHgOCzI8ZtMcCDqiRL9o6tYMk9F6wVmA4dRR0mfbh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oxg/j12Fm2EPupyZ02clKf5AwQogUsJcC+CA1k7smU8yrmr5u1pEadUzeu/CNDw+cMJ8Cyioh+YdtNEgH7ZDxdtSxOa950AtPe3xg+SGzO9hwCL9Gkd2QVsjki8wkcKPSgL9gb9W2Je/JPPE0WeXrySphms5QqO7LtM7ugmFcHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHv/EJZP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHv/EJZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFD51F00898;
	Fri, 29 May 2026 13:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780060045;
	bh=lS5EIhTABeMXjRYBFC+63t0Oqm4TW990BTocB+jyLQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hHv/EJZP3YqTS5J5oDld70x8J6fqY6lUbQl0NFDwjjO55kqZ8mbhDcgYydn3zooD5
	 QDb6kPFsTbEy/i9pKmvCxY11Yfwr1zEzgSSj2q055sL1nWunh55nsb3+kgKL8FAQnJ
	 pVz7b07AcM5FlC6Wi2jz4848fbQ0DGtXcF1e6bsC1XuCydFo2SKP9xW4XS1m8o1ziO
	 lfEY33caGXbOCjWF30oZwx9lczPx+5HY5U85bzDwnKV/NjrlB/Uu6dF1d9Zh3x1Gp1
	 RpGhLOvcprHYw6mnazdOztYGKWBM6rKucAx8WPFaMHlfRNsx3tcq4ukZzAnQeEzqia
	 3KslEi5qcvFBg==
Date: Fri, 29 May 2026 14:07:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Jinseob <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 7/7] MAINTAINERS: add Open Sensor Fusion IIO
 driver
Message-ID: <20260529140716.1c3a9afd@jic23-huawei>
In-Reply-To: <CALMSewL7RvTSet3DSk7cQ5Lqi+EDduUOSAVK=vZ5TKz65_9qyg@mail.gmail.com>
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
	<20260524085312.15369-8-kimjinseob88@gmail.com>
	<20260528153126.7be7c765@jic23-huawei>
	<CALMSewL7RvTSet3DSk7cQ5Lqi+EDduUOSAVK=vZ5TKz65_9qyg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 21:51:06 +0900
Kim Jinseob <kimjinseob88@gmail.com> wrote:

> On Thu, May 28, 2026 at 11:31:00PM +0100, Jonathan Cameron wrote:
> 
> > As noted, no need for lists. The appropriate catch all listings in
> > maintainers cover IIO and DT-bindings.  
> 
> Addressed in RFC v3.
> 
> I dropped the explicit linux-iio and devicetree list entries from the new
> MAINTAINERS section.
> 
> > Bring this in with the first file, then update as you add additional files.  
> 
> Addressed in RFC v3.
> 
> I removed the standalone MAINTAINERS patch and folded the MAINTAINERS updates
> into the patches that add the corresponding files.
> 
> Thanks
> 
> Jinseob

Hi.

A few kernel process things.
1) Don't reply just to say you have address comments - if you are saying that
   for some things in an email, then crop the rest of the quoted text.
   Keep thanks, and how you change it for the next version of the patch, mostly
   in the change log.
2) Slow down a bit - I'd leave at least a week on the list between early versions
   of a patch set of this complexity.  You might have received some more review
   before writing v3 or discussion might be continued on any feedback you commented
   on (I didn't spot any but maybe lack of cropping meant I missed it?)


Thanks,

Jonathan

