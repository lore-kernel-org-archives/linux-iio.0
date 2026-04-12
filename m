Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0122D785;
	Sun, 12 Apr 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776001230; cv=none; b=kt1gLgcdE8BWp0MrzvyGARyGEZehCN0CTVwHCIerbSgwzhVApaJMkqJgrSnlEN4TeCb/EQhHzNMpTZLT5ulqtwnNRyvPKhzjo6iv97f4G1xHEV4C6WHXoaLIje2UDmJJPG6VWMH2LgsToYKhRTvuUT5N/+xnrfaeWQONiSEA5Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776001230; c=relaxed/simple;
	bh=oTR9m4IsEdRT37DGUiCRgUO1bMrjc6Xl/DqLoqBprrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0j73qxbIraCnGboeTbI7n0mBQ+Vnhw7EEI92WKEtPLqnnJHlPOBBchELzvFW581q9dgOUcqASpzEFaPCiJn5bL2asMbZMLrcGaqhyUwyiodRGCTYOWwc4uJnyC23ZguqAQQxfMUmAuZMFSdDRsCavOdjbjAqqkNlDrNF6bpagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMgPRB+b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMgPRB+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E42C19424;
	Sun, 12 Apr 2026 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776001229;
	bh=oTR9m4IsEdRT37DGUiCRgUO1bMrjc6Xl/DqLoqBprrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HMgPRB+bb79b5Qo/jRH8bx8vI5NHnJNicJMT8lKaUt+kCDfruYcD+1T+wd/Ukiu1Z
	 oPQNxlObgdNrDoUJ5MwDxb/LdjQBU6X6l15FiqtzKNlc6vHHrEnMla8KnsQna09uPw
	 5EmnRUd38l9R/FSid37SgKyoGlwkFybDzSMjlyMZbbmsLu41ql9GDivUELS9pximki
	 rGQfYwLSbfnARvovK/onc8vr45ec+z4oe6kaLSwGr+saauzihJdlqw3SJ6IXi2x9eX
	 bCUrV/O7z7ESoqC4DSuHRPPrtnVRB3+CG24SKVIj52p9Q5F3HPGWRM6dgBl1BeZlEc
	 UZ5nUxYraOGMg==
Date: Sun, 12 Apr 2026 14:40:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Ammar Mustafa
 <ammarmustafa34@gmail.com>, Alisa-Dariana Roman <alisa.roman@analog.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Docs: iio: ad7191 Correct clock configuration
Message-ID: <20260412144020.502dafd9@jic23-huawei>
In-Reply-To: <CAMuHMdUcDrDR-1f5eXjdyDR3-HcTFFeGsmYU2whV=fQhzsCNtg@mail.gmail.com>
References: <aaHrsTS9iG-PEfue@ammar-VM2>
	<aaLIhgJjrNlp3oTy@ashevche-desk.local>
	<CAMuHMdUcDrDR-1f5eXjdyDR3-HcTFFeGsmYU2whV=fQhzsCNtg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 10:09:28 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Sat, 28 Feb 2026 at 11:51, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Fri, Feb 27, 2026 at 02:08:33PM -0500, Ammar Mustafa wrote:  
> > > Correct the ad7191 documentation to match the datasheet:
> > > - Fix inverted CLKSEL pin logic: device uses external clock when pin is
> > >   inactive, and internal CMOS/crystal when high.  
> >
> > high --> active  
> 
> Thanks for your patch, which is now commit d2a4ec19d2a2e54c ("Docs:
> iio: ad7191 Correct clock configuration") in char-misc-next and
> iio/togreg.
> 
> That commit message still says "inactive" and "high", thus adding to
> the confustion.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Ah.  Sorry, I missed that and can't really do anything to fix it up
now :(  All got a bit rushed as I was off on holiday.

Jonathan
