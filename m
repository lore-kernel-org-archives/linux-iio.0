Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:35186 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752433AbeCWMcM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Mar 2018 08:32:12 -0400
Date: Fri, 23 Mar 2018 12:32:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Anthony Legault Cesta <anthony@alcmedia.com>
CC: <linux-iio@vger.kernel.org>
Subject: Re: Controlling ADC SPI devices
Message-ID: <20180323133201.00006d75@huawei.com>
In-Reply-To: <58bf1805-774a-5b88-75cd-024199308491@alcmedia.com>
References: <58bf1805-774a-5b88-75cd-024199308491@alcmedia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Mar 2018 13:46:53 -0400
Anthony Legault Cesta <anthony@alcmedia.com> wrote:

> Hello,
> 
> my name's Anthony & I need some help with the following:
> 
> Reading ADC values from mcp3208 on the spi bus within my custom made 
> kernel module.
> 
> I'm able to read spi values thru /sys/bus/iio/devices/iio:device0 no 
> problems but I need access it from within my drivers.
> 
> I've tried using dev_to_iio_dev(dev) but can't seem to claim the *dev 
> allocated for the spi device.
> 
> How can I get a ref * to the device?
> 
> How can I tackle this using iio method?

Hi Anthony,

I am a little unclear of what you are trying to accomplish.
Do you simply want to be able to read a value from the device from
another driver or set some control parameters?  

If so we have the in kernel interfaces that allow you to do
so in either polled mode (Similar to sysfs operation) or in
buffered mode (similar to buffered mode via the IIO chrdev).
They are in the inkern.c file and iio/consumer.h.

To do that you have to register the relevant channel maps either
in code, or using the devicetree.  There are quite a few examples
in tree.

Jonathan
> 
> Thanks i advanced!
> 
> 
> Anthony
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

