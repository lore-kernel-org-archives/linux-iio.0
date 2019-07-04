Return-Path: <SRS0=0ob2=VB=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C8EC5B578
	for <linux-iio@archiver.kernel.org>; Thu,  4 Jul 2019 00:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2F72187F
	for <linux-iio@archiver.kernel.org>; Thu,  4 Jul 2019 00:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="WerE6/j2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfGDAbf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 3 Jul 2019 20:31:35 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:42381 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfGDAbf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2019 20:31:35 -0400
Received: by mail-io1-f51.google.com with SMTP id u19so9169561ior.9
        for <linux-iio@vger.kernel.org>; Wed, 03 Jul 2019 17:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=MxE+aF+uOANMhLBVXe0vHhLhBLv0SbT7tqRSlHjvpQ8=;
        b=WerE6/j2UO/r8TW545ExIRv+VNCt+HrWwCs2uaeUOwG61msQ8W5bUJAHmy83e7R6Yy
         dRiorZDUD60Tz4qoz4jBWSYqeBw+d1D7RRxg5nj0+DSlwcTl1ij5PDUJcyvXEzSxmkVd
         sv6nzrtSvrJQZLS0BVN8GrgJp7JIc5uvMFDww0J7LO5tMOgcF9ao/snaY2qosZdgm9bm
         HKTcn/3HP6zKsp+taDFRmXm6HnqpT3rqY1+BBhsfkqXP/XcDqd81xvFuC1d858MX7sPS
         6ZCUtCzl9zmHsJAwGgvPesfTefLyzxbB92YvRYuDMkRbu62suPNdSCasLHJp4tsoiMZx
         +AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MxE+aF+uOANMhLBVXe0vHhLhBLv0SbT7tqRSlHjvpQ8=;
        b=kTgC+OqxGFPfxhixe44B9R2+id8wpWumkqgxhEkPKYDe6jaccbUeUEbGZQROkldqsA
         nMO//CxCXTzE67/45GrFGSPGVK9d0GUy+ODlAjI3EemZb/Hn1sg7Yf66lh3MdVLl9yK9
         VQ1BsLQ77rcy/76W4/MykAqEjbP/r8BbecLyiDf5HlBMneRcWmqCq4FblXrk3iw563Ca
         kVeRHss5OtzuE+CUJbxuHO5OKiMwELbIpJRx+USc968Ec8nLcNRToCsvUerHcq+G16R1
         JS65JxEooaUbglieHpazlPIGnE1XIVy0kxvZTDdiWH1lpPhdjLqQk51RJkQjUhjLCs4a
         Ix5A==
X-Gm-Message-State: APjAAAWVw4L6w6vH4/soWlbqHiDS8si5UXzOCE67jpXObHAwHJPU6EYC
        qjwsjMldhuP0+2j5hiF+LkNxUQVVvGx4xnfPyg48PnVGSao=
X-Google-Smtp-Source: APXvYqzkajCyJpoaB/7uBqX0UFF4dSkn/lodXD5W/0ISL5ymZZ77LUKDOoNCmgiNGBIASZ6cKSIkXgWvSOEv8PU/oLs=
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr13614192iol.269.1562200294385;
 Wed, 03 Jul 2019 17:31:34 -0700 (PDT)
MIME-Version: 1.0
From:   Bobby Jones <rjones@gateworks.com>
Date:   Wed, 3 Jul 2019 17:31:23 -0700
Message-ID: <CALAE=UBgn6CoWZ84Gq5a4=pw6pQ0WnCOVMgy8Z7miZ-r3pjwVQ@mail.gmail.com>
Subject: LSM9DS1 Accel/Gyro Support?
To:     martin@martingkelly.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Martin and linux-iio,

I have a device using the LSM9DS1 and saw that you added support for
the magnetometer of the chip but I was unable to follow what was done
for the accel and gyro of the same part. Was this still something
you're working on or perhaps those components are compatible with
another st device?

Thanks,
Bobby Jones
