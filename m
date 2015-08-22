Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38201 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbbHVSEy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Aug 2015 14:04:54 -0400
Subject: Re: [PATCH 16/18] iio: frequency: adf4350: Add OF match table
To: Lars-Peter Clausen <lars@metafoo.de>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-17-git-send-email-javier@osg.samsung.com>
 <55D5F6F3.7060107@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D8B9C4.3030008@kernel.org>
Date: Sat, 22 Aug 2015 19:04:52 +0100
MIME-Version: 1.0
In-Reply-To: <55D5F6F3.7060107@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/08/15 16:49, Lars-Peter Clausen wrote:
> On 08/20/2015 09:07 AM, Javier Martinez Canillas wrote:
>> The Documentation/devicetree/bindings/iio/frequency/adf4350.txt DT binding
>> doc lists "adi,adf4350" or "adi,adf4351" as compatible strings but the
>> corresponding driver does not have an OF match table. Add the table to the
>> driver so the SPI core can do an OF style match.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> 
> Thanks.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

