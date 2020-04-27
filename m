Return-Path: <SRS0=i9YC=6L=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F774CAB362
	for <linux-iio@archiver.kernel.org>; Mon, 27 Apr 2020 15:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD9E2054F
	for <linux-iio@archiver.kernel.org>; Mon, 27 Apr 2020 15:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgD0PNr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:13:47 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:44301 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728203AbgD0PNq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 11:13:46 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.16.2])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 1A4BA5B0A4CF;
        Mon, 27 Apr 2020 17:13:43 +0200 (CEST)
Received: from localhost (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 27 Apr
 2020 17:13:42 +0200
Date:   Mon, 27 Apr 2020 17:12:14 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Andreas Klinger <ak@it-klinger.de>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <bgolaszewski@baylibre.com>,
        <linus.walleij@linaro.org>, <tglx@linutronix.de>,
        <allison@lohutok.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: bmp280: fix compensation of humidity
Message-ID: <20200427151214.GA6389@arch>
References: <20200427140017.GA25402@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200427140017.GA25402@arbad>
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 17773174454577880249
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrheelgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecukfhppedtrddtrddtrddtpdekledrjedtrdefuddrvddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 27, 2020 at 04:00:19PM +0200, Andreas Klinger wrote:
> Output of humidity compensation is limited to the range between 0 and 100
> percent. Add this to the compensation formula as described in the datasheet
> chapter 4.2.3.
>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  drivers/iio/pressure/bmp280-core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 29c209cc1108..ac9ef1b63b07 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -271,6 +271,9 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
>  		+ (s32)2097152) * calib->H2 + 8192) >> 14);
>  	var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)calib->H1) >> 4;
>
> +	var = var < 0 ? 0 : var;
> +	var = var > 419430400 ? 419430400 : var;
> +

Looks that clamp_val() might come in handy here.

>  	return var >> 12;
>  };
>
> --
> 2.20.1
