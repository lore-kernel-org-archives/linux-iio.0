Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32D6C433EF
	for <linux-iio@archiver.kernel.org>; Tue, 28 Jun 2022 10:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344169AbiF1KFX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbiF1KFW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 06:05:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDF41DA63
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 03:05:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n8so2851100eda.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blokas.io; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OFga85UYJMENUzaa/Z9A62+v99INYjrw0ib+4DPcaUk=;
        b=V+CKAw11Hi0gjoc0syxHLL2JHgPaW93KVYdpE2iMBySc7OzoXDyp1EwwjlPFpnaTHC
         2BDscFQ/KUiCOKsz/mVUUHczzDcIVkKhOceTq/KeXmHVz8GV3DgmcjOyOaQHrQGA9F40
         +1xlrKnAb1zCAFYdBoVs+iAr+nHvo+WDfaRwNMgIrHthcD+w3j29B0uuobcJf1fFXhJV
         xrZITYEuJunSaaHoq7rTfX5cPwCrbnyso4CwJAK9H/GAcWOqIvLxL9oFDzCd8rGRhlF/
         WDVAarQ3YM+DBxSUwqCcvzgr0A0vgSUpKgXVTwX2V2KeMgaPw0VazvaiMjEwHsVIrIxZ
         eBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OFga85UYJMENUzaa/Z9A62+v99INYjrw0ib+4DPcaUk=;
        b=MIKrj0ABrGnjwnnd8HCBAD9ojx7FEGn4nTGSczT6Vr9Lg/uc17FR8FP89Y48P+Tq9M
         BOizCjEsKo/49IzsmOejKUE+a0GHXNe84kiq29kWYZHnWRB4XUjxB1TP/BptVIRfwTsy
         8LXHgrqqgf94bWRD0cRa7hQEpjtCwIKj1I8vMv5S5R48IXG+IrG8We5VEkhfZ844IYz9
         IxRkHPH+U4bPiIdQ6/xq4UAd8pGRDJJGj3NHzj0vF1YW9mOFU57dMzSS+6nwwFMYFyEZ
         vHqLtI7LaPi1+BI8pEuBlJY3rzmJBByHhTLA5pavceYs+03TQnQsiavUzXGufVCebbK3
         9lNw==
X-Gm-Message-State: AJIora89ROJbpjS+pfuMeNtmjtvQ80QB3ZxT2112DM23bHihKSGY1Bat
        IT+9NSS8d0XknsfE7XdEyBNTWrShgiOvkcBIIPnW0rqKHu/Bvw==
X-Google-Smtp-Source: AGRyM1sFnTTk/FQqBSaxYJHlnIkdTo/Asbk/Dvz3sojDDqpm4b5CsbjHIoDVPH6IUDTLhX+mxL3i1rZIQFF8MgwmC+s=
X-Received: by 2002:a05:6402:238c:b0:435:8eb8:48dd with SMTP id
 j12-20020a056402238c00b004358eb848ddmr22015154eda.301.1656410720212; Tue, 28
 Jun 2022 03:05:20 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Giedrius_Trainavi=C4=8Dius?= <giedrius@blokas.io>
Date:   Tue, 28 Jun 2022 13:05:09 +0300
Message-ID: <CAMONXLtN9-t=SuNzDWk22ufYXQHh7ZkXD2FhrRmR_uRgJFmZng@mail.gmail.com>
Subject: Dynamically configured channels, overlap with GPIO, encoder support
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I am developing an extension board for Raspberry Pi, it has a
microcontroller on it and I'm trying to expose its pins as a I/O
expander via I=C2=B2C bus. I've recently successfully implemented gpiochip
interface as well as irq_chip in a kernel module, and now I'm looking
at adding ADC support, Industrial IO seems like a good candidate for
exposing it, but I have a couple of questions:

1. Can the IIO channels be configured dynamically? On the
microcontroller, the same pins can be used for GPIO, ADC, etc... - can
things like the channel direction, the function (simple high or low
GPIO pin, ADC, PWM output) be configured by userspace programs? Can it
be configured within a kernel module, if I provide my own sysfs
interface for function setup?

2. Can IIO channels be appended and removed to/from the list during runtime=
?

3. Are encoders supported by IIO? I'd like to decode encoders within
the firmware of the microcontroller, and provide only
increments/decrements to the kernel module via I=C2=B2C, can encoders built
in such a way be exposed via IIO? I've seen some patches on the
internet adding 'counter' interface to IIO, but it seems it never made
it to be within IIO, and instead the 'counter' in its own subsystem.

4. How does IIO interact with gpiochip? As I'm implementing gpiochip
interface, I could simply return -EBUSY for pins already used by the
other subsystem.

Thank you!
Giedrius.
