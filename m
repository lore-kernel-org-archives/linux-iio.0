Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90E93EA66
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807100; cv=none; b=AeHi36MtIQ3V87Zb8MTPNsh/fQmvVjmaw2hfgsMlecMc3oQppuBAgnF4bJBZ/iVx+Vm7QGATIg3ysa4Y9Xy8Ji+0jSi5BZ3Z6assZR/8T7ZJpr+/CvJkgTTBXZxyPKPAHmbHh2uPU9yjZPj2FAz8+Fye4CcmKrcQgALLFhqx0Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807100; c=relaxed/simple;
	bh=E/hPOg1OENodSsJ6mlvZpr1Hqj8yHyCAAemCdL74Mw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvFp/cCq3BjZn2bU9vyxVONT4blPDZCj3ahxjFC/aBEykHZ5h5l0stfbOS/4rslIyggxcXUdU/GPh3OOMNM+CPa7vs+4gTGcuqfXzvWFR6H/XvyRauwpgf/teupIZ8hHMCNr9KyQj6GLeelqXpr1HUifayPTs8UatI9YuQxYCaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJCrOc/0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJCrOc/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEF91F000FF;
	Sat, 19 Sep 2026 08:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789807098;
	bh=7g1jEiTMcqNA+VdyOP9PyQGneRPRUhJtgWd3c19/5Bg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CJCrOc/0HbGWnthpr4mS3RC1rpRunGrgK7L6QYZ7KJdogYdowX2ZRgXqu148ChUtq
	 jNmz8NVKSOW74yxCZSzVOmJJ1MeowKJMLQoRsG1s9i6nb2LBON1kxzIa0h5ztOxZcn
	 B/YVMXldbN9wed9zrKVjjRM9wZUXbqhK4/jaYmFibQyZNPCnPwQUOZlDB8FbAunlY/
	 eQxDgBO3SVcZQqVpefaDGq8oqnPtu91XEzTUHUkhiB8My2st49Gw9xKUyVQsJgOjSZ
	 iderIxvQpO3wuXXd2qNhAQ1cAokqfRPacVNMhApQYNQa4RzM5u0uh5L9OHKEwzfdou
	 6cWvf4GJovPxQ==
Message-ID: <a77309b9-7317-4d74-9593-a1f9705ccea1@kernel.org>
Date: Sat, 19 Sep 2026 10:38:13 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Maintainer entry profile/contributor guide for IIO
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, andy@kernel.org,
 nuno.sa@analog.com
References: <20260817111825.000063f6@gmail.com>
 <cb1937e9-c2fa-4d8d-bd95-f53423d88077@baylibre.com>
 <20260818090652.000020bc@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260818090652.000020bc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2026 09:06, Joshua Crofts wrote:
> On Mon, 17 Aug 2026 19:31:45 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 8/17/26 4:18 AM, Joshua Crofts wrote:
>>> Hi all,
>>>
>>> I was browsing lore and checked out the ksummit mailing list, where the
>>> topic about guiding new contributors arose [1]. New contributors tend to
>>> make the same mistakes when sending patches, causing reviewers to point
>>> these out all the time over and over again. For IIO, this is definitely the

New contributors do the same mistakes because they do not read existing
documentation, thus one more documentation won't solve it.

>>> case (I myself send an email telling people not to send a v2 in reply to a
>>> v1 several times a week). Other subsystems have a "Maintainer entry profile"
>>> that contains subsystem-specific process info (DAMON for example [2]) and 
>>> (sometimes even [3]) a document describing the code style of the subsystem
>>> (this would be a great place where to mention things like not using
>>> kernel.h in new drivers etc.). I'm happy to create both of the documents
>>> but it's always great to hear other people's ideas!   
>>
>> I think there are plenty of new contributor (to the kernel) guides out there.
>> People just don't read them. So I don't think we need another. Nothing wrong
>> with trying to make the existing guides more clear/easy to understand though.
>>
>> A subsystem doc that has our code style quirks and idioms would be helpful
>> though as I don't think that has every been written down in a single place.
>> Especially useful now since AI reviewers will read it even if humans don't.
> 
> Yes, but it shouldn't be limited to code style quirks - I highly doubt new
> contributors develop against the togreg tree of iio.git for example.
> 
> I'd propose 2 documents:
> - entry profile - documenting the review cycle, patchwork, point people over to
>   Sashiko, relevant git tree etc.

Maintainers file already defines git tree. Patchwork as well. Please
read existing docs first, because it seems you propose to duplicate it
(including submitting patches and other process documents).

Subsystem profiles are expected to document things which are done here a
bit differently or specific subsystem expectations, narrowing general
kernel process docs.


> - code style - the TODO is fine for existing problems in the subsystem but doesn't
>   point out idioms we have in IIO, i.e. not using (the awful) kernel.h, preferring
>   devm_* functions, not failing on a mismatched ID to ensure fallback etc. This is
>   stuff that appears a lot in patches.

You just described standard kernel practice. Don't create documents just
for sake of creating them.

> 
> Whether new contributors read these is up to them (from my experience if you write
> decent docs people still won't read them and ask pointless questions), nevertheless
> if we suspect someone is new we can just point them to these documents instead of
> reiterating the same over and over again.

You can already point them to existing docs.


Best regards,
Krzysztof
