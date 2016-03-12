Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43687 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbcCLLJK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Mar 2016 06:09:10 -0500
Subject: Re: [PATCH] iio: adc: imx25-gcq: fix do_div
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Markus Pargmann <mpa@pengutronix.de>
References: <1457009513-7069-1-git-send-email-sudipm.mukherjee@gmail.com>
 <56DB28BF.9070508@kernel.org> <8010548.jDMIC4yOG6@adelgunde>
 <20160307110632.GA10337@sudip-pc>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E3F8D3.3020707@kernel.org>
Date: Sat, 12 Mar 2016 11:09:07 +0000
MIME-Version: 1.0
In-Reply-To: <20160307110632.GA10337@sudip-pc>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/03/16 11:06, Sudip Mukherjee wrote:
> On Mon, Mar 07, 2016 at 10:01:34AM +0100, Markus Pargmann wrote:
>> Hi,
>>
>> On Saturday 05 March 2016 18:43:11 Jonathan Cameron wrote:
>>> On 03/03/16 12:51, Sudip Mukherjee wrote:
>>>> We are getting build failure with tilepro allmodconfig with the error:
>>>>
>>>> drivers/iio/adc/fsl-imx25-gcq.c:236:4: note: in expansion of macro 'do_div'
>>>> do_div(priv->channel_vref_mv[reg], 1000);
>>>>     ^
>>>>
>>>> include/asm-generic/div64.h:198:17: note: expected 'uint64_t *
>>>> 	{aka long long unsigned int *}' but argument is of type 'u32 *
>>>> 	{aka unsigned int *}'
>>>>
>>>> Create a temporary variable of type u64 and use that in do_div.
>>>>
>>>> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>>> Markus, can you take a quick look at this. 
>>
>> Thanks. I think this was already fixed by Arnd.
>> 	"iio: adc/imx25-gcq: move incorrect do_div"
> 
> It should. But I still have the same build failure with next-20160307
> and not only tilepro, even m32r is also having the same build failure.
> 
Lee, did you pick the original fix from Arnd up?

I can take this after the merge window if not.

Jonathan
> regards
> sudip
> 

