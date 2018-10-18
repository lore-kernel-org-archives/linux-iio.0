Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:45698 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeJSBWC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2018 21:22:02 -0400
Subject: Re: [PATCH 1/2] staging: iio: ad7606: Move out of staging
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, devel@driverdev.osuosl.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de
References: <1539853832-26534-1-git-send-email-stefan.popa@analog.com>
 <20181018125502.2hnp3s45lk6dggqt@mwanda>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2199f866-4c23-5424-3459-b966514414ce@metafoo.de>
Date: Thu, 18 Oct 2018 19:19:36 +0200
MIME-Version: 1.0
In-Reply-To: <20181018125502.2hnp3s45lk6dggqt@mwanda>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/18/2018 02:55 PM, Dan Carpenter wrote:
> On Thu, Oct 18, 2018 at 12:10:32PM +0300, Stefan Popa wrote:
>> +static int ad7606_read_samples(struct ad7606_state *st)
>> +{
>> +	unsigned int num = st->chip_info->num_channels;
>> +	u16 *data = st->data;
>> +	int ret;
>> +
>> +	/*
>> +	 * The frstdata signal is set to high while and after reading the sample
>> +	 * of the first channel and low for all other channels. This can be used
>> +	 * to check that the incoming data is correctly aligned. During normal
>> +	 * operation the data should never become unaligned, but some glitch or
>> +	 * electrostatic discharge might cause an extra read or clock cycle.
>> +	 * Monitoring the frstdata signal allows to recover from such failure
>> +	 * situations.
>> +	 */
>> +
>> +	if (st->gpio_frstdata) {
>> +		ret = st->bops->read_block(st->dev, 1, data);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (!gpiod_get_value(st->gpio_frstdata)) {
> 
> This check should maybe be:
> 
> 		if (gpiod_get_value(st->gpio_frstdata) <= 0) {
> 
> (Or possibly not, I don't know the code very well).

gpiod_get_value() is only allowed to return either 0 or 1.
