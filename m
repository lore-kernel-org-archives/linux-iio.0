Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42106 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbcH2RUU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 13:20:20 -0400
Subject: Re: [PATCH v2] iio: dac: AD8801: add Analog Devices AD8801/AD8803
 support
To: Lars-Peter Clausen <lars@metafoo.de>,
        Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        linux-iio@vger.kernel.org
References: <20160824144420.7326-1-gwenhael.goavec-merou@trabucayre.com>
 <0177ce8f-4bc2-a726-1503-6786a14f3148@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Paul Cercueil <paul.cercueil@analog.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8fcea3fb-dce1-d763-2d02-7909baed7ad3@kernel.org>
Date: Mon, 29 Aug 2016 18:20:18 +0100
MIME-Version: 1.0
In-Reply-To: <0177ce8f-4bc2-a726-1503-6786a14f3148@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/08/16 09:02, Lars-Peter Clausen wrote:
> On 08/24/2016 04:44 PM, Gwenhael Goavec-Merou wrote:
>> Add support for Analog Devices AD8801/AD8803, 8 channels 8bits, Digital to
>> Analog converters.
>>
>> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>
> 
> Looks good, thanks.
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Just one tiny thing, there is a extra new line at the end of the file. But
> maybe Jonathan can remove that if he replies the patch.
Done.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

