Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:58624 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3CAEjS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Feb 2013 23:39:18 -0500
Date: Thu, 28 Feb 2013 20:32:22 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: linux-iio@vger.kernel.org
Subject: IIO_BUFFER - IIO_TRIGGERED_BUFFER circular dependency
Message-ID: <20130301043222.GA5606@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

IIO_TRIGGERED_BUFFER depends on IIO_BUFFER because of:

drivers/iio/industrialio-triggered-buffer.c:20:16: error:
‘iio_sw_buffer_preenable’ undeclared here (not in a function)

On the other side, it is often selected as follows.

	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)

For that reason, selecting IIO_BUFFER in the IIO_TRIGGERED_BUFFER declaration
results in a circular dependency. Sometimes the "if (IIO_BUFFER)" when selecting
IIO_TRIGGERED_BUFFER is missing, though, which can result in the compile error.

What is the proper solution ?
- Add "if (IIO_BUFFER)" whenever IIO_TRIGGERED_BUFFER is selected
or
- Remove "if (IIO_BUFFER)" from IIO_TRIGGERED_BUFFER selection and add "select
  IIO_BUFFER" to the IIO_TRIGGERED_BUFFER declaration

I would prefer the latter to solve the problem for good.

Thanks,
Guenter
