Return-Path: <SRS0=A9f8=CH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E734EC433E2
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 15:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E66207DA
	for <linux-iio@archiver.kernel.org>; Sat, 29 Aug 2020 15:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598716487;
	bh=xeclwPlbfWVpsZXJD1ZTevUTmrD53fLqalk6KYlC4es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=G6m9Ve7CodNZZFoSpFrXiWIcHZMTzYnN3oSfGGdJRbhAULPVYNcmhOa/GpRBI+Tjk
	 z0KtjryxvQFlLdxQsp7IDSp4bfqUqXH922+hxJMcd/gAWKZRcix/1qUDp6MjpSuyPv
	 LI23Y+Ya/Dn600lCKubKOb1WWdnYL+PeZ828USaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgH2Pyq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Aug 2020 11:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbgH2Pyk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 11:54:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 674BB20707;
        Sat, 29 Aug 2020 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598716477;
        bh=xeclwPlbfWVpsZXJD1ZTevUTmrD53fLqalk6KYlC4es=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H3y2Wm6WEr9qH3jjCTSPXBsu56ecB1byWrvclK7JmMekckl+9pQxsQbBfNdYIcNwv
         ju5UbU+LNShlCPYjtNLl4h5cLRJDlKQuXlwjogbRhP3uw0n4lOXSe9QIAAbMXLNVbn
         8lk+4LtOSd6ynU9MoFwT28KlvqfhrKzm6MMxi+Nc=
Date:   Sat, 29 Aug 2020 16:54:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] platform: cros_ec: Reduce ligthbar get version
 command
Message-ID: <20200829165433.57b0e5e4@archlinux>
In-Reply-To: <20200826002945.394562-1-gwendal@chromium.org>
References: <20200826002945.394562-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Aug 2020 17:29:45 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> By default, the lightbar commands are set to the
> biggest lightbar command and response. That length is greater than 128
> bytes and may not work on all machines.
> But all EC are probed for lightbar by sending a get version request.
> Set that request size precisely.
> 
> Before the command would be:
> cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 194, insize: 128, result: 0
> Afer:
> cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 1, insize: 8, result: 0
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Hi Gwendal,

Description seems to me to suggest this is a fix?
Are there known machines on which it doesn't work currently?

If so, please can I have a fixes tag.  If it's just a precaution
against future problems then let me know and I can add it for the
next merge window.

Thanks,

Jonathan

> ---
> Changes since v1:
> - Remove BUG and TEST fields.
> 
>  drivers/platform/chrome/cros_ec_lightbar.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> index b59180bff5a3e..ef61298c30bdd 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -116,6 +116,8 @@ static int get_lightbar_version(struct cros_ec_dev *ec,
>  
>  	param = (struct ec_params_lightbar *)msg->data;
>  	param->cmd = LIGHTBAR_CMD_VERSION;
> +	msg->outsize = sizeof(param->cmd);
> +	msg->result = sizeof(resp->version);
>  	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
>  	if (ret < 0) {
>  		ret = 0;

