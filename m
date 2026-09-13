Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDCC28D8D0
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789260294; cv=none; b=KljOERU2ftbQJxddGtvU+P7jkXY460nbM9/KhsnAxe4uzTzn4HvfmHn4gr0rmhboW/mAOlTgOR9tCSXuOH2jyyjg5m+GHfwJr2VWzvJ5udHIu0X168CeE94vA7OZFjfluZCZb6vqNAIRi60sbE8/ihdxgvlq/oQB9gVjvD0tkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789260294; c=relaxed/simple;
	bh=uOz+U6kaoRZHLq9ttMtJiNicYroyZcmbCfI/pMASz7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw+3d59ZCal4gT3L4HwvhL+Hnuk27sh5c3zeihlCplh3zWU52pqE7cb/THB71Ws1+2vMPWHM3/QAOAoJYedyXeO6lBpAZ4QxdfvHmVclbFDgaglfR8YknXThUPgGLgga6R1pJKiGAh7dpNNxvw7rLnOq1M0ZUDzpN1hjM48tmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpczsIno; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpczsIno"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8871ada1a26so10073897b3.1
        for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 17:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789260292; x=1789865092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iWFoU5rdxCJzaHXWKFqIlTzp58cYSQhcI1+tHmj6guo=;
        b=FpczsInopC7bH2YQtQJgaiR0Lw0Rg+YokQjofjD0m0lyxGdU9vVREADD9XAUzjRKxu
         po+KJmDVXZJAMxooR82eq4VHtGzwNvzhBQT82C6bV6DDfJ/V4UVxiCqmlz/RU9K9jUDc
         Lhpmos0hFHgUYFswI8mGViV14CL6dMVp2FrSsU5RI21JJdD5XSgorv/Wm07nO1dwVGds
         G9iR6/Ht0/jk3tlF+fcw0aMFci+tR8EISG8jAhyvv3Srz/OQtGauPEPzLP5nZ0Q8mGZ0
         JZWf9ei2ok9BSqgvBb4kbROrCBy8bs2QSoX+2d5g8wKkI5ufu3SzPoUAnTFj9G0u8eaN
         ZWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789260292; x=1789865092;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iWFoU5rdxCJzaHXWKFqIlTzp58cYSQhcI1+tHmj6guo=;
        b=Ey474d+dYIVauYLWBgs3EK4TCGkRBiYGP5nBnxmY+zIZluBlBTPK44UOtl//FELBMi
         facL6nR8uTfzdD55B3QXh2IkeiEgUlY1HG544V2CkTt2NvUuj+w5H5fPkX5SmcKjY0fC
         aOqi4PATwiIxLbgKvf911NRt5YTBdZJkwaV8pmb17S1Q69Tb7NGg0xIulYkQG/NXTyOs
         rlaGFK0ypLIPrta5xDgBv4GZsRH+SagC6DClokBYtO1k06yyV/Ck0nBmBZA3qtHbeIjr
         eb4X+eGk89BaQ9yfYdBdNh5Elqiz5VMw+MOYczw4Z8ihbKft0gw0+ShVYVmV3msC3P7X
         NWig==
X-Forwarded-Encrypted: i=1; AKwUvBwkgJ8mK3tXtpd5dHTy3bajX3/AiTviekqmM1Y8VVc7XeBPJVBFDnZJRLawZe8NX0EH5Kia+JcG0lI=@vger.kernel.org
X-Gm-Message-State: AFuF++lIq8Os7p+hVU/gwttvqkNLI3GKbPrXMfyDSkAU3z2m6XIN6lj4
	KWVNPj/9RwswMtMi9xsUzLPQ2I3/MzhsO8e6snHZHa++Nkmz7QQF+BVv
X-Gm-Gg: AYBFou1dk/VBWh04sf6dDsLHzkjXr0dFOz8QqVfl/WKLP9rKhFCfvKhS/svwxxKtuhp
	BwVf9MYUO4FZj2jMLSO2vFK34Fnwj9HxGd3aJdORsYoU2meJqstxDcNK45NCznhVz2hzUgI0Lav
	GCQELgHzU3aDLdXYI9tkPnuatb4KIGJN1yx94Ckm5LvL++EHJyAbtlHpo2OEwTi1BsTGOaeBac5
	E1lJSlCls0GxVtoE5imaSwDLrNWDavL8LY50OiB4VjjJWKcMW82vITDy2/lHs4YpyB+t9x9lpfH
	PAj5EoXGXYsMugIfSNqhtzgmMHfMP6RUaGey1rxAcMmWwJ6cqgZN/Ssox5DF/C9zbNrDPk64NYn
	26lxVsEqu3dhe3Q8N1nKbTRbRV35JG/yhB1TYfs8fwHGQ84vQd0xsccb2PgtHzq2jEUGYdXigCt
	MaAXQaAgu4AxjHdSbMqgOBlF7Q0LieAVY+QHAYWw6y6pHor5xGSuCZNA==
X-Received: by 2002:a05:690c:a5c4:b0:820:b24:27c7 with SMTP id 00721157ae682-884adc0ce42mr30114457b3.14.1789260292326;
        Sat, 12 Sep 2026 17:44:52 -0700 (PDT)
Received: from gmail.com ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88486c2d167sm24010157b3.18.2026.09.12.17.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 17:44:51 -0700 (PDT)
Date: Sat, 12 Sep 2026 17:44:48 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add support for AS7343 multi-spectral sensor
Message-ID: <aqXyAL6vP1BghIN4@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
 <20260913013056.1a7c98b8@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913013056.1a7c98b8@jic23-hlaptop>

Hi Jonathan,

My sincere apologies. This is my first proper driver patch so
I didn't quite know how things work around here (I've only done
cleanup patches before). I'll slow down the submission
frequency from now on.

Best,
Chang

On Sun, Sep 13, 2026 at 01:30:56AM +0100, Jonathan Cameron wrote:
> On Fri, 11 Sep 2026 18:39:10 -0700
> Chang Yu <marcus.yu.56@gmail.com> wrote:
> 
> > This series adds initial support for the AMS AS7343 14-channel
> > multi-spectral sensor.
> > 
> > The sensor has 14 optical channels (11 visible + NIR + clear +
> > flicker) in total. This initial driver supports reading raw counts
> > from all 12 spectral channels (11 visible + NIR) via sysfs and basic
> > power management.
> 
> Hi Chang Yu,
> 
> We all appreciate enthusiasm but...
> 
> No idea if anyone called it out already but please slow down.
> Typically reviewers only get to looking at IIO patches once every week
> or so (in totality - they may review a few random ones more often whilst
> waiting for something to happen).
> 
> So for a driver in early stages of review, once a week at most for
> new versions.  That way we consolidate a bunch of feedback.  Key thing
> is many folk looking at your code doe enough review that they don't
> have the previous version in their head so each very takes roughly the
> same amount of time to do - it doesn't get shorter until very near merging
> when we know tiny stuff only is changing.
> 
> Jonathan
> > 
> > Not yet supported:
> > - Configurable integration time and gain
> > - Interrupt support
> > - Clear (VIS) channel and flicker detection
> > 
> > Patch 1 adds device tree bindings.
> > Patch 2 adds the driver.
> > 
> > Testing was performed on a Raspberry Pi 4.
> > 
> > Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> > 
> > Changes in v4:
> >   - Fix led-max-microamp property in dt bindings.
> >   - Use REGCACHE_MAPLE and add volatile table.
> >   - Use PM_RUNTIME_ACQUIRE* when resuming.
> > 
> > Changes in v3:
> >   - Fix gpio description and example in dt.
> >   - Only start measurements after suspend action has been registered.
> >   - Add a mutex and pm_runtime_resume_and_get before reading measurements.
> > 
> > Changes in v2:
> >   - Add the LDR, the interrupt pin, and the GPIO pin to the dt bindings.
> >   - Adjust the default gain to x256 and integration time to 50.1ms as
> >   recommended by the datasheet.
> >   - Use read_label instead of .extend
> >   - Remove all unused scan_index related constants.
> > 
> > Chang Yu (2):
> >   dt-bindings: iio: light: add as7343
> >   iio: light: add AS7343 multi-spectral sensor driver
> > 
> >  .../bindings/iio/light/ams,as7343.yaml        |  72 +++
> >  MAINTAINERS                                   |   7 +
> >  drivers/iio/light/Kconfig                     |  11 +
> >  drivers/iio/light/Makefile                    |   1 +
> >  drivers/iio/light/as7343.c                    | 434 ++++++++++++++++++
> >  5 files changed, 525 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> >  create mode 100644 drivers/iio/light/as7343.c
> > 
> 
