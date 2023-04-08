Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59538C7619A
	for <linux-iio@archiver.kernel.org>; Sat,  8 Apr 2023 11:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjDHLOV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 8 Apr 2023 07:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDHLOU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2023 07:14:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605596A59;
        Sat,  8 Apr 2023 04:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFF61614AD;
        Sat,  8 Apr 2023 11:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C67C433EF;
        Sat,  8 Apr 2023 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680952458;
        bh=F8Pk70gmucOlar+dBkR0TXgLrRuVtEej5mAHyAYA+k0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p0Rd1YXRGTxEFzXbpx9IpL79wKWPU3UsKAB7IHgYmBeKyf0sf6fUVp64d93wTIvIS
         mm8vyHoCtrxx5n4xcbgrqgPsVXWaJH7Duu0kQUZCDgOj/GKIK/lTMyH3eHitncHK3F
         kXAkMGXKiQghyEg8zxG+RpDWu0MAKamaeoVC49AS5EwQ9KqQy4MrBh8Wst9DRyHP1O
         zso0/22z+uJ+SstAzIF7iOVopOe6PyIcq0QUMl/JWE9hqdtjt13LTCXvgdFUg3B1ne
         t4OsjFn3zDOGYn8SjPETZCOkqWrsJdKA19n00s1/K3Re81jfw0SeU0NmIGPaSpwsob
         us5gfEoz4fpuA==
Date:   Sat, 8 Apr 2023 12:29:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: Honeywell mpr pressure sensor
Message-ID: <20230408122932.61d2bff0@jic23-huawei>
In-Reply-To: <ZC8g/dfMYWZcW4zg@arbad>
References: <20230401185717.1b971617@jic23-huawei>
        <ZC8g/dfMYWZcW4zg@arbad>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Apr 2023 21:43:57 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Hi Jonathan,
> 
> thanks for the extensive review. Most of it is clear but one questions remain.
> See below.
> 
> Jonathan Cameron <jic23@kernel.org> schrieb am Sa, 01. Apr 18:57:
> > > +static void mpr_reset(struct mpr_data *data)
> > > +{
> > > +	if (data->gpiod_reset) {
> > > +		gpiod_set_value(data->gpiod_reset, 0);
> > > +		udelay(10);
> > > +		gpiod_set_value(data->gpiod_reset, 1);
> > > +	}  
> > 
> > If there isn't a reset signal, I'd like to see an attempt at least to write
> > all configuration registers to a known value (same as the one you'd
> > get after reset).    
> 
> There is no configuration register in the sensor I could write to. But maybe I
> didn't comprehend your point.

Ah. Devices is even simpler than I was anticipating. Which makes me wonder.
What does the reset actually do?

I checked the datasheet and reason to bother with this is about powersupplies
that don't come up fast enough.  Fair enough. If someone hasn't wired
the reset I guess they are happy that the power on reset will work.
(4.0 Power support requirement) 

Jonathan

> 
> Andreas
> 

