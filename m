Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-025.synserver.de ([212.40.185.25]:1054 "EHLO
	smtp-out-025.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768AbbGPJT0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2015 05:19:26 -0400
Message-ID: <55A7771A.9020505@metafoo.de>
Date: Thu, 16 Jul 2015 11:19:22 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Gwendal Grignou <gwendal@chromium.org>
CC: linux-iio@vger.kernel.org
Subject: Re: Question about IIO_DEGREE_TO_RAD macro in include/linux/iio.h
References: <CAMHSBOVNOKP=Q32YTL2_vwcW+FfHYNKyOPM4CaesthfoH5xidg@mail.gmail.com>
In-Reply-To: <CAMHSBOVNOKP=Q32YTL2_vwcW+FfHYNKyOPM4CaesthfoH5xidg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/16/2015 01:24 AM, Gwendal Grignou wrote:
> Lars,
>
> Looking at the macro IIO_DEGREE_TO_RAD() to translate degree/s into rad/s,
> I don't understand why we add an offset when doing the conversion:
>
> #define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) /
> 18000000ULL)
>
> Shouldn't it just be
> #define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL) / 18000000ULL)

Hi,

The offset is for rounding to the nearest integer. Without the offset it 
would round down.

- Lars


