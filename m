Return-Path: <SRS0=4ymh=7N=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0EAC433E0
	for <linux-iio@archiver.kernel.org>; Sun, 31 May 2020 08:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56FC4207BC
	for <linux-iio@archiver.kernel.org>; Sun, 31 May 2020 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590914169;
	bh=O7XVaTF69YkeAj6As27J2fLMQZtZe11xdHEz7+i+6bQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gndPpppX9c9ltLv5hbXcVyJVwGqzavYCxQUtDMhk/viB4pESKqfs1BdYOuarJTQ6u
	 STO6tIC5yYtQYkjs7QHI+OAQwngZd46dU9GL+VepmTfCGtEGxm/oQO7OfCbSB7fz3y
	 aNS6D5HosuFmWsVYYTnRATsT3fIrAeWyXjKXXTX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgEaIgI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 31 May 2020 04:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEaIgI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 04:36:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD03A20707;
        Sun, 31 May 2020 08:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590914168;
        bh=O7XVaTF69YkeAj6As27J2fLMQZtZe11xdHEz7+i+6bQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xdXpqsxp/Z+Fg2JE9MNORCBMbGtmDjNDFzl0/U6Szj+ixr92CzFN6nkmkNk8jQDug
         +/8Xa83BPPrJS6HRxRWeK0yWzTC6TSQD54hwKHyFaKfq/nT44EooIZ8teIk44WrcMB
         NMzGz3KwkaA4H6xfBXQgua10rIYbxvhuj1vw+L4A=
Date:   Sun, 31 May 2020 09:36:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: atlas-ezo-sensor: move ret variable
 scope in atlas_ezo_read_raw()
Message-ID: <20200531093604.7af8d091@archlinux>
In-Reply-To: <20200531030208.12167-1-matt.ranostay@konsulko.com>
References: <20200531030208.12167-1-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 31 May 2020 06:02:08 +0300
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Move ret variable to the IIO_CHAN_INFO_RAW switch since currently
> only used within that scope.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/atlas-ezo-sensor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
> index f5a6d8ec6d4d..a94eb8a6bf32 100644
> --- a/drivers/iio/chemical/atlas-ezo-sensor.c
> +++ b/drivers/iio/chemical/atlas-ezo-sensor.c
> @@ -69,13 +69,13 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct atlas_ezo_data *data = iio_priv(indio_dev);
>  	struct i2c_client *client = data->client;
> -	int ret = 0;
>  
>  	if (chan->type != IIO_CONCENTRATION)
>  		return -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW: {
> +		int ret;
>  		long tmp;
>  
>  		mutex_lock(&data->lock);
> @@ -110,7 +110,7 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static const struct iio_info atlas_info = {

