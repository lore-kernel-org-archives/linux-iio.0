Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B43AF648
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280838; cv=none; b=pGrvoqE5NsY29d+sJDhNyqUtGLqqx9e4SEbzOFJW/MYc2UL5Mm+ihNvQUYrBFPi/nuRjxfkeKkb7f91jD702Q7Eu62WUgiOMjoBV6QwG0uocA49QfBVgIplfR5jTurKkkEw3VO+eBuAIZjA34Do8zwfJpr6at+pJaUM4v6iTAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280838; c=relaxed/simple;
	bh=lwTeK3+hOF1ypVH3nzERjtwaJE6pl2Fs0hd4iOxRaWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgncPTcbyxG917lebuBPGlTMTxKT984mwOE8xotkDyidDYZ7XBn1GwfXH7fsjq7v+WOh2GLd7CsEr4h6EY+Ht98yKKbkL6ituhjzbHRCWx3Q24kQdIeH88MTAowH2SFUTftWBsDHyeXFHjkuLP5L7xyAM1oXrq2vCQHnUNwxOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDMXoqoQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDMXoqoQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483487335c2so97349345e9.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777280835; x=1777885635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oUgNMCqtfYYDx/Kk9MiziiMJ2F/ZUQN8r504LZwqJAI=;
        b=hDMXoqoQrTVPhMLoRpjo9mfrDoVsmbXtTmpsGukDMgYkQgTmVZ3U9DcrYEkvPTxnOL
         JWBG+djDQKCbY23PKlscLIcnVFKiHIn5xMAc9mZp1azLWwPqEGS+tq9QsGa/jLZLA1ab
         S2A3vmpL+9QJDDmeSp5PYoSJkrL3SZZ5QzWFfZoe4J+eh1nK64tEKNEW+Hh4TgBLEwFL
         GTBOHvzssX2ZOvbD3JY+2Gma4jzXKUNol2owfBixYGvi7xAmdX1iPpi9bvSPNKaFeQi0
         5BpnPBMPLM9qnDcs/iyTzFPxNOUXu714H6x9UV7foiwP0q+aVfznSrbhicnNjsd0Sr7/
         Qovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777280835; x=1777885635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUgNMCqtfYYDx/Kk9MiziiMJ2F/ZUQN8r504LZwqJAI=;
        b=PI4YX9tzYjZ9yruXHXlN0iij+ZAPZ8O6DRockuhtaeRJJMIyUWNnl0QyIit+SRnjJL
         n39y8LgJ4P1w5IHN5g3rX8aXCekqIWQAmPialOQ352wrJUYjXKFU7EKaP5dOj2GpRdpI
         +zRZNTV8bXeJBxUYg6QCIH8CxBciug+b5NNACEkSwhB6AyLX29cc3FHeW7tjc9QMhl/e
         Ha7Sr1+TH0xHwP5mtNUO6cIYBfnkUNCbCInRAUSuKG5vNPvYZ2l7YSuCiHmveL1jeZkT
         zt3R12U/rOZUqbX66Biw3DmFZZGLFtrKGUVyBsEdryuKIlRRCgw9eKIwHiHZ2APwFsze
         G59Q==
X-Forwarded-Encrypted: i=1; AFNElJ94+BMYtsuIgdD5PBplZtA/is0gBI4APgPMwSa644Tozv7frdPXv6RCHHpSZUg+i/L/jvD5kojaVkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9T8bdiMdpFo0ie+/Owe5HxNwhm1rGEDEnKkE5FGb1CF9ChJ1
	Q/VlC2fMo0bdPzu1fj80Ac6ZwtGsSMLZVl9n7tx0A5EZdUuaDsZYdVKS
X-Gm-Gg: AeBDietG43OMVYgZ2bFKeNmOrmjWkhVDNRcwLoyRcJV16ovC30OOEaILHdFxfuOdIE7
	G+CuR25x6jbxaUZTNJzNZ876PvLp0Ysh59+3WGo5E1T/NBiYJUanTN8du/FRmuoYg+6VHWPAqH4
	gwC5Hr1f9hw/OJmeEnrQtL8v2VQANWSFcqPsoXLyOBdNr6Jxv2gnKUqYaNhgddSEKxXly7EFlB5
	9L8RgsNiNzcNzQb6jcBhcVNC6uVzYNNYyBUI+TxhUv7mjVvvDQat5FQeCMVL28LeGPd/o4inZs5
	zdu1qvUZSP/sdXMFLf+Vn1tSjde3m3nRVU7B5s4yyMTE8/L2OkemlZAvvqkon0OgLIY3B4Zf3Rd
	D29BK3oLsJpb090SWRPPP6YWY2oPLPU0SEVh0LAdIuTaI/97gmSsLeqCoE0jch4TCamcT+0hMGR
	anEyAq7DVrcn54yPZBxzBPpvIqvg==
X-Received: by 2002:a05:600c:6209:b0:48a:592c:e63d with SMTP id 5b1f17b1804b1-48a592ce89emr325477345e9.14.1777280834996;
        Mon, 27 Apr 2026 02:07:14 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cc7b2efsm329876765e9.0.2026.04.27.02.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:07:14 -0700 (PDT)
Date: Mon, 27 Apr 2026 10:08:06 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org, demonsingur@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: Update maintainer for iio driver(s)
Message-ID: <ae8nLmzyq5Erx9mp@nsa>
References: <20260421165856.2245598-1-sanjayembedded@gmail.com>
 <aenU2WZnVJ-esibn@nsa>
 <8C4ED753-72A9-4A34-920D-A5C5E8DB1840@gmail.com>
 <aeskNzhWtKPNYb4R@nsa>
 <20260424202727.1b880766@jic23-huawei>
 <DEE9F0E2-7759-4C58-BF53-2FA8732050B5@gmail.com>
 <20260426141645.5fb8406a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260426141645.5fb8406a@jic23-huawei>

On Sun, Apr 26, 2026 at 02:16:45PM +0100, Jonathan Cameron wrote:
> On Sun, 26 Apr 2026 15:21:47 +0530
> Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
> 
> > On 25 April 2026 12:57:27 am IST, Jonathan Cameron <jic23@kernel.org> wrote:
> > >On Fri, 24 Apr 2026 09:08:37 +0100
> > >Nuno Sá <noname.nuno@gmail.com> wrote:
> > >  
> > >> On Fri, Apr 24, 2026 at 07:22:37AM +0530, Sanjay Chitroda wrote:  
> > >> > 
> > >> > 
> > >> > On 23 April 2026 1:46:32 pm IST, "Nuno Sá" <noname.nuno@gmail.com> wrote:    
> > >> > >On Tue, Apr 21, 2026 at 10:28:56PM +0530, Sanjay Chitroda wrote:    
> > >> > >> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > >> > >> 
> > >> > >> The listed maintainer analog domain email for Cosmin Tanislav is no
> > >> > >> longer valid, and he would no longer maintain this driver(s).
> > >> > >> 
> > >> > >> Replacing email maintainer with list, to keep it valid all the time.
> > >> > >> 
> > >> > >> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > >> > >> ---
> > >> > >> Changes in v3:
> > >> > >> - Following input from Nuno and confirmation from Jonathan,
> > >> > >>   replacing domain specific maintainer with mailing list.
> > >> > >> - Link to v1: https://lore.kernel.org/all/20260418211336.1800221-1-sanjayembedded@gmail.com/
> > >> > >> ---    
> > >> > >
> > >> > >While you're doing this, could you take the opportunity and also update
> > >> > >this entry?
> > >> > >
> > >> > >https://elixir.bootlin.com/linux/v7.0/source/MAINTAINERS#L1837
> > >> > >
> > >> > >Thanks!
> > >> > >- Nuno Sá
> > >> > >    
> > >> > Hi Nuno Sá,
> > >> > 
> > >> > Are you suggesting to have separate change to add mailing list in analog devices and iio driver which you pointed ? 
> > >> > 
> > >> > This change is specific to email debounce due to Cosmin analog domain account.    
> > >> 
> > >> Yes, it makes more sense for it to be a separate patch. I also suggested
> > >> that one because it's an entry covering a lot of driver's and
> > >> includes Lars which has been silent for some time now so maybe it's better no
> > >> to "spam" him like that :)  
> > >
> > >If we are adding the entry to the catch all, do these individual entries
> > >bring any benefit. Maybe we should just drop them?
> > >  
> > 
> > Hi Nuno and Jonathan,
> > 
> > Here is my view on this,
> > 
> > Lars-peter is maintainer of drivers falls in different subsystem, so
> > If we can plan to drop/replace would need ack from Lars-peter and
> > also mutual agreement from all respective subsystem owner as it won't
> > be advisable just to update analog devices IIO drivers maintainer.
> 
> Definitely good to get Lars' view on this - though that can be on the
> final patch.  He is indeed busy with other thing these days so
> for IIO at least, if Lars doesn't respond for a while I can take
> a patch dropping him as the maintainer (and move to Credits) anyway.
> 
> > 
> > Regarding analog mailing list, we can plan to add list across
> > MAINTAINERS where analog devices ownership is there as maintainer or
> > reviewer.
> No. I'm proposing we add it to
> 
> ANALOG DEVICES INC IIO DRIVERS
> M:	Lars-Peter Clausen <lars@metafoo.de>
> M:	Michael Hennerich <Michael.Hennerich@analog.com>
> S:	Supported
> W:	http://wiki.analog.com/
> W:	https://ez.analog.com/linux-software-drivers
> F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
> F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> F:	Documentation/devicetree/bindings/iio/*/adi,*
> F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> F:	Documentation/iio/ad7606.rst
> F:	drivers/iio/*/ad*
> F:	drivers/iio/adc/ltc249*
> F:	drivers/iio/amplifiers/hmc425a.c
> F:	drivers/staging/iio/*/ad*
> X:	drivers/iio/*/adjd*
> 
> Only and for entries that match those wildcards and where there is not
> other info (such as the ones here post modification) just delete the
> more specific entry.
> 
> Where we have maintainers for specific drivers then we keep the entries.
> No need to sorry too much about adding this list to all of those ADI
> drivers as this catch all should also match.
> 
> So end result of the proposed change would be to just remove the entrees
> you are updating here as the catch all will cover them.
> 

Ack to the above from me!

- Nuno Sá

> Thanks,
> 
> Jonathan
> 
> > 
> > Also, this change would be separate from both above points so we
> > shall take it further.
> > 
> > Kindly share your thoughts, valuable input and guidance on how should
> > we proceed further for this change and other two topics.
> > 
> > Thanks,
> > Sanjay Chitroda 
> > 
> > >>   
> > >> > 
> > >> > Also, I had take a glance on MAINTAINERS, it looks there are
> > >> > good amount of drivers which are maintained by you and Michael
> > >> > Hennerich from analog. If you suggest I can plan to add analog
> > >> > mailing list in all respective places in separate change.
> > >> > 
> > >> > This way all analog device maintained drivers will have mailing
> > >> > list of analog.com    
> > >> 
> > >> Yeah, I'm not sure if it makes sense to go change all of those. I
> > >> would focus on bouncing emails and we (ADI) need to make sure to
> > >> also include that list from now on.
> > >> 
> > >> - Nuno Sá
> > >>   
> > >> > 
> > >> > Kindly share your thoughts on the same.
> > >> > 
> > >> > Thanks,
> > >> > Sanjay Chitroda 
> > >> > 
> > >> > 
> > >> >     
> > >> > >>  MAINTAINERS | 8 ++++----
> > >> > >>  1 file changed, 4 insertions(+), 4 deletions(-)
> > >> > >> 
> > >> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> > >> > >> index c981cbdff500..6498f0aed1ff 100644
> > >> > >> --- a/MAINTAINERS
> > >> > >> +++ b/MAINTAINERS
> > >> > >> @@ -644,7 +644,7 @@ F:	drivers/iio/accel/adxl355_i2c.c
> > >> > >>  F:	drivers/iio/accel/adxl355_spi.c
> > >> > >>  
> > >> > >>  ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> > >> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> > >> > >> +L:	linux@analog.com
> > >> > >>  L:	linux-iio@vger.kernel.org
> > >> > >>  S:	Supported
> > >> > >>  W:	https://ez.analog.com/linux-software-drivers
> > >> > >> @@ -1461,7 +1461,7 @@ F:
> > >> > >> Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> > >> > >> F:	drivers/iio/adc/ad4080.c 
> > >> > >>  ANALOG DEVICES INC AD4130 DRIVER
> > >> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> > >> > >> +L:	linux@analog.com
> > >> > >>  L:	linux-iio@vger.kernel.org
> > >> > >>  S:	Supported
> > >> > >>  W:	https://ez.analog.com/linux-software-drivers
> > >> > >> @@ -1549,7 +1549,7 @@ F:
> > >> > >> Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
> > >> > >> F:	drivers/iio/dac/ad7293.c 
> > >> > >>  ANALOG DEVICES INC AD74115 DRIVER
> > >> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> > >> > >> +L:	linux@analog.com
> > >> > >>  L:	linux-iio@vger.kernel.org
> > >> > >>  S:	Supported
> > >> > >>  W:	https://ez.analog.com/linux-software-drivers
> > >> > >> @@ -1557,7 +1557,7 @@ F:
> > >> > >> Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> > >> > >> F:	drivers/iio/addac/ad74115.c 
> > >> > >>  ANALOG DEVICES INC AD74413R DRIVER
> > >> > >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> > >> > >> +L:	linux@analog.com
> > >> > >>  L:	linux-iio@vger.kernel.org
> > >> > >>  S:	Supported
> > >> > >>  W:	https://ez.analog.com/linux-software-drivers
> > >> > >> -- 
> > >> > >> 2.34.1
> > >> > >>     
> > >  
> 
