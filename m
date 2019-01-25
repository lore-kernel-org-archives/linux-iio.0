Return-Path: <SRS0=ZZPN=QB=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97836C282C0
	for <linux-iio@archiver.kernel.org>; Fri, 25 Jan 2019 08:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6A22084A
	for <linux-iio@archiver.kernel.org>; Fri, 25 Jan 2019 08:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG17qrKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfAYIgc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:36:32 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:38310 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYIgb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Jan 2019 03:36:31 -0500
Received: by mail-ot1-f45.google.com with SMTP id e12so7834634otl.5
        for <linux-iio@vger.kernel.org>; Fri, 25 Jan 2019 00:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQztIlymY9qyT9ACcYwSCz7wVkStPOt9BT8WdgdIAh4=;
        b=EG17qrKfG5fMSMmqelJUVCbOLdcl7T6jSw7zdptYY3vbo3MuQSXw2kTvXUnrhgwijv
         h8OpB9zhVldWXU+nvB114H4LnmrTM3kDqcNO1d0mEH+3C1cnnfJXdznXoPYJOobJYd04
         uWw4btiQoMzNFzvtUELyxLPDQTL57zn6XYCuXHVnLBq50c23AMatoDVCt2JI9LIeIWJV
         62YqXV0IKM5+1L/qlJ9PmuAXj51R5qTzFKCJH87JJ5m9V8NSiAsGbiFL+u+Gxo9BB/hb
         NTCaLjaeq0+D8F7xux0cksaCVNWf6wxZjgU9V2KeQpsVhQS7kt6Cz5b8IRNJmmjuQK3W
         1tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQztIlymY9qyT9ACcYwSCz7wVkStPOt9BT8WdgdIAh4=;
        b=nxICBr/IunOGgHLI7E7cNcoLN05jglx5fiaWYMlYc+3BKgM2U1TznJXzv35xtcZjw4
         YXTOAuTGhGf0k3pBO5nwa4v3elXkaz0zmGFK1FurLfxxYIrVohSXhD26yWicQ4crhAUV
         VzOE5htE1GHPEyG8u84PYShvE1OoYhlGeA8Mvr8714riyAtAYmIbCyL0wuh/F6SHYv4m
         xA6Vyiwfm3wE9ejYLuYVV2fXl1aTPez2ev94j/vY+iKalvY0v+gwROpF3VnIqWCg6Zno
         zqnUi+9wSV31fc01MqGrpA4HzcLxQ0zbsAml8o9QlW8HViCXCxTZ8ydR5TYaJ6lAujEl
         ibzQ==
X-Gm-Message-State: AJcUukfkYGgE6HE3yirvZ9hVEg3Lh1yFxy7PUMneMaTuB492TP5cRwde
        0OLfAfRhhLHd2gacolkEJwyoEHP/Cv8StjqSsuoHnlahk6Q=
X-Google-Smtp-Source: ALg8bN7lswiGzziDhk3I5/PAK1Iv57cg+8ywe/3d6DTzhylPyK9vsW/qeE6nBWuw9cx5ocJm/96ySt6b0luV3pn9GEU=
X-Received: by 2002:a9d:42c:: with SMTP id 41mr7432666otc.41.1548405390896;
 Fri, 25 Jan 2019 00:36:30 -0800 (PST)
MIME-Version: 1.0
References: <ec351562-c263-6550-4c6e-7ba2c605e5c0@electromag.com.au>
In-Reply-To: <ec351562-c263-6550-4c6e-7ba2c605e5c0@electromag.com.au>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 25 Jan 2019 10:36:19 +0200
Message-ID: <CA+U=DsqtHkZYMVuWKJGYMOsQ3m4N5Cf2B9pj18JZPSvW_aNbzg@mail.gmail.com>
Subject: Re: iio scale precision
To:     Phil Reid <preid@electromag.com.au>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        alexandru.ardelean@analog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jan 23, 2019 at 11:17 AM Phil Reid <preid@electromag.com.au> wrote:
>
> What's the best way to handle scale values for very high precision ADC's.
>
> eg a 24 or even a 32 bit dac with a 2.5v full scale range.
>
> Even using the nV conversion param it looses a fair bit of precision.
>
> Would a option to return a rational number would be better?

Are you saying something like float/double C types ?
Typically those are not allowed in kernel.

Scale values are typically/mostly for informational purposes.
i.e. the driver computes the scales [and the current selected scales]
for the measured values, so that the userspace parts [usually libiio]
can compute actual values

So, you could compute & display scales almost any way you want it,
even just displaying a string representation of the scale value.
It is good to follow some conventions though.

You could take a look at various formats for the scales.
Something like IIO_VAL_INT_PLUS_NANO or IIO_VAL_FRACTIONAL or
IIO_VAL_FRACTIONAL_LOG2 [see __iio_format_value  in
drivers/iio/industrialio-core.c to get some idea ] .
Depends what you really need.

I guess to give a better answer here [I deferred giving one hoping
someone more informed would jump-in], we would also need a more
concrete example.

Thanks
Alex

>
> Or am I doing something wrong.
>
> --
> Regards
> Phil
