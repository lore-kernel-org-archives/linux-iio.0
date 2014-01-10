Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-077.synserver.de ([212.40.185.77]:1069 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750947AbaAJJ1S (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jan 2014 04:27:18 -0500
Message-ID: <52CFBD0F.1080603@metafoo.de>
Date: Fri, 10 Jan 2014 10:27:43 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	kernel@savoirfairelinux.com
Subject: Re: max1363: internal reference
References: <2013486580.319791.1389289182921.JavaMail.root@mail>
In-Reply-To: <2013486580.319791.1389289182921.JavaMail.root@mail>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2014 06:39 PM, Vivien Didelot wrote:
> Hi Jonathan,
> 
> As described in the max1363.c header, the control of the internal
> reference is not currently supported by the driver.
> 
> We have two max11603 and max11605 which need this option. We currently
> use a monkey patch like this in max1363.c:
> 
>     @@ -1414,7 +1414,12 @@ static const struct max1363_chip_info ma
>      static int max1363_initial_setup(struct max1363_state *st)
>      {
>     +#ifdef OUR_BOARD
>     +      st->setupbyte = MAX1363_SETUP_AIN3_IS_AIN3_REF_IS_INT
>     +#else
>            st->setupbyte = MAX1363_SETUP_AIN3_IS_AIN3_REF_IS_VDD
>     +#endif
>                    | MAX1363_SETUP_POWER_UP_INT_REF
>                    | MAX1363_SETUP_INT_CLOCK
>                    | MAX1363_SETUP_UNIPOLAR
> 
> In order to add the support for this, I would suggest adding a 
> platform_data for this driver such as:
> 
>     struct max1363_platform_data {
>         bool internal_reference;
>     };
> 
> What do you think?

Yes. But make sure to properly document the platform data struct with kernel
doc.

- Lars
