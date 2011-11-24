Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:43983 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab1KXP0S (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2011 10:26:18 -0500
Message-ID: <4ECE620A.9050904@free-electrons.com>
Date: Thu, 24 Nov 2011 16:26:02 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 3/3] ARM: AT91: Add the ADC to the sam9g20ek board
References: <1322134040-32382-1-git-send-email-maxime.ripard@free-electrons.com> <1322134040-32382-4-git-send-email-maxime.ripard@free-electrons.com> <CAOMZO5ADJrLCV6ohkraohqJT1aD2hC_pWEsbDezWGchGrvRYvA@mail.gmail.com>
In-Reply-To: <CAOMZO5ADJrLCV6ohkraohqJT1aD2hC_pWEsbDezWGchGrvRYvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 24/11/2011 16:20, Fabio Estevam wrote:
> On Thu, Nov 24, 2011 at 9:27 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
>> +static struct at91_adc_data ek_adc_data = {
>> +       .channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3),
>> +       .vref = 3300,
>> +};
> 
> Don't you need to also pass adc_clock?

ADC Clock is SoC specific, while these variables are board-specific. It
is thus set in the file arch/arm/mach-at91/at91sam9260_devices.c, in the
same patch.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
