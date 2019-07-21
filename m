Return-Path: <SRS0=GPtq=VS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1063C76191
	for <linux-iio@archiver.kernel.org>; Sun, 21 Jul 2019 18:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF8A20828
	for <linux-iio@archiver.kernel.org>; Sun, 21 Jul 2019 18:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563732103;
	bh=W9xIC+cBxqmTy4cKzYBRJjV9N5P4rDtDfrJf/VqOGqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gCZZlZJwNfWK4Ei0g1kPODMUsoQasvWF41kyWY5Szr4dCOH9d74VTQdUpCD5M9fmq
	 RhCsFRNXSguXOzQ51h9tdYGpq67k7jCP/mBdyE/QZUrN287tUNQs1+PHVbFzEDwh8U
	 p8Tkk2VotG1tPUAY3IpAtUsGOdPlhM220mx8H2ZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGUSBn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 21 Jul 2019 14:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGUSBm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jul 2019 14:01:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C36E2147A;
        Sun, 21 Jul 2019 18:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563732102;
        bh=W9xIC+cBxqmTy4cKzYBRJjV9N5P4rDtDfrJf/VqOGqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qNEE1gosDoBFcFysgyWrygYTzcl//rPj8MIxTjn1qYcIlh+2eK1ZOdZDnse9uIrkS
         yYDJewKgLL0dHHzQqoGMt3r5LiQU27GMpMMMLwvY5D/02jG/6OzMV7IXik32pb2Ofu
         OL/DpBYIo41NehFTqWC55SAV5Q2Xr4sXx98gFJSo=
Date:   Sun, 21 Jul 2019 18:50:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 03/11] iio:gyro: introduce st_gyro_get_settings()
 function
Message-ID: <20190721185008.32eece8a@archlinux>
In-Reply-To: <20190718225353.2078-4-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
        <20190718225353.2078-4-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 15:53:45 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> The function is introduced to retrieve gyro device settings. It will be
> used by probe in order to configure regmap.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied. Thanks,

> ---
> Changes in v2:
>  not there in v1. This meant to replace "iio:gyro:introduce st_gyro_multiread_bit() function"
> 
>  drivers/iio/gyro/st_gyro.h      |  1 +
>  drivers/iio/gyro/st_gyro_core.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
> index 460d190be4a4..592f6b34e987 100644
> --- a/drivers/iio/gyro/st_gyro.h
> +++ b/drivers/iio/gyro/st_gyro.h
> @@ -32,6 +32,7 @@ static const struct st_sensors_platform_data gyro_pdata = {
>  	.drdy_int_pin = 2,
>  };
>  
> +const struct st_sensor_settings *st_gyro_get_settings(const char *name);
>  int st_gyro_common_probe(struct iio_dev *indio_dev);
>  void st_gyro_common_remove(struct iio_dev *indio_dev);
>  
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index e995dc77e30e..5cc63d41d855 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -368,6 +368,24 @@ static const struct iio_trigger_ops st_gyro_trigger_ops = {
>  #define ST_GYRO_TRIGGER_OPS NULL
>  #endif
>  
> +/*
> + * st_gyro_get_settings() - get sensor settings from device name
> + * @name: device name buffer reference.
> + *
> + * Return: valid reference on success, NULL otherwise.
> + */
> +const struct st_sensor_settings *st_gyro_get_settings(const char *name)
> +{
> +	int index = st_sensors_get_settings_index(name,
> +					st_gyro_sensors_settings,
> +					ARRAY_SIZE(st_gyro_sensors_settings));
> +	if (index < 0)
> +		return NULL;
> +
> +	return &st_gyro_sensors_settings[index];
> +}
> +EXPORT_SYMBOL(st_gyro_get_settings);
> +
>  int st_gyro_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *gdata = iio_priv(indio_dev);

