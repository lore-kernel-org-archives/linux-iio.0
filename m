Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3A3ACA6F
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 01:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226084; cv=none; b=cRb9ULP9/q59k7+UzY+OAfRCo5O5NOSFEnY51FIukt+s3HNLCGzf1gCgV+Cb3e1RSowyRtOZpau24C8ImsH5p38rU3dEfCV+CYRwq4QOtMHlm79d6u0akQiZ1w1D0ZAxR20ufiZpntlLYqbEudN7ngNlqUfxHvHap2FyqtOzytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226084; c=relaxed/simple;
	bh=QGt1YjiI/mhzTO00cbHYiFktJLVXSS+Ad6iAxmSQHCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN5VoNyyD2MxZVDk5blgCDWnBTiEXpouSiFCMaDmU+i/MXiB3IpBwJWcgmVEnH5H8TZU5wvfLKQojb4hVD/bcVQFzKN9DDYqwLsxFi9eioRoYPdk8cZ8cOHTXCVysDkdsp78bCSOgzbKRcLCN3MjQ7f/qnU0qEDMCp97khfQoWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV7YSF4U; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV7YSF4U"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8200b55dc47so40038107b3.3
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 18:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788226081; x=1788830881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nIGoaz0LhcbcXCMDmNyRwcjq4U0fW/hB6lB0VymIzzk=;
        b=PV7YSF4UqSiDNoJan/UeGeSSjTAprRAOZe7drQbdVFyB2OFf4pV9vudu55TShAwFzJ
         m39ESkh1MPj62nD5lSVTWLwseFbaeqXf2Lmrmwuy/bSAcYLhIbV3bOxgUvKrikbabh7/
         7seDotf0epnxzBSvTKr98qZ5C1nFBMiIyeqcjCXwB3EBIdJNHhJFacJQISX8mbXrPIpX
         q7HbhXltFT7CqfTPdG1sPO5A9+sSVgtK0Z5MvQfSgjzbThowX6Gt6Gp1snGlTh9Lt0B6
         qVNuDrtkpIxHcQGNI2EjelZlmXfQgyKoXIp5cXMruI7pJSBdRGBfA+dkJdVhXvVLOhTw
         NZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788226081; x=1788830881;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIGoaz0LhcbcXCMDmNyRwcjq4U0fW/hB6lB0VymIzzk=;
        b=adMWrULd6gFTzo6ED1Eo5Te7eYnQDnLTQuAdnyvG5NfB8n1UcOTWiz8v+BA1Pzn+TL
         ASU8fInnlJAB3Z+EZ2Nlip2XYpDM/gZCxZ+s2yamO3Mn+ULjn/Ygt4KiP6X+1jbZFm9s
         nJn2u7gh/p0M2gflJKI4XR0UgTSZRpOeUm0GUgO+sD5/we8MhgR3D9IlhFa92KXJmzil
         Nf/gzfERwcbnQqngCWxFAfX6SoZz7LHrL7gDIWCIyfjRwu08Lp5rb1x6ze17CLlNuKUk
         y8Gnb4wDr+t4ZNTQewe/ACAAwIjEtaq2G9iNjrhcFGbzpNBefPoixWEU30QR7QJf62gs
         yUdw==
X-Forwarded-Encrypted: i=1; AKwUvBzQXgoJ9wLBHJhzufifVD/USraSorGNTbYSM/gmQfAH+DgJRht+uKqCiB9Ypt38OIlp0KLPutceQDM=@vger.kernel.org
X-Gm-Message-State: AFuF++lJR0PNcDwhPuZlZgzLG/Xy+8YnKLeP/4g3pdr74TSMJ+4Qbxmz
	CVySXPElggLvFghRqTH5bW/k6T8U7KdAlnTHGzuh8dTA7lUr55GhHqUQ
X-Gm-Gg: AYBFou34etQN3m+Vz3g6b4YcQh14z2z2wnOdqNnJcA53oLnyhYKGQu1eFjV15TqbPIB
	boOefNzyHcA5vi853V1Ka4yCLUA7KobHAU3WHgEdpgY6qLzDO+PwDyj1wvlssktQg99ydoX8VHC
	KTV4Q+ES1ivaUJ+S1SBCa4nHac/6MSky2OATPm+Bhq473Jr5YKQsuK/CZuAEh961zjeWdPP4Di+
	h4KE/bF3QJ9LgrpVt39zJ34IdzY1qzku5vQxh6PJ3555L6X44wkkCaRUdnRqO0bc58ObTI7saWX
	CJ4ffOCRRt4Kz/Znmj0Cmd7K3q3RSZU1jvwoL180V5R3g/SfNyU3yMZuKQoMZHbw4lx6HZ+Xnyw
	HmpcvIObdDvIDLBWVKUHU9qAo5MUcG0830RnOCLaDr0XwOjIz+7s302WJ+TgQhn2SbmjCVqTpec
	7Mgv0ZXz8Vcpw3dMhWatVokhyLZ2LuI1YCcBPEZ2JHtH3eBbV6N/2rz7ihQ7iWGZk7reCV
X-Received: by 2002:a05:690c:e254:20b0:81e:abe2:9a3b with SMTP id 00721157ae682-85d6a9aeec1mr85369257b3.10.1788226080941;
        Mon, 31 Aug 2026 18:28:00 -0700 (PDT)
Received: from localhost ([2804:30c:94d:7300:da0f:c2c1:1aa6:43da])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e6756c433sm65376667b3.44.2026.08.31.18.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:28:00 -0700 (PDT)
Date: Mon, 31 Aug 2026 22:28:50 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: light: stk3310: support the Sensortek
 STK36C61
Message-ID: <apYqUv_uuqZlhtOh@debian-BULLSEYE-live-builder-AMD64>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
 <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net>
 <apEMCqQXyj1tAMoP@debian-BULLSEYE-live-builder-AMD64>
 <20260828154705.11962-1-jorijnvdgraaf@catcrafts.net>
 <apRGQVfPKWHvE2Ct@debian-BULLSEYE-live-builder-AMD64>
 <20260830201950.63838-1-jorijnvdgraaf@catcrafts.net>
 <DL2YT4S4U7C4.2CPGBR94G01FD@fairphone.com>
 <apYiYnlM-agfG9he@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apYiYnlM-agfG9he@debian-BULLSEYE-live-builder-AMD64>

On 08/31, Marcelo Schmitt wrote:
> On 08/31, Luca Weiss wrote:
> > Hi Jorijn,
> > 
> > On Sun Aug 30, 2026 at 10:19 PM CEST, Jorijn van der Graaf wrote:
> > > On Sun, Aug 30, 2026 at 12:03:29PM -0300, Marcelo Schmitt wrote:
> > >> Having a closer look at the data sheet I found for STK36C61, I noticed registers
> > >> 0x13 and 0x14 are not listed. Does the newer part has ambient light sensing
> > >> besides the clear channel?
> > >
> > > That looks to be the "STK36C61-A Preliminary Datasheet v0.9" hosted by
> > > LCSC [1], which I hadn't found before, so the cover letter's "There is
> > > no public datasheet" is wrong. It documents the -A variant, however,
> > > and gives PDT_ID as 0x93, while the part in the Fairphone 6 reports
> > > 0x95. It does agree with the device on the colour-engine layout: RGBC
> 
> The data sheets I was comparing were from
> https://datasheet4u.com/datasheets/Sensortek/STK3310/836592
> https://jlcpcb.com/partdetail/SENSORTEK-STK36C61A/C49230205
> which were the first links that appeared to me on an online search.
> 
> > 
> > Just to chime in, the datasheet I have access to (STK36C61-A Preliminary
> > Datasheet Version - 0.9.2) there are a few changes compared with the one
> > from LCSC but nothing too interesting:
> > 
> > * On the overview page LED current 228.75 changed to 218.75 mA
> > * ALSCTRL1 register (0x02) has different values for BIT[6:4]
> >   (17.92 -> 143.36; 8.96 -> 35.84; 4.48 -> 8.96)
> > * PDT_ID is indeed 0x95 - maybe the previous version just had wrong
> >   copy-pasted info?
> > 
> 
> Hmm, I was initially thinking about the added STK3310_PROXIMITY_CHANNEL for
> stk36c61. If STK36C61 has ambient light sensing (similar to STK3310 light
> sensing read from registers 0x13 and 0x14) then it makes sense to have that
> channel for STK36C61 too. Otherwise, that specific ambient light channel
> shouldn't belong to stk36c61_channels.
> 
> I didn't find a data sheet for the part with PDT_ID 0x95, though, that sounds
> like another thing to tidy up. Update the naming from STK36C61 to STK36C61A.
> So, if STK36C61 (without the A) is ever added, there will be no naming conflict.
> Unless STK36C61 is never going to be released (which doesn't seem to be the case
> cause I can find a data sheet for that).

Never mind, I completely missed the point of it having a preliminary datasheet.
It might be sensible to try to estimate if the final version will keep the same
name and PDT_ID.
