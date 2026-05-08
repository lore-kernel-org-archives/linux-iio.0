Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D33DEAD0
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248284; cv=pass; b=dynvp0k1qr7rFz/o8nQOtrRFLt+aNR0v6Qmwj/ZZdREGkjf+AYQ7AwhakA02wbvnziLlkqWuCMX5EeICH0Umj+6kz9wCCuIjj7M/xzc/C+N9/hTqq4VEgLnps8WmviPcxhOlHotSrj0FUPdf28BQuWW4ayReZO7IIBQ71+d3FeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248284; c=relaxed/simple;
	bh=vMGRu5UP+HxQLHcHEu3EgY0sT7rkPnkOA1sZlQRI51M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YR9Ne3woBCgKCdPn9pWYYt8ODoCyXU1EI5ng+Sb76bmzvyQQanXkeiZKDtgEt/qVCcm14tr1HAIAUHTav86K1ToGoJ8mrmiCnPkF287KisdrSTa3lCxmaxEkQoJoDwmxFl1tIBMnEUJRqeJp9z/YM6FgMyPBEJ0fyjSGLjFNeZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj9rGNue; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj9rGNue"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a40d02b58bso1428113e87.3
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 06:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778248281; cv=none;
        d=google.com; s=arc-20240605;
        b=PHdbDOMfufGvXdem2ToSXojF12nSH28ZgxRwyP3vpIT2rm9rP79IGUdmB8MqRKw7O4
         1wHXn9dD44nxkMeJ4mNXKiv5l/rb3kG+W/Tw6ZKoa/4ATETJJLmDUUMblES/Ijwd44tI
         OkNFohPLrIRjwX8TepmOSiHSlx087syzYEEBrLl8QknvMTQoV2UhuFKaU/CphMvkpiQS
         KR/CHNzWnFKqmjXy5R0DFghtsurCQTS1Zs98rTob/atIXBh7Qlwaa3hpnqCs0N/I2bpV
         PLBJd827Oi8HmB/9Mfox0jYgLjGR5KtFSAzJEsIBLvW423I0yON8xuwC8lAeFijZ2yb6
         tLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5Ch+ggjtADKUH+qT1O+DxyUhpjnpiaoh2/HLDng+OhQ=;
        fh=lj7lOMOW6Vc239qavxjs1kkML+BHnDCDtR43tH911iY=;
        b=OGH3IwoZb2KMU51h8pA8Z/xmz02A+ACkk8Z+Ic8A5D5u66AehOXjyd1qVRtCwOnUIj
         2ZZSjjvXHIL5UMejAKgWhPDezTtXbv95G0SS2idPUqCcMgQY8frjP6LHPbQDaorRP/Th
         /LWKAl+VOgjJomggjBZKYdZD7eXh16vDD+iX5ITPMePvydhT786/lCNxEbnCFNIcrGVd
         Mt2T1TTH4Qis/PTVjoAuQ//FmdeiPLPXAms8m37xL/nRwlkQWsvG4FkQ7RmNlhJyPl5P
         NiUngQsbHDu7wEm4D4/StJ8aGUBXNrmXoxEgX45ePbiyN8V5SBPHUl6R6ST1NRESnj/o
         7egg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778248281; x=1778853081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ch+ggjtADKUH+qT1O+DxyUhpjnpiaoh2/HLDng+OhQ=;
        b=Tj9rGNueFMwQ7qfqZ57PB9iNWc0vCoYCgDsNWOvQ/q2rFpAIwiy7n5hdoNwgrZPbhh
         u2maHKj3vxLkt8fg+nRqEnpu5QIZpumypCY8xkf7SyekZa+gvnVi0sKTHR/cuijZoUAO
         BrZJJtO6sRansbXT6Z1+z1BlJzj3aKSFGEeyCSCXLPShTCoTDW5pnc4KshO4T9C1s6mY
         YIzBkEtlYpWJ/qpWbuqE3dU8IufHnnbg3stA23YEKlgtjdGkzVyZ+SKJzGIjHIFX8Qy8
         HfJ1R21GekFMFEq8JGvMe0wJ/Fxuzv2pAof4jQTHax8ANnaBE4/yZZJ6SXuBf1l0+MKG
         S+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778248281; x=1778853081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ch+ggjtADKUH+qT1O+DxyUhpjnpiaoh2/HLDng+OhQ=;
        b=p271v68oeQ02P37TRKtTOiv252QAO3LiHph6XK3Lus27LYnpg6ibkMGW20/wKxKobC
         DnpBiwsjTOvcMqTOdwpZOXYOmMv2WHml8meKBJNLMyFIq6I/gGQVm/7wOoYLli/8dquc
         e8tzI4s432lgCWreGglXuQhOdryUiMLXhuotXvvqSUUz5CnoFbRhr6KOhHcc1Pc/4oe0
         /ml6ZI9Smdfi0z/UA3OpdWVcHEkprp/5rSl+E/76V4m/oCIcc+4MKg37hXUreFJmA7au
         Czs+uhSovMxMrGQGf8gcFmBIKGlUQ4LYkMndSRDIdmAu5SQLnV1XdsyTdRQ5O46Ay8E4
         r7qQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8S5et0JfBGKx/aVaj7SQpb8vdl216iXx8P00qoDUbLWYV9Jfz/xFeUXGhZt/RLNdpDbAnjUUUTHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxraFrCtJqmXE1cLzJJsMKpg8FYyMaSTEW7K42yuLNccQEPCB8x
	0XXikwXNVtfyDIdlcll/9IGLZ2fKryTJ72KboUktHedfilCPMH+ugzX0lHCDT6aefwWO1W1iMXu
	nWBXoepFf4kw/hOVI0ABB+jHt14JiNp8=
X-Gm-Gg: Acq92OGYwX1nX3yMABwcjNbS526ediJL9819oX8Gs7hpriAnwHtyeOM5+BLtFyW7uOy
	wvMavChs7ksEM1F9MBQCisJJGHlepW4S4sM5hBZYxWkm1BfaZgyG7lbsFpjzPBKPERGhWjmQiO6
	qQ7PKgm+EXR+E7WuIyrXFNRkirXr8zFoBungJX0wMW9x4Pgvm60X28wL9OO1WX8kNazpQntVlLD
	akRAxETlgUxAQwAanN2Qgfi2Bo7vI8d0IHl9y2G+u6k0VegwLOVm3xx4IIOBpWVI6Dr2l/BZ7PS
	9ezLnfv5KgqlRVveu1XUlk2zFb/LiSRtefCS3n60r2SkvoGxgZOQ8eJTryHVMsmvZcmNJdvTQV7
	qfTYuUGHGZu9QEFbynpGIrHHdMPYvdAwHCNlWL1pABZ5yx4aokiibLOJGXoFAWOW9Id2xVpk3UC
	9re1bpD3WBr9cDXdwt00U1w2kTyTL81vXwNIQld8g=
X-Received: by 2002:a05:6512:ba7:b0:5a8:691e:abe with SMTP id
 2adb3069b0e04-5a887cea566mr5489054e87.30.1778248280543; Fri, 08 May 2026
 06:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com> <af2zup3PFlgs2DtE@ashevche-desk.local>
In-Reply-To: <af2zup3PFlgs2DtE@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 8 May 2026 15:51:06 +0200
X-Gm-Features: AVHnY4LdMequRrG6nfHcEh1aJebR5-BMcW8E5HZcw1MvTbmhmTZqNyUKtxVoP0w
Message-ID: <CALoEA-y-Qg22NSfVBLtqx4VFp0q=xqLOuL5Wf8TxW1AswW1+hQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed resources
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 May 2026 at 11:58, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, May 07, 2026 at 04:35:52PM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Switch the driver to use managed resources (devm_*) which simplifier
> > error handling and allows removing ak8975_remove() method from
> > the driver.
> >
> > Note, on error path we now also set mode to POWER_DOWN state which is
> > fine. Even if the device is in that mode, there is no problem to set
> > that mode again, it should be no-op.
> >
> > Additionally, remove any pm_runtime_get/put*() function calls that
> > dummy cycled the counter to autosuspend the device.
>
> ...
>
> > +static void devm_ak8975_power_off(void *data)
> > +{
> > +     struct ak8975_data *ak = data;
> > +     struct device *dev = &ak->client->dev;
> > +
> > +     /* Only power down if currently active */
> > +     if (pm_runtime_status_suspended(dev))
>
> Is this one a correct one?
> We also have pm_runtime_suspended(), which is different.

As we only require the status of the device and not the power.disable_depth,
pm_runtime_status_suspended() seems adequate.

-- 
Kind regards

CJD
