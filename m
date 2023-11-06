Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0BEC4167B
	for <linux-iio@archiver.kernel.org>; Mon,  6 Nov 2023 11:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjKFLHa (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 6 Nov 2023 06:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjKFLHV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Nov 2023 06:07:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475D01700;
        Mon,  6 Nov 2023 03:07:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EB3C433C7;
        Mon,  6 Nov 2023 11:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699268828;
        bh=QlAAP/B7tLRo9OBBNhArUNZWvgOjEW4JKbbEzOMYoTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HLLJpl3FSRHGYK4RcM36IIUHPWPY5+mSfc9sBlmTA5nFd7YdorB/4xjP9w+0/+k3O
         lDdvP7mCDIz9ybQL+fcgXoSME3t0t8GKQjM0a6vZx33xVKp+BffmtN/BnOfkoFa5RT
         86rkAa7wnW9yrlBBGBx3cVjcmfcIHBK/rLnJZt0D0k2AGqAuRzpyNA48vlI1Rz4bPX
         dfSNJvj8gS/ZWXF83OdngFraVMETZ1JpAtBGReFysmCvbH4VextVYpSk4UJ+RMYgyD
         G3gDn/odqOD12tq1ZY/pUN+k8oHvXn+ZJpVoy/gWsycd2sTFoclOztfFXe25PgLZZC
         FZI7GwkqumvLw==
Date:   Mon, 6 Nov 2023 11:07:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     alisadariana@gmail.com,
        Alisa-Dariana Roman <alisa.roman@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7192: Add AD7194 support
Message-ID: <20231106110701.0c2a9a25@jic23-huawei>
In-Reply-To: <ZUi_kWzZBMRBs3EU@smile.fi.intel.com>
References: <20231105193132.47009-1-alisadariana@gmail.com>
        <20231105193132.47009-4-alisadariana@gmail.com>
        <ZUi_kWzZBMRBs3EU@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 6 Nov 2023 12:27:29 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Nov 05, 2023 at 09:31:31PM +0200, alisadariana@gmail.com wrote:
> > From: Alisa-Dariana Roman <alisa.roman@analog.com>
> > 
> > Unlike the other AD719Xs, AD7194 has configurable differential
> > channels. The default configuration for these channels can be changed
> > from the devicetree.
> > 
> > The default configuration is hardcoded in order to have a stable number
> > of channels.  
> 
> ...
> 
> >  config AD7192
> > -	tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
> > +	tristate "Analog Devices AD7190 AD7192 AD7193 AD7194 AD7195 ADC driver"  
> 
> This doesn't scale. Please change this and below like:
> 
> 	tristate "Analog Devices AD719x ADC driver"
Also tends to cause trouble given habit of manufacturers to not have consistent
naming.

"AD7194 and similar ADC driver"
would be my preference.

