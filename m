Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:38856 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeJWOCl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Oct 2018 10:02:41 -0400
Date: Tue, 23 Oct 2018 08:39:54 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, devel@driverdev.osuosl.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Slawomir Stepien <sst@poczta.fm>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging: iio: adt7316: Switch to the gpio descriptor
 interface
Message-ID: <20181023053954.zsvkq2wqwnyp2xrd@mwanda>
References: <20181022171418.GA2612@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181022171418.GA2612@nishad>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Oct 22, 2018 at 10:44:22PM +0530, Nishad Kamdar wrote:
> -	chip->ldac_pin = adt7316_platform_data[1];
> +	chip->ldac_pin = devm_gpiod_get(dev, "ldac", GPIOD_OUT_HIGH);
> +	if (IS_ERR(chip->ldac_pin)) {
> +		ret = PTR_ERR(chip->ldac_pin);
> +		dev_err(dev, "Failed to request ldac GPIO: %d\n",
> +			ret);

This can fit on one line:

		dev_err(dev, "Failed to request ldac GPIO: %d\n", ret);

regards,
dan carpenter


> +		return ret;
> +	}
