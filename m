Return-Path: <SRS0=tzPa=5A=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF1CC10DCE
	for <linux-iio@archiver.kernel.org>; Sun, 15 Mar 2020 12:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1110A206B1
	for <linux-iio@archiver.kernel.org>; Sun, 15 Mar 2020 12:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584276150;
	bh=SoCs3pnq1oqA2/niEbhVOD8j5WmNjr6uaLWWJui/gC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xZREG9wmCHrWwDMqoLhvnxr8Rp8lVsO2sn2DnsRQzJoxQnPcBf9FzIWAKpE/MjhEV
	 nLXl78lzbU+1C3vteD800gSEXEtLpNdeigel77QyVj7Mpxmz+t2EAFxywkY+YxIzNM
	 R7+RGvk21Ad8xrBxVR36g8JfmX2j8VBvIn5l6i8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgCOMm3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 15 Mar 2020 08:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgCOMm3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 08:42:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A149920674;
        Sun, 15 Mar 2020 12:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584276148;
        bh=SoCs3pnq1oqA2/niEbhVOD8j5WmNjr6uaLWWJui/gC0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FO0ZddcHPFoyyk3MOM8UmDUCx4A/KdsieXVSAg0Nsk2Pbim8rhJB/6keEpP3MLftV
         msC30s4GIpzmpIblHVQQZjW6360gYAgpbPWaty8J4ssq2KxRivh0IOiZ2uWYq0bKSo
         RsofzDECeyr4LO3lLzKjTVlIYuH2m0joIXQxwU0Y=
Date:   Sun, 15 Mar 2020 12:42:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 6/8] iio: humidity: hts221: Use dev_get_platdata() to
 get platform_data
Message-ID: <20200315124224.2ef0a50a@archlinux>
In-Reply-To: <20200313104955.30423-6-andriy.shevchenko@linux.intel.com>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
        <20200313104955.30423-6-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Mar 2020 12:49:53 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use dev_get_platdata() to get the platform_data instead of
> referencing it directly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.   Thanks,

Jonathan

> ---
> v2: new patch
>  drivers/iio/humidity/hts221_buffer.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index 81d50a861c22..5f142a44c1dd 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -74,10 +74,10 @@ static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
>  
>  int hts221_allocate_trigger(struct hts221_hw *hw)
>  {
> +	struct st_sensors_platform_data *pdata = dev_get_platdata(hw->dev);
>  	struct iio_dev *iio_dev = iio_priv_to_dev(hw);
>  	bool irq_active_low = false, open_drain = false;
>  	struct device_node *np = hw->dev->of_node;
> -	struct st_sensors_platform_data *pdata;
>  	unsigned long irq_type;
>  	int err;
>  
> @@ -106,7 +106,6 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
>  	if (err < 0)
>  		return err;
>  
> -	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
>  	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
>  	    (pdata && pdata->open_drain)) {
>  		irq_type |= IRQF_SHARED;

