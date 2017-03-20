Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34490 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755327AbdCTTX1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 15:23:27 -0400
Received: by mail-pg0-f50.google.com with SMTP id 21so48789828pgg.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Mar 2017 12:23:26 -0700 (PDT)
Date: Mon, 20 Mar 2017 12:23:20 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: "De Vos, Bart (EXT - BE/Antwerp)" <bart.de_vos.ext@nokia.com>
Cc: matt.ranostay@konsulko.com, linux-iio@vger.kernel.org
Subject: Re: hdc100x driver backport
Message-ID: <20170320192319.GA4543@d830.WORKGROUP>
References: <AMSPR07MB129D24949977B4D40F31C338F3A0@AMSPR07MB129.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AMSPR07MB129D24949977B4D40F31C338F3A0@AMSPR07MB129.eurprd07.prod.outlook.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 20, 2017 at 04:54:07PM +0000, De Vos, Bart (EXT - BE/Antwerp) wrote:
> Hi,
> 
> I'm trying to backport the hdc100x driver to v3.10.
> 
> Can you elaborate on the temperature offset, especially here:
> http://lxr.linux.no/linux+v4.10/drivers/iio/humidity/hdc100x.c#L239
> 
> I see the goal is to have millidegrees, and as such I would expect an offset of -40000. I don't understand the numbers used here and the relationship between the two.
> If I read out the offset in runtime I got the value specified to 'val' on line 240.
> 
> Thanks for your feedback.
> 
> Kr,
> Bart.

Hi Bart,

Copying Matt Ranostay as he is the author/expert on this driver.

hdc100x temperature is calculated as:
(raw + offset) * scale / 1000

Here's a sample reading:
raw: 25443 scale: 2.517700195 offset: -15887.515151 resolution: 0.006350
Temperature 24057.846068

Hope that helps,
alisons

