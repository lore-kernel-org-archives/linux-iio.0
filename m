Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46202 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab3JLJqX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 05:46:23 -0400
Message-ID: <5259289E.50806@kernel.org>
Date: Sat, 12 Oct 2013 11:46:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?SsO8cmdlbiBCZWlzZXJ0?= <jbe@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] iio: adc: Move mxs-lradc out of staging
References: <1381263410-29849-1-git-send-email-festevam@gmail.com> <201310091508.30046.jbe@pengutronix.de> <CAOMZO5AmncWZdtJjN54+PA9KBAnRf_-h8Tp=34hEckQo-S_gaw@mail.gmail.com> <201310091614.00683.jbe@pengutronix.de>
In-Reply-To: <201310091614.00683.jbe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/09/13 15:14, Jürgen Beisert wrote:
> Hi Fabio,
> 
> On Wednesday 09 October 2013 15:17:33 Fabio Estevam wrote:
>> On Wed, Oct 9, 2013 at 10:08 AM, Jürgen Beisert <jbe@pengutronix.de> wrote:
>>>> Would it be acceptable if I move the mxs TODO text into mxs-lradc.c?
>>>
>>> Sounds like you want to make it forgotten. ;)
>>
>> What would you suggest?
> 
> Keep the driver in staging until somebody can spend some effort to split this 
> driver into an MFD and at least into its IIO (generic ADC) and touchscreen 
> components. IMHO the touchscreen component should go into the input subsystem 
> part of the kernel tree, its not related to IIO.
That would definitely be my preference as well.

Jonathan
> 
> Regards,
> Juergen
> 
