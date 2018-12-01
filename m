Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:54982 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeLBDHk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Dec 2018 22:07:40 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so3090082ita.4
        for <linux-iio@vger.kernel.org>; Sat, 01 Dec 2018 07:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20181128175312.9634-1-matheus.bernardino@usp.br> <9ea19805-de34-9286-e540-98b75e49f574@broadcom.com>
In-Reply-To: <9ea19805-de34-9286-e540-98b75e49f574@broadcom.com>
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Sat, 1 Dec 2018 13:54:39 -0200
Message-ID: <CAHd-oW4XyMkJaRaQcO+7+qRf1Lm+D2aQ54-YRqSE-TFump8q7A@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
To: scott.branden@broadcom.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Support Opensource <support.opensource@diasemi.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andreas Klinger <ak@it-klinger.de>, Milo Kim <milo.kim@ti.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-usp@googlegroups.com,
        Lucas Santos <ilucas.ms@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 28, 2018 at 4:54 PM Scott Branden
<scott.branden@broadcom.com> wrote:
>>
>>
>> On 2018-11-28 9:53 a.m., Matheus Tavares wrote:
>>
>> From: Lucas Santos <ilucas.ms@gmail.com>
>>
>> This patch removes all license boilerplate texts from the .c and .h
>>
> I know other people don't follow the patch guidelines,
>
> but more info on proper commit message format in link.
>
> (Don't say "this patch" or "this commit" or "I changed") - use imperative present tense.
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>

Ok, thanks for the review. I'll correct that in v2.

Matheus
