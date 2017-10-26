Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932367AbdJZRsB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 13:48:01 -0400
Date: Thu, 26 Oct 2017 18:39:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/light/max44000: Use common error handling code in
 max44000_probe()
Message-ID: <20171026183901.42f44acc@archlinux>
In-Reply-To: <c6c5a2d0-39e6-0792-a6d3-4f2861a7eb5a@users.sourceforge.net>
References: <28854212-d360-8636-4de5-017fbee0db36@users.sourceforge.net>
        <20171026172926.62d5ff87@archlinux>
        <c6c5a2d0-39e6-0792-a6d3-4f2861a7eb5a@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 26 Oct 2017 18:50:14 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> >> @@ -596,6 +592,10 @@ static int max44000_probe(struct i2c_client *client,
> >>  	}
> >>  
> >>  	return iio_device_register(indio_dev);
> >> +
> >> +report_failure:
> >> +	dev_err(&client->dev, "failed to write init config: %d\n", ret);  
> > This reduces readability of the code for a very minor gain.  
> 
> I got an other software development view on this aspect.
> 

Sadly I am going to put my foot down here before more time
is wasted. I am not going to discuss it further after this email.
(for others please see the amount of time already wasted on
what are mostly poor code changes from Markus).

> 
> > Printing an error message is not a source of bugs  
> 
> I find such a general information questionable.
> 
> It is also possible to discover various update candidates in this software area.
Judge each one carefully.  You need to be convincingly improving the code
not just obeying rules blindly.

> 
> 
> > or similar unlike unwinding some state, so a unified path makes little sense.  
> 
> How does such a view fit to the section “7) Centralized exiting of functions”
> in the document “coding-style.rst”?
All rules in there need to be applied with care. If they make the code
worse do not blindly apply them.

> 
> Regards,
> Markus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

