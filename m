Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58536 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab1KDQ2k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Nov 2011 12:28:40 -0400
Message-ID: <4EB412B5.2070103@jic23.retrosnub.co.uk>
Date: Fri, 04 Nov 2011 16:28:37 +0000
From: Jonathan Cameron <archive@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1320315070-1700-1-git-send-email-maxime.ripard@free-electrons.com> <1320315070-1700-2-git-send-email-maxime.ripard@free-electrons.com> <4EB3BFD2.5080909@jic23.retrosnub.co.uk> <4EB4031A.4080806@free-electrons.com>
In-Reply-To: <4EB4031A.4080806@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/04/2011 03:22 PM, Maxime Ripard wrote:
> Hi Jonathan,
> 
> On 04/11/2011 11:34, Jonathan Cameron wrote:
>> On 11/03/2011 10:11 AM, Maxime Ripard wrote:
>>> +/* ADC */
>>> +#define AT91_ADC_MAX_CHANNELS   16
>>> +
>>> +struct at91_adc_data {
>>> +	/* ADC Clock as specified by the datasheet, in Hz. */
>>> +	unsigned int adc_clock;
>>> +	/*
>>> +	 * Global number of channels available (to specify which channels are
>>> +	 * indeed used on the board, see the channels_used array).
>>> +	 */
>>> +	u8 num_channels;
>>> +	/* Channels in use on the board */
>> put it in a unsigned long and use the bitmap functions.
>>> +	u8 channels_used[AT91_ADC_MAX_CHANNELS];
>>> +	/* Number of channels in use */
>> just use bitmap_weight with the long above and
>> length set to num_channels.
>>> +	u8 num_channels_used;
> 
> I didn't know bitmap functions before you mentioned it, but if I read it
> correctly, while I agree with your point, I will lose the ability to
> define a combination of enabled and disabled channel in a board specific
> manner.
> 
> In the third patch, I defined channels_used as an array of one. But
> let's say that instead I want all channels except the second one. With
> what's in the driver for now, I initialise it to {1, 0, 1, 1}. I don't
> think it's possible to do so with bitmap functions, or am I missing
> something ?

unsigned long bitmask = BIT(0) | BIT(1) | BIT(3);

Bitmaps are just arrays of unsigned longs.  If you 'know' you have
less than 32 elements, you can just use a single unsigned long and
this assignment gets easier.

Most of the stuff you want comes from bitops.h anyway (maybe all come
to think of it?)
> 
> Or put the calls to bitmap_set in the board_init function ?
Just edit the underlying unsigned long directly.  The fact that the
bitops.h stuff is supposed to work on a bitmap as well means that
will always work.

Jonathan

