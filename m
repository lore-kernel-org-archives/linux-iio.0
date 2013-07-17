Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54961 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176Ab3GQONN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 10:13:13 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so4096362iec.5
        for <linux-iio@vger.kernel.org>; Wed, 17 Jul 2013 07:13:13 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 17 Jul 2013 11:13:12 -0300
Message-ID: <CAP9ODKq7TkBnpQSvwMRT0Cdy5wwfDGZ3E0ddP5vHkEgmskbcyg@mail.gmail.com>
Subject: ADC setting for differential and single-ended channels
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-iio@vger.kernel.org, Mario Goulart <mario@ossystems.com.br>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

Mario and I are working at TI ADS124x driver and this chip can be used
in two ways:

In case of ADS1247:

 - 2 differential channels
 - 3 single-ended channels

In the first case it take two inputs and the chip returns the
difference between them; in the second case it does the same but you
must choose one channel to be the negative reference for all the other
inputs. This is how we understood the datasheet however the
single-ended use is quite confusing on it so we might be wrong.

So we'd like to know the best way to handle those cases in the driver.
One alternative we discussed is to use two attributes in the dts as:

 ...
 #channels = <2>;
 channels = <0 3
                    1 2>;

So it'd take two channels. One composed by input 0 and input 3 and
another composed by input 1 and input 2.

On the another case, we'd use:

  ...
  #channels = <3>
  channels = <0 3
                     1 3
                     2 3>;

So it'd take three channels and all them comparing to input 3.

Are we in the right route? Any hints how to better solve this?

Regards,

--
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://projetos.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
