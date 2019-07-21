Return-Path: <SRS0=GPtq=VS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B39C76191
	for <linux-iio@archiver.kernel.org>; Sun, 21 Jul 2019 18:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F123208E4
	for <linux-iio@archiver.kernel.org>; Sun, 21 Jul 2019 18:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563732101;
	bh=NmAk6IGGiCMB6rQJ5XbXlTa4qCU5lIlKmlcRTAgSq6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fpo7/+0na6rmp3UDafdQ+SbePO/4SxwM5sHXdEWugEyc08LDtwWxayPCC9Lc5JSbg
	 T2+0geaMlSX4zPjuPRjVqN5v/LiW+23pECbBj6AFdbaMGaE2BoglKS5VWTQLkL7JIh
	 3SajHervJdEYhYLIWSpUJas1KUCve+2vNnsN9lfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfGUSBk (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 21 Jul 2019 14:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGUSBk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jul 2019 14:01:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BDEE20828;
        Sun, 21 Jul 2019 18:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563732100;
        bh=NmAk6IGGiCMB6rQJ5XbXlTa4qCU5lIlKmlcRTAgSq6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hpI6mDWjREWCj/oSzq1qo7NeU+iTTcPmHBVcjBGpl7i6s1+++QVzKh+M+afp8QwdN
         2GmW0GDa+82q1SqtPx/r22Ua1l7gKGGETvilcubck8guL8sK8/SdetdMRtD+ZlN92d
         Dy8Z1Eb49yAjfJfK0Dz60F3mEvGwWVjAQKlfSsn4=
Date:   Sun, 21 Jul 2019 18:51:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 04/11] iio:magn: introduce st_magn_get_settings()
 function
Message-ID: <20190721185124.24ce698b@archlinux>
In-Reply-To: <20190718225353.2078-5-denis.ciocca@st.com>
References: <20190718225353.2078-1-denis.ciocca@st.com>
        <20190718225353.2078-5-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 15:53:46 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> The function is introduced to retrieve magn device settings. It will be
> used by probe in order to configure regmap.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied.

Thanks,

Jonathan

> ---
> Changes in v2:
>  not there in v1. This meant to replace "iio:magn:introduce st_magn_multiread_bit() function"
> 
>  drivers/iio/magnetometer/st_magn.h      |  1 +
>  drivers/iio/magnetometer/st_magn_core.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
> index d69ef9b2a731..204b285725c8 100644
> --- a/drivers/iio/magnetometer/st_magn.h
> +++ b/drivers/iio/magnetometer/st_magn.h
> @@ -22,6 +22,7 @@
>  #define LIS2MDL_MAGN_DEV_NAME		"lis2mdl"
>  #define LSM9DS1_MAGN_DEV_NAME		"lsm9ds1_magn"
>  
> +const struct st_sensor_settings *st_magn_get_settings(const char *name);
>  int st_magn_common_probe(struct iio_dev *indio_dev);
>  void st_magn_common_remove(struct iio_dev *indio_dev);
>  
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 2f7a1dbcdeb3..43a49a52c81a 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -470,6 +470,24 @@ static const struct iio_trigger_ops st_magn_trigger_ops = {
>  #define ST_MAGN_TRIGGER_OPS NULL
>  #endif
>  
> +/*
> + * st_magn_get_settings() - get sensor settings from device name
> + * @name: device name buffer reference.
> + *
> + * Return: valid reference on success, NULL otherwise.
> + */
> +const struct st_sensor_settings *st_magn_get_settings(const char *name)
> +{
> +	int index = st_sensors_get_settings_index(name,
> +					st_magn_sensors_settings,
> +					ARRAY_SIZE(st_magn_sensors_settings));
> +	if (index < 0)
> +		return NULL;
> +
> +	return &st_magn_sensors_settings[index];
> +}
> +EXPORT_SYMBOL(st_magn_get_settings);
> +
>  int st_magn_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *mdata = iio_priv(indio_dev);

