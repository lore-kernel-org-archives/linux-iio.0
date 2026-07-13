Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCFE1F1537;
	Mon, 13 Jul 2026 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783904403; cv=none; b=hYmbjv0EssQldMetFg+OIUl8Q9vT6XFBiFHUQHzB2TK/M5BC9aGkZaTi128lidsXsm7lFko1s/HLsuPXtjg5KP9xmmLyLzE2s2tiF9c66X/bKozCUgxQeux/Hr7qwvAvVfIPWLCvjV5FxXzT9z3ru7DWqKGu7Qpgv1QcNkyCL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783904403; c=relaxed/simple;
	bh=zJGWjULhTp3sqnWT32Yx0zi4z7Pw++9UkvNaa8jtyOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJJMh6BXQp95ZKjAADhQoj361nWFAVDor4NzsFcC6sHiHvn9ZIgPudi7SbFYzpodRPdGDn7W4xwDI+ovyVPrJs+tgmQCrjodX2G1rAGB/5ZCn8ORlgwO2i7+Vsl200lCpbbHYtW9za8TRfPYtK3EQJ8W1ppyAS6NsZnwB9HBYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PATxtn4b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PATxtn4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5D81F000E9;
	Mon, 13 Jul 2026 00:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783904401;
	bh=w5b5XzUrXBPL4Y/XgS6zpe0aEAaeNOZna4tinb1RrwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PATxtn4bza5nx5XENHRTakU5aJYsl4GxMFTt61czPYDisqcM6zarGChrrc/MbxOqN
	 uJ73gdRxzUBz++gwaThu6QV5gBVIhvJAfkeRWN5lSl5owJW73dEUvMTDAyokOW6C14
	 WfzWevqVRfnkqNXgx5io1YyvSpbyCI9EFbtCuJH1zuVFAtlv55qdzBeQMeC4b45Bmq
	 06armzfho2+T8TZKceNg0UVEdRNqMBhefJUh7CPUMN7nMBuwlFjyyXbGyz0sB52L2c
	 8zz/1M/Y/mB/xxeytPjdSPK+roV3gqh3QqpqnPDVNQIaWUdJvDFQRCTIK505WtBuPI
	 SudDZeRst7zRA==
Date: Mon, 13 Jul 2026 01:59:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: dylanliu050903 <dylanliu050903@protonmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dylan Liu <pxyforeverlove1314@gmail.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: =?UTF-8?B?5Zue5aSN77ya?= Re: =?UTF-8?B?5Zue5aSN77ya?= Re:
 [PATCH] Signed-off-by: Dylan Liu <dylanliu050903@protonmail.com>
Message-ID: <20260713015954.3ea787b2@jic23-huawei>
In-Reply-To: <20260712184602.0c07aab0@systembl0wer>
References: <20260712141928.559844-1-dylanliu050903@protonmail.com>
	<2026071227-unspoiled-blatancy-0809@gregkh>
	<QNymfg8xEp8CU0BQxNJDcXKxDRN_xohHqySr8jzeakn2iJwHaezt4D2ks87ODGRh9227yPZ6dVpvcAa5OghRpS0htIaCUhCS7viUtr9aPgw=@protonmail.com>
	<alOtR-zUc71PORuA@ashevche-desk.local>
	<BKV7Mhbq1o3O_ErHy0kJsAxQU0wPO9BA6L-6CKJlZ9DsyAlGxNQzVfSIokpg-0V4bh0dp7KoAsq34iyjPsGOVDfFX3YSI7d0MozL381XqkA=@protonmail.com>
	<20260712184602.0c07aab0@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jul 2026 18:46:02 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun, 12 Jul 2026 15:41:54 +0000
> dylanliu050903 <dylanliu050903@protonmail.com> wrote:
> > Hi Andy,
> > 
> > First, I apologize for the HTML email earlier. I have fixed my email client settings.I was using the ProtonMail web client instead of `git send-email`, which unexpectedly defaulted to HTML.
> > 
> > Regarding the ABI change: I made a classic beginner mistake. I changed it purely because the `checkpatch.pl` script threw a warning suggesting it should be in snake_case. I blindly followed the script's advice without realizing that I was modifying a user/kernel ABI. 
> > 
> > I now understand that ABI stability (and aligning with IIO maintainers for any necessary staging transitions) absolutely takes precedence over resolving style warnings.
> > 
> > Please drop this patch. I will be much more careful with checkpatch warnings involving exposed interfaces in the future.I will also dive deeper into the codebase to ensure my future commits provide real value.
> > 
> > Thank you for your time and the guidance!
> > 
> > Best regards,
> > Dylan Liu
> >   
>

> Hi Dylan,
> 
> Please wrap your email body to 72 characters per line, as you would
> with a commit message. It's easier to read.
> 
> Thanks!

For any of the drivers in staging it is worth taking a look at lore.kernel.org
and seeing what has been proposed in the past. IIRC, this one has been the subject
of more than one attempt to clean it up. The userspace ABI is a long way with
compliant with IIO ABI. The challenge with sorting that out is that the changes
are invasive so you'd need to figure out how to test them.

Jonathan

