Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532083B9DAC
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241214; cv=none; b=q+vLXG+RbudzFvn61rNzmbq2My3BzBHTMJDW73kWEMK9nnDBmJYLfK5U3hPLC5SMbjLu2Rb5frsi1O9+wNwiTAuAd2onIrvaYQqeMvHxucCbEBOfKiIJItoZmE756d5uySHxLLIlv8Tkkny0FSO/RwztZv4pOIDmWYA6/YhQ+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241214; c=relaxed/simple;
	bh=AS429itr7wbpGuNOk5jL7MlDnLt1qmHnn3vRkHB1nVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ybuyqf2Qz3ABmUJFOalUye29Lb/bSM+haYiAJ9by/DAj1GLYgTcGJuYekrRKFWQI6HTH3iWXNoauIT2YT1lYUxObOZlT9Zgth18wV8iXCKE36qlvTUWAq7bCWG7a+jn3fIN1+Mdr1rNKXN7G7lFSMmiiehGBNrTKGR7L27ZmLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0k3KIXT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0k3KIXT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so45240935e9.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241211; x=1776846011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0otFmE3OfgX1ocRffAsBD3VgKhSHJKmOocoLMY68w2Q=;
        b=O0k3KIXTrRRTXq7ITdfsgz4CqfxhnnsMH1eB/RPf8ZrOiN+jGV7dxT1ik7p8SNFD4O
         jI4fSaTYA40PH2meeWkBVio+RGdNX7bS+9NrufjDQektPsXipRcOjrxVkTI/J14sF9ht
         d77eO62p8G4jsUCwh4bijIM1BiLwlzJL1GQg4D0UumwndDvsJ/ToV/MMIzQu3U94vpzW
         d+h8ES2B1K9GtcErvIv2vEtf4/CKmgUtbstgEbZNpyD6/mIEhXR3MbOkWvMXBVrzr645
         6PG1yiI5JiN3JouibmvfbLp9TGVvQyIoh/jCNDHZu4Z1q6tTGGVK4XR2rFetxvd9dSce
         hm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241211; x=1776846011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0otFmE3OfgX1ocRffAsBD3VgKhSHJKmOocoLMY68w2Q=;
        b=sujLEeq2QcYEllIwCNi8TFAVN0fRKGB+EZNseUkJGIw3en8CQFHF/ECRsOwafAEp+1
         pH4b8AK+4yeuFZQB9ryZ10LppeCZTwZKSSMQ1Ep5BDuz+x0DtzoulDlaYqvqLKhDEAR7
         W6nnKItC5sljU1Kxv7Tu9SHuMhOw+qmtNCHFhXDbSotRqWVhC2hEoh9LsOVOoSbPUolX
         W5oacjHPijvoyGMfns0Gch4E/Uz8tBusIA7yo63PcqCXHYY0K1kqxK/3o6K3ePPuSR0b
         6gmpfKy0yVCWtqA0CjUaJ5O3IsCObOrCNi2ZFTuU3gDpG33piJYX2i6EwT9D9fIl6tsu
         CVaw==
X-Forwarded-Encrypted: i=1; AFNElJ+eEz0o9l+k05ZU6rHUHyBQzpLwFBEvRXe+lmDfOeK6Za+1zASLlSwAkPgAkq6vouNXyu3K8bWZPJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ya6CwLGANJmblyaUgxOLWd8wS0s8aKVkZE9ly0ivOQ5js9QN
	9m9avMyWdd/YWFalcDmS3/CWo5+IQZPDEPkBLkzrq36cV+FDsdo4DFLA
X-Gm-Gg: AeBDievnzHJab4St/bgrHmi06NQOvwhPABzRNFEw1u7kucOFpXyuDdjLgWWF6XCbdEu
	LY0V8TYZ1PrP2IwVCdY5/PAKkLi55YL7PZnHmNZJnz3/kmTRFe/cICRJv/SipPOcspsUMCkmi2H
	xNVGnBgHhAhShWOOXA5OenRDU32rMNB94hMylSV+973tD60UVCxYIejNqw5Hy2QYtyIfRcnxDvF
	L5AtAJ/C1Jpnw8vjTHxXIuwEkrpNd3XC3Sfw1j4FXvIdOoVF2jRoi/cHLyrLm90Jut/pFeZ/7nP
	d8MwIJamyC2tmjdV37ybiVmjIm3lp327nLWWJirs35TYPPtvnMH+j6KRhGXGtUM0NiprixlVn2M
	sgwAqZFGlrgCdtLi0OFpn2cZhI/MDickRKMTwp1SrxN3S1WWAo68+xOIieTaWZZ/ZVBrkbbrfhi
	Tuh4y+X+yBhCbmOklx+88NPxY=
X-Received: by 2002:a05:600c:c0dc:b0:488:aa3d:fab1 with SMTP id 5b1f17b1804b1-488d68364f2mr188027275e9.17.1776241210420;
        Wed, 15 Apr 2026 01:20:10 -0700 (PDT)
Received: from nsa ([45.94.208.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3ebaf1sm2980604f8f.33.2026.04.15.01.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:20:09 -0700 (PDT)
Date: Wed, 15 Apr 2026 09:20:59 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
Message-ID: <ad9J9C5K7tyxuztU@nsa>
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
 <20260409-ad4692-multichannel-sar-adc-driver-v7-5-be375d4df2c5@analog.com>
 <742b1821-9103-414e-a860-c2e8d5406e35@baylibre.com>
 <20260412185821.739e477f@jic23-huawei>
 <LV9PR03MB8414E0A68C5676302909E220F7252@LV9PR03MB8414.namprd03.prod.outlook.com>
 <b352b76c-8047-4a1f-8b83-db8144466c36@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b352b76c-8047-4a1f-8b83-db8144466c36@baylibre.com>

On Tue, Apr 14, 2026 at 10:02:31AM -0500, David Lechner wrote:
> On 4/14/26 9:25 AM, Sabau, Radu bogdan wrote:
> > 
> > 
> >> -----Original Message-----
> >> From: Jonathan Cameron <jic23@kernel.org>
> >> Sent: Sunday, April 12, 2026 8:58 PM
> >> To: David Lechner <dlechner@baylibre.com>
> >> Cc: Sabau, Radu bogdan <Radu.Sabau@analog.com>; Lars-Peter Clausen
> >> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> >> Sa, Nuno <Nuno.Sa@analog.com>; Andy Shevchenko <andy@kernel.org>;
> >> Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> >> Conor Dooley <conor+dt@kernel.org>; Uwe Kleine-König
> >> <ukleinek@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> >> <broonie@kernel.org>; Linus Walleij <linusw@kernel.org>; Bartosz
> >> Golaszewski <brgl@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>;
> >> Jonathan Corbet <corbet@lwn.net>; Shuah Khan
> >> <skhan@linuxfoundation.org>; linux-iio@vger.kernel.org;
> >> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> >> pwm@vger.kernel.org; linux-gpio@vger.kernel.org; linux-doc@vger.kernel.org
> >> Subject: Re: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
> >>
> >> [External]
> >>
> >> On Fri, 10 Apr 2026 16:15:20 -0500
> >> David Lechner <dlechner@baylibre.com> wrote:
> >>
> >>> On 4/9/26 10:28 AM, Radu Sabau via B4 Relay wrote:
> >>>> From: Radu Sabau <radu.sabau@analog.com>
> >>>>
> >>>> Add per-channel oversampling ratio (OSR) support for CNV burst mode.
> >>>> The accumulator depth register (ACC_DEPTH_IN) is programmed with the
> >>>> selected OSR at buffer enable time and before each single-shot read.
> >>>>
> >>>> Supported OSR values: 1, 2, 4, 8, 16, 32.
> >>>>
> >>>> Introduce AD4691_MANUAL_CHANNEL() for manual mode channels,
> >> which do
> >>>> not expose the oversampling ratio attribute since OSR is not applicable
> >>>> in that mode. A separate manual_channels array is added to
> >>>> struct ad4691_channel_info and selected at probe time; offload paths
> >>>> reuse the same arrays with num_channels capping access before the soft
> >>>> timestamp entry.
> >>>>
> >>>> The reported sampling frequency accounts for the active OSR:
> >>>> effective_freq = oscillator_freq / osr
> >>>
> >>> Technically, the way this is implemented is fine according to IIO ABI
> >>> rules. Writing any attribute can cause others to change. It does
> >>> introduce a potential pitfall though. Currently, changing the OSR will
> >>> change the sampling frequency, so you have to always write
> >> oversampling_ratio
> >>> first, then write sampling_frequency to get what you asked for. If you want
> >>> to change the OSR and keep the same sample rate, you still have to write
> >> both
> >>> attributes again.
> >>>
> >>> In other drivers, I've implemented it so that the requested sampling
> >> frequency
> >>> is stored any you always get the closest sampling frequency available based
> >> on
> >>> the oversampling ratio. This way, it doesn't matter which order you write
> >>> the attributes. In that case, the actual periodic trigger source isn't set up
> >>> until we actually start sampling.
> >>>
> >> Agreed. This is more intuitive. Now generally the userspace should
> >> be sanity checking the value anyway as limitations may mean the new
> >> sampling frequency is not particularly close to the original one but
> >> at least it increases the chances of getting the expected value somewhat!
> >>
> >> So to me this is a nice useability improvement given the code to implement
> >> it tends not to be too complex.
> >>
> > 
> > Hi David, Jonathan,
> > 
> > What I understand from this is that the osr should be taken into account when writing
> > the sampling frequency as well, right? Here's what I understand:
> > 
> > If the user wants a 125kHz freq with 4 OSR, then when internal osc will be written
> > to 500kHz before single-shot read, buffer preenable/postenable.
> > However, if the user wants a 500kHz frequency with 4 OSR, that would mean a 2MHz
> > Internal osc freq, which is impossible.
> 
> It is up to the user to request something that is legal. They should know this
> from reading the datasheet.
> 
> > 
> > More than this, if the OSR is 32 the maximum effective rate would be 31250, so 25kHz
> > would make it the closes available one. If the user would select 1MHz from the available
> > list it would be weird I would say. So perhaps a solution for this is to display the avail list
> > depending on the set OSR value.
> 
> Yes, the available list should reflect the current state of any other attributes
> that affect it.

IMO, the above makes total sense to me.

- Nuno Sá

> 
> > 
> > Linking the two together is perhaps wrong to begin with from my end, since in this
> > driver's case, the per-channel sampling frequency is controlled by the internal oscillator
> > which has static available values. So perhaps sampling frequency should be separate, and
> > OSR separate as well, which would make everything cleaner.
> > 
> > Indeed, the effective rate is changed by OSR, but perhaps that is something the user
> > should be aware of, since the sampling frequency is the rate at which the channel samples
> > (1 sample per period) and OSR is how many times the channel samples upon a final sample
> > is to be read. The user already has to take this into account when setting the buffer
> > sampling frequency, so it would make sense to take this into account here too.
> 
> We can't change the definition of the IIO ABI just to make one driver simpler
> to implement. The OSR and sample rate can't be completely independent.
> 
> If you want to leave it the way it is currently implemented though, that is fine.
> 
> > 
> > Please let me know you thoughts on this,
> > Radu
> 
