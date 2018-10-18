Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:57076 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSCki (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2018 22:40:38 -0400
Date: Thu, 18 Oct 2018 21:37:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Stefan Popa <stefan.popa@analog.com>, jic23@kernel.org,
        devel@driverdev.osuosl.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 1/2] staging: iio: ad7606: Move out of staging
Message-ID: <20181018183740.ynxnplac6ca4wxf7@mwanda>
References: <1539853832-26534-1-git-send-email-stefan.popa@analog.com>
 <20181018125502.2hnp3s45lk6dggqt@mwanda>
 <2199f866-4c23-5424-3459-b966514414ce@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2199f866-4c23-5424-3459-b966514414ce@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Oct 18, 2018 at 07:19:36PM +0200, Lars-Peter Clausen wrote:
> On 10/18/2018 02:55 PM, Dan Carpenter wrote:
> > On Thu, Oct 18, 2018 at 12:10:32PM +0300, Stefan Popa wrote:
> >> +static int ad7606_read_samples(struct ad7606_state *st)
> >> +{
> >> +	unsigned int num = st->chip_info->num_channels;
> >> +	u16 *data = st->data;
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * The frstdata signal is set to high while and after reading the sample
> >> +	 * of the first channel and low for all other channels. This can be used
> >> +	 * to check that the incoming data is correctly aligned. During normal
> >> +	 * operation the data should never become unaligned, but some glitch or
> >> +	 * electrostatic discharge might cause an extra read or clock cycle.
> >> +	 * Monitoring the frstdata signal allows to recover from such failure
> >> +	 * situations.
> >> +	 */
> >> +
> >> +	if (st->gpio_frstdata) {
> >> +		ret = st->bops->read_block(st->dev, 1, data);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		if (!gpiod_get_value(st->gpio_frstdata)) {
> > 
> > This check should maybe be:
> > 
> > 		if (gpiod_get_value(st->gpio_frstdata) <= 0) {
> > 
> > (Or possibly not, I don't know the code very well).
> 
> gpiod_get_value() is only allowed to return either 0 or 1.

It looks like it can return negative error codes as well.

regards,
dan carpenter
