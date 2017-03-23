Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:47490 "EHLO
        userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754465AbdCWJdb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2017 05:33:31 -0400
Date: Thu, 23 Mar 2017 12:31:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: lars@metafoo.de, devel@driverdev.osuosl.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2] staging: iio: Replace a bit shift by a use of BIT.
Message-ID: <20170323093146.GM32449@mwanda>
References: <20170322164234.GA18805@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170322164234.GA18805@arushi-HP-Pavilion-Notebook>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 22, 2017 at 10:12:34PM +0530, Arushi Singhal wrote:
>  /* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
> -#define AD7746_CAPSETUP_CAPEN		(1 << 7)
> -#define AD7746_CAPSETUP_CIN2		(1 << 6) /* AD7746 only */
> -#define AD7746_CAPSETUP_CAPDIFF		(1 << 5)
> -#define AD7746_CAPSETUP_CACHOP		(1 << 0)
> +#define AD7746_CAPSETUP_CAPEN		(BIT(7))
> +#define AD7746_CAPSETUP_CIN2		(BIT(6)) /* AD7746 only */
> +#define AD7746_CAPSETUP_CAPDIFF		(BIT(5))
> +#define AD7746_CAPSETUP_CACHOP		(BIT(0))

Extra parens.

regards,
dan carpenter

