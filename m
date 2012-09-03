Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46675 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502Ab2ICULQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Sep 2012 16:11:16 -0400
Message-ID: <50450EE1.3020007@kernel.org>
Date: Mon, 03 Sep 2012 21:11:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH v3.6-rc2 V2 1/2] iio:ad5446: Add support for I2C based
 DACs
References: <502E10A4.1080800@metafoo.de> <1345559338-19509-1-git-send-email-jeff.dagenais@gmail.com> <1345559338-19509-2-git-send-email-jeff.dagenais@gmail.com> <503523DD.2030203@kernel.org> <503767CA.2010109@metafoo.de> <504463D5.6000104@metafoo.de>
In-Reply-To: <504463D5.6000104@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/2012 09:01 AM, Lars-Peter Clausen wrote:
> On 08/24/2012 01:38 PM, Lars-Peter Clausen wrote:
>> On 08/22/2012 08:24 PM, Jonathan Cameron wrote:
>>> On 08/21/2012 03:28 PM, Jean-Francois Dagenais wrote:
>>>> This patch adds support for I2C based single channel DACs to the ad5446
>>>> driver. Specifically AD5602, AD5612 and AD5622.
>>>>
>>>> V1: from Lars-Peter Clausen <lars@metafoo.de>
>>>> V2: Split the device IDs into two enums and move them to the c file.
>>> Sensible change.  Patch is fine but given we are still well away from
>>> the merge window I'll wait for Lars-Peter's response before merging this.
>>>
>>
>> Looks good to me on first sight. I'd have done the two patches in reverse
>> order, but it doesn't really matter.
>>
>> Will take a closer look when I'm back from vacation, but I'm already quite
>> confident that it can go in as is.
>>
> 
> 
> Both patches:
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Merge and pull request sent to Greg.

Thanks.
