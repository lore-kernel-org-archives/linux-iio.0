Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1267C4338F
	for <linux-iio@archiver.kernel.org>; Sun,  8 Aug 2021 17:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DCF60E93
	for <linux-iio@archiver.kernel.org>; Sun,  8 Aug 2021 17:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhHHRDm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 8 Aug 2021 13:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhHHRDm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 13:03:42 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C2D60C3E;
        Sun,  8 Aug 2021 17:03:18 +0000 (UTC)
Date:   Sun, 8 Aug 2021 18:06:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v14 01/17] counter: 104-quad-8: Return error when
 invalid mode during ceiling_write
Message-ID: <20210808180608.2925961b@jic23-huawei>
In-Reply-To: <a2147f022829b66839a1db5530a7fada47856847.1627990337.git.vilhelm.gray@gmail.com>
References: <cover.1627990337.git.vilhelm.gray@gmail.com>
        <a2147f022829b66839a1db5530a7fada47856847.1627990337.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  3 Aug 2021 21:06:11 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The 104-QUAD-8 only has two count modes where a ceiling value makes
> sense: Range Limit and Modulo-N. Outside of these two modes, setting a
> ceiling value is an invalid operation -- so let's report it as such by
> returning -EINVAL.
> 
> Fixes: fc069262261c ("counter: 104-quad-8: Add lock guards - generic interface")
> Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for 0-day to have
fun.

As an aside, I got the warning:
  CHECK   drivers/counter/104-quad-8.c
drivers/counter/104-quad-8.c:58: warning: Function parameter or member 'lock' not described in 'quad8'

Which might be nice to clean up, but has nothing much to do with this patch.

J

> ---
>  drivers/counter/104-quad-8.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 09a9a77cce06..81f9642777fb 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -715,12 +715,13 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
>  	case 1:
>  	case 3:
>  		quad8_preset_register_set(priv, count->id, ceiling);
> -		break;
> +		mutex_unlock(&priv->lock);
> +		return len;
>  	}
>  
>  	mutex_unlock(&priv->lock);
>  
> -	return len;
> +	return -EINVAL;
>  }
>  
>  static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,

