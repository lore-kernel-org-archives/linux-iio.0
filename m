Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50161 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbaJJXqv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Oct 2014 19:46:51 -0400
Message-ID: <5436E892.4010800@kernel.org>
Date: Thu, 09 Oct 2014 20:57:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: Duan Fugang-B38611 <B38611@freescale.com>,
	linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 1/5] iio: adc: vf610: Propagate the real error when platform_get_irq()
 fails
References: <1412299526-1331-1-git-send-email-festevam@gmail.com>	<542FD980.5050607@kernel.org> <CAOMZO5B3_axOM6egCr4dni2mZX3nufBE=-hywFxj-C=jV1uVFg@mail.gmail.com>
In-Reply-To: <CAOMZO5B3_axOM6egCr4dni2mZX3nufBE=-hywFxj-C=jV1uVFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/14 19:46, Fabio Estevam wrote:
> On Sat, Oct 4, 2014 at 8:26 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 03/10/14 02:25, Fabio Estevam wrote:
>>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>>
>>> There is no need to pass a 'fake' return value when platform_get_irq() fails.
>>>
>>> Propagate the real error instead.
>>>
>>> While at it, only consider negative numbers returned by platform_get_irq()
>>> as error.
>> Returning an irq of 0 is still invalid isn't it?
>> (there was a lot of 'fun' making this true for Arm a few years back).
>> Doesn't it effectively mean no irq is present?
> 
> In practice I cannot see how platform_get_irq() could return 0. Only
> if the dtsi was providing 0 as the irq number for the vf610-adc
> driver, which would mean a very broken dtsi.
> 
> This driver is used only by vf610 and imx6sx and their dtsi provide
> the correct values for the adc irq.
> 
> This type of check:
> 
>        if (irq < 0)
>                return irq;
> 
> is commonly used on the imx drivers and I was not aware of any
> problems in this regard.
Fair enough.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
