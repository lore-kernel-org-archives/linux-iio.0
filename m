Return-Path: <SRS0=fZBy=P5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297F6C37120
	for <linux-iio@archiver.kernel.org>; Mon, 21 Jan 2019 21:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE972085A
	for <linux-iio@archiver.kernel.org>; Mon, 21 Jan 2019 21:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9lXfg9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfAUVVD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:21:03 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:36277 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfAUVVD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2019 16:21:03 -0500
Received: by mail-io1-f42.google.com with SMTP id m19so17477990ioh.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Jan 2019 13:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3K/p/2CTauQGDcUiCtZ1Fycf/rqK+/kMas6uyXzkP7s=;
        b=a9lXfg9rJOOnPv1l6X3bphit6WfiqFqT6TYxUb9lQHeggwqu2GqqubgrZaLUtlJnn4
         znBIAwSxyfwIVIu/PvtmBkBZO6sVNOc2r7BUmY5pnDCLlJ5Ol7Qdf+4G7gUg0xG0PV8j
         VZ8eS9WKJfKf6qaeEMOo/juzzlWrwuUn1ZsZb9NCc9GiiOuMSBq3xe6e5il5eid9eEZp
         dw5uhPI+9x+uyizDkyD4H30LH4ZX0UTmf7PcuqTe2e8WWZhQPxjOw8nrRE2+yMVakCSB
         1hXKGJ7H+LtwUWHnbFjWO+55N8clqGQNoTY7oMaG8n2slDFOP+2f9b/AHFHH+f1K/nuy
         LPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3K/p/2CTauQGDcUiCtZ1Fycf/rqK+/kMas6uyXzkP7s=;
        b=iJJLwxZoNYzgUxebSAmOFysveUDxarYPCrs/9E8p21Iqy8lXJ5sdRemOkogdk4S2da
         WKuUzJHq9ItkBwyYI89oa6smiK6YCo/5h5M4jEihxXah+CWnSoyqNcqM/+vrcS7v9tr3
         t8DFMHVI2lta6j2lKNdnvp9baqFBDt8Bn+fyIFYxY2ryRZHwXn/XjNh8LqR1TFXFVe+g
         bNLy6N5uokKQAnJ6NzAgVLxLZXAb+KnUqU5kr2SPr4SnNyUSsnMXOR4dGbu080mZGWNL
         dGp4pV6zGb3bTKXkGif2vEGUvbHqJx+ZsVELkr+sq1FwOhYxpPxppFV8T9sj464A4V13
         bN7A==
X-Gm-Message-State: AJcUukeKfGigUTwdTrf18igxyl2xI6zM8lJ7pCEQ6RQDv6rrdnZyEleF
        pkzlJASMfToXtnkJnPaSiyfxiUvf6oOg+ByZAojy3il2
X-Google-Smtp-Source: ALg8bN7g2v8cK3R0nslMK+Tmu4RFjBCNlMKyFlWDD52YC1nkyg3MgDpYkVzkH8aFIDk03eLKVjK0IrUmlAvJ+M5Y+RA=
X-Received: by 2002:a5d:8e02:: with SMTP id e2mr17956196iod.215.1548105662040;
 Mon, 21 Jan 2019 13:21:02 -0800 (PST)
MIME-Version: 1.0
From:   Crash House <jcrash29.acc@gmail.com>
Date:   Mon, 21 Jan 2019 16:20:51 -0500
Message-ID: <CAD8jUXMVgzSEy+LSEkJ1Hk7Td12f+igZ_WOq1eXk6H_-qRB3dQ@mail.gmail.com>
Subject: Example for buffer-dmaengine?
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello everyone,

(Never done this before, let me know if I do anything incorrectly).

I am looking for a dummy example on using the iio/buffer-dmaengine

I have found several SDR examples in the linux/driver/iio/adc. However
I am struggling to implement a simple version of them myself.

The main road block I have currently seems to be a different between
the AnalogDevicesInc github project and Torvalds. Specifically the
difference is in  =E2=80=9Clinux/include/linux/iio/buffer-dmaengine.h=E2=80=
=9D. One
takes 2 arguments and the other 4.

Along with this when attempting to add a module that uses dmaEngine I
get the following dmesg: =E2=80=9CUnknown symbol iio_dmaengine_buffer_alloc=
=E2=80=9D

Am I missing something stupid?
Am I using an obsolete functionality?
Should I be using iio/kfifo_buf.h?

Thanks everyone,

John
