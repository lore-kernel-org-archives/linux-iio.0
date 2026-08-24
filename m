Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970DE40FDAD
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574610; cv=none; b=nv4mU18apXj7eJD7heHWtz/BymBTRwbfJoJ2sfmP8oBjK2eNOyZGQ9kwsfAyb1qqY5SJrl7fZeL705wjIWFp1ZWQoWz7+e7lIezlpgSM0+RtBgVv3Xhfq5gubtyTHQJZ7LYTgeJsJJDIyUuqrDGt5xAdid29ns+9KW/gpZJBB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574610; c=relaxed/simple;
	bh=cCTGFJqALamtbIgjOs1X+o3I1l2RKXfl/lY/kLoNrd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+soZqtNAilbjTB99gYiv9UxVS7r+1UAp9npVdHYDRKJMtVNvXVF311P/8V+Y5qi7uLZ/mZsbJeMbNikoAmKV665MoMOAVUYfNLB49Z4JU+wiuDzIrDgxXmpu/spro3X9ScvGHxJ3bUb0IUAkLaB5VXDLckAh8vMbe0aZTqNA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJCxRT1a; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJCxRT1a"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-97c441e66f0so1588160241.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 05:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787574605; x=1788179405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SuAn8nfeNzgPirFIqRh4b4nts7/1o15Z1Fon8Wbszww=;
        b=SJCxRT1aFkn/u6gj4TUek6jbrPecQvMXud29Bss9eMSOs9SZBKEDvdTXg0kAbL5mvi
         44YkW+K+ZMu3RMiNgU6+awqguQU9CreG8Qnz+EuT9Tix3TZPwvW1iloDcw/OFEkxzqMs
         YzQGo0K3PDwTfrVBUDabIN28eYnZV1vPVz7xmi5Ao7gPp6e6nA3yzuuaKq7a/UAOtuJN
         0lq0ZwtAt9zPp6CkZHfZK3AUdWkZmF7nP8uPQVsu82dV+0zu43c4uiLch2kVbKlJNVcZ
         ZwvcptELpguGKD3h/KUgXy7H6ryBh7fGaOqtlKMTVA9J7NGO5VR5X5PzjyQ4r3YUR+5t
         C6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574605; x=1788179405;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SuAn8nfeNzgPirFIqRh4b4nts7/1o15Z1Fon8Wbszww=;
        b=XTD03BmjIQOzmjrcN6y+/sQ1wrU1ix0gU4+eFtsCJSDq7TnhHNevDH4YkVIqeyAOO8
         S4sizFudtPqC6apTXWqWVX/svQrCGViNNrh+Zl6c82MjQXOsY3wr3msOWz1YrVU5+IKe
         49A/Sx8Qw/3uyTYwAmoEKvQDu3TRJ74kCqGAAKInMA+pJZDd0phJU23cyCgQMk5sEEv/
         s7SoCOzzOoCeBVma0Abn3WrucekNqVxzLOy7BdEYbJOP3TX9bjVBmCNleIYXzCnk9/tu
         j5djcmfdRQFeZ2ZQ3zpqGY5562WyNqAKrW2c3zwnFfdNXsHon/BtXF0KMg2N+dggnNuD
         /HkQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/z+j49iKFNhgKBxynGXG2gAalO+B91bj2u9jZXf5UtqTlxetO7r0OO6e28PNbwxc8TzuVoyV38SI=@vger.kernel.org
X-Gm-Message-State: AFuF++lItpMcZ0FXaI9Hs1XPBG6pBt18hGQFGE3KlkgIzdYPmjSPGzJn
	TwlJYKdT/ZTuzT2UB+YUHTd6EDFONFUBLC/3/W85gTOSzyzcB0sNBqYz
X-Gm-Gg: AR+sD10v8xI3Hh4ej5oR2EBigv4j0TRNEO/fJy7704fgQvn3254JDei6Lfx1TYyw9RV
	UXkC2XESEMsIo6AbwF3Cb9wsPIzWCFOZ+c9awa7VsDCagUL1GT4fdCv6GqJH92QCqc4NxJv5fkx
	GhYSIx+t0NadYnDJCocre1S+c1YXXpny5xOX6CQp7YFNFbYCXmEpjwVOKAJw6suTX/xi07zUMWV
	JQyCxhu9VupveO0M8u8+TQ3HZS9oirHwhPxOcvQHjEO2zOBfZIgbUb1+34nYpr20X2ZrYHNWovD
	ftj6v+231xwb5sJ/Cqf80eW/o/3Led5C5Zca83kksYvhAazFWhSddaWeKJup2pvjhIRHB6Y86o9
	roN6YXYnEBgQiYklWMS4Qb4N1WklG6xiZxqju7nT+hMCxt10kwhA4Z4KB8TXVayGuMg+nTGaJJq
	vGlX8NaAclhvfl2xaQ2lbONMwCOQI6xNw35nToVB31JLlCWobOPu7+wAm4TJs4SyIOdH+NLg==
X-Received: by 2002:a05:6102:304f:b0:77d:9fe9:1716 with SMTP id ada2fe7eead31-77d9fe93336mr3102480137.2.1787574604944;
        Mon, 24 Aug 2026 05:30:04 -0700 (PDT)
Received: from localhost ([2804:30c:97d:e800:9454:1179:18df:ab33])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-77d856d919esm2814790137.8.2026.08.24.05.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:30:03 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:30:45 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org
Subject: Re: [PATCH v10 1/2] iio: adc: ltc2378: Add support for LTC2338-18
Message-ID: <aow5dTZ3xg4Iuj4G@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1786661484.git.marcelo.schmitt@analog.com>
 <8b0d2e34163b85634266be3b9dd8f76697c89bd2.1786661484.git.marcelo.schmitt@analog.com>
 <aoK4FXvkPT45RsIV@ashevche-desk.local>
 <20260822032014.3d4607dd@jic23-huawei>
 <aov_FNNX2-TWheQc@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aov_FNNX2-TWheQc@ashevche-desk.local>

On 08/24, Andy Shevchenko wrote:
> On Sat, Aug 22, 2026 at 03:20:14AM +0100, Jonathan Cameron wrote:
> > On Mon, 17 Aug 2026 10:28:21 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Aug 13, 2026 at 08:05:07PM -0300, Marcelo Schmitt wrote:
> > > > LTC2338-18 is similar to LTC2378-18, differentiating from the already
> > > > supported part mainly on the embedment of an internal voltage reference and
> > > > addition of a resistor divider network connected to the input signal path.
> > > > Extend the device driver, handling the internal reference and input signal
> > > > attenuation, enabling it to also support LTC2338-18.  
> > > 
> > > LGTM now,
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Ah. I applied the earlier version fixing up at least comments it seems.
> > (Not that I've completely forgotten doing so!)
> > 
> > Can you please check if there is anything different we can handle
> > as a follow on patch?
> 
I'll wait a week or so until the release cycle rush ends to send a follow on patch.

> Hmm... Are you asking me doing this? I would delegate this to Marcelo.
> If we forget something, I don't think it would be a big deal. I just have
> almost no time for this.
> 
Agree, the difference from the applied version to v10 is just condestyle/readability.
No functional change or bug fix of any sort being made.

With Best Regards,
Marcelo
