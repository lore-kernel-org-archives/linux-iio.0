Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:45827 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbaJDSqy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 14:46:54 -0400
Received: by mail-lb0-f178.google.com with SMTP id w7so2542282lbi.9
        for <linux-iio@vger.kernel.org>; Sat, 04 Oct 2014 11:46:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <542FD980.5050607@kernel.org>
References: <1412299526-1331-1-git-send-email-festevam@gmail.com>
	<542FD980.5050607@kernel.org>
Date: Sat, 4 Oct 2014 15:46:52 -0300
Message-ID: <CAOMZO5B3_axOM6egCr4dni2mZX3nufBE=-hywFxj-C=jV1uVFg@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: adc: vf610: Propagate the real error when
 platform_get_irq() fails
From: Fabio Estevam <festevam@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Duan Fugang-B38611 <B38611@freescale.com>,
	linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 4, 2014 at 8:26 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 03/10/14 02:25, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> There is no need to pass a 'fake' return value when platform_get_irq() fails.
>>
>> Propagate the real error instead.
>>
>> While at it, only consider negative numbers returned by platform_get_irq()
>> as error.
> Returning an irq of 0 is still invalid isn't it?
> (there was a lot of 'fun' making this true for Arm a few years back).
> Doesn't it effectively mean no irq is present?

In practice I cannot see how platform_get_irq() could return 0. Only
if the dtsi was providing 0 as the irq number for the vf610-adc
driver, which would mean a very broken dtsi.

This driver is used only by vf610 and imx6sx and their dtsi provide
the correct values for the adc irq.

This type of check:

       if (irq < 0)
               return irq;

is commonly used on the imx drivers and I was not aware of any
problems in this regard.
