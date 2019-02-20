Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7090CC43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 10:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8DC2183F
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 10:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550659683;
	bh=WVVDboWDcq0WS9DthkuGwMg+AUB9IyJqQafsxG8+fZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uYoBk+Xla01Cd+H+vLIC3siZFd+piE45isaykFNepS50uMPNQPaOagXLujoRfR5Bw
	 /bdeR2F+47SQWW1yyr0b8M/zXgnrQqEhM7EmAozPQirv3UkXKk/NcBW4qCdJIhm2Nf
	 17Q8BE9h+BaRlkZ6SM4u/gylc2vPytpdws5A0T2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfBTKsB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:48:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbfBTKsB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 05:48:01 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA1A12147C;
        Wed, 20 Feb 2019 10:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550659681;
        bh=WVVDboWDcq0WS9DthkuGwMg+AUB9IyJqQafsxG8+fZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i4XELSJdCO8n+Io3PeEO4eEZd0GY2M51ABdxq/HfBzm6+EaDZTfCHRt37u51N2oNc
         0KcXtUaGCb5RtvrGeHdoaF2tduqGuXWp0p5vmpmF6cl2kkuBCTWXOtihNMccRjsQWU
         q3uOHwi8/LWt0NTt5jvEjZ+oeuOZLm2jni532d0g=
Date:   Wed, 20 Feb 2019 10:47:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: remove redundant unlikely annotation
Message-ID: <20190220104753.62ae8823@archlinux>
In-Reply-To: <20190218075326.24672-1-cgxu519@gmx.com>
References: <20190218075326.24672-1-cgxu519@gmx.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Feb 2019 15:53:26 +0800
Chengguang Xu <cgxu519@gmx.com> wrote:

> unlikely has already included in IS_ERR(),
> so just remove redundant unlikely annotation.
>=20
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to poke at it.

=46rom an IIO point of view, we are almost certainly closed
for the coming merge window, so this will be next time
around.

Thanks,

Jonathan
> ---
>  drivers/iio/trigger/iio-trig-loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/ii=
o-trig-loop.c
> index 94a90e0a3fdb..9258d3cf149b 100644
> --- a/drivers/iio/trigger/iio-trig-loop.c
> +++ b/drivers/iio/trigger/iio-trig-loop.c
> @@ -60,7 +60,7 @@ static int iio_loop_trigger_set_state(struct iio_trigge=
r *trig, bool state)
>  	if (state) {
>  		loop_trig->task =3D kthread_run(iio_loop_thread,
>  					      trig, trig->name);
> -		if (unlikely(IS_ERR(loop_trig->task))) {
> +		if (IS_ERR(loop_trig->task)) {
>  			dev_err(&trig->dev,
>  				"failed to create trigger loop thread\n");
>  			return PTR_ERR(loop_trig->task);

