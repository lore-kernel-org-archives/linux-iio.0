Return-Path: <SRS0=4pMd=73=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4E5C433DF
	for <linux-iio@archiver.kernel.org>; Sun, 14 Jun 2020 13:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02DA52078A
	for <linux-iio@archiver.kernel.org>; Sun, 14 Jun 2020 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592141482;
	bh=/uJx9xJP/BXMm9u5TU7AgHyPa0pgpsTOUd83Ehr90rI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=O8lX/0J3dJE8v4x5efdsHr5CPMidVOuj0DdFW1vbdMSUC68w2E8Ykyv9p7wizpU/1
	 Kb99adlaYXQ/NarQyFXPhXip5eKZDWyiHX1lDQURcU1HW4Y4+ykzkgAFXTZ9if3RU5
	 wAGIpWmtdpae6R92VtiFegCxVCNJiGMtOF3V5qiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgFNNbV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Jun 2020 09:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgFNNbV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jun 2020 09:31:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9899D2068E;
        Sun, 14 Jun 2020 13:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592141480;
        bh=/uJx9xJP/BXMm9u5TU7AgHyPa0pgpsTOUd83Ehr90rI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VSw/bWdTlv2mVBTfo7wAbw5yIJ0SLfJHGu/sIrRZS8BTLK289C4PkinA8UJJODkkh
         aFqhuqaWdC00bIKKrmAsVamfDgDY2ItZ1WMb4cqsscFiuUlP4ZBwRhADXpdTQzN0Tr
         Touo/XvlmiTmGzY5zaFw/i4EFUIltD7d9+KuCBLg=
Date:   Sun, 14 Jun 2020 14:31:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: fix spelling mistake
Message-ID: <20200614143115.0c14acc3@archlinux>
In-Reply-To: <20200609223955.107506-1-iamkeyur96@gmail.com>
References: <20200609223955.107506-1-iamkeyur96@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  9 Jun 2020 18:39:52 -0400
Keyur Patel <iamkeyur96@gmail.com> wrote:

> Fix typo: "tigger" --> "trigger"
> 
> Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>

*After a diversion to read some AA Milne*

Applied to the togreg branch of iio.git and pushed out as testing
because there is other stuff in the tree that needs testing.

Thanks,

Jonathan

> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index c831915ca7e5..4888fb23d801 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -352,7 +352,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  		} else {
>  			/*
>  			 * The only way to get samples in buffer is to set a
> -			 * software tigger (systrig, hrtimer).
> +			 * software trigger (systrig, hrtimer).
>  			 */
>  			ret = devm_iio_triggered_buffer_setup(
>  					dev, indio_dev, NULL, trigger_capture,

