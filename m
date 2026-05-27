Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273CE40628F
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892950; cv=pass; b=hlBpFgTMglOE5Lmkr4KzqSzZpIuU4V42JdO6mFxtQn6I8sAnZWIIE++UuMj1kzCEIfA/66WxXWSFXTFral72xoT9yEjs/FQiyszzM8Gq2sW58TCgb7IGaRG9Iq6OYirjAXsRvWekec4cVXPTltWdPYRMa9jGE/AcvyHn2hLYmYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892950; c=relaxed/simple;
	bh=Wkjf0xfD0fgdDS+kPV5B88MN47vTkuZEVXzAIEFeTRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4sI2bujjyMz6KVYKTGgDCmFd/n3PIC8gy1U9Uk2KsCAJr/FTkR+oY7l2GIpF7jqSrS1E4C1kgDk/pxuN/s7fw/QBKIat5WQ9mIHhQrAuT4BjuexNVFF1ktpV1pf4NDheOlNd5Dwnh69qoDyWDjTQWW/mYP4OKEyu5c0TK+ivXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLswE/Vs; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLswE/Vs"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65c52bb5dd7so11342569d50.2
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 07:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779892948; cv=none;
        d=google.com; s=arc-20240605;
        b=gdGbt7DAsN48PrZUeyFFf/PBZb2gEcztg2TRJxrsC4p3vBgdf3ZySS+Vr8A/1d+9V8
         qjGvGcb+BtQtHISsmE73VWesg0ixtfB+UChfAlARexDxsL8b2EUcpHCdWI13jZMTtDfi
         IoKM4pHy2xzgHBovviYfdyODMkkD6w8YC62rf2HNonLuf12eKdH9sp5TEeu6QstdfJpz
         G6ipdyvekcWsKJ5cCvnrauoRkqAdXe9KQPJivThraTodB+s4A1jtzSS0usR8VxGH7Eds
         xS9JAQmET5ZOXJzp7NGck4fR41OYNQMn3NqApskFi0h1Vwaqg8mX4ljFp97WbaqVwSVX
         QRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hlWIP+UVVvtbpjNyLXvxi0le4H6Qgzv6+ziP6V6KTS8=;
        fh=5s8FKd2lCUGb+WrUvlccvj1cPJdmyWGxITiEzCYXWA4=;
        b=jCx3c6jesNz2tu8YeKBexRdXhr57fGzbSdpFKCTF9F0azVdk7SVWW88eGYRDoPd/JL
         V9PfW9xUX0rUm+8HAJtgLgPIOQzWdjdMD8BlDr08MhF04Q/ZnhnuR/gNoByRBWMZWLkq
         waBw8ZwwB8g6y7SzYc21zyfqt2q9SzuYs2Zt2xJGEfPHWDngmfElOwugdoCghNraTqFE
         ou5d22TrlX0qAOAj5tyItY/eQxczuSEQd9VJ44TRbkcf8T8T9s9G8WGpmmyLVMxJMCdh
         sn9GzIRqlfm3zMXpRKjVp4LlKDuLJ/ibOt2q8ylNU8nJASpDxAuSA5Cu8MwVVLGeAxW7
         DQEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779892948; x=1780497748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlWIP+UVVvtbpjNyLXvxi0le4H6Qgzv6+ziP6V6KTS8=;
        b=MLswE/Vs49DsA34EQyTLb3fN8q4HfRoJHVe7hJ3EZJHriNmCWMHWLfWdaDKqOR+Z92
         oBxelXDr1GsvkiGRHHak5Jzg2pOPB9D+JJNo2W02ug4noNAqfIprpSzu831vJIqsoNFb
         MNowTIjCz5SfR0XGP/hE4F3HL3wV63lBsylEOJIM3XpTX54z/Nn54MUwZcLjVvVJnU4/
         KCYgRhL1ZsvNZpzxV9ZMfoU1sl0F2JvR24i2fTMlBTVZpA7CwU/Tog+WpbtJannhRMw7
         n5tWgWFV9hjS4fC5AIrlLoyq5PaFrwLmZE49w0PM4Bdu5l3MZX9l7RfuAts+9gNheHrg
         8Mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892948; x=1780497748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hlWIP+UVVvtbpjNyLXvxi0le4H6Qgzv6+ziP6V6KTS8=;
        b=MrwFoqUCnNv8Z9Wic+TVI5HxdllNO3xzJh1u1Tm9Ow0BvenEbV6P1XFVZ0o/s1JcWN
         uMmVukpr5WGHKuHEir06afZL3x/UuFupuSus6mQUaWJAt/IA+yMmj9q9BpfZuaNgRSS/
         +3D6j+msEbMm9qCNdxoRDHOZoYW3JSwAqW6uoc1r3NGhg7K1HnFCFR2QJYrDncZIMIq1
         AI0Mrq7WMaG4haWtC7l6q5PwmKpZGjoly7rtveh3NKKV8i036QXba38ZO4mW2/YEFQmT
         wlINPGOl6X7gxqyuWOyF/vk+jk/gp1+jIjZhgsUinEXXiX4usu4RE38iPLut1l3ZE4ib
         GjJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9R0fTlJaGjQ9GIVasm0SUSDISXOst3Vm4H8FsqiwgIB6awr33FDd9y8lu4d7b9x7e5cZR1w45chsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZTsQXd7mGEntaX7GFRyIFJY7XQ/ipPGYLm3fpkMJailUycchO
	hHGhyW82i5ilCizDDF8qrKdKyWXcUuB+qZGRd19ujw9zS2+5els2QkG9QgOHb58X4sozI6BqU9L
	ErS6wRhiY7Yz9tQr6mXcwVfSLWBuMci0=
X-Gm-Gg: Acq92OH0LNGAMHmLe7Q1WqXGY6OGWy8qNb1e4XAveMR/DteG4qM/6SGNtT2dKe6hsds
	qyK+gm3TBS8paLyjM7alH6OsPO1ptdTcEsUqgoMIFwS8bA6B8wPBwoAhsbRB06V9GadPYEE4yJs
	Gyc1HxkW7lr0tT6fiCRwUFL2R7VqjfwqgEtqE+17InyLDwpmiDFrYoVp023s6p1ILJIOZ9DHO+Y
	Ztik4I/HQdmfnD2O1kR43rXkFIXslstdMIf/emfZaTwKtUT8lsIuKKHRdDrHn2xCiZVSC2CCOzD
	3RFlFxYQ4w==
X-Received: by 2002:a53:d053:0:20b0:65c:5b88:84a8 with SMTP id
 956f58d0204a3-65ec966be89mr18424914d50.14.1779892948116; Wed, 27 May 2026
 07:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524205112.26638-1-wafgo01@gmail.com> <20260524205112.26638-5-wafgo01@gmail.com>
 <20260526173616.256fd535@jic23-huawei> <20260527143515.102794-3-wafgo01@gmail.com>
In-Reply-To: <20260527143515.102794-3-wafgo01@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 27 May 2026 09:42:17 -0500
X-Gm-Features: AVHnY4KqJRjrOALhnhkMuN-1YF-kxouvAtTfdFTs73jWaX1UNoZiFjbArngVtBQ
Message-ID: <CAKqfh0GbHLALg8eEBf2EtmKXAsB=H7EXL=6D49yaNWiMutycvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/4] MAINTAINERS: add entry for Sensirion SLF3x
 flow sensor driver
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com, ak@it-klinger.de, 
	linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wadim,

On Wed, May 27, 2026 at 9:37=E2=80=AFAM Wadim Mueller <wafgo01@gmail.com> w=
rote:
>
> On Tue, 26 May 2026 17:36:16 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > > +SENSIRION SLF3X LIQUID FLOW SENSOR DRIVER
> > > +M: Wadim Mueller <wafgo01@gmail.com>
> > > +L: linux-iio@vger.kernel.org
> > > +S: Maintained
> > > +F: Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> > > +F: drivers/iio/flow/slf3x.c
> > No need for separate patch.  Bring it in with the dt entry in the bindi=
ng
> > patch then add the .c file in the following one.
>
> Done in v2.  MAINTAINERS hunk is in the driver patch (3/3); F:
> line points at drivers/iio/flow/slf3s.c.  Series is 3 patches
> now (types, dt-binding, driver+MAINTAINERS).
>

I was taking a look at the data sheet for this device and thought it
was rather interesting. I'd be willing to help review patches for this
driver if you'd like :)

best regards,
max
