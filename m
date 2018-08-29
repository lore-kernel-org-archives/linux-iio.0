Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21368 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH2Kjl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Aug 2018 06:39:41 -0400
Message-ID: <060655b11b68d25fd855e9535df75db4b113a615.camel@az8.co>
Subject: Re: [PATCH 2/4] iio: gyro: add device tree support for fxas21002c
From: Afonso Bordado <afonsobordado@az8.co>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date: Wed, 29 Aug 2018 07:43:53 +0100
In-Reply-To: <20180827181341.6563c0bf@archlinux>
References: <20180825211910.22929-1-afonsobordado@az8.co>
         <20180825211910.22929-2-afonsobordado@az8.co>
         <20180827181341.6563c0bf@archlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2018-08-27 at 18:13 +0100, Jonathan Cameron wrote:
> On Sat, 25 Aug 2018 22:19:08 +0100
> Afonso Bordado <afonsobordado@az8.co> wrote:
> 
> > This patch adds device tree support for the fxas21002c driver,
> > including
> > bindings.
> > 
> > Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
> 
> Now, the devicetree bindings should not reflect just what the driver
> uses right now, but rather describe the hardware.
> 
> There are interrupts on there for starters that definitely want to be
> described from the start.  Also there is a reset line that should
> probably
> be here from the start.
> 
> Potentially also the two power supplies though that's less critical
> (nice to have though)
> 
> It is also an i2c and spi part though that can probably be added
> later as
> we can argue we are only documenting the bindings for the device in
> i2c mode
> for now.
> 
> So what is here is fine, but I think we need to describe more.
> 
> It's all well understood details of how it is connected so no need to
> have tested it with a driver to be sure it will be right.
> 
> Jonathan

Ok, so i'm thinking about adding both interrupts, the reset line and
the regulators. If i say they are optional in the device tree document,
i shouldn't need to add any more code immediately and could just
implement support for it later right?
