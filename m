Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A7C48BCF
	for <linux-iio@archiver.kernel.org>; Sat, 12 Jun 2021 16:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B6961287
	for <linux-iio@archiver.kernel.org>; Sat, 12 Jun 2021 16:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhFLQqX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 12 Jun 2021 12:46:23 -0400
Received: from mail-yb1-f179.google.com ([209.85.219.179]:33437 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhFLQqX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Jun 2021 12:46:23 -0400
Received: by mail-yb1-f179.google.com with SMTP id f84so9043718ybg.0
        for <linux-iio@vger.kernel.org>; Sat, 12 Jun 2021 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UA/wjAcUWeEk8rIZrKamqx+K5OM/e1f9gmQyPOEiyYs=;
        b=OJAXuVN+uvC1q+05KBiHZNGxZSmEfs7gdJp+4ROviUo0xS1zrP0TiJ2ORSBo9SdyQY
         Yk5emkuZrNiNFdWddP881c5aIKI9g6HEWkuE0bD+GhdAa8AFfYJinEAvgZkVdFxzWSBF
         Q6aP3WhGZEP2rK07SpMovvKlVA0tnzaSnC0BqJv69tbNa/WhV5FpkQ0ikIWF6rl2fhUU
         gkDPv930H7/nm2/FlwxZfEhcqleM/B93E0ZNFU+VmIab/0Uam8mhui9AqEJab4nlcUqx
         OktqApzGKmpEaMwdPlYSj6ioBqiyXEy7h6PSQu944Kzhvsy9+V0mIIaovB+2eledXwRa
         LrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UA/wjAcUWeEk8rIZrKamqx+K5OM/e1f9gmQyPOEiyYs=;
        b=PkYaDwnMqZGr4zTiULOxRQjSC7KA6GhM5h73NXDKm/SSUY7F2IUuUlUdV1KHJT02G2
         I2BUnG65eop2OaC5s8ZntJXsWBWUfHN6ykoo+1P4VKmBaCFFF1XsstnvQ47321PwZ1qH
         EkaBDJn6aiIcKmhNl1fsDMe2gqeMTLTtxXh7QSE+t7NnPUyX+nObcAombgUvN9Qb9H7K
         I5mMk1b/KjYOJNAEcYlOPD7RQggoCx0KuJx4IYYeggp6edgnbGFJYqaEM1Ix8+kgjPEQ
         bxJxlOBfJP1BDBOGa4MryEVUAYZQHs5JPOk1qTpbo3sBTU6weygUWYUQrv6WifvrsHFa
         Hvrw==
X-Gm-Message-State: AOAM532BIeDC0DS32bpaNss1UFkFMQk0nbY8R0AGPbEBZnsT6oaWyh2v
        SIAsB/OAev4nWN0Rjt3V8BgJ39VPgP/m0QN52Jo/Q0Bz1qusow==
X-Google-Smtp-Source: ABdhPJxH4dAxrc1nre9NAkBQLK5chynVuh7EtKeuIdEJ6dlNLgSMxpmR4VEmzABNiSQqll48AwkIdd/aH7SQNgtamrM=
X-Received: by 2002:a25:aad4:: with SMTP id t78mr12898305ybi.266.1623516202933;
 Sat, 12 Jun 2021 09:43:22 -0700 (PDT)
MIME-Version: 1.0
From:   William Huang <whuang8933@gmail.com>
Date:   Sat, 12 Jun 2021 12:43:12 -0400
Message-ID: <CADa-vC0c4_0XiLd6GQto6f0h2BZi0CvWiP7v9NTjG9cgXTGoLw@mail.gmail.com>
Subject: Can't find trigger_now for sysfs-based triggering
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi everyone,

I hope this is the right place to ask my noob question.
I'm trying to learn how to write an IIO driver and using a couple
books as my resource. I managed to write a simple one and perform
oneshot-based data reads (e.g. cat iio:device0/in_temp_raw).

Now, I'm trying to set up a trigger-buffered data read. I believe I
set up the triggers correctly:
cat trigger0/name > iio:device0/trigger/current_trigger
echo 1 > iio:device0/scan_elements/in_temp_en
echo 1 > iio:device0/buffer/enable
cat /dev/iio\:device0 | xxd -

Now, I'm not understanding how I should actually perform the trigger.
From my books, there should be a trigger_now file where I can echo 1
to trigger, but it's not available in my trigger0/ directory. Also,
the book references a add_trigger in /sys/devices/iio_sysfs_trigger/
directory, but that's nowhere to be found as well.

My .config also has CONFIG_IIO_SYSFS_TRIGGER=m.

Any help/advice would be appreciated!

Thanks,
William Huang
