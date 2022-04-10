Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AA0C433EF
	for <linux-iio@archiver.kernel.org>; Sun, 10 Apr 2022 16:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbiDJQzf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 10 Apr 2022 12:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiDJQze (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2022 12:55:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9084C4B435;
        Sun, 10 Apr 2022 09:53:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49CC5B80E29;
        Sun, 10 Apr 2022 16:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8EEC385A4;
        Sun, 10 Apr 2022 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649609601;
        bh=EEwOvziSa4XARwMx46j7IVRZEenEfM1PTjghg9jOR34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AkxjgfUCTQHhTT37GlLVL7t9SBSvz5KSkiU1Lu/gURVt1OzpoHgK7wFU3ZYB61Nes
         yiGx0TI3n9ww10maVxxwK8eB0M90+F160JG61C8yzm/VSW6ZMbH4WagUwKF5pwO/y7
         QaLbGypK7NF0nM4IqBWHkiELnclVY1Be2a7vD0Uir+PoV+/ckf++nFb56ATQ38R8TQ
         k+wYzAW5mnsVfIl18zUag9BkQJKb7PDrfaEdAzGQmyMh9EOPy0q/nerH01uvIlk8eH
         JTuu8PmxCXzUxImjD49k5l/HxhbBkWlUdY6rWvMyDuVglIFUYuNKyxO4urnrOXoK2Z
         ujwVtyF0Pbq9g==
Date:   Sun, 10 Apr 2022 18:01:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org
Subject: Re: [PATCH v2 0/2] add support for ASM330LHHX
Message-ID: <20220410180112.38e9f047@jic23-huawei>
In-Reply-To: <cover.1649100168.git.lorenzo@kernel.org>
References: <cover.1649100168.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  4 Apr 2022 21:24:42 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add support for ASM330LHHX IMU automotive mems sensor
> https://www.st.com/resource/en/datasheet/asm330lhhx.pdf
> 
> Changes since v1:
> - use lsm6dsr as fallback device for asm330lhhx

Series applied to the togreg branch of iio.git and initially
pushed out as testing for 0-day to take a first look at it.

Thanks,

Jonathan

> 
> Lorenzo Bianconi (2):
>   iio: imu: st_lsm6dsx: add support to ASM330LHHX
>   dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhx device bindings
> 
>  .../bindings/iio/imu/st,lsm6dsx.yaml          | 38 ++++++++++---------
>  drivers/iio/imu/st_lsm6dsx/Kconfig            |  6 +--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 +
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  3 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  6 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |  5 +++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |  5 +++
>  7 files changed, 43 insertions(+), 22 deletions(-)
> 

