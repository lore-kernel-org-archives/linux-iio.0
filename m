Return-Path: <SRS0=wvAN=YF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78239C4360C
	for <linux-iio@archiver.kernel.org>; Sat, 12 Oct 2019 12:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4784321A4A
	for <linux-iio@archiver.kernel.org>; Sat, 12 Oct 2019 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570883148;
	bh=OVuBDbj/mxE+fQqEQMS1cE9xWhqDaLjbyKyuUAn4wS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=W4DRbp18i1yz25uevJHCMpqnMI4j2FIR7AvDwwbYenfcDTYfx9FsB8nHzZJcThy+b
	 IVyvrYkTyizfLRU1F1RsDARZitpDEMP1c96keZiE+GN6PcQ3TBsWT5YlhHihpLxv93
	 TA4ZygL5KmGsAdClW1OITNIYQv6uLXeAXGaR2Tfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfJLMZr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 12 Oct 2019 08:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfJLMXr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 08:23:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 888722089C;
        Sat, 12 Oct 2019 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570883027;
        bh=OVuBDbj/mxE+fQqEQMS1cE9xWhqDaLjbyKyuUAn4wS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ji7PYXmP0YgDLaCmVXNWqtdHcwbgHaX0FJk6J+0uJZ2UvDrCEyCJVephPawYxYhqz
         HiF3drksaxWGQtJhBeZCuU3hnqIQ1Hc7lFsTL8L/SvMp/hn6Ak14ZhZSkuBbnIp2H2
         zbIGWyY+mGt7Q4q2KxKDOFILOcfQhwgyXSh3BPq4=
Date:   Sat, 12 Oct 2019 13:23:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 08/13] iio: imu: st_lsm6dsx: grab conf mutex in
 st_lsm6dsx_write_event_config
Message-ID: <20191012132342.239811c6@archlinux>
In-Reply-To: <b9761bf79a087f1699c5df049e9f2a10c9ad66ea.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
        <b9761bf79a087f1699c5df049e9f2a10c9ad66ea.1570367532.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  6 Oct 2019 15:22:02 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Always grub conf mutex in st_lsm6dsx_write_event_config since it can run
> concurrently with FIFO configuration
> 
> Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
applied.

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 023646762b4a..04231710ab9c 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1604,7 +1604,9 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
>  	if (err < 0)
>  		return err;
>  
> +	mutex_lock(&hw->conf_lock);
>  	err = st_lsm6dsx_sensor_set_enable(sensor, state);
> +	mutex_unlock(&hw->conf_lock);
>  	if (err < 0)
>  		return err;
>  

