Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35753 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932680AbcLIFUs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2016 00:20:48 -0500
Received: by mail-pf0-f175.google.com with SMTP id i88so1877311pfk.2
        for <linux-iio@vger.kernel.org>; Thu, 08 Dec 2016 21:20:48 -0800 (PST)
Date: Thu, 8 Dec 2016 21:20:44 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 3/3] iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC
Message-ID: <20161209052044.GV30492@tuxbot>
References: <1481032279-27115-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481032279-27115-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue 06 Dec 05:51 PST 2016, Linus Walleij wrote:

> +static struct pm8xxx_chan_info *
> +pm8xxx_get_channel(struct pm8xxx_xoadc *adc, u8 chan)
> +{
> +	struct pm8xxx_chan_info *ch;
> +	int i;
> +
> +	if (chan >= adc->nchans)
> +		return NULL;

nchans is the number of children and chan is the channel id, so this
doesn't seem right (I think you should just drop this check).

> +
> +	for (i = 0; i < adc->nchans; i++) {
> +		ch = &adc->chans[i];
> +		if (ch->amux_channel == chan)
> +			break;
> +	}
> +	if (i == adc->nchans)
> +		return NULL;
> +
> +	return ch;
> +}
> +
> +static int pm8xxx_read_channel_rsv(struct pm8xxx_xoadc *adc,
> +				   const struct pm8xxx_chan_info *ch,
> +				   u8 rsv, u16 *adc_code)
> +{
> +	int ret;
> +	unsigned int val;
> +	u8 rsvmask, rsvval;
> +	u8 lsb, msb;
> +
> +	dev_dbg(adc->dev, "read channel \"%s\", amux %d, mpp %d, rsv %d\n",
> +		ch->name, ch->amux_channel, ch->amux_mpp_channel, rsv);
> +
> +	/* Mux in this channel */
> +	ret = regmap_write(adc->map, ADC_ARB_USRP_AMUX_CNTRL,
> +			   ch->amux_channel << ADC_AMUX_SEL_SHIFT |
> +			   ch->amux_mpp_channel << ADC_AMUX_PREMUX_SHIFT);

Does this need synchronization to stop multiple clients to stomp on each
other here?

> +	if (ret)
> +		return ret;
> +

Regards,
Bjorn
