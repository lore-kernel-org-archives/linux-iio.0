Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37849 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbcGTPIb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2016 11:08:31 -0400
Subject: Re: [PATCH] staging: iio: light: isl29018/28: remove I2C_CLASS_HWMON
 .class setting
To: Wolfram Sang <wsa@the-dreams.de>
References: <20160716022831.GA7636@d830.WORKGROUP> <578C9843.10408@nvidia.com>
 <dff1e871-de49-654f-5e9b-c9b230a35b0a@kernel.org>
 <20160719071343.GA2086@tetsubishi>
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
	Alison Schofield <amsfield22@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0d515ff9-252a-a8f9-49c1-89ef0b1e9887@kernel.org>
Date: Wed, 20 Jul 2016 16:08:26 +0100
MIME-Version: 1.0
In-Reply-To: <20160719071343.GA2086@tetsubishi>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/07/16 08:13, Wolfram Sang wrote:
> On Mon, Jul 18, 2016 at 02:30:46PM +0100, Jonathan Cameron wrote:
>> On 18/07/16 09:50, Laxman Dewangan wrote:
>>>
>>> On Saturday 16 July 2016 07:58 AM, Alison Schofield wrote:
>>>> I2C_CLASS_HWMON is for a hardware monitoring chip wanting
>>>> auto-detection.  IIO drivers don't typically use .class.
>>>> Remove it.
>>>>
>>>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>>>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>>>>
>>>
>>> Agree.
>>> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
>> Any resulting ABI change from dropping it?
> 
> What do you mean with ABI? This is only relevant for "automatic"
> instantiation.
Cool, I was just being paranoid and didn't have time to check!

Thanks,

Jonathan
> From me:
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> 

