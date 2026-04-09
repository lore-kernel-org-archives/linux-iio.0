Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C378826290
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771175; cv=none; b=EbHSQJa0+lFxGclcqVpkOFRvJ08oqVb+Bc2pu8vJoDiEVmp7ZFd4Kn+p+4wRiuunyE7UcHNEoAvTFfBRGC2ujlkSD+RQcGYPoUxCD3wjIXxI9tG8Iqt7+SQUHn274nX+7UfUkaiKM8iuUl89Kss84PG+i7Kaw9HTCKSN3CrIznc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771175; c=relaxed/simple;
	bh=aa0Kv53GKsOZPdXhCjjoUJZEwKI82rcoBJpFvZGdXYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrQ/KZtOQlp6erFfvO6x9YH+bkmoszvZR65FXYUwaghxb29x93cs9ZURMGlScm0EfMYlUAJ66dTLARQgWNgeySQRaHR3rFRr3ZpAWf2uoD6hzU9wePwaMYHlqiiqCEyaR9vxKOc3JV0RG0IrXNZb7qQVoS12BDdhvQBx8Bku3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxPvrslU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxPvrslU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488c2690057so13897645e9.0
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2026 14:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775771172; x=1776375972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKZ97EUNpti69PwZiOZxOsJQ3NBK/kMV901OOo+brBM=;
        b=KxPvrslUr2IYnhIGg8Q/umkgYuonsZIKpceFeRmxznxwSr9FrR96M4qA3SZrhxOcOV
         qR+WnHlyeAMv+UMnGCZSen08VwIC05LpT68nJprXuFGld86ox7dbDSK7230aNRSYEHA0
         hFbzfIWH2pW0n38X+HJ/rdRW476vS9gIF7mMrw/vGyOxVMkdVuHMui4hi/Kk2OhD6yD0
         cu1UVC6wpchDwO85BkSswI3IcH2ZsA5CB6EWxJMpevneYJWvwlKBSFYMHNP2xo2S0oni
         P8UPAjWiV8Iv0n/B2l7/85rbuzDWOqQ6ApVLtTlKqTIw4GvxClufq+dAegjfgWKNbKpn
         3Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771172; x=1776375972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zKZ97EUNpti69PwZiOZxOsJQ3NBK/kMV901OOo+brBM=;
        b=k7JqifOV4cP28g4SDWwz459eTgj0gT2o9/LJwxRUsOlW3FNkSaIdZCdnW6AjoW4W2x
         OxCzCsFfAMcP21MXBuRjfxA7yBw+/tqq7D3bSLKE+lu/rXnUw1/cJ6owmcROFOpmRm+M
         qZfhO9Qtw7R19Po/CA7XIRMPFLzSDloMn/FJ67b74sdsDkbaZvuSaROhLSs2Fw0xZlP6
         P1X6TKQ9WS+0ESLqa7i7NwLARGOyUNlVStkAJHJgG2SRb1Fv/MR9FEtIBpPA8kqALZGw
         RzJEoGdZrXR3UwvIuIMTD6lDwF4LnrhkCN6Y/mhMQn98700VxRtxe28njl29wdSwvIZm
         vF8g==
X-Forwarded-Encrypted: i=1; AJvYcCWrWZb73ZzU9SmoA8hIK6iwhmdU7CvOIDEFNB+2WPO54vTmluLY5qrTHdBX+1D1ENyc40ZGcHEFgz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznylhxXzgbrX9fjSlO6b5X4XkV/IV8KoCG7lv4PhXP6EmlI+yp
	JAHEm1fHo9STGO0L5dI+FlYsBuBaCdfX8B2BI28Yt4joYu7ZD62Ys4/G
X-Gm-Gg: AeBDieu7qxWnj9jkZ0wxwXFSvgXcJ8VXt16NuZgFAY2GPaWMTwvkYnkjK+lR/WdaxuW
	LFJarMmvkUCeGmaA/n5HfOl61ySi2NMPmKpPHOgcLJ8MMHEQZfcXEk/Hks7X0t16Odsp7ND2zBZ
	1R8lLzIzqmw+z7lVudyo2D1XNApKN6Dq+Ob3N4PCu24oEiTj1gw/mxztxe702UJcP+yby7Zg8Y4
	zKZttZFtYXdTq35eFD8hHf8ttoJY1aLL/uTROfmNhTBv5Go/c40uFlKH++naXf6rXIhaHVRJjFF
	rptF0AxCdxZc4NS/oIWkS0uONJH2fWBc/O+K4KzMiz2uQUo8FxAkGeq4c1Zds/lYE4/MJOE4zfv
	c0gJmPnPAzKFHoGDznLsMrvjU4JSuKF7qJ3ynC7TLEf5NnpXMZ8Uk8Rjb8XmmQLh6RAMBoHp8M9
	rHqrGyyqkazTJnvypxZHU3WnpHzYmgoJyvZJ8Li7XZb4VTtUU6vBDCGU/lFv1pRZJYPMy2GuuMA
	bQ=
X-Received: by 2002:a05:600c:8591:b0:488:a824:fe04 with SMTP id 5b1f17b1804b1-488d6abe9e4mr3406955e9.26.1775771171966;
        Thu, 09 Apr 2026 14:46:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3cbb2sm22726265e9.13.2026.04.09.14.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 14:46:11 -0700 (PDT)
Date: Thu, 9 Apr 2026 22:46:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 greghk@linuxfoundation.org, dlechner@baylibre.com, nono.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH] iio: frequency: ad983x: replace do_div() with
 div64_ul().
Message-ID: <20260409224609.3e36a208@pumpkin>
In-Reply-To: <CALoEA-yVCyyiA1gUCj4Z0JcLscpSSssPCPXnUPOciWJOHj3VUg@mail.gmail.com>
References: <20260409131823.1289-1-joshua.crofts1@gmail.com>
	<20260409182755.499a419c@pumpkin>
	<CALoEA-yVCyyiA1gUCj4Z0JcLscpSSssPCPXnUPOciWJOHj3VUg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Apr 2026 21:58:20 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Thu, 9 Apr 2026 at 19:27, David Laight <david.laight.linux@gmail.com> wrote:
> > Except here you have clock frequencies.
> > Either they fit in 32bits or they don't.
> > So the value shouldn't be 'unsigned long', but either u32 or u64.  
> 
> The clk struct in linux/clk.h explicitly uses an unsigned long to represent
> the clock value, which is used in this driver. Using an unsigned long
> ensures platform independent usage without type mismatching.

Not really.
I've NFI why the the clock API using 'unsigned long'.
It almost certainly predates 64bit and any real idea that a clock might
exceed 4.2GHz.
It might even come from someone who wrote 16bit windows code and wanted
to ensure it was actually 32bit.

For 'platform portability' clocks are limited to 32bits so the 32bit
divide is fine.
If the clock could exceed 4.2G then you'd have to use u64 throughout. 

> 
> > You need to check the domain of the values, coccinelle is just looking
> > at the types.
> > Even with mclk being 'unsigned long' the code is fine provided the
> > frequency is below 4.2GHz.  
> 
> I agree that we're not dealing with potential truncation problems, however
> changing to div64_ul aligns the types with the clk API and scrubs a perfectly
> valid cocci error.

cocci only does type checking, it doesn't know the domain of the values.
So in this case it is almost certainly a false positive.

	David


