Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:47337 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932589Ab1AKS4d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jan 2011 13:56:33 -0500
Message-ID: <4D2CA995.80002@cam.ac.uk>
Date: Tue, 11 Jan 2011 19:03:49 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org
Subject: Re: cs_change for SPI transfers
References: <4D2B1619.1010408@iis.fraunhofer.de>
In-Reply-To: <4D2B1619.1010408@iis.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/10/11 14:22, Manuel Stahl wrote:
> Hi,
> 
> I think there's an error in most IIO devices that use SPI transfers.
> 
> Haavard Skinnemoen wrote:
>> The normal behaviour is:
>>   * After all transfers except the last: CS stays active
>>   * After the last transfer: CS goes inactive
>>
>> The cs_change flag is used to invert this behaviour. So for the last
>> transfer, cs_change indicates that CS should stay active after the
>> transfer (though the driver may not actually be able to do so, e.g. if
>> the message is followed by a message to a different device.)
>>
> 
> The drivers in IIO set cs_change for all transfers (including the
> last in a message), which is not what we want. I can prepare a patch
> to correct this.

Yikes.

They win for completely counter intuitive interface... I guess I can see why
they did it like that (to make 0 the default behaviour).
Clearer naming would have been nice. cs_change_non_default or something...

Please do submit a patch set for this.

Jonathan
