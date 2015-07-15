Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34249 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbbGOX2w (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2015 19:28:52 -0400
Received: by iebmu5 with SMTP id mu5so44604798ieb.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2015 16:28:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMHSBOVNOKP=Q32YTL2_vwcW+FfHYNKyOPM4CaesthfoH5xidg@mail.gmail.com>
References: <CAMHSBOVNOKP=Q32YTL2_vwcW+FfHYNKyOPM4CaesthfoH5xidg@mail.gmail.com>
From: Gwendal Grignou <gwendal@google.com>
Date: Wed, 15 Jul 2015 16:28:30 -0700
Message-ID: <CAMHSBOWjDW9X4LnZcub9jA2h9P+LPSj-t_Rrg8STA6KpFtezTw@mail.gmail.com>
Subject: Re: Question about IIO_DEGREE_TO_RAD macro in include/linux/iio.h
To: Gwendal Grignou <gwendal@chromium.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

[Plain text]
Lars,

Looking at the macro IIO_DEGREE_TO_RAD() to translate degree/s into rad/s, I
don't understand why we add an offset when doing the conversion:

#define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) / 18000000ULL)

Shouldn't it just be
#define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL) / 18000000ULL)

Gwendal.
