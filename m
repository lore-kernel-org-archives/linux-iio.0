Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-030.synserver.de ([212.40.185.30]:1057 "EHLO
	smtp-out-030.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbbHTPyb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2015 11:54:31 -0400
Message-ID: <55D5F81C.40904@metafoo.de>
Date: Thu, 20 Aug 2015 17:54:04 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Chee Nouk Phoo <cnphoon@altera.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
CC: Michael.Hennerich@analog.com, cnphoon.linux@gmail.com
Subject: Re: [PATCH] Altera Modular ADC driver device tree binding
References: <1440056795-6190-1-git-send-email-cnphoon@altera.com>
In-Reply-To: <1440056795-6190-1-git-send-email-cnphoon@altera.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/20/2015 09:46 AM, Chee Nouk Phoo wrote:
> From: Chee Nouk Phoon <cnphoon@altera.com>
> 
> Altera Modular ADC is soft IP that wraps the hardened ADC block in a Max1
> device. It can be configured to dual ADC mode that supports two channel
> synchronous sampling or independent single ADCs. ADC sampled values will be
> written into memory slots in sequence determined by a user configurable
> sequencer block.
> 
> This patch adds device tree binding for Altera Modular ADC driver

Is there also a driver for the device? Would be nice to see some of the DT
properties in context.

[...]
> +- altr,adc-slot-count : specify number of conversion slot in use
> +
> +- altr,adc<ADC index>-slot-sequence-<slot index>: specify ADC channel 
> +  conversion sequence
> +  <ADC index>: instantiated ADC number
> +  <slot index>: slot index for ADC memory slot
> +

These attributes for example sound like a software rather than a hardware
configuration.
