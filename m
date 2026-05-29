Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88D6270EDF
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058970; cv=pass; b=KNa/rEV4i18o427Uoa5eh3lAyJBEPhDDUpwZG6BMcpCKyJQoJJwyXuybl+jU2GGNLblLhGZQqlw4iyMpGEA435xqN9cGaERw37EUheJJnxmn2rObZcL2vGHuNMglkd/gPFoZTcjPvH+4jQ12BxP87xZxrHG/96kP8Tm/71Poa3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058970; c=relaxed/simple;
	bh=wnAYEg9vOROpsL13TeQ9svG6rRxiCECbhZZHUY30t7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqBVksTvWc38Lr7uVspnA2V0sU1VulIqJ+SCIISdlmOqPxWTqhDvqMdCfweZWicRcFL2nc0sL5zhLt/ImNpwfg1D9DKM3zRtsK4eO8m42pSywMT9/OmkdzfQwBSD2txzNg/dc3oXK+kpUvBFKXojXxTz6AH3YzU5y3Y9nSnm9ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sg8rYOj3; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sg8rYOj3"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1370417c01cso6514922c88.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 05:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780058967; cv=none;
        d=google.com; s=arc-20240605;
        b=jCWo5h1N9iWj1lS7iPDZ33uOmmrxZcXUajNpjgIdc2Spg86cq8rC6NOHKqwI8Ac7p8
         DIzQVqcqQPoNdj58Gxornk+uRF6a4ZouJHgFobl06D8DlwwvA3MUY6i+yk9UWTZl6usD
         p6QVqcAG8yaHwhLSyKCg+SHMbsvkWEIlrssyGx1sO4ogUyXTBV8TPRk/iyW+isRE6eW3
         loovnP7FG4bV4UZ4QCyjLjBBz0PpCBnzOGvmxNFK1WCxICSRaXgJPyGjP3kmpoBKAHKY
         sWul38WctI4F7uKgO2/+CuUJlEQvav6/12XkpnJEXff1HZHTGmcL6WXhkOGojkyeTbwx
         bXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b86HzbFDPFZFe6VT99TCPFl1ySb6jYj9OLb2aq8afX4=;
        fh=UBjF/oaYi4vC6OARkco+8hEEXBrCV+v5SUUTBWTLU8U=;
        b=lRi86EMvPvTzxMyRqvYmvamEIJ9jBVaUErPSx1jJW/V2+1mL9+0dOlGgOjLHEXMxfn
         dcKlCfN52SZxxw0qtFex8evpKVM26s7LdbXNMrbhnqJfc1WeCoYk40PJuLuFFOVymb2w
         SpXkPz8KEyZZkETRrQ/qyrq6Z5Q9aioOX/HNtgZJpx414cRjeXuioLaxIb414/14vale
         51QflHoNiO+rO/s+/zRtiVE/oweDPRcUWHGXT5u97CATasaNFBqMscmxG6ENhztfJ1Bn
         QdAevKJccBwKuRwd1gw96KHa8Ri1BpBPtiMIdPaggW+nPJYJ2sVGsqYS1xFe2xFG7n0u
         /kfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780058966; x=1780663766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b86HzbFDPFZFe6VT99TCPFl1ySb6jYj9OLb2aq8afX4=;
        b=sg8rYOj3esxI8AT+SHKJhrBeTiVtEGTqr0UDLYmgI4VQbM3WCTfKG8j+G8G6ZaASZI
         yQ6orClsbhlr7l13zoIUEsoYLlmHh3q0Ivwx1IdmbTY+ao9zTudN3vIHb59Js1NuJ8h2
         VjkEVQMcN8rw7z8UmRjQHB5IcYAKF0npFOaGvG8LKMXUb7S+utGabmeFmwif6CtjvGou
         GKeU79FQqmiau5KhhF29Nwg2QKxCdmkK2JBc6EiY03vCJ+oqVhwNMhwn3Rg/Z5vZ26K5
         zTcckfTeAPCuJzXEAK6T70zIaDVuAlZ7pXOl+ZR/QUcutGz6LgomRApyqmhVoCKo1dg7
         56AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780058967; x=1780663767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b86HzbFDPFZFe6VT99TCPFl1ySb6jYj9OLb2aq8afX4=;
        b=g6LKZ9WziXt2jCLI+BhRgYDKPPxjJDEFhNKnSMIF1YEjF2Qi/vz4+bO6XkiCaI1PG2
         NDQ67UMEGLvP/XxlzwAlQ/nghCEP/ZWOeLiSCFwRbleAohPCGWbGo6Li94Iir0RaH8ZY
         IPWgGyAoI10zjPVLMdwDOqqcU5APmLSfsce83RLwCJLv8KdGri4dd9YZIr368uETfEii
         9T1KjRJMCaXKgrPs6Oy279qcvFVNKsqoKNX2Lw0JSQRxMDLSEtyCivbUvVBUmz7UFKLl
         MqVJTlUWrw+JnzmoZiUxVpHevLVLpmtfcJg+tDOSKtgZzqFMmgNySiCO8fjalXCsYUL9
         +Mlg==
X-Gm-Message-State: AOJu0YxrCUQ6sKK/DI2PDSnyV/wRLPc7btdSOZg2Mrte8WShWCFtoqi8
	JLcdD6Xs99YhsY3Tg/dpFqzv+2o8BGuM7XhU4ES+7cTuDnFTwLrgCaM+WDNurYXnfbEv/vj3lpV
	wD9NTVXNCC2k/8QThdYKzLywAa7opRmsJSyAiB6rWqQ==
X-Gm-Gg: Acq92OEPuanaqWpw0veqW0Uf8HwRuYh47SwZgyLMz3DmIheYkJC8XEAi2KREYGoE5WD
	inBpYMj6PEqbFrdkj6Y7nJK/04j+MLRb6uitqOc5MppKQtbGXvjG83RGHhoinlIiM9iS54NmsgL
	UOTC8DQ54zc38n/g9aMhHYys36FjVHGWV2k3Gs50+VE9h8b4Neg9cFDF8ylqdBPWOSFc0MTRq7t
	K1S0y7hoQw+zMYhw5yfOa9FaEDdPBRRu/dJrSmrhLpfJ9hQy1dWB7xtBLDS0IZpVvJP+q4+LNG4
	kmRnsF4l2uLNCBxwYK5C+gQMGNFkTCaYQGeX8n8kEJvHIkqqx/VqI2QRKZ/JfYTRitr3UGAZatB
	jGVTwu19ZvNvDI31g
X-Received: by 2002:a05:7022:ec86:b0:137:9ab:2cde with SMTP id
 a92af1059eb24-137af113ceemr1006345c88.32.1780058966526; Fri, 29 May 2026
 05:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
 <20260524085312.15369-7-kimjinseob88@gmail.com> <20260528153036.3fe67c85@jic23-huawei>
In-Reply-To: <20260528153036.3fe67c85@jic23-huawei>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Fri, 29 May 2026 21:49:14 +0900
X-Gm-Features: AVHnY4K-djBwKZm3kepGPNtrB_bDZtLs_aGW98E47Lo_OnDo0EpBY5G-6tD8ZSA
Message-ID: <CALMSewL2dxWuq3BE+ni9pPPBichKM5v8QssDs5gQoGWxwHD-og@mail.gmail.com>
Subject: Re: [PATCH RFC v2 6/7] iio: osf: register IIO devices from capabilities
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, May 28, 2026 at 11:30:00PM +0100, Jonathan Cameron wrote:

> Various things inline.

Addressed in RFC v3.

> Why?

Addressed in the v3 patch split. The core/protocol/IIO changes were
reworked so the includes match the code introduced in each patch

> This sounds like it makes a duplicate.  Rename to _isduplicate() or something like that.

Addressed in RFC v3.

> Another place a designated intializer makes sense I think. See below for
> other examples.

Addressed in RFC v3 where it made the code clearer.

> Maybe reorder so yo ucan use a designated initializer.
> Technically it will zero the values before you then fill them, but the
> code is a fair bit simpler.

Addressed in RFC v3 where it made the code clearer.

> I'd flip
>         if (!indio_dev)
>                 return 0; /* Nothing to do */

Addressed in RFC v3.

> Seems like these changes belong in the earlier patch? Can you refactor
> that to avoid having to modify it here.

Addressed in the v3 patch split.

> I'd put the found block here rather than a goto. That simpler
> flow is worth the cost of indent. You can also flip the condition
> giving

Addressed in RFC v3.

> Some of each of these comes from an existing structure reflecting what we
> read from the device, can we use that structure embedded her instead of having
> to copy field by field?

I reviewed this while preparing RFC v3. I kept the cached runtime state
separate from the wire-format decode structures, but reduced the field-by-field
copying where the decoded data did not need to be retained.

> Neither device.h nor kernel.h should be included in a driver, unless you
> are using one of the few definitions that need them. Typically there are more
> focused include like dev_printk.h which should be used instead.

Addressed in RFC v3. I removed broad includes that were not needed.
linux/device.h
remains only where device APIs are used.

> Only seems likely to be used once. So why have an macro?
> Maybe it is useful just to put it next to the others for visual comparison.

Reviewed while preparing RFC v3. I kept the channel helper macros only where
they improved consistency between the channel definitions.

> 0 is a terminating entry so no trailing comma.

Addressed in RFC v3.

> If this isn't needed to silence a compiler or similar warning: we control
> that value in the driver so should know if this can happen or not.
> So probably not needed.

Addressed in RFC v3. I removed unnecessary defensive checks for values the
driver controls.

> If you are unregistering something that is null something went wrong
> probably.  Seems unlikely we need this defence.

Addressed in RFC v3.

> Then this can be done at declaration above.

Addressed in RFC v3.

> Add a comment on what the race is (I assume) that gets us here with that not set.

Addressed in RFC v3. I added a short comment around the iio_buffer_enabled()
case.

I also addressed the Sashiko feedback for this patch in RFC v3 by fixing the
IIO_BUFFER / IIO_KFIFO_BUF dependency handling, rejecting channel_count
mismatches before pushing samples to IIO buffers, and adding locking around
cached latest samples.

Thanks,

Jinseob
