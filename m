Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36280 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756936Ab3GQTMo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 15:12:44 -0400
In-Reply-To: <CAP9ODKq7TkBnpQSvwMRT0Cdy5wwfDGZ3E0ddP5vHkEgmskbcyg@mail.gmail.com>
References: <CAP9ODKq7TkBnpQSvwMRT0Cdy5wwfDGZ3E0ddP5vHkEgmskbcyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: ADC setting for differential and single-ended channels
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 17 Jul 2013 20:12:41 +0100
To: Otavio Salvador <otavio@ossystems.com.br>,
	linux-iio@vger.kernel.org, Mario Goulart <mario@ossystems.com.br>
CC: Lars-Peter Clausen <lars@metafoo.de>, Marek Vasut <marex@denx.de>
Message-ID: <814feb73-b2b3-4f23-8066-4221b75ac0b9@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Otavio Salvador <otavio@ossystems.com.br> wrote:
>Hello,
>
>Mario and I are working at TI ADS124x driver and this chip can be used
>in two ways:
>
>In case of ADS1247:
>
> - 2 differential channels
> - 3 single-ended channels
>
>In the first case it take two inputs and the chip returns the
>difference between them; in the second case it does the same but you
>must choose one channel to be the negative reference for all the other
>inputs. This is how we understood the datasheet however the
>single-ended use is quite confusing on it so we might be wrong.
>
>So we'd like to know the best way to handle those cases in the driver.
>One alternative we discussed is to use two attributes in the dts as:
>
> ...
> #channels = <2>;
> channels = <0 3
>                    1 2>;
>
>So it'd take two channels. One composed by input 0 and input 3 and
>another composed by input 1 and input 2.
>
>On the another case, we'd use:
>
>  ...
>  #channels = <3>
>  channels = <0 3
>                     1 3
>                     2 3>;
>
>So it'd take three channels and all them comparing to input 3.
>
>Are we in the right route? Any hints how to better solve this?

Another option is to leave it entirely up to user space.  See max1363 driver where both single ended and differential channels are supported at the same time with care taken in buffered mode.

Not sure if that works for your case?
>
>Regards,
>
>--
>Otavio Salvador                             O.S. Systems
>http://www.ossystems.com.br        http://projetos.ossystems.com.br
>Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
