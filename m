Return-Path: <SRS0=BGF5=5N=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F7BC43331
	for <linux-iio@archiver.kernel.org>; Sat, 28 Mar 2020 13:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0F02082F
	for <linux-iio@archiver.kernel.org>; Sat, 28 Mar 2020 13:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585401858;
	bh=NtaGXm0jiwVyeQzmg2Ra9GPn/Hw9dJVwO4ZlGKOCvfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iquXqGrzWV9qKWfeELnecgZBsXqP09cmDJLd5LFP5CqtAAV9Fg5f9Vrg66sG/84dc
	 5+GSKnIqENluusldgX47SXqltuCX9tw+ei9EohXgdfgjBToIo1o1mgA3dp2CGEtYpb
	 kKD9k2BFiHxBBeUqCViTZBPsJAknGDgOSMajT3XQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgC1NYR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 28 Mar 2020 09:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1NYR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 09:24:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 724D120716;
        Sat, 28 Mar 2020 13:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585401857;
        bh=NtaGXm0jiwVyeQzmg2Ra9GPn/Hw9dJVwO4ZlGKOCvfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PfTOz+gzMA3YDz/K8DAfGBD7JpsH4XLn+tzDY3o61vtm/cLpqTCdA97DYFaXoJ7U7
         Uazuw0dt7eqW+wt+CvygzktSNuAOt4H2+3vWMlhINPOFf+SGnUIMezVSPx3M3yw80O
         LuIxn5zj46LjPskOt2I76bynR+wGFnVESXFR3Vik=
Date:   Sat, 28 Mar 2020 13:24:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com,
        lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] media: staging/intel-ipu3: Reformat pointer
 initialization
Message-ID: <20200328132412.6f6368f2@archlinux>
In-Reply-To: <20200322185350.GA12377@deeUbuntu>
References: <20200322185350.GA12377@deeUbuntu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Mar 2020 00:23:54 +0530
Deepak R Varma <mh12gx2825@gmail.com> wrote:

> Reformat pointer initialization to make it more readable as per the
> coding standards. Problem detected by checkpatch.
> 
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>

Check your cc list before sending and make sure it makes sense.
Driver has nothing to do with IIO and half your list are from
IIO MAINTAINERS entry.

> ---
> 
> Changes since v1:
>     - Correct commit message and description as advised vy Stefano. Its
>       pointer initialization and not declaration as mentioned earlier.
>     
>  drivers/staging/media/ipu3/ipu3-v4l2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
> index 569e27b824c8..52826fad6f42 100644
> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
> @@ -485,7 +485,6 @@ static int imgu_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
>  	if (r < 0)
>  		goto fail_return_bufs;
>  
> -
>  	if (!imgu_all_nodes_streaming(imgu, node))
>  		return 0;
>  
> @@ -1013,8 +1012,9 @@ static const struct v4l2_ioctl_ops imgu_v4l2_meta_ioctl_ops = {
>  
>  static int imgu_sd_s_ctrl(struct v4l2_ctrl *ctrl)
>  {
> -	struct imgu_v4l2_subdev *imgu_sd =
> -		container_of(ctrl->handler, struct imgu_v4l2_subdev, ctrl_handler);
> +	struct imgu_v4l2_subdev *imgu_sd = container_of(ctrl->handler,
> +							struct imgu_v4l2_subdev,
> +							ctrl_handler);
>  	struct imgu_device *imgu = v4l2_get_subdevdata(&imgu_sd->subdev);
>  	struct device *dev = &imgu->pci_dev->dev;
>  

