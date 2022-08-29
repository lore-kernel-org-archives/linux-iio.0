Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7291CC0502C
	for <linux-iio@archiver.kernel.org>; Mon, 29 Aug 2022 15:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiH2PRu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 29 Aug 2022 11:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiH2PRt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2022 11:17:49 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381007AC0D
        for <linux-iio@vger.kernel.org>; Mon, 29 Aug 2022 08:17:49 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11eb44f520dso6490793fac.10
        for <linux-iio@vger.kernel.org>; Mon, 29 Aug 2022 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=zR5b6bKWNfwu6igeVhleFnuDNx79NhHyc/5OQ//e33o=;
        b=Zm+KThV9k9P+rrZ2djLzW1iuGExqNRFC89/UpvUGBT/V1FEbo2h6FV79ttDOITYzzI
         2j7RPd/siRu6FMUA3f+5wjbcf8HItpWXUoMujaGF3zByls1IRTxJgasut2+0NjJPaZGh
         h+m7DuTzWPNod5TNbN0SskcvCYrkS1O13/eM0oa1o6z3eU2lNcx2J+M8Qd6wClE++Ksx
         bvBZ2nhgTlOHN8eOGOJYGII3m1rTLzewGMnEKw8qzmssQCYBMD4DPqYZWrpCK9bBq3h4
         Sd8fddYeAm/pfTouGYDY5tIhbrc0awFwMVPme3vodlfou9lM44uh8X6EbQTT6Pcdr2oe
         goNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zR5b6bKWNfwu6igeVhleFnuDNx79NhHyc/5OQ//e33o=;
        b=BS1jABr72AgesQHtckw0MPTpKsyVNZ7X9DWsgKGJ4UMuiLhuw7PkOUbkNGNcLZY3wf
         80brb+LCEdbi4OXujbU3qwFnUzdPYpQkPTSEV3lrYSqvH9f6vxJxybB/I3nREBmUoHkL
         i2IYF42VA/jAwCQOWWllDJWTp+dKSb/MpOHcMzJeZnC8SIPjTyNY2RiZbIdHkMGGhlHU
         nnuMJq8kKGfRTaD2YXcWp0RwvQxRrvd6ULZZKFaE4cb5mguNiQynTaT2xheKFh/eAncT
         fpUY0ZGlXpzRhnBhCHKWk2IezFqYtOjXln6hWw4gMMeFhx1AyM2kIY65ieOufbs7JFZE
         kFYQ==
X-Gm-Message-State: ACgBeo1e4fNeMVQiyN+gJgP1VV7jvuYt/Kc3KssYipvyuqbQBHdieWUp
        h4Rrh0d5HY1Kh1s3gbPfOiCIanMIWEDVDQ==
X-Google-Smtp-Source: AA6agR59u70qR1mZlWa6IsS7A8WgFmvFPsp80VJs8HNwUTkXfD+d0Je+aBTD4w0ckB7v4CihwvN9Yg==
X-Received: by 2002:a05:6870:6107:b0:11c:2344:e050 with SMTP id s7-20020a056870610700b0011c2344e050mr8277549oae.267.1661786268419;
        Mon, 29 Aug 2022 08:17:48 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id z14-20020a056830128e00b006389650374dsm5771320otp.54.2022.08.29.08.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:17:48 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, fabien.lahoudere@collabora.com,
        gwendal@chromium.org, enric.balletbo@collabora.com,
        bleung@chromium.org, groeck@chromium.org, jic23@kernel.org,
        david@lechnology.com, robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [RFC PATCH 0/2] Add support for Counter array components
Date:   Mon, 29 Aug 2022 11:17:29 -0400
Message-Id: <cover.1661785438.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The COUNTER_COMP_ARRAY_U64 Counter component type is introduced to
enable support for Counter array components. With Counter array
components, exposure for buffers on counter devices can be defined via
new Counter array component macros. This should simplify code for driver
authors who would otherwise need to define individual Counter components
for each array element.

For example, suppose a driver wants to expose a Count's read-only
capture buffer of four elements using a callback `foobar_read()`::

        COUNTER_COMP_COUNT_ARRAY_U64("capture", foobar_read, NULL, 4)

Respective sysfs attributes for each array element would appear for the
respective Count:

* /sys/bus/counter/devices/counterX/countY/capture0
* /sys/bus/counter/devices/counterX/countY/capture1
* /sys/bus/counter/devices/counterX/countY/capture2
* /sys/bus/counter/devices/counterX/countY/capture3

If a user tries to read _capture2_ for example, `idx` will be `2` when
passed to the `foobar_read()` callback, and thus the driver knows which
array element to handle.

Currently, only u64 arrays are supported. One thing to consider is
whether it would make sense to support arrays of other types. This would
allow support for arrays that don't necessarily correlate to a buffer on
the device, but rather serve as logical groupings of components.

For example, if a Signal has four polarity modes, a driver author can
define a Counter array component to handle the exposure of all four
together rather than defining individual components for each one. This
is the reason I've chosen the more generic "array" terminology for this
feature rather than "buffer".

William Breathitt Gray (2):
  counter: Consolidate Counter extension sysfs attribute creation
  counter: Introduce the COUNTER_COMP_ARRAY_U64 component type

 drivers/counter/counter-sysfs.c | 210 ++++++++++++++++++++++++--------
 include/linux/counter.h         |  78 ++++++++++++
 2 files changed, 239 insertions(+), 49 deletions(-)


base-commit: a12224997bec72d231a8dd642876e6364decdc45
-- 
2.37.2

