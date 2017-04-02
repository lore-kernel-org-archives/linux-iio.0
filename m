Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47750 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdDBJy0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 05:54:26 -0400
Subject: Re: [PATCH v2] iio:adc: Driver for Linear Technology LTC2497 ADC
To: Lars-Peter Clausen <lars@metafoo.de>, michael.hennerich@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1490599433-6103-1-git-send-email-michael.hennerich@analog.com>
 <3d54516e-cbd1-8a61-0d83-a91d7055f44c@kernel.org>
 <f0229cde-15b6-d45b-6d85-3c90082d0226@metafoo.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <892d8b1d-7673-e240-1f42-fbc0ee94f7a2@kernel.org>
Date: Sun, 2 Apr 2017 10:54:24 +0100
MIME-Version: 1.0
In-Reply-To: <f0229cde-15b6-d45b-6d85-3c90082d0226@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/04/17 10:52, Lars-Peter Clausen wrote:
> On 04/02/2017 11:30 AM, Jonathan Cameron wrote:
>> On 27/03/17 08:23, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> This patch adds support for the Analog Devices / Linear Technology
>>> LTC2497 ADCs. The LTC2497 is a 16-channel (eight differential),
>>> 16-bit, high precision, delta-sigma ADC with an automatic, differential,
>>> input current cancellation front end and a 2-wire, I2C interface.
>>>
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> Looks good to me.
>>
>> Applied to the togreg branch of iio.git and pushed out as testing for
>> the autobuilders to play with it.
> 
> There is a v3 of this patch.
> 
unapplied.  Thanks Lars!


