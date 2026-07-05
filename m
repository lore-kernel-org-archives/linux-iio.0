Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FC986341
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 01:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783216643; cv=none; b=SU4dqix3+2v/rPd2id71W3vMRnyiK04U4TqPw0/1NzCsD8tslamq+353pzwUHl37k5lRfRvAqMeIX8H4tqG8CAY1H/AX/guyQEBHXplITBWTU05ftl0KlJcFkye/VRDKFCoD9wK6XfpPE+UzbccWKY2xU9KQ7du/QRZjZfsxNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783216643; c=relaxed/simple;
	bh=Uc1UeSgXcLQisE331Fx/w4AxESxEfcZ/fW5sTxYv6NE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3B2U8DdrBkZMFD2TiUi39BjHgFl2A9Pk6+OT0oxKygROczqlRii6iQBc1rEeNy30Tzyq9EgES8sa8Gnn7bsvHJcgd8CLfmKnyFELn5lBZmmUpHO8mbZxorIRHu1n8AVqBqFN1xLPbpGsaabs3YwiJs8nfBynCl4OJksPPi+k5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3oOCAHr; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3oOCAHr"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43cce34c881so1353251fac.2
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2026 18:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783216640; x=1783821440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g8dZZ0ezVRB2v/8tDo+4cmpTy+MFf1s9r33Lw4vpQWw=;
        b=H3oOCAHrySC2Fm01dzULXMt2eDdGPgfwTLrACNGpiCu2gUByxo9N4spJqLyDY4IKQf
         TYIoliWnbD1u3myJ4G6vUYBk3hr5P1c7koz2I4FO4Ut/d2qRuOr14vKZM441PQO1Y6wZ
         iRHnJrvrvNaS766bROy+KU9qYdT5nr7WOeOBL6kLLT0B4vfZ3sdRIelSXLFX2iA8TWNd
         mBAQB5LMnJZto7XWroghP0ZJ7RYMJHgl7/aiewv7Izdkv11W0xC5HGaFTq03ZyfLP3z/
         8DM/IdiR5m5TmqBCLs1ZtI9rhYudzdDnzsxodrK91IL9Wxjg4mdDStSDXSgB1jIRkul4
         X/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783216640; x=1783821440;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8dZZ0ezVRB2v/8tDo+4cmpTy+MFf1s9r33Lw4vpQWw=;
        b=kbxk51fgkQb6PYKNjuiA0xpiZfx7vzByybL7QTDEklLAu0B+OXz5PWMdfg5rOaTt4v
         IAdHX6LpVRaij7V6QGKL9prU046xfiv9tlyYOv74QNTKsdHCFsCjQZ9Rx8kwMAmghDmH
         6TGI3HZJnG4bKGwdT1tR3fjYa+GQN56Mc5TnYr1p9mQX3Y+1FicBPiZ8Gp/+5GWv+OCb
         7oBKRVne5q63kvGjnnu3sOeIGcuRPimueO89LAJ3GjZsU5w/ByL6s8XrDgaCl2B3iXDS
         puXATik7Ki/FNThDugN7KkhXa1mH3vAjbMZ/0iEFRm19GkRPN3xhfCjrG8QPhGVlDllM
         cpfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5Lqc4XCOeHcNP56XH5MVW9PKpx6kWkXxMeQMkmT/OvyYEPzZ1U/l9QuV8HIBaE44M7WJhUsUZ/Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPALt5oZ4KheympE5IOPLlMb22iR90l2lbMZw7aV80vQRxCE1
	mLb0nSJGpdOlJqw3FE/BAquZ/gM9C+TMmkZG15Gxg0Ot5poM9gDnNPhp
X-Gm-Gg: AfdE7cmoL1aSOHFzUn69JKyVi2xZGeb9Vw2FGbHVPGPZyUK+EOqybTjG8vwnWp59ijT
	dkv2T3Og7buCMdx1jz5Wff3+TdiFlq+0ZKeaOJuqyfB/HjP1fYQoV/N49siw5TY8QGVRq9rsKag
	sY2+FTVVyQza0axp7SccGXwt8rxp8zaTAVGyjGDa+/27SFPyRlTFBcC43aEzyCksAN8wfJLi6bm
	QAi7GVYWQAY9UGMaiPWaziJqsKXmJ6nFbU3LhISHD8y9tDSDqnWx08a/tGN76VcoJc7ISwVsD/C
	VtlTwiPVqKE/JNON5bRqxznZbj87DtA/ebaygUrw1c34MKbM+o3QMPiQ2CQXZjCWIuHa3Ar5bWn
	Nbj9250SXrdLvhKQw5d66I6JiQdtOPd4xUGqwzjrtLv/IliyN+KPcZ/wPdW0vzrxKVhsLS4u2Ne
	PQf4jFRPQa5ge3qJcF4wpgq8l0bYuyFsthf8ken/ogWOz3bjzpVqnf
X-Received: by 2002:a05:6870:8a29:b0:448:5591:15d8 with SMTP id 586e51a60fabf-44d18442248mr2902707fac.36.1783216639884;
        Sat, 04 Jul 2026 18:57:19 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb1d011asm6467451fac.8.2026.07.04.18.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 18:57:19 -0700 (PDT)
Date: Sat, 4 Jul 2026 20:57:17 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM
 AND DRIVERS), devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 2/2] iio: temperature: Add STS30 temperature sensor
 driver
Message-ID: <20260704205717.137c506e@linuxescape>
In-Reply-To: <20260705000053.6e8fc3f0@jic23-huawei>
References: <20260621004626.66629-1-m32285159@gmail.com>
	<20260621004626.66629-3-m32285159@gmail.com>
	<20260703010532.4fc0f46b@jic23-huawei>
	<20260704144503.2347331b@linuxescape>
	<20260705000053.6e8fc3f0@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Jul 2026 00:00:53 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 4 Jul 2026 14:45:03 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
> 
> > Hi Jonathan,
> > 
> > On Fri, 3 Jul 2026 01:05:32 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Sat, 20 Jun 2026 19:46:24 -0500
> > > Maxwell Doose <m32285159@gmail.com> wrote:
> > >     
> > > > Add a driver for the Sensirion STS30 family of temperature sensor
> > > > drivers over I2C. The STS30 family of sensors includes the STS30, STS31,
> > > > and STS35, all of which are supported by this driver, since they all
> > > > share the same commands, etc. and only differ in accuracy and tolerance.
> > > > 
> > > > The driver currently supports single-shot non-clock stretched readings,
> > > > by using a specified delay based on the repeatability/delay specified
> > > > by the user. The repeatability/delay can be changed at any time through
> > > > sysfs.
> > > > 
> > > > Additionally add Kconfig and Makefile entries for the driver as well as
> > > > a MAINTAINERS entry.
> > > > 
> > > > Signed-off-by: Maxwell Doose <m32285159@gmail.com>      
> > > 
> > > Big question first.  Why IIO? These are fairly basic temperature sensors
> > > which typically means hwmon is more appropriate.  What does it need
> > > that hwmon doesn't provide?
> > >     
> > 
> > The datasheet says that the STS30 supports continuous reads which means
> > that we can read it into a triggered buffer (which hwmon doesn't
> > support) and at some point I'd like to implement that.  
> 
> Hmm. For a temperature chip that is often more about the monitors running
> continuously than the ability to gather signals fast.  Temperature changes
> tend to be fairly slow when it's a physical sensor - gets less obvious when
> infrared remote sensors are involved.
> 
> Even more relevant - there is an existing driver I think.
> See drivers/hwmon/sht3x.c which supports things under the wildcard sts3x as well.
> Check if that covers this part.
> 

I think the last time I checked the sts30 series wasn't listed in the
dt-bindings but it may have changed since then. Oh well. I'll still go
check it out. If it's (very very) similar I would probably consider
dropping this one, otherwise I'll improve this one and resubmit once I
get the hardware.

-- 
best regards,
max
