Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:53633 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932127AbdJZQui (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 12:50:38 -0400
Subject: Re: [PATCH] iio/light/max44000: Use common error handling code in
 max44000_probe()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <28854212-d360-8636-4de5-017fbee0db36@users.sourceforge.net>
 <20171026172926.62d5ff87@archlinux>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <c6c5a2d0-39e6-0792-a6d3-4f2861a7eb5a@users.sourceforge.net>
Date: Thu, 26 Oct 2017 18:50:14 +0200
MIME-Version: 1.0
In-Reply-To: <20171026172926.62d5ff87@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>> @@ -596,6 +592,10 @@ static int max44000_probe(struct i2c_client *client,
>>  	}
>>  
>>  	return iio_device_register(indio_dev);
>> +
>> +report_failure:
>> +	dev_err(&client->dev, "failed to write init config: %d\n", ret);
> This reduces readability of the code for a very minor gain.

I got an other software development view on this aspect.


> Printing an error message is not a source of bugs

I find such a general information questionable.

It is also possible to discover various update candidates in this software area.


> or similar unlike unwinding some state, so a unified path makes little sense.

How does such a view fit to the section “7) Centralized exiting of functions”
in the document “coding-style.rst”?

Regards,
Markus
