Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9174C636CC
	for <linux-iio@archiver.kernel.org>; Sun,  5 Feb 2023 13:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjBEN7r (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 5 Feb 2023 08:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBEN7q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2023 08:59:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CB11E298
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 05:59:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF15560BB9
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 13:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EBFC433EF;
        Sun,  5 Feb 2023 13:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675605581;
        bh=93KmjiFPlPAT7KxqJ407VBS9n5BwW8h56C5+GwAgfwA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DGxPvsCLfzBl+X12EuThPy/jggM/O7qH0kCEA4x+8zWxuJynoEdDSTnFf5/KiK0Pi
         6O9lHG6B65z1OIf1p38HeRTI9uPOpt3Jvx/RDhmbxJ1CkTAoixhUzo0G2rTRj3w4yn
         Ylt7x23kFukDMZtlXiL6N45nOFo2ui141qCLy5IOXu712M8s+elDkcHXkxghNgaKPs
         8vt75vg90yVE8oJYIWFwisLas/5N54oSQXlXMgt/Uyv/6H98obD5WRpcHY0HaxnJ7Q
         4GXh0+SV1XC9e157cS9QXMctmK+IqxzGd40NHVLYVxASyjl8oWEQf7apWNMhjyt368
         ol95Rs+Nxs3ww==
Date:   Sun, 5 Feb 2023 14:13:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philippe De Muyter <phdm@macq.eu>
Cc:     lorenzo@kernel.org, linux-iio@vger.kernel.org
Subject: Re: st_lsm6dsx : first two values of ism330dlc_gyro are wrong
Message-ID: <20230205141342.10dbc447@jic23-huawei>
In-Reply-To: <20230205101223.GA10729@frolo.macqel>
References: <20230205101223.GA10729@frolo.macqel>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Feb 2023 11:12:23 +0100
Philippe De Muyter <phdm@macq.eu> wrote:

> Hello Lorenzo and list,
> 
> I use the imu/st_lsm6dsx (i2c) driver to drive a ism330dlc imu.
> 
> Every time I start a new acquisition of gyro values, the first two
> values read are wrong, as can be see here :
> 
>  $ sudo ./iio_generic_buffer -n ism330dlc_gyro -g -c 10 -a
>  iio device number being used is 1
>  trigger-less mode selected
>  No channels are enabled, enabling all channels
>  Enabling: in_anglvel_z_en
>  Enabling: in_timestamp_en
>  Enabling: in_anglvel_y_en
>  Enabling: in_anglvel_x_en
>  -0.138924 -0.915246 0.470628 1675591514696125669
>  -0.012699 -0.362151 0.143208 1675591514772675669
>  0.001989 -0.076500 0.035190 1675591514849250669
>  0.002295 -0.076194 0.035343 1675591514925825669
>  0.002142 -0.076041 0.035343 1675591515002400669
>  0.001989 -0.076041 0.035343 1675591515078975669
>  0.001836 -0.076347 0.035649 1675591515155525669
>  0.001836 -0.076500 0.035649 1675591515232075669
>  0.001989 -0.076500 0.035649 1675591515308625669
>  0.001989 -0.076347 0.035649 1675591515385200669
>  Disabling: in_anglvel_z_en
>  Disabling: in_timestamp_en
>  Disabling: in_anglvel_y_en
>  Disabling: in_anglvel_x_en
>  $
> 
> Is that a normal behaviour for a gyro in that family or is it be caused
> by a software or hardware bug ?

So, some random thoughts on what might be going on...
1) Stale data in the fifo.  Could you run this experiment twice whilst being
   careful not to move the device between the runs.  If we still see the wrong
   values at the start then it's not that...

2) Device takes a little whilst to stabilize. Possibly this is down to the
   low pass filters requiring a few samples before they deliver stable output.
   From a quick glance I don't think we provide any userspace control of those
   filters and I think LPR1 is left in default state of disabled.

You could try messing with the sampling frequency as that may affect the number
of bad samples you see and give us more of a clue (it affects lpf2 directly).

Jonathan

> 
> Best regards
> 
> Philippe
> 

