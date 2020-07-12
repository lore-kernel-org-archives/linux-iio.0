Return-Path: <SRS0=WZ3W=AX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BA1C433E3
	for <linux-iio@archiver.kernel.org>; Sun, 12 Jul 2020 12:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B475E20672
	for <linux-iio@archiver.kernel.org>; Sun, 12 Jul 2020 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594555526;
	bh=zPmWLPiVLK6GWNqVQox5Gti6dKu/1z3i6S2S01OL5ME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=A9owO0kP9x+XIWhfqpe+jMCbNwjT0TLmlzB6pjRsGzK9ptZ3Q8PQj5qUaC4mZ57Tf
	 FeTO3bdVNTNuSwCrgcxE+Z+9O8iVKrJ7h9bPkoeu6slnS/dhd3ayfwSfHYgL8XznJ7
	 Pjb7SwxtPHR1yp64D549Gyt1NEmgTHdClLE8LfQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgGLMFW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 12 Jul 2020 08:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgGLMFW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Jul 2020 08:05:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC41020672;
        Sun, 12 Jul 2020 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594555521;
        bh=zPmWLPiVLK6GWNqVQox5Gti6dKu/1z3i6S2S01OL5ME=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EtoDm0Q8f1PJRUNtQfv6aIv4NgkpCN+JdRBQyEHBKRhCfWKpEkQCTh9QrwVF/WLr/
         twG7wuQwCLo1kqU5lqE7mOxYRKDGn1AdkgFt8KgzjHW7vlM7izKhjS+JLPgd440/i4
         mXd8B1o1GHhslmUt0t2mC0OeDPo5TLgNix6YNNzY=
Date:   Sun, 12 Jul 2020 13:05:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] IIO: Ingenic JZ47xx: Add xlate cb to retrieve
 correct channel idx
Message-ID: <20200712130517.397fd668@archlinux>
In-Reply-To: <20200709152200.10039-4-contact@artur-rojek.eu>
References: <20200709152200.10039-1-contact@artur-rojek.eu>
        <20200709152200.10039-4-contact@artur-rojek.eu>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  9 Jul 2020 17:21:57 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> Provide an of_xlate callback in order to retrieve the correct channel
> specifier index from the IIO channels array.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
Applied.  Thanks,

Jonathan

> ---
> 
>  Changes:
> 
>  v2-v8: no change
> 
>  drivers/iio/adc/ingenic-adc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
> index c1946a9f1cca..89019fb59d48 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -400,6 +400,21 @@ static int ingenic_adc_read_raw(struct iio_dev *iio_dev,
>  	}
>  }
>  
> +static int ingenic_adc_of_xlate(struct iio_dev *iio_dev,
> +				const struct of_phandle_args *iiospec)
> +{
> +	int i;
> +
> +	if (!iiospec->args_count)
> +		return -EINVAL;
> +
> +	for (i = 0; i < iio_dev->num_channels; ++i)
> +		if (iio_dev->channels[i].channel == iiospec->args[0])
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
>  static void ingenic_adc_clk_cleanup(void *data)
>  {
>  	clk_unprepare(data);
> @@ -409,6 +424,7 @@ static const struct iio_info ingenic_adc_info = {
>  	.write_raw = ingenic_adc_write_raw,
>  	.read_raw = ingenic_adc_read_raw,
>  	.read_avail = ingenic_adc_read_avail,
> +	.of_xlate = ingenic_adc_of_xlate,
>  };
>  
>  static const struct iio_chan_spec ingenic_channels[] = {

