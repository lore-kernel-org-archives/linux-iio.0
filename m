Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33815 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162820AbcG1HSB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jul 2016 03:18:01 -0400
Received: by mail-wm0-f54.google.com with SMTP id q128so34857480wma.1
        for <linux-iio@vger.kernel.org>; Thu, 28 Jul 2016 00:18:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b6dd0816-074c-a2a7-4e2c-55e417dfcf77@arcor.de>
References: <b6dd0816-074c-a2a7-4e2c-55e417dfcf77@arcor.de>
From: Matt Ranostay <mranostay@gmail.com>
Date: Thu, 28 Jul 2016 00:17:20 -0700
Message-ID: <CAKzfze9wUKJ4JfhNtKhR17KNQ82_RPNcyoj259Tc=k4=mk8BSw@mail.gmail.com>
Subject: Re: trivial error in ti-ads1015.c
To: Giorgio <giorgio.nicole@arcor.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 27, 2016 at 1:29 PM, Giorgio <giorgio.nicole@arcor.de> wrote:
> Hi,
>
> I noticed a trivial bug in the file 'drivers/iio/adc/ti-ads1015.c', in
> the function:
>
> static int ads1015_get_channels_config_of(struct i2c_client *client)
> {
>         struct ads1015_data *data = i2c_get_clientdata(client);
>         struct device_node *node;
> ...
>
> The pointer 'data' is not correctly assigned; its definition should look
> like:
>
>         struct iio_dev *indio_dev = i2c_get_clientdata(client);
>         struct ads1015_data *data = iio_priv(indio_dev);
>

Good catch however it seems ads1015_data pointer reference isn't even
needed in this function.
I'll submit a patchset to remove this and cc you.

Thanks,

Matt

> as is the case in:
>
> static void ads1015_get_channels_config(struct i2c_client *client)
> {
> ..
>
> giorgio
>
