Return-Path: <SRS0=edWO=OK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBF7C04EB9
	for <linux-iio@archiver.kernel.org>; Sat,  1 Dec 2018 16:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1A62082F
	for <linux-iio@archiver.kernel.org>; Sat,  1 Dec 2018 16:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ubMCYgLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1A62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeLBEEQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:04:16 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:52301 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeLBEEQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Dec 2018 23:04:16 -0500
Received: by mail-it1-f182.google.com with SMTP id i7so3249006iti.2
        for <linux-iio@vger.kernel.org>; Sat, 01 Dec 2018 08:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=4jfBZDHxYfRZyGAXdEOcAdFVVta4f6xuVZnxV8YBvMo=;
        b=ubMCYgLLFFPuu6KwGFMTUxx08ddi4kVGbL1tG7MKPBei5v5V43+DPHj4Sv8aYjHitn
         qPzQbV+cBCDWge/Sl114qq6Vhb9Nq6qRF13rvqTYDxkGvSGxegbs52b0lCJbfLZuVSZy
         glWr5uSZUeosvvT536uKkYHD+1vSlo++iNKcte7cu4z4HIGgFNNrcoW+07KVgv7XNmJS
         SH36w2JxlEogxtOTJJDnhYnuIu1UEL4gzEmKH06NcdMNyWt9mD6PaKorNhG5hOP1pZrN
         ahq+yMNP9Ts4Sn+s23wZd02yhuwkxGUCsZ5UdDuBsXb+jiQddBP6P6+KBoROIJS9mktI
         FTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=4jfBZDHxYfRZyGAXdEOcAdFVVta4f6xuVZnxV8YBvMo=;
        b=AA8YdcWLXVz2uAng/6TG0UZOheNve1XzbdA9Y0ZNxNIYjRFOEkOOVP7hhGklUcvUMr
         8I3JFv3chRGn1xk77uhw3NjRKg5YIgkqOA0fObeA0EsC06iMT+FkBYYfOXQl0jOPBjUU
         rSvd8ijvH434wZ/Xu5MJ5ENEF7bdjKI0iV1vm4HfVSuNav35v3yhNufPzdKPaj5/+nkq
         HcFE4UBDCU1yD0/oGd3381w4acrSc34pjr4JktNkyBCIWoHfj1n3bHnw+zOyV0IDXutd
         XXKIHAoFySKQeafh/lMcXiMlbdH5DXLJmwUgWazlWQtUhG8zvlEQvRg7hmibzjc6qGLl
         cjRA==
X-Gm-Message-State: AA+aEWbW9hl1BxUfWk6CWwXtK3qNGxPq+0iGrQAw+W4X2K7Xe8v+2PrU
        Nd+J4oHO3nl6NVCdyUYkMN2YtAA0Y7nHt0JfbkYiPSyTyz1y3g==
X-Google-Smtp-Source: AFSGD/VJg3widFGXs3YsdwlA4ZHWQv2F8vu45KqkUwA+NBwEyv/0KOBQNjHW3vSjEVY2NdvUbQUl20dQN4JgMFmd6+8=
X-Received: by 2002:a02:a315:: with SMTP id q21mr8574078jai.94.1543683079232;
 Sat, 01 Dec 2018 08:51:19 -0800 (PST)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 1 Dec 2018 14:51:07 -0200
Message-ID:
 <CAHd-oW4U-BGs+Enf07SP_XXWDPv4bzOM6KM83FX54gKWpW7hXw@mail.gmail.com>
Subject: Questions about the contributing process
To:     linux-iio@vger.kernel.org
Cc:     kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
Message-ID: <20181201165107.WOEoWW8rDdOaD3Hpeud6vdRIGuxtjHiuXvdAJgitM50@z>

Hello everyone

It's been a few months since I started sending patches, but there are
still some points about the process that I do not quite understand. I
would be really grateful if anyone could help clarify them for me.

1) How do we credit more than one person as an author? Here at the
University of S=C3=A3o Paulo we sometimes develop patches in pair
programming, and I don't really know if in these cases we should just
add the S-o-B of both authors or add the "Co-Developed-by" tag (or
something else). Also, is this something specific to each subsystem?

2) Does iio have a test infrastructure? I know there are autobuilders
playing with the iio.git testing branch, but how does it work? Also,
if there is no test beyond building, is there some plan to make such
an infrastructure in the near future?

3) When a reviewer sends an Acked-by, but I still have to send a v2
for some reason (maybe adjusting the patch message, e.g.), should I
add the Acked-by in v2 or that's something the maintainers will do?

Thank you
Matheus
