Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ECC41323A;
	Wed, 29 Apr 2026 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484527; cv=none; b=SRmSJtpJ8tdqNHDvmpWe1mGM96B+giISPoSuGynzhYMdsZip82HIdzv2ajmMAPT4KjLSxSp4VxBn35YtDww0doyii9a4vnM1JPauyyQ93b7u45sJQbcR3AkIwxBo3zsKRiScdRA5NtSGLOosiKiUZIRjT24S3qJxKPlYuHeX7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484527; c=relaxed/simple;
	bh=E0vBOIwceecB/pXFZeW5Kk25N5h2+ziBlv8PPx2C4T4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2NP55DnhAPxyngcciEAVjNSyGimTGgDR9FZWrhZzEm4yTQNNU8xg56URv5vJyrr9+ND8tFLkxzhgmbAz3j84pahKs4v8xi1Lx8uwSPAOzPKzJqX9iK6r0KbDzjiEKFWb50R7YiJ2Oz4kJ7HtY0YThpB7Y+9jKwaSgXWOqcLYoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLvXDtBJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLvXDtBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56D6C19425;
	Wed, 29 Apr 2026 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777484526;
	bh=E0vBOIwceecB/pXFZeW5Kk25N5h2+ziBlv8PPx2C4T4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KLvXDtBJGp22eTdmB8xGttypE9dP+aVBV1sH/2yxX18GFLtXRK+hiQp1YyGV6Qyrz
	 7vD9s2tZWP/KMeOXazM187k5wS92X+gpDYU0mqJDwaMepHFe7dayw7TXgr8UclVcRm
	 R29XAa1LByD/fuW0ftWULv7olLz16EetinRl7WCZ57u/1SU7NpUIQ42V6UgeQWaggV
	 eKSRc6GYMhGtkQVFeqfua3hjCFdq5SFOf8fMNbgtSUAm8oLsW2mdg3tRPDZn2/UzF+
	 NQMy7yCbOGUFj9vM7aWEhHygveaMf8iWuquSLPWAM0aQb/nxg0mjHr2kxmMjK7ZTy3
	 YLGX2MR5iU9KA==
Date: Wed, 29 Apr 2026 18:41:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 06/13] iio: dac: ad5686: refactor include headers
Message-ID: <20260429184156.6be961fa@jic23-huawei>
In-Reply-To: <CALoEA-yBU_pwiOFQx89-Gcgmtz_KtuxJJvph7uKPHKJNihDS8Q@mail.gmail.com>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
	<20260429-ad5686-fixes-v4-6-bb8f1cbd68e1@analog.com>
	<afIRG2S94JEn3Oqd@ashevche-desk.local>
	<CALoEA-yBU_pwiOFQx89-Gcgmtz_KtuxJJvph7uKPHKJNihDS8Q@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 16:38:02 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed, 29 Apr 2026 at 16:14, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > I haven't checked this deeply, but I hope at some point we will have
> > more or less usable state of `iwyu` tool that may do this automatically.
> > At least current result looks better than the original.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>  
> 
> I did find a "filter" file of sorts for IWYU that Jonathan had on the
> mailing list.
> It does a good job of omitting reports of very low level headers but at the
> same time IWYU still tells you to include things like <linux/stddef.h> and
> remove anything <asm/*>  from your includes. Perhaps it needs more
> tweaking?
> 

I ran into a few corners that I couldn't get to work right
+ probably didn't cover enough of the asm files with specific rules.

I'd love a canonical config file (at least for IIO).

Also turns out the LLMs are quite good at reviewing these patches

Jonathan
