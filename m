Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:62662 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbdJ0Nny (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Oct 2017 09:43:54 -0400
Subject: Re: [PATCH] iio/adc/palmas: Use common error handling code in
 palmas_gpadc_calibrate()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Alison Schofield <amsfield22@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <0ae3662d-6a74-622c-0423-e8552ea79bca@users.sourceforge.net>
 <20171026173314.0bd5fd27@archlinux>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <bcd5b722-fe10-8ea0-0f90-662cb414b4c0@users.sourceforge.net>
Date: Fri, 27 Oct 2017 15:43:27 +0200
MIME-Version: 1.0
In-Reply-To: <20171026173314.0bd5fd27@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>> @@ -329,6 +325,10 @@ static int palmas_gpadc_calibrate(struct palmas_gpadc *adc, int adc_chan)
>>  
>>  scrub:
>>  	return ret;
>> +
>> +report_failure:
> 
> This makes for complex code flow where it is not needed.

The shown code layout would be required in the suggested software design direction.


> As such I am not going to even think about taking this sort of patch.

It might take more time until similar situations will be reconsidered.


>> +	dev_err(adc->dev, "TRIM read failed: %d\n", ret);
>> +	goto scrub;
>>  }
>>  
>>  static int palmas_gpadc_start_conversion(struct palmas_gpadc *adc, int adc_chan)

Do any other contributors find a bit of code reduction desirable for this
software module?

Regards,
Markus
