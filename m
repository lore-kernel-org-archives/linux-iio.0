Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21A4C43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 12:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E33920880
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 12:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfBTMHz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:07:55 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:54674 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfBTMHy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Feb 2019 07:07:54 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id ADD6D9E7A71;
        Wed, 20 Feb 2019 12:07:52 +0000 (GMT)
Date:   Wed, 20 Feb 2019 12:07:49 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     David Frey <dpfrey@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: bme680 gas sensor channel attributes
Message-ID: <20190220120749.04c69120@archlinux>
In-Reply-To: <c8ffa8de-ecc2-e9e4-0043-67fc54ca4740@gmail.com>
References: <c8ffa8de-ecc2-e9e4-0043-67fc54ca4740@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 Feb 2019 08:53:46 -0800
David Frey <dpfrey@gmail.com> wrote:

> Hi,

Hi David,

Always fun to expand ABI :)
> 
> I would like to enhance the gas sensor support in the bme680 driver, but
> I'm not sure how to fit the enhancement into IIO.
> 
> The bme680 has the following registers:
> idac_heat_0 to 9 at 0x50..0x59 - initial current applied to heater
> res_heat_0 to 9 at 0x5A..0x63 - target temperature of heater
> gas_wait_0 to 9 at 0x64..0x6D - heater on duration
> 
> The ctrl_gas_1 register has an nb_conv<3:0> field which selects which of
> the settings (0 to 9) to use for the gas sensor.
> 
> Currently, the driver just hard codes some values into res_heat_0 and
> gas_wait_0.  idac_heat_0 is not written, but the datasheet says this is
> optional.  I think it would be good if the user could configure these
> parameters.  At a minimum it would be nice to expose one set of the
> three values, but if I'm going to expose one, it seems like I might as
> well expose all 10 and also allow the user to select which setting group
> is active.
> 
> The current version of the driver has this for the gas channel definition:
> {
> 	.type = IIO_RESISTANCE,
> 	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> },
> 
> Other channels of the device (such as temperature) support an
> oversampling ratio, and are defined like this:
> 
> {
> 	.type = IIO_TEMP,
> 	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> 			      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> },
> 
> I checked enum iio_chan_info_enum and there is no IIO_CHAN_INFO_
> definition which seems applicable to "initial current", "target
> temperature" or "heater duration".  How can I add these configuration
> parameters in an idiomatic way?
I'll be honest, these are pretty device specific, and unlikely to
be of interest to any in kernel users.  As such use the
extended attribute infrastructure to define some custom attributes
for them.  First step though is probably to document the ABI so
we can discuss how it first into the wider ABI (should still be
consistent as we can make it).

We have previously dealt with heaters via explicit output channels
(they are common in humidity sensors) but that probably only gives you
a base to work from given they still won't have the right attributes.

Jonathan

> 
> Thanks,
> David

