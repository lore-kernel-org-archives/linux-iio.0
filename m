Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782459;
	b=cm0MRKJShhXfXxWt4oEj7sN02D74eoa+SfDaFKeJUKii+KK8+uJpsbdGvMG1MttARkdm
	 fZe1+bICxc6pY3fHI/mo3XsGKbCm+UnzZzXq2k7SzfwYror7xAo0T/y7i5JFT0rNS9s8h
	 TcvN79xLTdj7custXSdUujZSFZkM8Xcc1tNEn4v2lMdgUS31mjYFKrfAiWAXubgNSH2P2
	 32v/ZtsrpbQw0Pr1dBPyuY1sYGriq6oM54gB3GOLCrTXJdagHMERcapKJk0ONiJ9YttFD
	 Whoj4j/2MK5x9K22/VQ/Kxf4x1CG+sZk/NO+TTDvYUYa8zJS0vz3bSHnE4wk8ZxfdLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=995SOgcWBB026Ztcaii7kwHRKn59ipdNGgwbnoFQZH0=;
	b=qwGy+P0FsyqSAPLwWSt6r70/sm98DNGE8cGFbnx9NcF0aQGPJv9N1ZGXrXtdvPApXGLh
	 IqswgwFEl3s2R++pErv1keVrT4kaTB3v0sq22iyOzxQmS+NPloWs6xVJRFfh/IstTKKJX
	 Yz38gEpOfAm5FUiQjnBp17BswCFKZQopKm5Wl8zTYnw03zlLHq4tQs6aQUyS1Ei1wMfsE
	 Pp6fDicjIvL9dReZy37x6C1Y0z42W/jHKLZcQi3XTrm8/A7YmWi7deBL1FZ/pjqGwcLOv
	 Ct5TtoIjzzW5lw+rMVQ+YNIYhKSWc+g3in7Be82f8aAc/JLl8OdFimBdikjd8eWIRoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hxZ0G9Ms;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB75606A336
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 08:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CB75606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hxZ0G9Ms
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b30cbfa628so5733307b3.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 00:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793782458; x=1794387258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=995SOgcWBB026Ztcaii7kwHRKn59ipdNGgwbnoFQZH0=;
        b=hxZ0G9Ms2bXEh5gQJZdNqjnx2lpt6R1XWLc8qWOrdhhjkK+LOEjyXqIOolu6ay0jTq
         GyZrycPkfvSjp3XlXU2LmYduWVgjHEwJfeVAPEtyyGOB6mgJ8UakSs7StUoej6/oZ+6L
         tGV6+SkSg5NZOvGBXbC5dZQ39prmruKSPmBQX0INnv0KscvaGOSDkkaYre2oZZ+MZ2Is
         ywu1wQqVelzsnzzG3ZrnvNx59HwAHvMlSvpIniWRyNP/y42RtWYToDxN3KHfao8vzzC9
         kSX/XpkllP4D7BRvdqFTAqnwzVBatbteWhKGYI2d/7Kyxx9irXthmzRlMFDpycX9jehZ
         xw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793782458; x=1794387258;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=995SOgcWBB026Ztcaii7kwHRKn59ipdNGgwbnoFQZH0=;
        b=ZbY9iNXDRPSWaz5rGd+A6Yo4q4+g/24XanHQRCWtt3IVS6EfFqXxw4YTmXG3JGqV0x
         11/tVjZ+MjSuUkmlCy+S9wUia9dyxIJTgxoZLYAVJqeniJ1xydpCTA2JgqG2mpv30h47
         eWiJbAcG4+/K/KpBqpOqv4RNJiMDkYOtKuDCCsmw0xPWluu1njlhu7C/QZ591sin+gzC
         PYuSGq88ETt085E4lg7b8PpZNmtBWrBhZFdB3tgBwTJ2iBl76nPxJQrW49ycYXsigUpZ
         Oz07wExUA0+1Fxcdt3WD6wNDY75zh0BHUYytO9vAXX9WpKVivbuB6CuA1S9BmBCxhWeH
         /zmQ==
X-Gm-Message-State: APuU4Z8Hs0N47RoHCMGVQWcpNZ7TyeuEwmDGtoo8lujVjwly69TjqFva
	BJ26ShA0Py8WJctfHTi1jmDN0tSBXpG07VTzsOrGEmMK5dDfqu2pik71
X-Gm-Gg: AYBFou1jg3iz8JTJFu+7s5mlbyiCc1nCPBjTmY1mTf8siY+Yzw7yE2Wa6ecm9cp8asp
	jLRconU5t1BFxjBgZDL5qtWpjB5f5D2aJmCcw9eEVOIyFpG+9BhxJERC7sHJqxxPrLeGmSlGEjC
	mO3IVMrWhKrI4gtRaqe77nWWudsq7nkiIypchB0XaYJaoAfN7UhMtHitjWOPlPGq8sYFQ5sMNBc
	nHSdHP0fgMCeOVCOr9VhdAUQwN3u/LBqeGT3QUuR9nL7PwIp4dCrYVsDdJzRGj88p5VXrpcs7uG
	Yax3nebL1CkHymb0Koqc7bWvxd5mOgxtAZgdZXFzrEepyZpCSRo/igVri92PrAMZZa9FMxQobT0
	RpU6bvNT//0mmsKDDiBWnrnOEvfIv9Kap3oi4oe4EhxW+37zw/Ct2i6MH1Ts78msJuSwsb3KEPG
	IzPDXhefV4KTwObgFJC107q3vyPA7uzVyO7YeESPT0s9peLGeRycpn6ksgufin69uVgXH4eEA5i
	O9xVkAciQ6jPFwNOqmG4ZB1VBj9tgXbKP7DcsJh0t9Ma7VXfV2BQSENEEgZAbrruuQMurnCIIeY
	9RSnSOgC3daB7LiV0VeKTLh3VFhscy60+CMHFif92ZSUPwgjg84K65DX7cHX/Kj74g/aOAFsOZS
	CAGrv00LpbpxPj9Pa90pe6QJ9
X-Received: by 2002:a05:690c:dc8:b0:8a8:7fda:15ee with SMTP id 00721157ae682-8b2b676a6e5mr116717537b3.50.1793782458184;
        Wed, 04 Nov 2026 00:54:18 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.31.netskope-rdns.com. [158.95.44.31])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3098c3174sm14420647b3.12.2026.11.04.00.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 00:54:16 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Wed, 4 Nov 2026 05:54:07 -0300
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 01/10] iio: frequency: ad9910: powerdown fix
Message-ID: <ynwpqktxxbunqm3ee3q7iogrjynlz3egrwryfb33vsp7x6wcqr@uhfsxwrpsyhu>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
 <20261103-ad9910-backend-support-v3-1-0e9224ddf7b7@analog.com>
 <20261104002042.10064e8b@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104002042.10064e8b@jic23-hlaptop>

On 04/11/26 00:20, Jonathan Cameron wrote:
> On Tue, 03 Nov 2026 11:52:57 -0300
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Enable the software powerdown on all the applicable CFR1 register bits at
> > once with an IO update.
> > 
> > It turns out that DIGITAL and REFCLK_INPUT powerdown do need an IO update
> > when enabling the powerdown, but that is not the case when powering it up
> > again. It is an asymmetric behavior, which was observed while profiling
> > power consumption in the lab.
> 
> Just to be absolutely sure I understand this right... The bug today
> wastes power but otherwise doesn't break using the device?

Correct! 

> 
> I'm just trying to judge urgency of applying this. Is it fine
> to go with the changes that follow later in the series or do
> I need to rush it in, potentially delaying the rest.

I'd say that there is no rush.

-- 
Kind regards,

Rodrigo Alencar
