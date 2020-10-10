Return-Path: <SRS0=sXLK=DR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CC2C35267
	for <linux-iio@archiver.kernel.org>; Sat, 10 Oct 2020 22:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C146E2080C
	for <linux-iio@archiver.kernel.org>; Sat, 10 Oct 2020 22:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602370626;
	bh=T6GGCEhM2gUPnyDP7vWHf219OEKiW5GT1qvoQTUWZu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GYUTFgqAY03mQIFtas4SEz49OKIv5rYO3XLx3mD70ybMQ1ztpXenxjvjHTKmrjLfH
	 BAo56xJnG9E2VTSoJI80rSyb1KNSp2+UYzQsiw6GBtN1AoxPCtNylZJ48fphsZo+Py
	 71snAw6i9w7FJJQYUw9VOsZBvwnOHvYMRl1hhDso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbgJJW5F (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731824AbgJJTh1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Oct 2020 15:37:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4014F2078B;
        Sat, 10 Oct 2020 16:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602347269;
        bh=T6GGCEhM2gUPnyDP7vWHf219OEKiW5GT1qvoQTUWZu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mlsw1eK1aOcWR09vUEu1jf2qt9iTLm8kA2f+ABYEefr15XEL8rwm6O4pztYr0KnYx
         Grcqji+mJKCS5J5d9Zful1NgwwNKGI9RN5o/NJJg1jcD1WXDMKFjVuScB0ikB84Sq7
         Qh5IxBWyfQhU5VnvViDfPEhX/2oFbb11zICaZXrU=
Date:   Sat, 10 Oct 2020 17:27:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, mario.tesi@st.com
Subject: Re: [PATCH 0/2] add support for LSM6DST
Message-ID: <20201010172744.395d879c@archlinux>
In-Reply-To: <cover.1601985763.git.lorenzo@kernel.org>
References: <cover.1601985763.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  6 Oct 2020 14:07:40 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add support for LSM6DST IMU mems sensor
> https://www.st.com/resource/en/datasheet/lsm6dst.pdf
> 
> Lorenzo Bianconi (2):
>   iio: imu: st_lsm6dsx: add support to LSM6DST
>   dt-bindings: iio: imu: st_lsm6dsx: add lsm6dst device bindings
> 
>  .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
>  drivers/iio/imu/st_lsm6dsx/Kconfig            |   4 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   2 +
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 207 +++++++++++++++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |   5 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |   5 +
>  7 files changed, 222 insertions(+), 4 deletions(-)
> 

Applied to the togreg branch of iio.git and as normal pushed out as testing
for the autobuilders to poke at it and see what we missed.

Thanks,

Jonathan
