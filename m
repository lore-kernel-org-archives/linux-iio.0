Return-Path: <SRS0=ElSe=5U=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24615C2BA15
	for <linux-iio@archiver.kernel.org>; Sat,  4 Apr 2020 14:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14FC206E9
	for <linux-iio@archiver.kernel.org>; Sat,  4 Apr 2020 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586010261;
	bh=yWnYpAv4nNSnqYFjCHAQeJHJdXgIGKNSmgdEV2Q0JrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2QKo030498izalYf3h/XdP6r+fVrNZHwwQuPquzWphgQCE1gDApOMUIgwrN4hGqTd
	 lWlZmvGBhJRe7MiiO8qgUsKm82C0gME1r0avvKiHDz+dJ6hPylLO53dzaKnJPsPg3u
	 0TcZUEsku78v6PRy7tRDrbfJrlAZqfZ3icGwd8LA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgDDOYV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgDDOYV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 10:24:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C4B206C3;
        Sat,  4 Apr 2020 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586010260;
        bh=yWnYpAv4nNSnqYFjCHAQeJHJdXgIGKNSmgdEV2Q0JrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xeK1amMA+GyF25Zbpm/k2qrU7B9iZyjS5uSgPe/gf9wM2vVZXZOAPfOHRGjPowIsS
         f+6A8rrU0+VPm0Dt9MlZKNX/fQYBBQfBVjMPmIraDen32dPvuQnay8y2IxUyW/2WA1
         S5g7+/Kiyra0mocwSz8nn/4YAfIsxlx+OVh2+tCM=
Date:   Sat, 4 Apr 2020 15:24:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jimmyassarsson@gmail.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: configure full scale on slave
 device if supported
Message-ID: <20200404152415.53cc596e@archlinux>
In-Reply-To: <cb3059b1ef8a5f0ebbd68a11db9931d6a2e4f44d.1584651650.git.lorenzo@kernel.org>
References: <cb3059b1ef8a5f0ebbd68a11db9931d6a2e4f44d.1584651650.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Mar 2020 22:02:45 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Introduce st_lsm6dsx_shub_set_full_scale routine in order to configure
> the i2c slave device sensitivity
> 
> Tested-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
I've lost track of what is going on around this driver.
One thing is clear though, this doesn't currently apply to my togreg
tree.  I'll assume that's because I'm missing something (maybe a fix,
or maybe another series).

Give me a poke if I seem to have lost this in a few weeks once all the
trees catch up properly after the merge window.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 33 ++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 64ef07a30726..fec1dbd5f00d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -518,6 +518,36 @@ st_lsm6dsx_shub_read_raw(struct iio_dev *iio_dev,
>  	return ret;
>  }
>  
> +static int
> +st_lsm6dsx_shub_set_full_scale(struct st_lsm6dsx_sensor *sensor,
> +			       u32 gain)
> +{
> +	const struct st_lsm6dsx_fs_table_entry *fs_table;
> +	int i, err;
> +
> +	fs_table = &sensor->ext_info.settings->fs_table;
> +	if (!fs_table->reg.addr)
> +		return -ENOTSUPP;
> +
> +	for (i = 0; i < fs_table->fs_len; i++) {
> +		if (fs_table->fs_avl[i].gain == gain)
> +			break;
> +	}
> +
> +	if (i == fs_table->fs_len)
> +		return -EINVAL;
> +
> +	err = st_lsm6dsx_shub_write_with_mask(sensor, fs_table->reg.addr,
> +					      fs_table->reg.mask,
> +					      fs_table->fs_avl[i].val);
> +	if (err < 0)
> +		return err;
> +
> +	sensor->gain = gain;
> +
> +	return 0;
> +}
> +
>  static int
>  st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
>  			  struct iio_chan_spec const *chan,
> @@ -552,6 +582,9 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
>  		}
>  		break;
>  	}
> +	case IIO_CHAN_INFO_SCALE:
> +		err = st_lsm6dsx_shub_set_full_scale(sensor, val2);
> +		break;
>  	default:
>  		err = -EINVAL;
>  		break;

